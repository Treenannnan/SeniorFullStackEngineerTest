package auth

import (
	"context"
	"database/sql"
	"fmt"
	"math/rand"
	"os"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	authv1 "github.com/backend/gen/auth/v1"
	"github.com/backend/internal/storage"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

var (
	sharedDB *sql.DB
)

func newSvcT(t *testing.T) *Service {
	secret := []byte("test-secret")

	if sharedDB == nil {
		sharedDB = mustOpenMySQL(t)
	}

	t.Cleanup(func() { cleanMySQLTestData(t, sharedDB) })
	return NewService(storage.NewSQLStore(sharedDB), secret)

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

func cleanMySQLTestData(t *testing.T, db *sql.DB) {
	t.Helper()

	ctx := context.Background()
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		t.Fatalf("begin tx: %v", err)
	}
	defer func() {
		_ = tx.Rollback()
	}()

	pattern := "test+%@testgo.com"

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

func getenvDefault(k, def string) string {
	if v := os.Getenv(k); v != "" {
		return v
	}
	return def
}

func mustSignUp(t *testing.T, s *Service, email, pass string) *authv1.AuthResponse {
	t.Helper()
	resp, err := s.SignUp(context.Background(), &authv1.SignUpRequest{
		Email:    email,
		Password: pass,
	})
	if err != nil {
		t.Fatalf("SignUp(%s) unexpected error: %v", email, err)
	}
	if resp.GetUser().GetEmail() != email {
		t.Fatalf("SignUp email mismatch: got=%s want=%s", resp.GetUser().GetEmail(), email)
	}
	if resp.GetUser().GetRole() != authv1.Role_ROLE_USER {
		t.Fatalf("default role must be ROLE_USER")
	}
	if resp.GetTokens().GetAccessToken() == "" || resp.GetTokens().GetRefreshToken() == "" {
		t.Fatalf("tokens should not be empty")
	}
	return resp
}

func TestSignUp_ThenSignIn_Success(t *testing.T) {
	s := newSvcT(t)

	email, pass := fmt.Sprintf("test+%d@testgo.com", (rand.Intn(1000)+100)), "xYz#12345"

	_ = mustSignUp(t, s, email, pass)

	resp, err := s.SignIn(context.Background(), &authv1.SignInRequest{
		Email:    email,
		Password: pass,
	})
	if err != nil {
		t.Fatalf("SignIn unexpected error: %v", err)
	}
	if resp.GetUser().GetEmail() != email {
		t.Fatalf("SignIn user email mismatch")
	}
	if resp.GetTokens().GetAccessToken() == "" || resp.GetTokens().GetRefreshToken() == "" {
		t.Fatalf("SignIn tokens empty")
	}

	t.Log("sign-up and sign-in ok.")
}

func TestSignUp_DuplicateEmail(t *testing.T) {
	s := newSvcT(t)
	email := "test+test2@testgo.com"

	_ = mustSignUp(t, s, email, "pw1")

	_, err := s.SignUp(context.Background(), &authv1.SignUpRequest{
		Email:    email,
		Password: "pw2",
	})
	if err == nil {
		t.Fatalf("expected AlreadyExists on duplicate email")
	}
	st, _ := status.FromError(err)
	if st.Code() != codes.AlreadyExists {
		t.Fatalf("expected AlreadyExists, got %v", st.Code())
	}

	t.Log("sign-up duplicate email ok.")
}

func TestSignIn_InvalidPassword(t *testing.T) {
	s := newSvcT(t)
	email := "test+test3@testgo.com"
	_ = mustSignUp(t, s, email, "correct_pw")

	_, err := s.SignIn(context.Background(), &authv1.SignInRequest{
		Email:    email,
		Password: "wrong_pw",
	})
	if err == nil {
		t.Fatalf("expected Unauthenticated for wrong password")
	}
	st, _ := status.FromError(err)
	if st.Code() != codes.Unauthenticated {
		t.Fatalf("expected Unauthenticated, got %v", st.Code())
	}

	t.Log("sign-in invalid password ok.")
}

func TestRefreshToken_RotateAndOldFails(t *testing.T) {
	s := newSvcT(t)
	email := "test+test4@testgo.com"
	sign := mustSignUp(t, s, email, "pw")

	oldRT := sign.GetTokens().GetRefreshToken()
	if oldRT == "" {
		t.Fatalf("empty refresh token from SignUp")
	}

	ref1, err := s.RefreshToken(context.Background(), &authv1.RefreshTokenRequest{
		RefreshToken: oldRT,
	})
	if err != nil {
		t.Fatalf("RefreshToken unexpected error: %v", err)
	}
	newRT := ref1.GetTokens().GetRefreshToken()
	if newRT == "" || newRT == oldRT {
		t.Fatalf("refresh token not rotated")
	}

	_, err = s.RefreshToken(context.Background(), &authv1.RefreshTokenRequest{
		RefreshToken: oldRT,
	})
	if err == nil {
		t.Fatalf("expected error when using rotated (old) refresh token")
	}
	st, _ := status.FromError(err)
	if st.Code() != codes.Unauthenticated {
		t.Fatalf("expected Unauthenticated, got %v", st.Code())
	}

	t.Log("refresh token try rotate and use old to rotate ok.")
}

func TestValidateToken_ValidAndInvalid(t *testing.T) {
	s := newSvcT(t)
	email := "test+test5@testgo.com"
	sign := mustSignUp(t, s, email, "pw")

	vr, err := s.ValidateToken(context.Background(), &authv1.ValidateTokenRequest{
		AccessToken: sign.GetTokens().GetAccessToken(),
	})
	if err != nil {
		t.Fatalf("ValidateToken unexpected error: %v", err)
	}
	if !vr.GetValid() {
		t.Fatalf("expected valid=true for good token")
	}
	if vr.GetUser() == nil || vr.GetUser().GetEmail() != email {
		t.Fatalf("expected user email %s", email)
	}
	if vr.GetExpiresAt() == nil || vr.GetExpiresAt().AsTime().Before(time.Now().Add(-1*time.Minute)) {
		t.Fatalf("expires_at should be in the future")
	}

	vr2, err := s.ValidateToken(context.Background(), &authv1.ValidateTokenRequest{
		AccessToken: "bad.token.value",
	})
	if err != nil {
		t.Fatalf("ValidateToken should not return error for bad token, got: %v", err)
	}
	if vr2.GetValid() {
		t.Fatalf("expected valid=false for bad token")
	}

	t.Log("validate token and validate invalid token ok.")
}

func TestPasswordResetFlow(t *testing.T) {
	s := newSvcT(t)
	email := "test+test6@testgo.com"
	_ = mustSignUp(t, s, email, "oldpw")

	userRec, err := s.store.GetUserByEmail(context.Background(), email)
	if err != nil {
		t.Fatalf("GetUserByEmail error: %v", err)
	}
	token := "test-reset-token-123"
	exp := time.Now().Add(30 * time.Minute)
	if err := s.store.CreateResetToken(context.Background(), token, userRec.GetId(), exp); err != nil {
		t.Fatalf("CreateResetToken error: %v", err)
	}

	rr, err := s.ResetPassword(context.Background(), &authv1.ResetPasswordRequest{
		ResetToken:  token,
		NewPassword: "newpw",
	})
	if err != nil {
		t.Fatalf("ResetPassword unexpected error: %v", err)
	}
	if !rr.GetOk() {
		t.Fatalf("ResetPassword ok=false")
	}

	_, err = s.ResetPassword(context.Background(), &authv1.ResetPasswordRequest{
		ResetToken:  token,
		NewPassword: "newer",
	})
	if err == nil {
		t.Fatalf("expected error on reused reset token")
	}
	st, _ := status.FromError(err)
	if st.Code() != codes.PermissionDenied {
		t.Fatalf("expected PermissionDenied, got %v", st.Code())
	}

	if _, err := s.SignIn(context.Background(), &authv1.SignInRequest{
		Email:    email,
		Password: "newpw",
	}); err != nil {
		t.Fatalf("SignIn with new password failed: %v", err)
	}

	t.Log("request password reset and reset password ok.")
}

func TestRevokeToken(t *testing.T) {
	s := newSvcT(t)
	email := "test+test7@testgo.com"
	resp := mustSignUp(t, s, email, "pw")

	rt := resp.GetTokens().GetRefreshToken()
	if rt == "" {
		t.Fatalf("empty refresh token")
	}

	rev, err := s.RevokeToken(context.Background(), &authv1.RevokeTokenRequest{
		RefreshToken: rt,
	})
	if err != nil {
		t.Fatalf("RevokeToken unexpected error: %v", err)
	}
	if !rev.GetOk() {
		t.Fatalf("RevokeToken ok=false")
	}

	_, err = s.RefreshToken(context.Background(), &authv1.RefreshTokenRequest{
		RefreshToken: rt,
	})
	if err == nil {
		t.Fatalf("expected error after revoke")
	}
	st, _ := status.FromError(err)
	if st.Code() != codes.Unauthenticated {
		t.Fatalf("expected Unauthenticated, got %v", st.Code())
	}

	t.Log("revoke token ok.")
}
