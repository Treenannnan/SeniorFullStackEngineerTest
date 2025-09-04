
DOCKER_COMPOSE ?= docker compose 
MYSQL_SVC      ?= mysql         
MYSQL_USER     ?= root
MYSQL_PASS     ?= 12345
MYSQL_DB       ?= auth
MYSQL_PORT     ?= 3306

PROTO_DIR := protobuf
GO_OUT    := ./
DART_OUT  := ../frontend/lib/proto
PROTOC_INC:=C:\\Users\\user\\vcpkg\\packages\\protobuf_x64-windows\\include

AUTH_PROTO    := $(PROTO_DIR)/auth/v1/authentication.proto
SCHEMA_PROTO  := $(PROTO_DIR)/schema/v1/schema.proto
SHOP_PROTO 	  := $(PROTO_DIR)/shop/v1/shop.proto
WKT_TIMESTAMP := google/protobuf/timestamp.proto
WKT_EMPTY     := google/protobuf/empty.proto


TEST_MYSQL_DSN ?= $(MYSQL_USER):$(MYSQL_PASS)@tcp(127.0.0.1:$(MYSQL_PORT))/$(MYSQL_DB)?parseTime=true&charset=utf8mb4&loc=UTC

.PHONY: gen gen-go gen-dart db-reset db-build

gen: gen-go gen-dart

gen-go:
	protoc -I$(PROTO_DIR) -Ithird_party/googleapis --go_out=$(GO_OUT) --go_opt=module=github.com/backend --go-grpc_opt=module=github.com/backend --go-grpc_out=$(GO_OUT) $(AUTH_PROTO) $(SCHEMA_PROTO) $(SHOP_PROTO)

gen-dart:
	$(MKDIR_P)
	protoc -I$(PROTO_DIR) -Ithird_party/googleapis -I"$(PROTOC_INC)" $(DART_PLUGIN) --dart_out=grpc:$(DART_OUT) \
	  $(AUTH_PROTO) $(SCHEMA_PROTO) $(SHOP_PROTO) $(WKT_TIMESTAMP) $(WKT_EMPTY)

go-test-all:
	go test -timeout 300s -count=1 github.com/backend/internal/auth github.com/backend/internal/shop

db-build:
	docker exec -i mySQL12345 mysql -u$(MYSQL_USER) -p$(MYSQL_PASS) $(MYSQL_DB) < ./sql/000_drop.sql
	docker exec -i mySQL12345 mysql -u$(MYSQL_USER) -p$(MYSQL_PASS) $(MYSQL_DB) < ./sql/001_auth.sql
	docker exec -i mySQL12345 mysql -u$(MYSQL_USER) -p$(MYSQL_PASS) $(MYSQL_DB) < ./sql/002_shop.sql

down-backend:
	docker stop service-app mysql-app
	docker rm -f service-app mysql-app

down-backend-go:
	docker stop service-app
	docker rm -f service-app

.PHONY: compose-up wait-mysql compose-db-build go-test deploy down logs

compose-up:
	$(DOCKER_COMPOSE) up -d --build

compose-app:
	$(DOCKER_COMPOSE) build app
	$(DOCKER_COMPOSE) up -d app

wait-mysql:
	@echo "waiting for mysql to be healthy..."
	@$(DOCKER_COMPOSE) exec -T $(MYSQL_SVC) sh -lc '\
		until mysqladmin ping -h 127.0.0.1 -uroot -p"$$MYSQL_ROOT_PASSWORD" --silent; do \
			echo "  still waiting..."; \
			sleep 2; \
		done; \
		echo "mysql is ready."'

compose-db-build:
	docker cp ./sql mysql-app:/sql
	docker exec -i mysql-app sh -lc "mysql -uroot -p12345 auth < /sql/000_drop.sql"
	docker exec -i mysql-app sh -lc "mysql -uroot -p12345 auth < /sql/001_auth.sql"
	docker exec -i mysql-app sh -lc "mysql -uroot -p12345 auth < /sql/002_shop.sql"

go-test:
	@set TEST_MYSQL_DSN=root:12345@tcp(127.0.0.1:3306)/auth?parseTime=true^&charset=utf8mb4^&loc=UTC && \
	set AUTH_JWT_SECRET=test-secret && \
	go test -timeout 300s -count=1 github.com/backend/internal/auth github.com/backend/internal/shop

deploy: compose-up wait-mysql compose-db-build go-test
	@echo "deploy + db-build + go test completed."

deploy-go: compose-app go-test
	@echo "deploy update app + go test completed."

deploy-go-skip: compose-app
	@echo "deploy update app + go test completed."
	
down:
	$(DOCKER_COMPOSE) down -v

logs:
	$(DOCKER_COMPOSE) logs -f
