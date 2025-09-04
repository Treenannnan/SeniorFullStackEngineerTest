package aihelper

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"path"
	"time"
)

type LocalPipeline struct {
	baseURL string
	client  *http.Client
}

func NewLocalPipeline(baseURL string) *LocalPipeline {
	if baseURL == "" {
		baseURL = "http://localhost:8000"
	}

	return &LocalPipeline{
		baseURL: baseURL,
		client:  &http.Client{Timeout: 10 * time.Minute},
	}
}

/*
func (p *LocalPipeline) ContinueTranscript(s3URL string, callback func(PipelineState, *Output)) (*Output, error) {
	if callback == nil {
		callback = func(PipelineState, *Output) {}
	}
	if s3URL == "" {
		return nil, fmt.Errorf("path is required")
	}

		lp := s3URL
		if u, err := url.Parse(s3URL); err == nil && u.Scheme != "" {
			switch u.Scheme {
			case "file":
				lp = u.Path
			case "http", "https", "s3":
				return nil, fmt.Errorf("ContinueTranscript(local) does not support %s URLs", u.Scheme)
			}
		}

	out := &Output{
		Meta: map[string]interface{}{
			"mode":       "local",
			"base_url":   p.baseURL,
			"sourcePath": s3URL,
		},
	}

	callback(PipelineState_TranscriptStarted, out)
	txt, err := p.transcribe(context.Background(), s3URL)
	if err != nil {
		return out, fmt.Errorf("local transcribe: %w", err)
	}
	out.Transcript = txt
	callback(PipelineState_TranscriptComplete, out)

	return out, nil
}

func (p *LocalPipeline) ContinueSummary(transcript string, callback func(PipelineState, *Output)) (*Output, error) {
	if callback == nil {
		callback = func(PipelineState, *Output) {}
	}
	out := &Output{
		Transcript: transcript,
		Meta: map[string]interface{}{
			"mode":     "local",
			"base_url": p.baseURL,
		},
	}

	callback(PipelineState_SummaryStart, out)
	sum, matches, newCat, err := p.summarize(context.Background(), transcript, p.existing)
	if err != nil {
		return out, fmt.Errorf("local summarize: %w", err)
	}
	out.Summary = sum
	out.CategoriesOut = matches
	out.NewCategory = newCat

	callback(PipelineState_Done, out)
	return out, nil
}
*/

func (p *LocalPipeline) transcribe(ctx context.Context, localPath string) (string, error) {
	ctx, cancel := context.WithTimeout(ctx, 10*time.Minute)
	defer cancel()
	req := transcribeReq{LocalPath: localPath, Language: "en"}
	var resp transcribeRes
	if err := p.postJSON(ctx, "/transcribe", req, &resp); err != nil {
		return "", err
	}
	return resp.Text, nil
}

func (p *LocalPipeline) summarize(ctx context.Context, transcript string, existing string) (string, []CategoryWithScore, error) {
	ctx, cancel := context.WithTimeout(ctx, 10*time.Minute)
	defer cancel()

	req := summReq{Existing: existing, Transcript: transcript}
	var resp summRes
	if err := p.postJSON(ctx, "/summarize", req, &resp); err != nil {
		return "", nil, err
	}

	return resp.Summary, resp.Categories, nil
}

func (p *LocalPipeline) postJSON(ctx context.Context, endpoint string, in any, out any) error {
	u, err := joinURL(p.baseURL, endpoint)
	if err != nil {
		return err
	}
	b, err := json.Marshal(in)
	if err != nil {
		return fmt.Errorf("marshal req: %w", err)
	}

	req, err := http.NewRequestWithContext(ctx, http.MethodPost, u, bytes.NewReader(b))
	if err != nil {
		return fmt.Errorf("new request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")

	res, err := p.client.Do(req)
	if err != nil {
		return fmt.Errorf("http do: %w", err)
	}
	defer res.Body.Close()

	if res.StatusCode < 200 || res.StatusCode >= 300 {
		return fmt.Errorf("http %s %s -> %d", http.MethodPost, u, res.StatusCode)
	}
	if out == nil {
		return nil
	}
	return json.NewDecoder(res.Body).Decode(out)
}

func joinURL(base, pth string) (string, error) {
	bu, err := url.Parse(base)
	if err != nil {
		return "", err
	}
	ep, err := url.Parse(pth)
	if err != nil {
		return "", err
	}
	bu.Path = path.Join(bu.Path, ep.Path)
	return bu.String(), nil
}

type transcribeReq struct {
	LocalPath string `json:"local_path"`
	Language  string `json:"language"`
}
type transcribeRes struct {
	Text string `json:"text"`
}

type summReq struct {
	Existing   string `json:"existing"`
	Transcript string `json:"transcript"`
}
type summRes struct {
	Summary    string              `json:"summary"`
	Matches    []CategoryWithScore `json:"matches"`
	Categories []CategoryWithScore `json:"categories"`
}
