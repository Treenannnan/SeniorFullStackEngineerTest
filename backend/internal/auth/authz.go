package auth

import (
	"context"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
)

var ErrForbidden = errors.New("forbidden")

type ctxKeyClaims struct{}

func WithClaims(ctx context.Context, claims jwt.MapClaims) context.Context {
	return context.WithValue(ctx, ctxKeyClaims{}, claims)
}

func ClaimsFrom(ctx context.Context) (jwt.MapClaims, bool) {
	v := ctx.Value(ctxKeyClaims{})
	claims, ok := v.(jwt.MapClaims)
	if !ok || claims == nil {
		return nil, false
	}
	return claims, true
}

func AuthUnaryInterceptor(secret []byte, skip map[string]bool) grpc.UnaryServerInterceptor {
	return func(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {

		if skip[info.FullMethod] {
			return handler(ctx, req)
		}
		md, _ := metadata.FromIncomingContext(ctx)
		vals := md.Get("authorization")
		if len(vals) == 0 || !strings.HasPrefix(strings.ToLower(vals[0]), "bearer ") {
			return nil, status.Error(codes.Unauthenticated, "missing bearer token")
		}
		token := strings.TrimSpace(vals[0][len("Bearer "):])

		claims, err := VerifyJWT(token, secret)
		if err != nil {
			return nil, status.Error(codes.Unauthenticated, err.Error())
		}

		ctx = WithClaims(ctx, claims)
		return handler(ctx, req)
	}
}

func VerifyJWT(tokenString string, secret []byte) (jwt.MapClaims, error) {
	claims := jwt.MapClaims{}

	parser := jwt.NewParser(jwt.WithValidMethods([]string{"HS256"}), jwt.WithAudience("auth_service"))

	token, err := parser.ParseWithClaims(tokenString, claims, func(t *jwt.Token) (interface{}, error) {
		return secret, nil
	})
	if err != nil {
		return nil, fmt.Errorf("invalid token: %w", err)
	}
	if !token.Valid {
		return nil, errors.New("token invalid")
	}

	if expVal, ok := claims["exp"].(float64); ok {
		exp := time.Unix(int64(expVal), 0)
		if time.Now().After(exp) {
			return nil, errors.New("token expired")
		}
	} else {
		return nil, errors.New("exp not found")
	}

	return claims, nil
}
