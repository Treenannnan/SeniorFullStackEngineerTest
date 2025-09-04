CREATE TABLE users (
  id              VARCHAR(64)   NOT NULL PRIMARY KEY,
  email           VARCHAR(320)  NOT NULL,
  email_norm      VARCHAR(320)  GENERATED ALWAYS AS (LOWER(email)) STORED,
  provider        VARCHAR(16)   NOT NULL,                
  role            VARCHAR(16)   NOT NULL DEFAULT 'USER',  -- "USER" | "ADMIN"
  email_verified  BOOLEAN       NOT NULL DEFAULT FALSE,
  password_hash   VARBINARY(255) NULL,
  created_at      DATETIME(6)   NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at      DATETIME(6)   NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),

  UNIQUE KEY uq_users_email_norm (email_norm),
  KEY idx_users_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE refresh_tokens (
  token       VARCHAR(255) NOT NULL PRIMARY KEY,
  user_id     VARCHAR(64)  NOT NULL,
  expires_at  DATETIME(6)  NOT NULL,
  created_at  DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),

  CONSTRAINT fk_refresh_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  KEY idx_refresh_user (user_id),
  KEY idx_refresh_exp (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE reset_tokens (
  token       VARCHAR(255) NOT NULL PRIMARY KEY,
  user_id     VARCHAR(64)  NOT NULL,
  expires_at  DATETIME(6)  NOT NULL,
  created_at  DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),

  CONSTRAINT fk_reset_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  KEY idx_reset_user (user_id),
  KEY idx_reset_exp (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
