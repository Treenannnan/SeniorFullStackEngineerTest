package shopmock

import (
	"context"
	"io"
	"sync"
	"time"
)

type MemoryBlobStore struct {
	mu   sync.RWMutex
	data map[string][]byte
}

func NewMemoryBlobStore() *MemoryBlobStore {
	return &MemoryBlobStore{data: make(map[string][]byte)}
}

func (m *MemoryBlobStore) SaveStream(ctx context.Context, objectKey string, r ReadAtLeast) (string, error) {
	buf := make([]byte, 32*1024)
	var out []byte
	for {
		n, err := r.Read(buf)
		if n > 0 {
			out = append(out, buf[:n]...)
		}
		if err == io.EOF {
			break
		}
		if err != nil {
			return "", err
		}
	}
	m.mu.Lock()
	m.data[objectKey] = out
	m.mu.Unlock()
	return objectKey, nil
}

func (m *MemoryBlobStore) CreateUploadURL(ctx context.Context, objectKey, contentType string, maxBytes int64, ttl time.Duration) (string, error) {
	// สำหรับเทสใน-Go: ให้ URL หลอก ๆ ก็พอ
	return "mem://" + objectKey, nil
}

func (m *MemoryBlobStore) CreateDownloadURL(ctx context.Context, objectKey string, ttl time.Duration) (string, error) {
	return "mem://" + objectKey, nil
}

// Helpers for tests
func (m *MemoryBlobStore) Get(objectKey string) ([]byte, bool) {
	m.mu.RLock()
	defer m.mu.RUnlock()
	b, ok := m.data[objectKey]
	return b, ok
}
func (m *MemoryBlobStore) Reset() {
	m.mu.Lock()
	m.data = make(map[string][]byte)
	m.mu.Unlock()
}

func (m *MemoryBlobStore) GetBlobFilePath() string {
	return ""
}
