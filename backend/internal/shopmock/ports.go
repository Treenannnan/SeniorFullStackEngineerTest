package shopmock

import (
	"context"
	"time"
)

type BlobStore interface {
	SaveStream(ctx context.Context, objectKey string, r ReadAtLeast) (string, error)
	CreateUploadURL(ctx context.Context, objectKey, contentType string, maxBytes int64, ttl time.Duration) (string, error)
	CreateDownloadURL(ctx context.Context, objectKey string, ttl time.Duration) (string, error)
	GetBlobFilePath() string
}

type ReadAtLeast interface {
	Read(p []byte) (n int, err error)
}

type AIProvider interface {
	// Returns transcript text, description summary, and up to 3 tags
	TranscribeAndDescribe(ctx context.Context, audioPath string) (transcript string, description string, tags []string, err error)
}
