// internal/storage/database.go
package storage

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"strings"
	"time"

	schemav1 "github.com/backend/gen/schema/v1"
	shopv1 "github.com/backend/gen/shop/v1"
	"google.golang.org/protobuf/types/known/timestamppb"
)

var (
	ErrNotFound     = errors.New("not found")
	ErrAlreadyExist = errors.New("already exists")
	ErrCartEmpty    = errors.New("cart is empty")
)

type Store interface {
	// ===== Users (เดิม) =====
	CreateUser(ctx context.Context, u *schemav1.UserRecord) error
	GetUserByEmail(ctx context.Context, email string) (*schemav1.UserRecord, error)
	GetUserByID(ctx context.Context, id string) (*schemav1.UserRecord, error)
	SetUserPasswordHash(ctx context.Context, userID string, hash []byte) error
	SetEmailVerified(ctx context.Context, userID string, verified bool) error
	SetUserRole(ctx context.Context, userID string, role schemav1.Role) error

	// ===== Refresh Tokens (เดิม) =====
	CreateRefreshToken(ctx context.Context, token string, userID string, expiresAt time.Time) error
	GetRefreshTokenOwner(ctx context.Context, token string) (userID string, ok bool, err error)
	DeleteRefreshToken(ctx context.Context, token string) error
	DeleteAllRefreshTokensForUser(ctx context.Context, userID string) error

	// ===== Password Reset Tokens (เดิม) =====
	CreateResetToken(ctx context.Context, token string, userID string, expiresAt time.Time) error
	ConsumeResetToken(ctx context.Context, token string) (userID string, ok bool, err error)

	// ===== Cleanup (เดิม) =====
	PruneExpired(ctx context.Context) error

	// =====================================================================
	// ============================== SHOP ==================================
	// =====================================================================

	// Audiobooks
	CreateAudiobookProcessing(ctx context.Context, rec *schemav1.AudiobookRecord) error
	UpdateAudiobookAI(ctx context.Context, audiobookID string, aiDescription, transcript, url string, status string, categories []string) error
	GetAudiobookByID(ctx context.Context, id string) (*schemav1.AudiobookRecord, []string, error)
	ListAudiobooks(ctx context.Context, query, category string, limit int) ([]*shopv1.Audiobook, error)
	GetTranscriptPreview(ctx context.Context, id string, maxChars int) (string, error)
	GetAudioPathByID(ctx context.Context, id string) (string, error)
	SetAudiobookStatus(ctx context.Context, id string, status string) error
	SetAudiobookDownloadURL(ctx context.Context, id string, url string) error
	SetAudiobookTranscript(ctx context.Context, id string, transcript string) error
	GetAllCategoryLabels(ctx context.Context) ([]string, error)
	// Cart
	ViewCart(ctx context.Context, userID string) (items []struct {
		Book schemav1.AudiobookRecord
		Line int64
	}, subtotal int64, err error)
	AddToCart(ctx context.Context, userID, audiobookID string) error
	RemoveFromCart(ctx context.Context, userID, audiobookID string) error
	ClearCart(ctx context.Context, userID string) error

	// Checkout / Purchases
	Checkout(ctx context.Context, userID string) (orderUID string, totalCents int64, err error)
	ListPurchases(ctx context.Context, userID string, limit int) ([]struct {
		Book       schemav1.AudiobookRecord
		PriceCents int64
		Time       time.Time
	}, error)
	HasPurchased(ctx context.Context, userID, audiobookID string) (bool, error)
}

type SQLStore struct {
	DB *sql.DB
}

func NewSQLStore(db *sql.DB) *SQLStore { return &SQLStore{DB: db} }

// =========================== Users (เดิม) ===========================

func (s *SQLStore) CreateUser(ctx context.Context, u *schemav1.UserRecord) error {
	const q = `
INSERT INTO users (id, email, provider, email_verified, created_at, updated_at, password_hash, role)
VALUES (?, ?, ?, ?, COALESCE(?, UTC_TIMESTAMP(6)), UTC_TIMESTAMP(6), ?, ?)`
	_, err := s.DB.ExecContext(ctx, q,
		u.GetId(),
		u.GetEmail(),
		providerToText(u.GetProvider()),
		u.GetEmailVerified(),
		timeOrNil(u.GetCreatedAt()),
		bytesOrNil(u.GetPasswordHash()),
		roleToText(u.GetRole()),
	)
	return err
}

func (s *SQLStore) GetUserByEmail(ctx context.Context, email string) (*schemav1.UserRecord, error) {
	const q = `SELECT id,email,provider,email_verified,created_at,updated_at,password_hash,role FROM users WHERE email_norm = LOWER(?) LIMIT 1`
	var (
		u       schemav1.UserRecord
		prv, rl string
		h       []byte
		ca, ua  time.Time
	)
	err := s.DB.QueryRowContext(ctx, q, email).Scan(
		&u.Id, &u.Email, &prv, &u.EmailVerified, &ca, &ua, &h, &rl,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	u.Provider = parseProvider(prv)
	u.Role = textToRole(rl)
	u.CreatedAt = ts(ca)
	u.UpdatedAt = ts(ua)
	u.PasswordHash = h
	return &u, nil
}

func (s *SQLStore) GetUserByID(ctx context.Context, id string) (*schemav1.UserRecord, error) {
	const q = `SELECT id,email,provider,email_verified,created_at,updated_at,password_hash,role FROM users WHERE id = ? LIMIT 1`
	var (
		u       schemav1.UserRecord
		prv, rl string
		h       []byte
		ca, ua  time.Time
	)
	err := s.DB.QueryRowContext(ctx, q, id).Scan(
		&u.Id, &u.Email, &prv, &u.EmailVerified, &ca, &ua, &h, &rl,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	u.Provider = parseProvider(prv)
	u.Role = textToRole(rl)
	u.CreatedAt = ts(ca)
	u.UpdatedAt = ts(ua)
	u.PasswordHash = h
	return &u, nil
}

func (s *SQLStore) SetUserPasswordHash(ctx context.Context, userID string, hash []byte) error {
	const q = `UPDATE users SET password_hash = ?, updated_at = UTC_TIMESTAMP(6) WHERE id = ?`
	res, err := s.DB.ExecContext(ctx, q, bytesOrNil(hash), userID)
	if err != nil {
		return err
	}
	if n, _ := res.RowsAffected(); n == 0 {
		return ErrNotFound
	}
	return nil
}

func (s *SQLStore) SetEmailVerified(ctx context.Context, userID string, verified bool) error {
	const q = `UPDATE users SET email_verified = ?, updated_at = UTC_TIMESTAMP(6) WHERE id = ?`
	res, err := s.DB.ExecContext(ctx, q, verified, userID)
	if err != nil {
		return err
	}
	if n, _ := res.RowsAffected(); n == 0 {
		return ErrNotFound
	}
	return nil
}

func (s *SQLStore) SetUserRole(ctx context.Context, userID string, role schemav1.Role) error {
	const q = `UPDATE users SET role = ?, updated_at = UTC_TIMESTAMP(6) WHERE id = ?`
	res, err := s.DB.ExecContext(ctx, q, roleToText(role), userID)
	if err != nil {
		return err
	}
	if n, _ := res.RowsAffected(); n == 0 {
		return ErrNotFound
	}
	return nil
}

// ======================= Refresh Tokens (เดิม) ======================

func (s *SQLStore) CreateRefreshToken(ctx context.Context, token, userID string, expiresAt time.Time) error {
	const q = `
INSERT INTO refresh_tokens (token, user_id, expires_at)
VALUES (?, ?, ?)
ON DUPLICATE KEY UPDATE user_id = VALUES(user_id), expires_at = VALUES(expires_at)`
	_, err := s.DB.ExecContext(ctx, q, token, userID, expiresAt.UTC())
	return err
}

func (s *SQLStore) GetRefreshTokenOwner(ctx context.Context, token string) (string, bool, error) {
	const q = `SELECT user_id FROM refresh_tokens WHERE token = ? AND expires_at > UTC_TIMESTAMP(6)`
	var uid string
	err := s.DB.QueryRowContext(ctx, q, token).Scan(&uid)
	if errors.Is(err, sql.ErrNoRows) {
		return "", false, nil
	}
	if err != nil {
		return "", false, err
	}
	return uid, true, nil
}

func (s *SQLStore) DeleteRefreshToken(ctx context.Context, token string) error {
	_, err := s.DB.ExecContext(ctx, `DELETE FROM refresh_tokens WHERE token = ?`, token)
	return err
}

func (s *SQLStore) DeleteAllRefreshTokensForUser(ctx context.Context, userID string) error {
	_, err := s.DB.ExecContext(ctx, `DELETE FROM refresh_tokens WHERE user_id = ?`, userID)
	return err
}

// =================== Password Reset Tokens (เดิม) ===================

func (s *SQLStore) CreateResetToken(ctx context.Context, token, userID string, expiresAt time.Time) error {
	const q = `
INSERT INTO reset_tokens (token, user_id, expires_at)
VALUES (?, ?, ?)
ON DUPLICATE KEY UPDATE user_id = VALUES(user_id), expires_at = VALUES(expires_at)`
	_, err := s.DB.ExecContext(ctx, q, token, userID, expiresAt.UTC())
	return err
}

// Atomic consume: SELECT ... FOR UPDATE แล้วค่อย DELETE ภายใน txn
func (s *SQLStore) ConsumeResetToken(ctx context.Context, token string) (string, bool, error) {
	tx, err := s.DB.BeginTx(ctx, &sql.TxOptions{Isolation: sql.LevelReadCommitted})
	if err != nil {
		return "", false, err
	}
	var uid string
	err = tx.QueryRowContext(ctx,
		`SELECT user_id FROM reset_tokens WHERE token = ? AND expires_at > UTC_TIMESTAMP(6) FOR UPDATE`,
		token,
	).Scan(&uid)
	if errors.Is(err, sql.ErrNoRows) {
		_ = tx.Rollback()
		return "", false, nil
	}
	if err != nil {
		_ = tx.Rollback()
		return "", false, err
	}
	if _, err := tx.ExecContext(ctx, `DELETE FROM reset_tokens WHERE token = ?`, token); err != nil {
		_ = tx.Rollback()
		return "", false, err
	}
	return uid, true, tx.Commit()
}

func (s *SQLStore) PruneExpired(ctx context.Context) error {
	if _, err := s.DB.ExecContext(ctx, `DELETE FROM refresh_tokens WHERE expires_at <= UTC_TIMESTAMP(6)`); err != nil {
		return err
	}
	if _, err := s.DB.ExecContext(ctx, `DELETE FROM reset_tokens WHERE expires_at <= UTC_TIMESTAMP(6)`); err != nil {
		return err
	}
	return nil
}

func (s *SQLStore) CreateAudiobookProcessing(ctx context.Context, rec *schemav1.AudiobookRecord) error {
	const q = `
INSERT INTO audiobooks (id, title, author, duration_sec, content_type, price_cents, cover_url, audio_path, status, ai_description, transcript, created_at, updated_at)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'UNSPECIFIED', NULL, NULL, COALESCE(?, UTC_TIMESTAMP(6)), UTC_TIMESTAMP(6))`

	dur := rec.GetDurationSeconds()
	if dur < 0 {
		dur = 0
	}

	_, err := s.DB.ExecContext(ctx, q,
		rec.GetId(),
		rec.GetTitle(),
		rec.GetAuthor(),
		dur,
		rec.ContentType,
		rec.GetPriceCents(),
		nullString(rec.GetCoverUrl()),
		rec.GetAudioPath(),
		timeOrNil(rec.GetCreatedAt()),
	)
	return err
}

func (s *SQLStore) SetAudiobookStatus(ctx context.Context, id string, status string) error {
	const q = `
UPDATE audiobooks 
SET status=?, updated_at=UTC_TIMESTAMP(6)
WHERE id=?`

	_, err := s.DB.ExecContext(ctx, q, status, id)
	return err
}

func (s *SQLStore) SetAudiobookDownloadURL(ctx context.Context, id string, url string) error {
	const q = `
UPDATE audiobooks 
SET cover_url=?, updated_at=UTC_TIMESTAMP(6)
WHERE id=?`

	_, err := s.DB.ExecContext(ctx, q, url, id)
	return err
}

func (s *SQLStore) SetAudiobookTranscript(ctx context.Context, id string, transcript string) error {
	const q = `
UPDATE audiobooks 
SET transcript=?, updated_at=UTC_TIMESTAMP(6)
WHERE id=?`

	_, err := s.DB.ExecContext(ctx, q, transcript, id)
	return err
}

func (s *SQLStore) GetAllCategoryLabels(ctx context.Context) ([]string, error) {
	rows, err := s.DB.QueryContext(ctx, `SELECT label FROM audiobook_category_types`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var labels []string
	for rows.Next() {
		var label string
		if err := rows.Scan(&label); err != nil {
			return nil, err
		}
		labels = append(labels, label)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return labels, nil
}

func (s *SQLStore) UpdateAudiobookAI(ctx context.Context, audiobookID string, aiDescription, transcript, url string, status string, categories []string) error {
	tx, err := s.DB.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer func() {
		if err != nil {
			_ = tx.Rollback()
		}
	}()

	_, err = tx.ExecContext(ctx, `
UPDATE audiobooks
SET ai_description=?, transcript=?, cover_url=?, status=?, updated_at=UTC_TIMESTAMP(6)
WHERE id=?`,
		nullable(aiDescription), nullable(transcript), nullable(url), statusOrDefault(status), audiobookID,
	)
	if err != nil {
		return err
	}

	if _, err = tx.ExecContext(ctx, `DELETE FROM audiobook_categories WHERE audiobook_id=?`, audiobookID); err != nil {
		return err
	}

	if len(categories) > 3 {
		categories = categories[:3]
	}
	pos := 0
	for _, c := range categories {
		c = strings.TrimSpace(c)
		if c == "" {
			continue
		}
		catID, e := s.getOrCreateCategoryID(ctx, c)
		if e != nil {
			err = e
			return err
		}
		if _, err = tx.ExecContext(ctx, `
INSERT INTO audiobook_categories (audiobook_id, category_id, idx_pos)
VALUES (?,?,?)`, audiobookID, catID, pos); err != nil {
			return err
		}
		pos++
	}

	return tx.Commit()
}

func (s *SQLStore) GetAudiobookByID(ctx context.Context, id string) (*schemav1.AudiobookRecord, []string, error) {
	const q = `
SELECT id,title,author,duration_sec,content_type,price_cents,cover_url,audio_path,status,ai_description,transcript,created_at,updated_at
FROM audiobooks WHERE id=? LIMIT 1`
	var (
		r                                               schemav1.AudiobookRecord
		durationNullable, price                         int64
		coverURL, audioPath, status, aiDesc, transcript sql.NullString
		ca, ua                                          time.Time
	)
	err := s.DB.QueryRowContext(ctx, q, id).Scan(
		&r.Id, &r.Title, &r.Author, &durationNullable, &r.ContentType, &price, &coverURL, &audioPath, &status, &aiDesc, &transcript, &ca, &ua,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, nil, ErrNotFound
	}
	if err != nil {
		return nil, nil, err
	}
	r.DurationSeconds = durationNullable
	r.PriceCents = price
	r.CoverUrl = coverURL.String
	r.AudioPath = audioPath.String
	r.Status = status.String
	r.AiDescription = aiDesc.String
	r.Transcript = transcript.String
	r.CreatedAt = ts(ca)
	r.UpdatedAt = ts(ua)

	cr, err := s.DB.QueryContext(ctx, `
SELECT ac.audiobook_id, act.label
FROM audiobook_categories ac
JOIN audiobook_category_types act ON act.id = ac.category_id
WHERE ac.audiobook_id=?
ORDER BY ac.idx_pos ASC`, id)
	if err != nil {
		return &r, nil, err
	}
	defer cr.Close()

	var cats []string
	for cr.Next() {
		var bid, label string
		if err := cr.Scan(&bid, &label); err == nil {
			cats = append(cats, label)
		}
	}

	return &r, cats, nil
}

func ShopStatusFromText(s string) shopv1.MediaStatus {
	switch strings.ToUpper(s) {
	case "DETETED":
		return shopv1.MediaStatus_MEDIA_DETETED
	case "HIDE":
		return shopv1.MediaStatus_MEDIA_HIDE
	case "AUDIO":
		return shopv1.MediaStatus_MEDIA_PROCESSING_AUDIO
	case "SUMMARY":
		return shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY
	case "TRANSCRIPT":
		return shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT
	case "READY":
		return shopv1.MediaStatus_MEDIA_READY
	default:
		return shopv1.MediaStatus_MEDIA_STATUS_UNSPECIFIED
	}
}

func ShopStatusToText(status shopv1.MediaStatus) string {
	switch status {
	case shopv1.MediaStatus_MEDIA_DETETED:
		return "DETETED"
	case shopv1.MediaStatus_MEDIA_HIDE:
		return "HIDE"
	case shopv1.MediaStatus_MEDIA_PROCESSING_AUDIO:
		return "AUDIO"
	case shopv1.MediaStatus_MEDIA_PROCESSING_SUMMARY:
		return "SUMMARY"
	case shopv1.MediaStatus_MEDIA_PROCESSING_TRANSCRIPT:
		return "TRANSCRIPT"
	case shopv1.MediaStatus_MEDIA_READY:
		return "READY"
	default:
		return "UNSPECIFIED"
	}
}

func inPlaceholders(n int) string {
	if n <= 0 {
		return ""
	}
	return strings.TrimRight(strings.Repeat("?,", n), ",")
}

func (s *SQLStore) ListAudiobooks(ctx context.Context, query, category string, limit int) ([]*shopv1.Audiobook, error) {
	if limit <= 0 || limit > 50 {
		limit = 20
	}
	args := []any{}
	q := `
SELECT DISTINCT
  a.id, a.title, a.author, a.duration_sec, a.price_cents,
  a.cover_url, a.audio_path, a.status, a.ai_description,
  a.created_at, a.updated_at
FROM audiobooks a`

	if category != "" {
		q += `
JOIN audiobook_categories ac ON ac.audiobook_id = a.id
JOIN audiobook_category_types act ON act.id = ac.category_id AND act.label = ?`
		args = append(args, category)
	}

	where := []string{}
	if query != "" {
		where = append(where, `(a.title LIKE ? OR a.author LIKE ? )`)
		args = append(args, "%"+query+"%", "%"+query+"%")
	}
	if len(where) > 0 {
		q += ` WHERE ` + strings.Join(where, " AND ")
	}

	q += ` ORDER BY a.created_at DESC LIMIT ?`
	args = append(args, limit)

	rows, err := s.DB.QueryContext(ctx, q, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var ids []string
	byID := make(map[string]*shopv1.Audiobook, limit)

	for rows.Next() {
		var (
			id, title, author string
			duration, price   int64
			cover, ap, st, ai sql.NullString
			ca, ua            time.Time
		)
		if err := rows.Scan(&id, &title, &author, &duration, &price, &cover, &ap, &st, &ai, &ca, &ua); err != nil {
			return nil, err
		}
		b := &shopv1.Audiobook{
			Id:              id,
			Title:           title,
			Author:          author,
			PriceCents:      price,
			DurationSeconds: duration,
			CoverUrl:        cover.String,
			Status:          ShopStatusFromText(st.String),
			CreatedAt:       timestamppb.New(ca.UTC()),
			UpdatedAt:       timestamppb.New(ua.UTC()),
		}
		ids = append(ids, id)
		byID[id] = b
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	if len(ids) == 0 {
		return []*shopv1.Audiobook{}, nil
	}

	// ดึง labels ของทุกเล่ม
	qc := `
SELECT ac.audiobook_id, act.label
FROM audiobook_categories ac
JOIN audiobook_category_types act ON act.id = ac.category_id
WHERE ac.audiobook_id IN (` + inPlaceholders(len(ids)) + `)
ORDER BY ac.audiobook_id, ac.idx_pos ASC`
	args2 := make([]any, len(ids))
	for i, id := range ids {
		args2[i] = id
	}
	cr, err := s.DB.QueryContext(ctx, qc, args2...)
	if err != nil {
		return nil, err
	}
	defer cr.Close()

	for cr.Next() {
		var id, label string
		if err := cr.Scan(&id, &label); err != nil {
			return nil, err
		}
		if b := byID[id]; b != nil {
			b.Categories = append(b.Categories, label)
		}
	}
	if err := cr.Err(); err != nil {
		return nil, err
	}

	out := make([]*shopv1.Audiobook, 0, len(ids))
	for _, id := range ids {
		out = append(out, byID[id])
	}
	return out, nil
}

func (s *SQLStore) GetTranscriptPreview(ctx context.Context, id string, maxChars int) (string, error) {
	if maxChars <= 0 {
		maxChars = 200
	}
	var prev sql.NullString
	err := s.DB.QueryRowContext(ctx, `SELECT SUBSTRING(transcript,1,?) FROM audiobooks WHERE id=?`, maxChars, id).Scan(&prev)
	if errors.Is(err, sql.ErrNoRows) {
		return "", ErrNotFound
	}
	if err != nil {
		return "", err
	}
	return prev.String, nil
}

func (s *SQLStore) GetAudioPathByID(ctx context.Context, id string) (string, error) {
	var key string
	err := s.DB.QueryRowContext(ctx, `SELECT audio_path FROM audiobooks WHERE id=?`, id).Scan(&key)
	if errors.Is(err, sql.ErrNoRows) {
		return "", ErrNotFound
	}
	return key, err
}

// ---------- Cart ----------

func (s *SQLStore) ViewCart(ctx context.Context, userID string) (items []struct {
	Book schemav1.AudiobookRecord
	Line int64
}, subtotal int64, err error) {
	rows, err := s.DB.QueryContext(ctx, `
SELECT a.id,a.title,a.author,a.price_cents
FROM cart_items ci JOIN audiobooks a ON a.id=ci.audiobook_id
WHERE ci.user_id=?`, userID)
	if err != nil {
		return nil, 0, err
	}
	defer rows.Close()

	for rows.Next() {
		var id, title, author string
		var price int64
		if err := rows.Scan(&id, &title, &author, &price); err != nil {
			return nil, 0, err
		}
		line := price
		items = append(items, struct {
			Book schemav1.AudiobookRecord
			Line int64
		}{
			Book: schemav1.AudiobookRecord{
				Id:         id,
				Title:      title,
				Author:     author,
				PriceCents: price,
			},
			Line: line,
		})
		subtotal += line
	}
	return items, subtotal, nil
}

func (s *SQLStore) AddToCart(ctx context.Context, userID, audiobookID string) error {
	_, err := s.DB.ExecContext(ctx, `
INSERT INTO cart_items (user_id,audiobook_id,created_at,updated_at)
VALUES (?,?,UTC_TIMESTAMP(6),UTC_TIMESTAMP(6))
ON DUPLICATE KEY UPDATE
updated_at = VALUES(updated_at)`,
		userID, audiobookID)
	return err
}

func (s *SQLStore) RemoveFromCart(ctx context.Context, userID, audiobookID string) error {
	_, err := s.DB.ExecContext(ctx, `DELETE FROM cart_items WHERE user_id=? AND audiobook_id=?`, userID, audiobookID)
	return err
}

func (s *SQLStore) ClearCart(ctx context.Context, userID string) error {
	_, err := s.DB.ExecContext(ctx, `DELETE FROM cart_items WHERE user_id=?`, userID)
	return err
}

// ---------- Checkout / Purchases ----------

func (s *SQLStore) Checkout(ctx context.Context, userID string) (orderUID string, totalCents int64, err error) {
	tx, err := s.DB.BeginTx(ctx, nil)
	if err != nil {
		return "", 0, err
	}
	// collect cart
	rows, err := tx.QueryContext(ctx, `
SELECT a.id,a.price_cents FROM cart_items ci JOIN audiobooks a ON a.id=ci.audiobook_id
WHERE ci.user_id=?`, userID)
	if err != nil {
		_ = tx.Rollback()
		return "", 0, err
	}
	var ids []string
	for rows.Next() {
		var id string
		var price int64
		if err := rows.Scan(&id, &price); err != nil {
			_ = tx.Rollback()
			return "", 0, err
		}
		ids = append(ids, id)
		totalCents += price
	}
	_ = rows.Close()

	if len(ids) == 0 {
		_ = tx.Rollback()
		return "", 0, ErrCartEmpty
	}

	orderUID = newPublicID()
	res, err := tx.ExecContext(ctx, `INSERT INTO orders (order_uid,user_id,total_cents) VALUES (?,?,?)`, orderUID, userID, totalCents)
	if err != nil {
		_ = tx.Rollback()
		return "", 0, err
	}
	orderID, _ := res.LastInsertId()

	for _, id := range ids {
		// order items
		if _, err := tx.ExecContext(ctx, `
INSERT INTO order_items (order_id,audiobook_id,price_cents)
SELECT ?, id, price_cents FROM audiobooks WHERE id=?`, orderID, id); err != nil {
			_ = tx.Rollback()
			return "", 0, err
		}
		// purchases upsert
		if _, err := tx.ExecContext(ctx, `
INSERT INTO purchases (user_id,audiobook_id,price_cents,purchased_at)
SELECT ?, id, price_cents, UTC_TIMESTAMP(6) FROM audiobooks WHERE id=?
ON DUPLICATE KEY UPDATE price_cents=VALUES(price_cents), purchased_at=UTC_TIMESTAMP(6)`, userID, id); err != nil {
			_ = tx.Rollback()
			return "", 0, err
		}
	}

	// clear cart
	if _, err := tx.ExecContext(ctx, `DELETE FROM cart_items WHERE user_id=?`, userID); err != nil {
		_ = tx.Rollback()
		return "", 0, err
	}

	if err := tx.Commit(); err != nil {
		return "", 0, err
	}
	return orderUID, totalCents, nil
}

func (s *SQLStore) ListPurchases(ctx context.Context, userID string, limit int) ([]struct {
	Book       schemav1.AudiobookRecord
	PriceCents int64
	Time       time.Time
}, error) {
	if limit <= 0 || limit > 200 {
		limit = 100
	}
	rows, err := s.DB.QueryContext(ctx, `
SELECT a.id, a.title, a.author, p.price_cents, p.purchased_at
FROM purchases p
JOIN audiobooks a ON a.id = p.audiobook_id
WHERE p.user_id = ?
ORDER BY p.purchased_at DESC
LIMIT ?;`, userID, limit)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var out []struct {
		Book       schemav1.AudiobookRecord
		PriceCents int64
		Time       time.Time
	}
	for rows.Next() {
		var id, title, author string
		var price int64
		var t time.Time
		if err := rows.Scan(&id, &title, &author, &price, &t); err != nil {
			return nil, err
		}
		out = append(out, struct {
			Book       schemav1.AudiobookRecord
			PriceCents int64
			Time       time.Time
		}{
			Book: schemav1.AudiobookRecord{
				Id:         id,
				Title:      title,
				Author:     author,
				PriceCents: price,
				CreatedAt:  ts(t),
			},
			PriceCents: price,
			Time:       t,
		})
	}
	return out, nil
}

func (s *SQLStore) HasPurchased(ctx context.Context, userID, audiobookID string) (bool, error) {
	var n int
	err := s.DB.QueryRowContext(ctx, `SELECT COUNT(1) FROM purchases WHERE user_id=? AND audiobook_id=?`, userID, audiobookID).Scan(&n)
	if err != nil {
		return false, err
	}
	return n > 0, nil
}

func parseProvider(p string) schemav1.Provider {
	switch strings.ToUpper(p) {
	case "CUSTOM":
		return schemav1.Provider_PROVIDER_CUSTOM
	case "GOOGLE":
		return schemav1.Provider_PROVIDER_GOOGLE
	default:
		return schemav1.Provider_PROVIDER_UNSPECIFIED
	}
}

func roleToText(r schemav1.Role) string {
	switch r {
	case schemav1.Role_ROLE_ADMIN:
		return "ADMIN"
	default:
		return "USER"
	}
}

func textToRole(s string) schemav1.Role {
	switch strings.ToUpper(s) {
	case "ADMIN":
		return schemav1.Role_ROLE_ADMIN
	default:
		return schemav1.Role_ROLE_USER
	}
}

func ts(t time.Time) *timestamppb.Timestamp { return timestamppb.New(t.UTC()) }

func timeOrNil(ts *timestamppb.Timestamp) any {
	if ts == nil || ts.AsTime().IsZero() {
		return nil
	}
	return ts.AsTime().UTC()
}

func bytesOrNil(b []byte) any {
	if b == nil {
		return nil
	}
	return b
}

func providerToText(p schemav1.Provider) string {
	switch p {
	case schemav1.Provider_PROVIDER_CUSTOM:
		return "CUSTOM"
	case schemav1.Provider_PROVIDER_GOOGLE:
		return "GOOGLE"
	default:
		return "CUSTOM" // fallback ปลอดภัย
	}
}

// null helpers
func nullString(s string) any {
	if strings.TrimSpace(s) == "" {
		return nil
	}
	return s
}
func nullInt64(v int64) any {
	if v == 0 {
		return nil
	}
	return v
}
func nullable(s string) any {
	if s == "" {
		return nil
	}
	return s
}
func statusOrDefault(s string) string {
	up := strings.ToUpper(strings.TrimSpace(s))
	switch up {
	case "PROCESSING", "READY", "FAILED":
		return up
	default:
		return "READY"
	}
}

// newPublicID: ให้ layer อื่นสร้าง id ก็ได้
func newPublicID() string {
	// แบบง่าย: epoch-nano (ควรเปลี่ยนเป็น ksuid/uuid ใน production)
	return time.Now().UTC().Format("20060102T150405") + "-" + strings.TrimPrefix(strings.ReplaceAll(time.Now().UTC().Format("15:04:05.000000"), ":", ""), "15")
}

func (s *SQLStore) getOrCreateCategoryID(ctx context.Context, label string) (int64, error) {
	label = strings.TrimSpace(label)
	if label == "" {
		return 0, fmt.Errorf("empty category label")
	}

	// ลองหา id ก่อน
	var id int64
	err := s.DB.QueryRowContext(ctx,
		`SELECT id FROM audiobook_category_types WHERE label=?`, label,
	).Scan(&id)
	if err == nil {
		return id, nil
	}
	if !errors.Is(err, sql.ErrNoRows) {
		return 0, err
	}

	// ไม่เจอ → สร้างใหม่ (unique key บน label)
	res, err := s.DB.ExecContext(ctx,
		`INSERT INTO audiobook_category_types (label) VALUES (?)
         ON DUPLICATE KEY UPDATE updated_at=VALUES(updated_at)`, label)
	if err != nil {
		return 0, err
	}
	id, _ = res.LastInsertId()
	if id != 0 {
		return id, nil
	}
	// กรณี duplicate race: ดึงอีกครั้ง
	if err := s.DB.QueryRowContext(ctx,
		`SELECT id FROM audiobook_category_types WHERE label=?`, label,
	).Scan(&id); err != nil {
		return 0, err
	}
	return id, nil
}
