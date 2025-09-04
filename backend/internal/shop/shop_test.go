package shop

import (
	"context"
	"database/sql"
	"fmt"
	"math/rand"
	"os"
	"path/filepath"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/golang-jwt/jwt/v5"
	"google.golang.org/protobuf/types/known/emptypb"

	authv1 "github.com/backend/gen/auth/v1"
	shopv1 "github.com/backend/gen/shop/v1"
	"github.com/backend/internal/auth"
	"github.com/backend/internal/shopmock"
	"github.com/backend/internal/storage"
)

var (
	sharedDB *sql.DB
	secret   = []byte("test-secret")
)

func newSvcT(t *testing.T, audiobookId *string) *Service {

	if sharedDB == nil {
		sharedDB = mustOpenMySQL(t)
	}

	blobPath := getenvDefault("BLOB_STORAGE_PATH", "../../.data/blob")

	blobs, err := shopmock.NewLocalHTTPBlobStore(blobPath, getenvDefault("BLOB_BIND_ADDR", "0.0.0.0:0"), getenvDefault("BLOB_PUBLIC_BASE_URL", "http://0.0.0.0:0"))

	if err != nil {
		t.Fatalf("create http error: %v", err)
	}

	t.Cleanup(func() { cleanMySQLTestData(t, sharedDB, *audiobookId) })

	return NewService(storage.NewSQLStore(sharedDB), blobs, secret)

}

func makeJWT(t *testing.T, sub string, role string, secret []byte) string {
	t.Helper()

	claims := jwt.MapClaims{
		"sub":      sub,
		"email":    "test",
		"provider": "AUTH_PROVIDER_TEST",
		"role":     role,
		"iat":      time.Now().Unix(),
		"exp":      jwt.NewNumericDate(time.Now().Add(time.Hour)),
		"aud":      "auth_service",
	}

	tok := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	signed, err := tok.SignedString(secret)
	if err == nil {
		return signed
	}
	return ""
}

func mustOpenMySQL(t *testing.T) *sql.DB {
	t.Helper()
	dsn := getenvDefault("MYSQL_DSN",
		"root:12345@tcp(127.0.0.1:3306)/auth?parseTime=true&loc=UTC&charset=utf8mb4",
	)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		t.Fatalf("open mysql: %v", err)
	}
	if err := db.Ping(); err != nil {
		t.Fatalf("ping mysql: %v", err)
	}
	return db
}

func getenvDefault(k, def string) string {
	if v := os.Getenv(k); v != "" {
		return v
	}
	return def
}

func cleanMySQLTestData(t *testing.T, db *sql.DB, audiobookId string) {
	t.Helper()

	ctx := context.Background()
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		t.Fatalf("begin tx: %v", err)
	}
	defer func() {
		_ = tx.Rollback()
	}()

	if audiobookId == "" {
		return
	}

	if _, err := tx.ExecContext(ctx,
		"DELETE FROM order_items WHERE audiobook_id LIKE ?", audiobookId,
	); err != nil {
		t.Fatalf("delete order_items: %v", err)
	}

	if _, err := tx.ExecContext(ctx,
		"DELETE FROM purchases WHERE audiobook_id LIKE ?", audiobookId,
	); err != nil {
		t.Fatalf("delete purchases: %v", err)
	}

	if _, err := tx.ExecContext(ctx, `
        DELETE FROM audiobook_categories WHERE audiobook_id IN (
            SELECT id FROM audiobooks WHERE id LIKE ?
        )`, audiobookId); err != nil {
		t.Fatalf("delete audiobook_categories: %v", err)
	}

	if _, err := tx.ExecContext(ctx,
		"DELETE FROM audiobooks WHERE id LIKE ?", audiobookId,
	); err != nil {
		t.Fatalf("delete audiobooks: %v", err)
	}

	pattern := "test+%@testshopgo.com"

	if _, err := tx.ExecContext(ctx, `
        DELETE FROM refresh_tokens WHERE user_id IN (
            SELECT id FROM users WHERE email LIKE ?
        )`, pattern); err != nil {
		t.Fatalf("delete refresh_tokens: %v", err)
	}

	if _, err := tx.ExecContext(ctx, `
        DELETE FROM reset_tokens WHERE user_id IN (
            SELECT id FROM users WHERE email LIKE ?
        )`, pattern); err != nil {
		t.Fatalf("delete reset_tokens: %v", err)
	}

	if _, err := tx.ExecContext(ctx,
		"DELETE FROM users WHERE email LIKE ?", pattern,
	); err != nil {
		t.Fatalf("delete users: %v", err)
	}

	if err := tx.Commit(); err != nil {
		t.Fatalf("commit: %v", err)
	}
}

func TestShop_ShopAction_Local(t *testing.T) {

	if sharedDB == nil {
		sharedDB = mustOpenMySQL(t)
	}

	auths := auth.NewService(storage.NewSQLStore(sharedDB), secret)

	email, pass := fmt.Sprintf("test+%d@testshopgo.com", (rand.Intn(1000)+100)), "xYz#12345"

	authr, err := auths.SignUp(context.Background(), &authv1.SignUpRequest{
		Email:    email,
		Password: pass,
	})

	if err != nil {
		t.Fatalf("expected SignUp error %s", err)
	}
	str := ""
	audiobookId := &str
	service := newSvcT(t, audiobookId)

	adminJWT := makeJWT(t, authr.User.Id, "ADMIN", secret)

	claims, _ := auth.VerifyJWT(adminJWT, secret)

	ctx := auth.WithClaims(context.Background(), claims)

	up, err := service.CreateUploadURL(ctx, &shopv1.CreateUploadUrlRequest{
		Title:       "Test Book",
		Author:      "Unit Tester",
		PriceCents:  12900,
		Filename:    "test_book.mp3",
		ContentType: "audio/mpeg",
	})
	if err != nil {
		t.Fatalf("CreateUploadURL: %v", err)
	}
	if up.GetAudiobookId() == "" {
		t.Fatalf("missing audiobook_id")
	}

	*audiobookId = up.GetAudiobookId()

	rec, _, err := service.store.GetAudiobookByID(context.Background(), up.GetAudiobookId())
	if err != nil {
		t.Fatalf("GetAudiobookByID: %v", err)
	}

	path := filepath.Join(service.blobs.GetBlobFilePath(), filepath.FromSlash(rec.GetAudioPath()))

	f, err := os.Open("./testasset/test_book.mp3")

	if err != nil {
		t.Fatalf("open test file: %v", err)
	}
	defer f.Close()

	if _, err := service.blobs.SaveStream(context.Background(), path, f); err != nil {
		t.Fatalf("SaveStream: %v", err)
	}

	defer os.Remove(path)

	info, err := os.Stat(path)
	if err != nil {
		t.Fatalf("file not found: %v", err)
	}
	t.Logf("saved file: %s (%d bytes)", path, info.Size())

	cmp, err := service.CompleteUpload(ctx, &shopv1.CompleteUploadRequest{AudiobookId: up.GetAudiobookId(), AiProvider: shopv1.AIProvider_AIProvider_LOCAL})
	if err != nil {
		t.Fatalf("CompleteUpload: %v", err)
	}
	if got := cmp.GetBook().GetStatus(); got != shopv1.MediaStatus_MEDIA_READY {
		t.Fatalf("status = %v, want MEDIA_READY", got)
	}

	cmp, err = service.CompleteUpload(ctx, &shopv1.CompleteUploadRequest{AudiobookId: up.GetAudiobookId(), AiProvider: shopv1.AIProvider_AIProvider_LOCAL, ForceStatus: shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT})
	if err != nil {
		t.Fatalf("CompleteUpload: %v", err)
	}
	if got := cmp.GetBook().GetStatus(); got != shopv1.MediaStatus_MEDIA_READY {
		t.Fatalf("status = %v, want MEDIA_READY", got)
	}

	cmp, err = service.CompleteUpload(ctx, &shopv1.CompleteUploadRequest{AudiobookId: up.GetAudiobookId(), AiProvider: shopv1.AIProvider_AIProvider_LOCAL, ForceStatus: shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY})
	if err != nil {
		t.Fatalf("CompleteUpload: %v", err)
	}
	if got := cmp.GetBook().GetStatus(); got != shopv1.MediaStatus_MEDIA_READY {
		t.Fatalf("status = %v, want MEDIA_READY", got)
	}

	lab, err := service.ListAudiobooks(ctx, &shopv1.ListAudiobooksRequest{PageSize: 10,
		PageToken: "",
		Query:     "",
		Category:  ""})

	if err != nil {
		t.Fatalf("expected ListAudiobooks error %s", err)
	}

	labf := false
	for i := 0; i < len(lab.Items); i++ {
		if lab.Items[i].Id == *audiobookId {
			labf = true
		}
	}

	if !labf {
		t.Fatalf("expected  create audiobooks error")
	}

	_, err = service.AddToCart(ctx, &shopv1.AddToCartRequest{AudiobookId: *audiobookId})

	if err != nil {
		t.Fatalf("expected AddToCart error %s", err)
	}

	_, err = service.Checkout(ctx, &emptypb.Empty{})

	if err != nil {
		t.Fatalf("expected Checkout error %s", err)
	}

	_, err = service.GetDownloadURL(ctx, &shopv1.GetDownloadURLRequest{AudiobookId: *audiobookId})

	if err != nil {
		t.Fatalf("expected GetDownloadURL error %s", err)
	}

	t.Log("create upload and upload complete ok.")
}

func TestShop_ShopAction_AWS(t *testing.T) {

	if sharedDB == nil {
		sharedDB = mustOpenMySQL(t)
	}

	auths := auth.NewService(storage.NewSQLStore(sharedDB), secret)

	email, pass := fmt.Sprintf("test+%d@testshopgo.com", (rand.Intn(1000)+100)), "xYz#12345"

	authr, err := auths.SignUp(context.Background(), &authv1.SignUpRequest{
		Email:    email,
		Password: pass,
	})

	if err != nil {
		t.Fatalf("expected SignUp error %s", err)
	}
	str := ""
	audiobookId := &str
	service := newSvcT(t, audiobookId)

	adminJWT := makeJWT(t, authr.User.Id, "ADMIN", secret)

	claims, _ := auth.VerifyJWT(adminJWT, secret)

	ctx := auth.WithClaims(context.Background(), claims)

	up, err := service.CreateUploadURL(ctx, &shopv1.CreateUploadUrlRequest{
		Title:       "Test Book",
		Author:      "Unit Tester",
		PriceCents:  12900,
		Filename:    "test_book.mp3",
		ContentType: "audio/mpeg",
	})
	if err != nil {
		t.Fatalf("CreateUploadURL: %v", err)
	}
	if up.GetAudiobookId() == "" {
		t.Fatalf("missing audiobook_id")
	}

	*audiobookId = up.GetAudiobookId()

	rec, _, err := service.store.GetAudiobookByID(context.Background(), up.GetAudiobookId())
	if err != nil {
		t.Fatalf("GetAudiobookByID: %v", err)
	}

	path := filepath.Join(service.blobs.GetBlobFilePath(), filepath.FromSlash(rec.GetAudioPath()))

	f, err := os.Open("./testasset/test_book.mp3")

	if err != nil {
		t.Fatalf("open test file: %v", err)
	}
	defer f.Close()

	if _, err := service.blobs.SaveStream(context.Background(), path, f); err != nil {
		t.Fatalf("SaveStream: %v", err)
	}

	defer os.Remove(path)

	info, err := os.Stat(path)
	if err != nil {
		t.Fatalf("file not found: %v", err)
	}
	t.Logf("saved file: %s (%d bytes)", path, info.Size())

	cmp, err := service.CompleteUpload(ctx, &shopv1.CompleteUploadRequest{AudiobookId: up.GetAudiobookId(), AiProvider: shopv1.AIProvider_AIProvider_AWS})
	if err != nil {
		t.Fatalf("CompleteUpload: %v", err)
	}
	if got := cmp.GetBook().GetStatus(); got != shopv1.MediaStatus_MEDIA_READY {
		t.Fatalf("status = %v, want MEDIA_READY", got)
	}

	cmp, err = service.CompleteUpload(ctx, &shopv1.CompleteUploadRequest{AudiobookId: up.GetAudiobookId(), AiProvider: shopv1.AIProvider_AIProvider_AWS, ForceStatus: shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT})
	if err != nil {
		t.Fatalf("CompleteUpload: %v", err)
	}
	if got := cmp.GetBook().GetStatus(); got != shopv1.MediaStatus_MEDIA_READY {
		t.Fatalf("status = %v, want MEDIA_READY", got)
	}

	cmp, err = service.CompleteUpload(ctx, &shopv1.CompleteUploadRequest{AudiobookId: up.GetAudiobookId(), AiProvider: shopv1.AIProvider_AIProvider_AWS, ForceStatus: shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY})
	if err != nil {
		t.Fatalf("CompleteUpload: %v", err)
	}
	if got := cmp.GetBook().GetStatus(); got != shopv1.MediaStatus_MEDIA_READY {
		t.Fatalf("status = %v, want MEDIA_READY", got)
	}

	lab, err := service.ListAudiobooks(ctx, &shopv1.ListAudiobooksRequest{PageSize: 10,
		PageToken: "",
		Query:     "",
		Category:  ""})

	if err != nil {
		t.Fatalf("expected ListAudiobooks error %s", err)
	}

	labf := false
	for i := 0; i < len(lab.Items); i++ {
		if lab.Items[i].Id == *audiobookId {
			labf = true
		}
	}

	if !labf {
		t.Fatalf("expected  create audiobooks error")
	}

	_, err = service.AddToCart(ctx, &shopv1.AddToCartRequest{AudiobookId: *audiobookId})

	if err != nil {
		t.Fatalf("expected AddToCart error %s", err)
	}

	_, err = service.Checkout(ctx, &emptypb.Empty{})

	if err != nil {
		t.Fatalf("expected Checkout error %s", err)
	}

	_, err = service.GetDownloadURL(ctx, &shopv1.GetDownloadURLRequest{AudiobookId: *audiobookId})

	if err != nil {
		t.Fatalf("expected GetDownloadURL error %s", err)
	}

	t.Log("create upload and upload complete ok.")
}
