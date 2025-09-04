package shop

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"strings"
	"time"

	schemav1 "github.com/backend/gen/schema/v1"
	shopv1 "github.com/backend/gen/shop/v1"
	"github.com/backend/internal/aihelper"
	"github.com/backend/internal/auth"
	"github.com/backend/internal/shopmock"
	"github.com/backend/internal/storage"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
	"google.golang.org/protobuf/types/known/timestamppb"
)

var (
	ErrUnauthenticated = errors.New("unauthenticated")
	ErrPermission      = errors.New("permission denied")
)

type Service struct {
	shopv1.UnimplementedShopServiceServer

	store  storage.Store
	blobs  shopmock.BlobStore
	secret []byte
}

func NewService(store storage.Store, blobs shopmock.BlobStore, secret []byte) *Service {
	return &Service{
		store:  store,
		blobs:  blobs,
		secret: secret,
	}
}

func (s *Service) userFromCtx(ctx context.Context) (userID, role string, err error) {
	claims, ok := auth.ClaimsFrom(ctx)
	if !ok {
		return "", "", ErrUnauthenticated
	}

	sub, _ := claims["sub"].(string)
	if strings.TrimSpace(sub) == "" {
		return "", "", ErrUnauthenticated
	}

	roleStr, _ := claims["role"].(string)
	roleStr = strings.ToUpper(strings.TrimSpace(roleStr))

	return sub, roleStr, nil
}

func requireAdmin(role string) error {
	if role != "ADMIN" {
		return ErrPermission
	}
	return nil
}

func newID() string {
	now := time.Now().UTC()
	return fmt.Sprintf("%d%09d", now.Unix(), now.Nanosecond())
}

func sanitizeFilename(s string) string {
	s = strings.TrimSpace(s)
	s = strings.ReplaceAll(s, "\\", "_")
	s = strings.ReplaceAll(s, "/", "_")
	s = strings.ReplaceAll(s, " ", "_")
	return s
}

func pbBook(r *schemav1.AudiobookRecord, cats []string) *shopv1.Audiobook {
	if r == nil {
		return nil
	}
	out := &shopv1.Audiobook{
		Id:              r.GetId(),
		Title:           r.GetTitle(),
		Author:          r.GetAuthor(),
		DurationSeconds: r.GetDurationSeconds(),
		PriceCents:      r.GetPriceCents(),
		CoverUrl:        r.GetCoverUrl(),
		Status:          storage.ShopStatusFromText(r.GetStatus()),
		Categories:      append([]string(nil), cats...),
		AiDescription:   r.GetAiDescription(),
		CreatedAt:       r.GetCreatedAt(),
		UpdatedAt:       r.GetUpdatedAt(),
	}
	return out
}

// deprecated
func (s *Service) UploadAudiobook(stream shopv1.ShopService_UploadAudiobookServer) error {
	ctx := stream.Context()
	_, role, err := s.userFromCtx(ctx)
	if err != nil {
		return err
	}
	if err := requireAdmin(role); err != nil {
		return err
	}

	// Expect first message as header
	first, err := stream.Recv()
	if err != nil {
		return err
	}
	hdr := first.GetHeader()
	if hdr == nil {
		return errors.New("missing upload header")
	}

	bookID := newID()
	objectKey := fmt.Sprintf("audiobooks/%s/%s", bookID, sanitizeFilename(hdr.GetFilename()))

	err = s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_AUDIO))

	if err != nil {
		return err
	}

	pr, pw := io.Pipe()
	done := make(chan error, 1)

	// Save to blob storage in background
	go func() {
		_, saveErr := s.blobs.SaveStream(ctx, objectKey, pr)
		_ = pr.Close()
		done <- saveErr
	}()

	// Write first (no data in first message), then rest chunks
	for {
		msg, err := stream.Recv()
		if err == io.EOF {
			_ = pw.Close()
			break
		}
		if err != nil {
			_ = pw.CloseWithError(err)
			return err
		}
		if data := msg.GetData(); data != nil {
			if _, werr := pw.Write(data); werr != nil {
				_ = pw.CloseWithError(werr)
				return werr
			}
		}
	}
	saveErr := <-done
	if saveErr != nil {
		// mark failed
		//_ = s.store.UpdateAudiobookAI(ctx, bookID, "", "", "FAILED", nil)
		return saveErr
	}

	audioPath := fmt.Sprintf("./.data/%s", objectKey)

	awsPipeline := aihelper.NewPipeline(
		audioPath,
		aihelper.PipelineProvider_LOCAL,
		30,
		"audiobooks-shop",
		"",
		"ap-southeast-1",
		"",
		true,
		false,
		"audiobooks",
	)

	// AI pipeline

	awsPipelineState := aihelper.PipelineState_Start

	out, err := awsPipeline.Run(func(state aihelper.PipelineState, temOut *aihelper.Output) {
		awsPipelineState = state
	})

	switch awsPipelineState {
	case aihelper.PipelineState_Start:
		return fmt.Errorf("upload audio to cloud is failure")
	case aihelper.PipelineState_UploadComplete:
	case aihelper.PipelineState_TranscriptStarted:
		{
			s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT))
			s.store.SetAudiobookDownloadURL(ctx, bookID, out.OriginalURL)
			return fmt.Errorf("ai transcript is failure")
		}
	case aihelper.PipelineState_TranscriptComplete:
	case aihelper.PipelineState_SummaryStart:
		{
			s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY))
			s.store.SetAudiobookTranscript(ctx, bookID, out.Transcript)
			return fmt.Errorf("ai summary is failure")
		}
	case aihelper.PipelineState_Done:
		{
			categories := []string{}

			for i := 0; i < len(out.CategoriesOut); i++ {
				if i > 2 {
					break
				}
				categories = append(categories, out.CategoriesOut[i].Label)
			}

			err = s.store.UpdateAudiobookAI(ctx, bookID, out.Summary, out.Transcript, out.OriginalURL, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_READY), categories)
		}
	}

	if err != nil {
		fmt.Println("error:", err)
	}

	// Build response from storage
	rec, cats, _ := s.store.GetAudiobookByID(ctx, bookID)
	b := pbBook(rec, cats)
	return stream.SendAndClose(&shopv1.UploadAudiobookResponse{Book: b})
}

func (s *Service) CreateUploadURL(ctx context.Context, r *shopv1.CreateUploadUrlRequest) (*shopv1.CreateUploadUrlResponse, error) {
	_, role, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}
	if err := requireAdmin(role); err != nil {
		return nil, err
	}

	bookID := newID()
	objectKey := fmt.Sprintf("audiobooks/%s/%s", bookID, sanitizeFilename(r.GetFilename()))
	url, err := s.blobs.CreateUploadURL(ctx, objectKey, r.GetContentType(), 1<<30 /*1GB*/, 15*time.Minute)
	if err != nil {
		return nil, err
	}

	rec := &schemav1.AudiobookRecord{
		Id:          bookID,
		Title:       r.GetTitle(),
		Author:      r.GetAuthor(),
		PriceCents:  r.GetPriceCents(),
		AudioPath:   objectKey,
		Status:      "UNSPECIFIED",
		CreatedAt:   timestamppb.Now(),
		UpdatedAt:   timestamppb.Now(),
		CoverUrl:    url,
		ContentType: "audio/mpeg",
	}
	if err := s.store.CreateAudiobookProcessing(ctx, rec); err != nil {
		return nil, err
	}

	return &shopv1.CreateUploadUrlResponse{
		AudiobookId: bookID,
		UploadUrl:   url,
		MaxBytes:    1 << 30,
	}, nil
}

func (s *Service) CompleteUpload(ctx context.Context, r *shopv1.CompleteUploadRequest) (*shopv1.CompleteUploadResponse, error) {
	_, role, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}
	if err := requireAdmin(role); err != nil {
		return nil, err
	}

	rec, _, err := s.store.GetAudiobookByID(ctx, r.GetAudiobookId())
	if err != nil {
		return nil, err
	}

	bookID := rec.Id

	// AI pipeline

	status := rec.GetStatus()

	objectKey := rec.AudioPath

	audioPath := fmt.Sprintf("%s/%s", s.blobs.GetBlobFilePath(), objectKey)

	catagories, _ := s.store.GetAllCategoryLabels(ctx)

	pipelineProvider := aihelper.PipelineProvider_LOCAL

	if r.AiProvider == shopv1.AIProvider_AIProvider_AWS {
		pipelineProvider = aihelper.PipelineProvider_AWS
	}

	aiPipeline := aihelper.NewPipeline(
		audioPath,
		pipelineProvider,
		30,
		"audiobooks-shop",
		"",
		"ap-southeast-1",
		strings.Join(catagories, ","),
		true,
		false,
		"audiobooks",
	)

	awsPipelineState := aihelper.PipelineState_Start
	out := &aihelper.Output{}

	awsPipelineRunCallback := func(state aihelper.PipelineState, tempOut *aihelper.Output) {
		awsPipelineState = state
		switch state {
		case aihelper.PipelineState_Start:
			{
				s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_AUDIO))
			}
		case aihelper.PipelineState_UploadComplete, aihelper.PipelineState_TranscriptStarted:
			{
				s.store.SetAudiobookDownloadURL(ctx, bookID, tempOut.OriginalURL)
				s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT))
			}
		case aihelper.PipelineState_TranscriptComplete, aihelper.PipelineState_SummaryStart:
			{
				s.store.SetAudiobookTranscript(ctx, bookID, tempOut.Transcript)
				s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY))
			}
		}
	}

	if r.ForceStatus == shopv1.MediaStatus_MEDIA_PROCESSING_AUDIO ||
		r.ForceStatus == shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT ||
		r.ForceStatus == shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY {
		status = storage.ShopStatusToText(r.ForceStatus)
	}

	if status == storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_STATUS_UNSPECIFIED) ||
		status == storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_AUDIO) ||
		status == "NONE" ||
		rec.CoverUrl == "" {
		err = s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_AUDIO))
		if err != nil {
			return nil, err
		}
		out, err = aiPipeline.Run(awsPipelineRunCallback)
	} else if status == storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT) || rec.GetTranscript() == "" {
		err = s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT))
		if err != nil {
			return nil, err
		}

		out, err = aiPipeline.ContinueTranscript(rec.GetCoverUrl(), awsPipelineRunCallback)
	} else if status == storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY) {
		err = s.store.SetAudiobookStatus(ctx, bookID, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY))
		if err != nil {
			return nil, err
		}

		out, err = aiPipeline.ContinueSummary(rec.GetTranscript(), awsPipelineRunCallback)
	}

	if err != nil {
		fmt.Println("error:", err)
	}

	switch awsPipelineState {
	case aihelper.PipelineState_Done:
		{
			categories := []string{}

			sb, _ := json.Marshal(out.CategoriesOut)

			fmt.Printf("categories: %s\n", string(sb))

			for i := 0; i < len(out.CategoriesOut); i++ {
				if i > 2 {
					break
				}
				categories = append(categories, out.CategoriesOut[i].Label)
			}

			if out.OriginalURL == "" {
				out.OriginalURL = rec.GetCoverUrl()
			}

			err = s.store.UpdateAudiobookAI(ctx, bookID, out.Summary, out.Transcript, out.OriginalURL, storage.ShopStatusToText(shopv1.MediaStatus_MEDIA_READY), categories)
		}
	default:
		return nil, err
	}

	if err != nil {
		fmt.Println("error:", err)
	}

	rec, cats, _ := s.store.GetAudiobookByID(ctx, r.GetAudiobookId())
	return &shopv1.CompleteUploadResponse{Book: pbBook(rec, cats)}, nil
}

func (s *Service) GetUploadURL(ctx context.Context, r *shopv1.GetUploadURLRequest) (*shopv1.CreateUploadUrlResponse, error) {
	_, role, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, status.Error(codes.Unauthenticated, "unauthenticated")
	}
	if role != "ADMIN" {
		return nil, status.Error(codes.PermissionDenied, "admin only")
	}

	rec, _, err := s.store.GetAudiobookByID(ctx, r.GetAudiobookId())
	if errors.Is(err, storage.ErrNotFound) {
		return nil, status.Error(codes.NotFound, "audiobook not found")
	}
	if err != nil {
		return nil, status.Errorf(codes.Internal, "get audiobook: %v", err)
	}
	/*
		if rec.GetStatus() == "READY" {
			return &shopv1.CreateUploadUrlResponse{
				AudiobookId: rec.GetId(),
				UploadUrl:   url,
			}, nil
		}
	*/
	url, err := s.blobs.CreateUploadURL(ctx, rec.GetAudioPath(), rec.GetContentType(), 0, 15*time.Minute)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "blob.CreateUploadURL: %v", err)
	}

	return &shopv1.CreateUploadUrlResponse{
		AudiobookId: rec.GetId(),
		UploadUrl:   url,
	}, nil
}

func (s *Service) ListAudiobooks(ctx context.Context, r *shopv1.ListAudiobooksRequest) (*shopv1.ListAudiobooksResponse, error) {

	_, role, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}

	ps := int(r.GetPageSize())
	if ps <= 0 || ps > 50 {
		ps = 20
	}
	recs, err := s.store.ListAudiobooks(ctx, r.GetQuery(), r.GetCategory(), ps)
	if err != nil {
		return nil, err
	}
	items := make([]*shopv1.Audiobook, 0, len(recs))

	for _, rec := range recs {
		if role == "ADMIN" {
			items = append(items, rec)
			continue
		}

		if rec.Status == shopv1.MediaStatus_MEDIA_READY {
			items = append(items, rec)
		}

	}
	return &shopv1.ListAudiobooksResponse{Items: items}, nil
}

func (s *Service) GetAudiobook(ctx context.Context, r *shopv1.GetAudiobookRequest) (*shopv1.GetAudiobookResponse, error) {
	rec, cats, err := s.store.GetAudiobookByID(ctx, r.GetId())
	if err != nil {
		return nil, err
	}
	prev, _ := s.store.GetTranscriptPreview(ctx, r.GetId(), 1000)
	return &shopv1.GetAudiobookResponse{
		Book:              pbBook(rec, cats),
		TranscriptPreview: prev,
		Description:       rec.AiDescription,
	}, nil
}

func (s *Service) ViewCart(ctx context.Context, _ *emptypb.Empty) (*shopv1.ViewCartResponse, error) {
	u, _, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}
	items, subtotal, err := s.store.ViewCart(ctx, u)
	if err != nil {
		return nil, err
	}
	out := &shopv1.ViewCartResponse{SubtotalCents: subtotal}
	for i := range items {

		it, cats, _ := s.store.GetAudiobookByID(ctx, items[i].Book.GetId())

		out.Items = append(out.Items, &shopv1.CartItem{
			Book: &shopv1.Audiobook{
				Id:         it.GetId(),
				Title:      it.GetTitle(),
				Author:     it.GetAuthor(),
				PriceCents: it.GetPriceCents(),
				Categories: cats,
			},
			LineSubtotalCents: items[i].Line,
		})
	}
	return out, nil
}

func (s *Service) AddToCart(ctx context.Context, r *shopv1.AddToCartRequest) (*shopv1.ViewCartResponse, error) {
	u, _, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}

	if err := s.store.AddToCart(ctx, u, r.GetAudiobookId()); err != nil {
		return nil, err
	}
	return s.ViewCart(ctx, &emptypb.Empty{})
}

func (s *Service) RemoveFromCart(ctx context.Context, r *shopv1.RemoveFromCartRequest) (*shopv1.ViewCartResponse, error) {
	u, _, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}
	if err := s.store.RemoveFromCart(ctx, u, r.GetAudiobookId()); err != nil {
		return nil, err
	}
	return s.ViewCart(ctx, &emptypb.Empty{})
}

func (s *Service) Checkout(ctx context.Context, _ *emptypb.Empty) (*shopv1.CheckoutResponse, error) {
	u, _, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}
	orderUID, total, err := s.store.Checkout(ctx, u)
	if err != nil {
		return nil, err
	}
	return &shopv1.CheckoutResponse{
		OrderId:    orderUID,
		TotalCents: total,
		CreatedAt:  timestamppb.Now(),
	}, nil
}

func (s *Service) ListPurchases(ctx context.Context, _ *emptypb.Empty) (*shopv1.ListPurchasesResponse, error) {
	u, _, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}
	rows, err := s.store.ListPurchases(ctx, u, 100)
	if err != nil {
		return nil, err
	}
	out := &shopv1.ListPurchasesResponse{}
	for i := range rows {
		row := &rows[i]
		b := &row.Book
		_, cats, _ := s.store.GetAudiobookByID(ctx, b.GetId())
		out.Items = append(out.Items, &shopv1.ListPurchasesResponse_PurchasedItem{
			OrderId: "",
			Book: &shopv1.Audiobook{
				Id:         b.GetId(),
				Title:      b.GetTitle(),
				Author:     b.GetAuthor(),
				PriceCents: b.GetPriceCents(),
				CreatedAt:  timestamppb.New(row.Time),
				Categories: cats,
			},
			PriceCents:  row.PriceCents,
			PurchasedAt: timestamppb.New(row.Time),
		})
	}
	return out, nil
}

func (s *Service) GetDownloadURL(ctx context.Context, r *shopv1.GetDownloadURLRequest) (*shopv1.GetDownloadURLResponse, error) {
	u, _, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}
	ok, err := s.store.HasPurchased(ctx, u, r.GetAudiobookId())
	if err != nil {
		return nil, err
	}
	if !ok {
		return nil, ErrPermission
	}

	ab, _, err := s.store.GetAudiobookByID(ctx, r.GetAudiobookId())
	if err != nil {
		return nil, err
	}
	/*
		url, err := s.blobs.CreateDownloadURL(ctx, key, 10*time.Minute)
		if err != nil {
			return nil, err
		}
	*/
	return &shopv1.GetDownloadURLResponse{DownloadUrl: ab.GetCoverUrl()}, nil
}

func (s *Service) GetTranscript(ctx context.Context, r *shopv1.GetTranscriptRequest) (*shopv1.GetTranscriptResponse, error) {
	u, _, err := s.userFromCtx(ctx)
	if err != nil {
		return nil, err
	}
	ok, err := s.store.HasPurchased(ctx, u, r.GetAudiobookId())
	if err != nil {
		return nil, err
	}
	if !ok {
		return nil, ErrPermission
	}
	rec, _, err := s.store.GetAudiobookByID(ctx, r.GetAudiobookId())
	if err != nil {
		return nil, err
	}
	return &shopv1.GetTranscriptResponse{Transcript: rec.GetTranscript()}, nil
}

func (s *Service) GetDescription(ctx context.Context, r *shopv1.GetDescriptionRequest) (*shopv1.GetDescriptionResponse, error) {
	rec, _, err := s.store.GetAudiobookByID(ctx, r.GetAudiobookId())
	if err != nil {
		return nil, err
	}
	return &shopv1.GetDescriptionResponse{Description: rec.GetAiDescription()}, nil
}

func (s *Service) GetAudiobookStatus(ctx context.Context, r *shopv1.GetAudiobookStatusRequest) (*shopv1.GetAudiobookStatusResponse, error) {
	rec, _, err := s.store.GetAudiobookByID(ctx, r.GetAudiobookId())
	if err != nil {
		return nil, err
	}
	return &shopv1.GetAudiobookStatusResponse{Status: storage.ShopStatusFromText(rec.GetStatus())}, nil
}
