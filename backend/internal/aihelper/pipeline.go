package aihelper

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"math/rand"
	"net/url"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strings"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/feature/s3/manager"
	"github.com/aws/aws-sdk-go-v2/service/bedrockruntime"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/transcribe"

	s3types "github.com/aws/aws-sdk-go-v2/service/s3/types"
	trTypes "github.com/aws/aws-sdk-go-v2/service/transcribe/types"
)

type PipelineAPI interface {
	Run(callback func(PipelineState, *Output)) (*Output, error)

	ContinueTranscript(s3URL string, callback func(PipelineState, *Output)) (*Output, error)

	ContinueSummary(transcript string, callback func(PipelineState, *Output)) (*Output, error)
}

var _ PipelineAPI = (*Pipeline)(nil)

type Output struct {
	OriginalURL   string                 `json:"original_url"`
	ClipURL       string                 `json:"clip_url"`
	Transcript    string                 `json:"transcript"`
	Summary       string                 `json:"summary_spoiler_free"`
	CategoriesOut []CategoryWithScore    `json:"categories"`
	NewCategory   *CategoryWithScore     `json:"new_category,omitempty"`
	Meta          map[string]interface{} `json:"meta,omitempty"`
}

type PipelineState int

const (
	PipelineState_Start              PipelineState = 0
	PipelineState_UploadComplete     PipelineState = 1
	PipelineState_TranscriptStarted  PipelineState = 2
	PipelineState_TranscriptComplete PipelineState = 3
	PipelineState_SummaryStart       PipelineState = 4
	PipelineState_Done               PipelineState = 5
)

type transcribeJSON struct {
	Results struct {
		Transcripts []struct {
			Transcript string `json:"transcript"`
		} `json:"transcripts"`
	} `json:"results"`
}

type CategoryWithScore struct {
	Label      string  `json:"label"`
	Confidence float32 `json:"confidence"`
}

type Pipeline struct {
	inputPath      string
	provider       PipelineProvider
	clipSeconds    int
	bucket         string
	prefix         string
	region         string
	ffmpegPath     string
	existingCats   string
	languageCode   string
	mediaFormat    string
	modelID        string
	makePublic     bool
	usePresignOnly bool
	keyAnchor      string

	localPipeline *LocalPipeline
}

type PipelineProvider int

const (
	PipelineProvider_AWS   PipelineProvider = 0
	PipelineProvider_LOCAL PipelineProvider = 1
)

func NewPipeline(
	audioLocalPath string,
	provider PipelineProvider,
	clipSeconds int,
	bucket string,
	prefix string,
	region string,
	existingCats string,
	makePublic bool,
	usePresignOnly bool,
	keyAnchor string,
) *Pipeline {
	if region == "" {
		region = "ap-southeast-1"
	}
	if clipSeconds <= 0 {
		clipSeconds = 30
	}

	if existingCats == "" {
		existingCats = `["News","Education","Technology","Business","Health","Society & Culture","Entertainment","True Crime","Sports","Interview", "Fantasy"]`
	}

	return &Pipeline{
		inputPath:      audioLocalPath,
		provider:       provider,
		clipSeconds:    clipSeconds,
		bucket:         bucket,
		prefix:         prefix,
		region:         region,
		ffmpegPath:     "ffmpeg",
		existingCats:   existingCats,
		languageCode:   "en-US",
		mediaFormat:    "mp3",
		modelID:        "us.amazon.nova-lite-v1:0",
		makePublic:     makePublic,
		usePresignOnly: usePresignOnly,
		keyAnchor:      keyAnchor,
		localPipeline:  NewLocalPipeline(getenvDefault("AI_API_BASE", "http://127.0.0.1:8000")),
	}
}

func getenvDefault(k, def string) string {
	if v := os.Getenv(k); v != "" {
		return v
	}
	return def
}

func (p *Pipeline) Run(callback func(PipelineState, *Output)) (*Output, error) {
	if callback == nil {
		callback = func(PipelineState, *Output) {}
	}
	if err := p.validate(); err != nil {
		return nil, err
	}
	outPartial := &Output{
		Meta: map[string]interface{}{
			"bucket":        p.bucket,
			"prefix":        p.prefix,
			"language_code": p.languageCode,
			"model_id":      p.modelID,
			"region":        p.region,
		},
	}

	ctx := context.Background()
	cfg, err := config.LoadDefaultConfig(ctx, config.WithRegion(p.region))
	if err != nil {
		return outPartial, fmt.Errorf("load aws config: %w", err)
	}
	s3c := s3.NewFromConfig(cfg)
	uploader := manager.NewUploader(s3c)
	//trc := transcribe.NewFromConfig(cfg)
	/*
		clipPath := makeClipPath(p.inputPath)
		if err := trimAndCompressAudio(p.ffmpegPath, p.inputPath, clipPath, p.clipSeconds); err != nil {
			return outPartial, fmt.Errorf("trim+compress audio: %w", err)
		}
	*/
	if p.keyAnchor == "" {
		p.keyAnchor = "audiobooks"
	}
	origKey, _ := deriveS3KeysFromLocalPath(p.inputPath, p.keyAnchor, p.prefix)

	origURL, err := uploadAndLink(ctx, uploader, s3c, p.bucket, origKey, p.inputPath, p.region, p.makePublic, p.usePresignOnly)
	if err != nil {
		return outPartial, fmt.Errorf("upload original: %w", err)
	}
	outPartial.OriginalURL = origURL
	outPartial.ClipURL = origURL
	/*
		clipURL, err := uploadAndLink(ctx, uploader, s3c, p.bucket, clipKey, clipPath, p.region, p.makePublic, p.usePresignOnly)
		if err != nil {
			return outPartial, fmt.Errorf("upload clip: %w", err)
		}
		outPartial.ClipURL = clipURL
	*/
	callback(PipelineState_UploadComplete, outPartial)

	pipelineOut, err := p.ContinueTranscript(origURL, callback)

	outPartial.Transcript = pipelineOut.Transcript
	outPartial.Summary = pipelineOut.Summary
	outPartial.CategoriesOut = pipelineOut.CategoriesOut
	outPartial.NewCategory = pipelineOut.NewCategory

	if err != nil {
		return outPartial, fmt.Errorf("ai pipelier clip: %w", err)
	}

	/*
		callback(PipelineState_TranscriptStarted, outPartial)
		base := strings.TrimSuffix(filepath.Base(p.inputPath), filepath.Ext(p.inputPath))
		jobName := fmt.Sprintf("job-%s-%d-%04d", base, time.Now().Unix(), rand.Intn(10000))
		outPrefix := strings.TrimSuffix(origKey, filepath.Ext(origKey)) + ".json"

		if err := startTranscribe(ctx, trc, jobName, p.bucket, origKey, p.mediaFormat, p.languageCode, p.bucket, outPrefix); err != nil {
			return outPartial, fmt.Errorf("start transcribe: %w", err)
		}
		if err := waitTranscribe(ctx, trc, jobName, 60*time.Minute, 5*time.Second); err != nil {
			return outPartial, fmt.Errorf("wait transcribe: %w", err)
		}

		transcriptKey, err := getTranscriptS3Key(ctx, trc, jobName)
		if err != nil {
			return outPartial, fmt.Errorf("get transcript key: %w", err)
		}
		outPartial.Meta["transcript_key"] = transcriptKey

		transcriptText, err := readTranscript(ctx, s3c, p.bucket, transcriptKey)
		if err != nil {
			return outPartial, fmt.Errorf("read transcript: %w", err)
		}
		outPartial.Transcript = transcriptText
		callback(PipelineState_TranscriptComplete, outPartial)

		if p.modelID == "" {
			p.modelID = "us.amazon.nova-lite-v1:0"
		}

		p.region = "us-east-1"

		cfg, err = config.LoadDefaultConfig(ctx, config.WithRegion(p.region))
		if err != nil {
			return outPartial, fmt.Errorf("load aws config: %w", err)
		}

		brc := bedrockruntime.NewFromConfig(cfg)

		callback(PipelineState_SummaryStart, outPartial)

		existing, err := parseCategories(p.existingCats)
		if err != nil {
			return outPartial, fmt.Errorf("parse categories: %w", err)
		}
		sum, cats, newCat, err := bedrockSummarizeAndClassifyNova(ctx, brc, p.modelID, transcriptText, existing)
		if err != nil {
			return outPartial, fmt.Errorf("bedrock summarize+classify: %w", err)
		}
		outPartial.Summary = sum
		outPartial.CategoriesOut = cats
		outPartial.NewCategory = newCat

		callback(PipelineState_Done, outPartial)
	*/
	return outPartial, nil
}

func (p *Pipeline) ContinueTranscript(s3URL string, callback func(PipelineState, *Output)) (*Output, error) {
	if callback == nil {
		callback = func(PipelineState, *Output) {}
	}

	outPartial := &Output{Meta: map[string]interface{}{"region": p.region}}
	outPartial.OriginalURL = s3URL
	outPartial.ClipURL = s3URL
	if p.provider == PipelineProvider_LOCAL {

		callback(PipelineState_TranscriptStarted, outPartial)

		trans, err := p.localPipeline.transcribe(context.Background(), s3URL)

		if err != nil {
			return outPartial, err
		}

		outPartial.Transcript = trans

		callback(PipelineState_TranscriptComplete, outPartial)

		callback(PipelineState_SummaryStart, outPartial)

		sum, categories, err := p.localPipeline.summarize(context.Background(), trans, p.existingCats)

		if err != nil {
			return outPartial, err
		}

		outPartial.CategoriesOut = categories
		outPartial.Summary = sum

		callback(PipelineState_Done, outPartial)

		return outPartial, err
	}

	if p.region == "" {
		p.region = "ap-southeast-1"
	}
	if p.languageCode == "" {
		p.languageCode = "en-US"
	}
	if p.mediaFormat == "" {
		p.mediaFormat = "mp3"
	}

	bucket, key, err := parseS3URL(s3URL)

	if err != nil {
		return outPartial, err
	}
	outPartial.Meta["bucket"] = bucket
	outPartial.Meta["source_key"] = key

	ctx := context.Background()
	cfg, err := config.LoadDefaultConfig(ctx, config.WithRegion(p.region))
	if err != nil {
		return outPartial, fmt.Errorf("load aws config: %w", err)
	}
	s3c := s3.NewFromConfig(cfg)
	trc := transcribe.NewFromConfig(cfg)

	callback(PipelineState_TranscriptStarted, outPartial)
	jobName := fmt.Sprintf("job-cont-%d-%04d", time.Now().Unix(), rand.Intn(10000))
	outBucket := p.bucket
	if outBucket == "" {
		outBucket = bucket
	}
	outPrefix := strings.TrimSuffix(key, filepath.Ext(key)) + ".json"

	if err := startTranscribe(ctx, trc, jobName, bucket, key, p.mediaFormat, p.languageCode, outBucket, outPrefix); err != nil {
		return outPartial, fmt.Errorf("start transcribe: %w", err)
	}
	if err := waitTranscribe(ctx, trc, jobName, 60*time.Minute, 5*time.Second); err != nil {
		return outPartial, fmt.Errorf("wait transcribe: %w", err)
	}

	transcriptKey, err := getTranscriptS3Key(ctx, trc, jobName)
	if err != nil {
		return outPartial, fmt.Errorf("get transcript key: %w", err)
	}
	outPartial.Meta["transcript_key"] = transcriptKey

	txt, err := readTranscript(ctx, s3c, outBucket, transcriptKey)
	if err != nil {
		return outPartial, fmt.Errorf("read transcript: %w", err)
	}
	outPartial.Transcript = txt
	callback(PipelineState_TranscriptComplete, outPartial)

	return p.ContinueSummary(outPartial.Transcript, callback)
}

func (p *Pipeline) ContinueSummary(transcript string, callback func(PipelineState, *Output)) (*Output, error) {
	if callback == nil {
		callback = func(PipelineState, *Output) {}
	}

	outPartial := &Output{
		Transcript: transcript,
		Meta:       map[string]interface{}{"region": p.region, "model_id": p.modelID},
	}

	if p.provider == PipelineProvider_LOCAL {

		callback(PipelineState_SummaryStart, outPartial)

		sum, categories, err := p.localPipeline.summarize(context.Background(), transcript, p.existingCats)

		if err != nil {
			return outPartial, err
		}

		outPartial.CategoriesOut = categories
		outPartial.Summary = sum

		callback(PipelineState_Done, outPartial)

		return outPartial, err
	}

	if p.region == "" {
		p.region = "ap-southeast-1"
	}

	if p.modelID == "" {
		p.modelID = "us.amazon.nova-lite-v1:0"
	}

	p.region = "us-east-1"

	ctx := context.Background()
	cfg, err := config.LoadDefaultConfig(ctx, config.WithRegion(p.region))
	if err != nil {
		return outPartial, fmt.Errorf("load aws config: %w", err)
	}
	brc := bedrockruntime.NewFromConfig(cfg)

	callback(PipelineState_SummaryStart, outPartial)

	existing, err := parseCategories(p.existingCats)
	if err != nil {
		return outPartial, fmt.Errorf("parse categories: %w", err)
	}
	sum, cats, newCat, err := bedrockSummarizeAndClassifyNova(ctx, brc, p.modelID, transcript, existing)
	if err != nil {
		return outPartial, fmt.Errorf("bedrock summarize+classify: %w", err)
	}
	outPartial.Summary = sum
	outPartial.CategoriesOut = cats
	outPartial.NewCategory = newCat

	callback(PipelineState_Done, outPartial)
	return outPartial, nil
}

func (p *Pipeline) validate() error {
	if p.inputPath == "" {
		return errors.New("inputPath is required")
	}
	if _, err := os.Stat(p.inputPath); err != nil {
		return fmt.Errorf("input file not found: %w", err)
	}
	if p.bucket == "" {
		return errors.New("bucket is required")
	}
	if p.region == "" {
		p.region = "ap-southeast-1"
	}

	if p.clipSeconds <= 0 {
		p.clipSeconds = 30
	}
	if p.languageCode == "" {
		p.languageCode = "en-US"
	}
	if p.mediaFormat == "" {
		p.mediaFormat = "mp3"
	}
	if p.modelID == "" {
		p.modelID = "us.amazon.nova-lite-v1:0"
	}
	return nil
}

func pathJoin(parts ...string) string {
	return strings.TrimLeft(strings.ReplaceAll(filepath.ToSlash(filepath.Join(parts...)), "//", "/"), "/")
}

func dispFilename(name string) string {
	enc := url.PathEscape(name) // UTF-8 → percent-encode
	return fmt.Sprintf(`attachment; filename="%s"; filename*=UTF-8''%s`, name, enc)
}

func uploadAndLink(
	ctx context.Context,
	uploader *manager.Uploader,
	s3c *s3.Client,
	bucket, key, localPath, region string,
	makePublic bool,
	usePresignOnly bool,
) (string, error) {
	f, err := os.Open(localPath)
	if err != nil {
		return "", err
	}
	defer f.Close()

	filename := path.Base(localPath)

	put := &s3.PutObjectInput{
		Bucket:             aws.String(bucket),
		Key:                aws.String(key),
		Body:               f,
		ContentType:        aws.String("audio/mpeg"),
		ContentDisposition: aws.String(dispFilename(filename)),
	}
	if makePublic && !usePresignOnly {
		put.ACL = s3types.ObjectCannedACLPublicRead
	}

	if _, err := uploader.Upload(ctx, put); err != nil {
		return "", err
	}

	if usePresignOnly {
		ps := s3.NewPresignClient(s3c)
		urlOut, err := ps.PresignGetObject(ctx, &s3.GetObjectInput{
			Bucket: aws.String(bucket),
			Key:    aws.String(key),
		}, s3.WithPresignExpires(24*time.Hour))
		if err != nil {
			return "", err
		}
		return urlOut.URL, nil
	}
	return fmt.Sprintf("https://%s.s3.%s.amazonaws.com/%s", bucket, region, key), nil
}

func startTranscribe(
	ctx context.Context,
	trc *transcribe.Client,
	jobName string,
	srcBucket, srcKey, mediaFmt, lang, outBucket, outPrefix string,
) error {
	mediaURI := fmt.Sprintf("s3://%s/%s", srcBucket, srcKey)
	_, err := trc.StartTranscriptionJob(ctx, &transcribe.StartTranscriptionJobInput{
		TranscriptionJobName: aws.String(jobName),
		LanguageCode:         trTypes.LanguageCode(lang),
		Media:                &trTypes.Media{MediaFileUri: aws.String(mediaURI)},
		MediaFormat:          trTypes.MediaFormat(mediaFmt),
		OutputBucketName:     aws.String(outBucket),
		OutputKey:            aws.String(outPrefix),
		Settings:             &trTypes.Settings{ShowSpeakerLabels: aws.Bool(false)},
	})
	return err
}

func waitTranscribe(ctx context.Context, trc *transcribe.Client, jobName string, timeout, poll time.Duration) error {
	deadline := time.Now().Add(timeout)
	for {
		if time.Now().After(deadline) {
			return errors.New("transcribe timeout")
		}
		out, err := trc.GetTranscriptionJob(ctx, &transcribe.GetTranscriptionJobInput{
			TranscriptionJobName: aws.String(jobName),
		})
		if err != nil {
			return err
		}
		switch out.TranscriptionJob.TranscriptionJobStatus {
		case trTypes.TranscriptionJobStatusCompleted:
			return nil
		case trTypes.TranscriptionJobStatusFailed:
			return fmt.Errorf("transcribe failed: %s", aws.ToString(out.TranscriptionJob.FailureReason))
		}
		time.Sleep(poll)
	}
}

func getTranscriptS3Key(ctx context.Context, trc *transcribe.Client, jobName string) (string, error) {
	out, err := trc.GetTranscriptionJob(ctx, &transcribe.GetTranscriptionJobInput{
		TranscriptionJobName: aws.String(jobName),
	})
	if err != nil {
		return "", err
	}
	uri := aws.ToString(out.TranscriptionJob.Transcript.TranscriptFileUri)
	parts := strings.SplitN(uri, "/", 5)
	if len(parts) < 5 {
		return "", fmt.Errorf("unexpected transcript uri: %s", uri)
	}
	return parts[4], nil
}

func readTranscript(ctx context.Context, s3c *s3.Client, bucket, key string) (string, error) {
	o, err := s3c.GetObject(ctx, &s3.GetObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(key),
	})
	if err != nil {
		return "", err
	}
	defer o.Body.Close()
	b, err := io.ReadAll(o.Body)
	if err != nil {
		return "", err
	}
	var tj transcribeJSON
	if err := json.Unmarshal(b, &tj); err != nil {
		return "", err
	}
	if len(tj.Results.Transcripts) == 0 {
		return "", errors.New("no transcripts found")
	}
	return tj.Results.Transcripts[0].Transcript, nil
}

func stripToJSON(s string) string {
	s = strings.TrimSpace(s)
	if strings.HasPrefix(s, "```") {
		s = strings.TrimPrefix(s, "```")
		s = strings.TrimSpace(s)
		if i := strings.IndexByte(s, '\n'); i >= 0 {
			s = s[i+1:]
		}
		if j := strings.LastIndex(s, "```"); j >= 0 {
			s = s[:j]
		}
		s = strings.TrimSpace(s)
	}
	if a, b := strings.Index(s, "{"), strings.LastIndex(s, "}"); a >= 0 && b > a {
		return s[a : b+1]
	}
	return s
}

func clampChars(s string, minChars, maxChars int) string {
	r := []rune(strings.TrimSpace(s))
	if len(r) > maxChars {
		r = r[:maxChars]
		s = strings.TrimSpace(string(r)) + "…"
	}
	return s
}

func bedrockSummarizeAndClassifyNova(
	ctx context.Context,
	brc *bedrockruntime.Client,
	modelID string, // e.g. "us.amazon.nova-lite-v1:0"
	transcript string,
	existing []string,
) (summary string, matches []CategoryWithScore, newCat *CategoryWithScore, err error) {

	sys := []map[string]string{
		{"text": `You are an assistant that returns ONE raw JSON object only (no code fences, no prose).

You are an expert annotator. Analyze the TRANSCRIPT and generate a summary.

Hard constraints
- "summary" length must be between 320 and 330 characters inclusive.
- Writing style: engaging, spoiler-free, no intro phrases (e.g., “This is about...”).
- Do not exceed 330 characters. Do not go below 320 characters.
- Each category label must be a single word (no spaces, hyphens, or emojis) and ≤ 13 characters.
- Prioritize Existing categories first when they are semantically relevant.
- Confidence values are floats in [0,1] with 3 decimals (e.g., 0.842).
- No duplicate labels across any list (case-insensitive).
- Sort items in each list by confidence descending.
- Combined total across matches_exist and new_category must include ≥ 3 unique labels.
- Do NOT use generic or meaningless labels such as: news, general, other, misc, random, uncategorized, or any equivalent.
- Skip them if they appear in Existing categories or if the model would generate them.
- Selected categories must be distinct and not semantically redundant. If multiple labels are very similar in meaning (e.g., Novel, Fiction, Story), pick only the most widely recognized one.
- Prefer standard bookstore-style categories (e.g., Fiction, Nonfiction, Biography, History, Science, Philosophy, Children, Romance, Fantasy, Mystery, Poetry, Religion, Politics, Business, Health, Travel). Avoid hyper-specific or obscure terms.

Decision rules

1. matches_exist (up to 5 items)
1.1 Consider only labels from Existing categories.
1.2 Add a label if it closely matches the main topics in TRANSCRIPT (semantic similarity / keyword overlap / intent match).
2. new_category (up to 3 items)
2.1 Use only when Existing categories do not adequately cover the content.
2.2 If you have fewer than 3 high-confidence (≥ 0.800) matches in matches_exist, propose new labels to cover uncovered topics.
2.3 New labels must be concise, generic, and reusable (avoid names, IDs, or overly specific phrases).
2.4 Ensure that the combined total of matches_exist and new_category provides at least 3 unique labels.
2.5 If any Existing label violates the “single-word ≤13 chars” rule, skip it.
`},
	}

	user := fmt.Sprintf(`Existing categories: %v

Produce exactly this JSON schema:
{
  "summary":"200-250 chars, engaging, no code fences, no intro phrases>",
  "matches_exist":[{"label":"<from existing>","confidence":0.xxx}, ... up to 5 or empty],
  "new_category": null OR {"label":"<new>", "confidence":0.xxx}, ... up to 3 or empty]
}

TRANSCRIPT:
%s`, existing, transcript)

	body := map[string]any{
		"schemaVersion": "messages-v1",
		"system":        sys,
		"messages": []map[string]any{
			{"role": "user", "content": []map[string]string{{"text": user}}},
		},
		"inferenceConfig": map[string]any{
			"maxTokens":   1000,
			"temperature": 0.3,
			"topP":        0.9,
		},
	}
	payload, _ := json.Marshal(body)

	out, err := brc.InvokeModel(ctx, &bedrockruntime.InvokeModelInput{
		ModelId:     aws.String(modelID),
		ContentType: aws.String("application/json"),
		Accept:      aws.String("application/json"),
		Body:        payload,
	})
	if err != nil {
		return "", nil, nil, err
	}

	var env struct {
		Output struct {
			Message struct {
				Content []struct {
					Text string `json:"text"`
				} `json:"content"`
			} `json:"message"`
		} `json:"output"`
	}
	if err := json.Unmarshal(out.Body, &env); err != nil {
		return "", nil, nil, fmt.Errorf("nova: bad envelope: %w; raw=%s", err, string(out.Body))
	}
	if len(env.Output.Message.Content) == 0 {
		return "", nil, nil, fmt.Errorf("nova: empty content: %s", string(out.Body))
	}
	txt := stripToJSON(env.Output.Message.Content[0].Text)

	var resp struct {
		Summary     string              `json:"summary"`
		Matches     []CategoryWithScore `json:"matches_exist"`
		NewCategory *CategoryWithScore  `json:"new_category"`
	}
	if err := json.Unmarshal([]byte(txt), &resp); err != nil {
		if err2 := json.Unmarshal(out.Body, &resp); err2 != nil {
			return "", nil, nil, fmt.Errorf("nova: parse JSON failed: %v; got=%s", err, txt)
		}
	}

	resp.Summary = clampChars(resp.Summary, 200, 2000)
	for i := range resp.Matches {
		if resp.Matches[i].Confidence < 0 {
			resp.Matches[i].Confidence = 0
		}
		if resp.Matches[i].Confidence > 1 {
			resp.Matches[i].Confidence = 1
		}
		resp.Matches[i].Label = strings.TrimSpace(resp.Matches[i].Label)
	}
	if resp.NewCategory != nil && strings.TrimSpace(resp.NewCategory.Label) == "" {
		resp.NewCategory = nil
	}

	return resp.Summary, resp.Matches, resp.NewCategory, nil
}

func parseCategories(in string) ([]string, error) {
	in = strings.TrimSpace(in)
	if in == "" {
		return []string{}, nil
	}
	var arr []string
	if strings.HasPrefix(in, "[") {
		if err := json.Unmarshal([]byte(in), &arr); err == nil && len(arr) > 0 {
			return arr, nil
		}
	}
	parts := strings.Split(in, ",")
	for i := range parts {
		parts[i] = strings.TrimSpace(parts[i])
	}
	if len(parts) == 0 {
		return nil, errors.New("no categories found")
	}
	return parts, nil
}

func parseS3URL(s3url string) (bucket, key string, err error) {
	u, err := url.Parse(s3url)
	if err != nil {
		return "", "", err
	}

	switch u.Scheme {
	case "s3":
		bucket = u.Host
		key = strings.TrimPrefix(u.Path, "/")
	case "https", "http":
		parts := strings.SplitN(u.Host, ".", 2)
		if len(parts) < 2 || !strings.Contains(parts[1], "amazonaws.com") {
			return "", "", fmt.Errorf("invalid S3 https url: %s", s3url)
		}
		bucket = parts[0]
		key = strings.TrimPrefix(u.Path, "/")
	default:
		return "", "", fmt.Errorf("invalid scheme: %s", u.Scheme)
	}

	if bucket == "" || key == "" {
		return "", "", fmt.Errorf("invalid s3 url: %s", s3url)
	}
	return bucket, key, nil
}

func deriveS3KeysFromLocalPath(inputPath, anchor, fallbackPrefix string) (origKey, clipKey string) {
	p := filepath.ToSlash(inputPath)

	rel := ""
	if anchor != "" {
		needle := "/" + anchor + "/"
		if idx := strings.Index(p, needle); idx >= 0 {
			rel = p[idx+1:]
		} else if strings.HasPrefix(p, anchor+"/") {
			rel = p
		}
	}

	if rel == "" {
		base := filepath.Base(p)
		rel = pathJoin(fallbackPrefix, base)
	}

	dir := filepath.Dir(rel)
	base := filepath.Base(rel)
	ext := filepath.Ext(base)
	name := strings.TrimSuffix(base, ext)

	origKey = rel
	clipBase := name + "_clip" + ext
	if dir == "." || dir == "/" {
		clipKey = clipBase
	} else {
		clipKey = pathJoin(filepath.ToSlash(dir), clipBase)
	}
	return
}

func trimAndCompressAudio(ffmpeg, in, out string, seconds int) error {
	if seconds <= 0 {
		return errors.New("seconds must be > 0")
	}

	cmd := exec.Command(ffmpeg,
		"-y",
		"-i", in,
		"-t", fmt.Sprint(seconds),
		"-ac", "1",
		"-ar", "8000",
		"-b:a", "16k",
		out,
	)
	return cmd.Run()
}

/*
func makeClipPath(inputPath string) string {
	dir := filepath.Dir(inputPath)
	base := filepath.Base(inputPath)
	ext := filepath.Ext(base)
	name := strings.TrimSuffix(base, ext)
	return filepath.Join(dir, name+"_clip"+ext)
}
*/
