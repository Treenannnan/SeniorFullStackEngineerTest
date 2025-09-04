package main

import (
	"flag"
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiQURNSU4iLCJpc3MiOiJjbGkiLCJzdWIiOiJhZG1pbi0xIiwiZXhwIjoxNzU2NTM3NTQ2fQ.CrKBpU-E-up2qnoJPGUC4nSiCmqmmnJYtS6oRIMnvlo
func main() {
	secret := flag.String("secret", "dev-secret", "")
	sub := flag.String("sub", "admin-1", "")
	role := flag.String("role", "ADMIN", "")
	flag.Parse()
	type C struct {
		Role string `json:"role"`
		jwt.RegisteredClaims
	}
	t := jwt.NewWithClaims(jwt.SigningMethodHS256, &C{
		Role: *role,
		RegisteredClaims: jwt.RegisteredClaims{
			Subject:   *sub,
			Issuer:    "cli",
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(2 * time.Hour)),
		},
	})
	s, _ := t.SignedString([]byte(*secret))
	fmt.Println(s)
}
