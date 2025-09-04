package auth

import (
	"context"
	"crypto/rand"
	"encoding/base64"
	"errors"
	"fmt"
	"log"
	"strings"
	"time"

	authv1 "github.com/backend/gen/auth/v1"
	schemav1 "github.com/backend/gen/schema/v1"
	"github.com/backend/internal/storage"
	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/timestamppb"

	"google.golang.org/api/idtoken"
)

type Service struct {
	authv1.UnimplementedAuthenticationServiceServer

	store  storage.Store
	secret []byte
}

func NewService(store storage.Store, secret []byte) *Service {
	return &Service{
		store:  store,
		secret: secret,
	}
}

func (s *Service) now() time.Time { return time.Now().UTC() }

func (s *Service) nextID() string {
	b := make([]byte, 12)
	_, _ = rand.Read(b)
	return base64.RawURLEncoding.EncodeToString(b)
}

func (s *Service) newOpaqueToken(n int) string {
	b := make([]byte, n)
	_, _ = rand.Read(b)
	return base64.RawURLEncoding.EncodeToString(b)
}

func toAuthProvider(p schemav1.Provider) authv1.AuthProvider {
	switch p {
	case schemav1.Provider_PROVIDER_CUSTOM:
		return authv1.AuthProvider_AUTH_PROVIDER_CUSTOM
	case schemav1.Provider_PROVIDER_GOOGLE:
		return authv1.AuthProvider_AUTH_PROVIDER_GOOGLE
	default:
		return authv1.AuthProvider_AUTH_PROVIDER_UNSPECIFIED
	}
}

func toAuthRole(r schemav1.Role) authv1.Role {
	switch r {
	case schemav1.Role_ROLE_ADMIN:
		return authv1.Role_ROLE_ADMIN
	case schemav1.Role_ROLE_USER:
		fallthrough
	default:
		return authv1.Role_ROLE_USER
	}
}

func toAuthUser(u *schemav1.UserRecord) *authv1.User {
	if u == nil {
		return nil
	}
	return &authv1.User{
		Id:            u.GetId(),
		Email:         u.GetEmail(),
		Provider:      toAuthProvider(u.GetProvider()),
		EmailVerified: u.GetEmailVerified(),
		CreatedAt:     u.GetCreatedAt(),
		UpdatedAt:     u.GetUpdatedAt(),
		Role:          toAuthRole(u.GetRole()),
	}
}

func (s *Service) makeTokens(u *authv1.User) (*authv1.TokenPair, error) {
	accessTTL := 30 * time.Minute
	refreshTTL := 7 * 24 * time.Hour

	accessExp := s.now().Add(accessTTL)
	refreshExp := s.now().Add(refreshTTL)

	parser := jwt.NewParser(jwt.WithValidMethods([]string{"HS256"}), jwt.WithAudience("auth_service"))

	_ = parser

	claims := jwt.MapClaims{
		"sub":      u.GetId(),
		"email":    u.GetEmail(),
		"provider": strings.TrimPrefix(u.GetProvider().String(), "AUTH_PROVIDER_"),
		"role":     strings.TrimPrefix(u.GetRole().String(), "ROLE_"),
		"iat":      time.Now().Unix(),
		"exp":      accessExp.Unix(),
		"aud":      "auth_service",
	}

	tok := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	access, err := tok.SignedString(s.secret)
	if err != nil {
		return nil, err
	}

	refresh := s.newOpaqueToken(32)

	if err := s.store.CreateRefreshToken(context.Background(), refresh, u.GetId(), refreshExp); err != nil {
		return nil, fmt.Errorf("store.CreateRefreshToken: %w", err)
	}

	return &authv1.TokenPair{
		AccessToken:           access,
		RefreshToken:          refresh,
		AccessTokenExpiresAt:  timestamppb.New(accessExp),
		RefreshTokenExpiresAt: timestamppb.New(refreshExp),
		TokenType:             "Bearer",
	}, nil
}

func (s *Service) SignUp(ctx context.Context, r *authv1.SignUpRequest) (*authv1.AuthResponse, error) {
	email := strings.ToLower(strings.TrimSpace(r.GetEmail()))
	pw := r.GetPassword()
	if email == "" || pw == "" {
		return nil, status.Error(codes.InvalidArgument, "email/password required")
	}

	if _, err := s.store.GetUserByEmail(ctx, email); err == nil {
		return nil, status.Error(codes.AlreadyExists, "email already used")
	} else if !errorsIs(err, storage.ErrNotFound) {
		return nil, status.Errorf(codes.Internal, "store.GetUserByEmail: %v", err)
	}

	uid := s.nextID()
	hash, _ := bcrypt.GenerateFromPassword([]byte(pw), bcrypt.DefaultCost)

	rec := &schemav1.UserRecord{
		Id:            uid,
		Email:         email,
		Provider:      schemav1.Provider_PROVIDER_CUSTOM,
		EmailVerified: false,
		CreatedAt:     timestamppb.Now(),
		UpdatedAt:     timestamppb.Now(),
		PasswordHash:  hash,
		Role:          schemav1.Role_ROLE_USER,
	}
	if err := s.store.CreateUser(ctx, rec); err != nil {
		if errorsIs(err, storage.ErrAlreadyExist) {
			return nil, status.Error(codes.AlreadyExists, "email already used")
		}
		return nil, status.Errorf(codes.Internal, "store.CreateUser: %v", err)
	}

	u := toAuthUser(rec)

	if strings.Contains(email, "@testshopgo.com") {
		return &authv1.AuthResponse{
			User:   u,
			Tokens: nil,
		}, nil
	}

	toks, err := s.makeTokens(u)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "token error: %v", err)
	}
	return &authv1.AuthResponse{
		User:   u,
		Tokens: toks,
	}, nil
}

func (s *Service) SignIn(ctx context.Context, r *authv1.SignInRequest) (*authv1.AuthResponse, error) {
	email := strings.ToLower(strings.TrimSpace(r.GetEmail()))
	pw := r.GetPassword()

	rec, err := s.store.GetUserByEmail(ctx, email)
	if err != nil {
		if errorsIs(err, storage.ErrNotFound) {
			return nil, status.Error(codes.Unauthenticated, "invalid credentials")
		}
		return nil, status.Errorf(codes.Internal, "store.GetUserByEmail: %v", err)
	}
	if rec.GetProvider() != schemav1.Provider_PROVIDER_CUSTOM {
		return nil, status.Error(codes.Unauthenticated, "invalid credentials")
	}
	if bcrypt.CompareHashAndPassword(rec.GetPasswordHash(), []byte(pw)) != nil {
		return nil, status.Error(codes.Unauthenticated, "invalid credentials")
	}

	u := toAuthUser(rec)
	toks, err := s.makeTokens(u)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "token error: %v", err)
	}
	return &authv1.AuthResponse{User: u, Tokens: toks}, nil
}

const googleClientID = "225011963709-jqhe548mvechr2d0jkl6ggv2t20pu539.apps.googleusercontent.com" // ใส่ Client ID ที่ตรงกับฝั่งที่ออก token จริง ๆ

func emailFromIDToken(ctx context.Context, rawIDToken string) (string, bool, error) {
	payload, err := idtoken.Validate(ctx, rawIDToken, googleClientID)
	if err != nil {
		return "", false, fmt.Errorf("invalid id token: %w", err)
	}

	var email string
	var verified bool

	if v, ok := payload.Claims["email"]; ok {
		if s, ok := v.(string); ok {
			email = s
		}
	}
	if v, ok := payload.Claims["email_verified"]; ok {
		if b, ok := v.(bool); ok {
			verified = b
		}
	}

	if email == "" {
		return "", false, fmt.Errorf("email claim not present")
	}
	return email, verified, nil
}

func (s *Service) GoogleSignIn(ctx context.Context, r *authv1.GoogleSignInRequest) (*authv1.AuthResponse, error) {
	if r.GetIdToken() == "" {
		return nil, status.Error(codes.InvalidArgument, "id_token required")
	}

	email, _, err := emailFromIDToken(ctx, r.GetIdToken())

	if err != nil {
		return nil, status.Errorf(codes.Internal, "verify failed: %v", err)
	}

	rec, err := s.store.GetUserByEmail(ctx, email)
	switch {
	case err == nil:

	case errorsIs(err, storage.ErrNotFound):
		rec = &schemav1.UserRecord{
			Id:            s.nextID(),
			Email:         email,
			Provider:      schemav1.Provider_PROVIDER_GOOGLE,
			EmailVerified: true,
			CreatedAt:     timestamppb.Now(),
			UpdatedAt:     timestamppb.Now(),
			Role:          schemav1.Role_ROLE_USER,
		}
		if err := s.store.CreateUser(ctx, rec); err != nil {
			return nil, status.Errorf(codes.Internal, "store.CreateUser: %v", err)
		}
	default:
		return nil, status.Errorf(codes.Internal, "store.GetUserByEmail: %v", err)
	}

	u := toAuthUser(rec)
	toks, err := s.makeTokens(u)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "token error: %v", err)
	}
	return &authv1.AuthResponse{User: u, Tokens: toks}, nil
}

func (s *Service) RefreshToken(ctx context.Context, r *authv1.RefreshTokenRequest) (*authv1.AuthResponse, error) {
	rt := r.GetRefreshToken()
	uid, ok, err := s.store.GetRefreshTokenOwner(ctx, rt)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "store.GetRefreshTokenOwner: %v", err)
	}
	if !ok {
		return nil, status.Error(codes.Unauthenticated, "invalid refresh token")
	}

	if err := s.store.DeleteRefreshToken(ctx, rt); err != nil {
		return nil, status.Errorf(codes.Internal, "store.DeleteRefreshToken: %v", err)
	}

	userRec, err := s.store.GetUserByID(ctx, uid)
	if err != nil {
		if errorsIs(err, storage.ErrNotFound) {
			return nil, status.Error(codes.NotFound, "user not found")
		}
		return nil, status.Errorf(codes.Internal, "store.GetUserByID: %v", err)
	}

	u := toAuthUser(userRec)
	toks, err := s.makeTokens(u)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "token error: %v", err)
	}
	return &authv1.AuthResponse{User: u, Tokens: toks}, nil
}

func (s *Service) ValidateToken(ctx context.Context, r *authv1.ValidateTokenRequest) (*authv1.ValidateTokenResponse, error) {
	tok := r.GetAccessToken()
	if tok == "" {
		return &authv1.ValidateTokenResponse{Valid: false}, nil
	}

	claims, err := VerifyJWT(tok, s.secret)

	if err != nil {
		return &authv1.ValidateTokenResponse{Valid: false}, nil
	}

	email, _ := claims["email"].(string)
	var u *authv1.User
	if email != "" {
		if rec, err := s.store.GetUserByEmail(ctx, email); err == nil {
			u = toAuthUser(rec)
		}
	}
	var exp *timestamppb.Timestamp
	if v, ok := claims["exp"].(float64); ok {
		exp = timestamppb.New(time.Unix(int64(v), 0).UTC())
	}
	return &authv1.ValidateTokenResponse{Valid: true, User: u, ExpiresAt: exp}, nil
}

func (s *Service) RequestPasswordReset(ctx context.Context, r *authv1.RequestPasswordResetRequest) (*authv1.RequestPasswordResetResponse, error) {
	email := strings.ToLower(strings.TrimSpace(r.GetEmail()))
	rec, err := s.store.GetUserByEmail(ctx, email)
	if err == nil && rec.GetProvider() == schemav1.Provider_PROVIDER_CUSTOM {
		rt := "abcABC" //s.newOpaqueToken(24)
		exp := s.now().Add(30 * time.Minute)
		if err := s.store.CreateResetToken(ctx, rt, rec.GetId(), exp); err == nil {
			log.Printf("[DEV] reset token for %s: %s\n", email, rt)
		}
	}
	return &authv1.RequestPasswordResetResponse{Ok: true}, nil
}

func (s *Service) ResetPassword(ctx context.Context, r *authv1.ResetPasswordRequest) (*authv1.ResetPasswordResponse, error) {
	uid, ok, err := s.store.ConsumeResetToken(ctx, r.GetResetToken())
	if err != nil {
		return nil, status.Errorf(codes.Internal, "store.ConsumeResetToken: %v", err)
	}
	if !ok {
		return nil, status.Error(codes.PermissionDenied, "invalid reset token")
	}
	hash, _ := bcrypt.GenerateFromPassword([]byte(r.GetNewPassword()), bcrypt.DefaultCost)
	if err := s.store.SetUserPasswordHash(ctx, uid, hash); err != nil {
		return nil, status.Errorf(codes.Internal, "store.SetUserPasswordHash: %v", err)
	}
	return &authv1.ResetPasswordResponse{Ok: true}, nil
}

func (s *Service) RevokeToken(ctx context.Context, r *authv1.RevokeTokenRequest) (*authv1.RevokeTokenResponse, error) {
	if err := s.store.DeleteRefreshToken(ctx, r.GetRefreshToken()); err != nil {
		return nil, status.Errorf(codes.Internal, "store.DeleteRefreshToken: %v", err)
	}
	return &authv1.RevokeTokenResponse{Ok: true}, nil
}

func errorsIs(err, target error) bool {
	return (err != nil && target != nil && (err == target || errors.Is(err, target)))
}
