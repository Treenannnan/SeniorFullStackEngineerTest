// internal/shopmock/blob_local.go
package shopmock

import (
	"context"
	"errors"
	"io"
	"net"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"strings"
	"sync"
	"time"
)

type LocalHTTPBlobStore struct {
	baseDir    string
	bindAddr   string
	listenAddr string
	publicBase *url.URL

	srv   *http.Server
	mu    sync.RWMutex
	start bool
}

func NewLocalHTTPBlobStore(baseDir, bindAddr, publicBase string) (*LocalHTTPBlobStore, error) {
	u, err := url.Parse(publicBase)
	if err != nil {
		return nil, err
	}
	return &LocalHTTPBlobStore{
		baseDir:    baseDir,
		bindAddr:   bindAddr,
		publicBase: u,
	}, nil
}

func (l *LocalHTTPBlobStore) ensureStarted() error {
	l.mu.Lock()
	defer l.mu.Unlock()
	if l.start {
		return nil
	}
	if err := os.MkdirAll(l.baseDir, 0o755); err != nil {
		return err
	}

	mux := http.NewServeMux()

	mux.HandleFunc("/upload/", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPut {
			http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
			return
		}
		key := strings.TrimPrefix(r.URL.Path, "/upload/")
		if key == "" {
			http.Error(w, "missing key", http.StatusBadRequest)
			return
		}
		dstPath := filepath.Join(l.baseDir, filepath.FromSlash(key))
		if err := os.MkdirAll(filepath.Dir(dstPath), 0o755); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		f, err := os.Create(dstPath)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer f.Close()
		if _, err := io.Copy(f, r.Body); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.WriteHeader(http.StatusCreated)
	})

	//fileHandler := http.StripPrefix("/files/", http.FileServer(http.Dir(l.baseDir)))
	//mux.Handle("/files/", fileHandler)

	l.srv = &http.Server{
		Addr:              l.bindAddr,
		Handler:           mux,
		ReadHeaderTimeout: 5 * time.Second,
	}

	ln, err := net.Listen("tcp", l.bindAddr)
	if err != nil {
		return err
	}
	go func() { _ = l.srv.Serve(ln) }()

	l.start = true
	l.listenAddr = ln.Addr().String()
	return nil
}

func (l *LocalHTTPBlobStore) SaveStream(ctx context.Context, objectKey string, r ReadAtLeast) (string, error) {
	//if err := l.ensureStarted(); err != nil {
	//	return "", err
	//}

	dst := filepath.Join(l.baseDir, filepath.FromSlash(objectKey))
	if err := os.MkdirAll(filepath.Dir(dst), 0o755); err != nil {
		return "", err
	}
	f, err := os.Create(dst)
	if err != nil {
		return "", err
	}
	defer f.Close()

	buf := make([]byte, 32*1024)
	for {
		n, err := r.Read(buf)
		if n > 0 {
			if _, werr := f.Write(buf[:n]); werr != nil {
				return "", werr
			}
		}
		if errors.Is(err, io.EOF) {
			break
		}
		if err != nil {
			return "", err
		}
	}
	return objectKey, nil
}

func (l *LocalHTTPBlobStore) CreateUploadURL(ctx context.Context, objectKey, contentType string, maxBytes int64, ttl time.Duration) (string, error) {
	if err := l.ensureStarted(); err != nil {
		return "", err
	}
	//u := *l.publicBase
	//u.Path = "/upload/" + objectKey
	return "/upload/" + objectKey, nil
}

func (l *LocalHTTPBlobStore) CreateDownloadURL(ctx context.Context, objectKey string, ttl time.Duration) (string, error) {
	if err := l.ensureStarted(); err != nil {
		return "", err
	}
	//u := *l.publicBase
	//u.Path = "/files/" + objectKey
	return "/files/" + objectKey, nil
}

func (l *LocalHTTPBlobStore) Close(ctx context.Context) error {
	l.mu.Lock()
	defer l.mu.Unlock()
	if !l.start || l.srv == nil {
		return nil
	}
	l.start = false
	shCtx, cancel := context.WithTimeout(ctx, 2*time.Second)
	defer cancel()
	return l.srv.Shutdown(shCtx)
}

func (l *LocalHTTPBlobStore) Exists(objectKey string) (bool, error) {
	if err := l.ensureStarted(); err != nil {
		return false, err
	}
	_, err := os.Stat(filepath.Join(l.baseDir, filepath.FromSlash(objectKey)))
	if err == nil {
		return true, nil
	}
	if errors.Is(err, os.ErrNotExist) {
		return false, nil
	}
	return false, err
}

func (l *LocalHTTPBlobStore) GetBlobFilePath() string {
	return l.baseDir
}
