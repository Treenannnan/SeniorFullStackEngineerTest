CREATE TABLE audiobooks (
  id               VARCHAR(64)    NOT NULL PRIMARY KEY,
  title            VARCHAR(256)   NOT NULL,
  author           VARCHAR(256)   NOT NULL,
  duration_sec     BIGINT         NOT NULL DEFAULT 0,
  price_cents      BIGINT         NOT NULL,
  cover_url        VARCHAR(1024)  NULL,
  audio_path       VARCHAR(1024)  NOT NULL,
  status           VARCHAR(16)    NOT NULL DEFAULT 'NONE',
  ai_description   MEDIUMTEXT     NULL,
  transcript       LONGTEXT       NULL,
  created_at       DATETIME(6)    NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at       DATETIME(6)    NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  content_type     VARCHAR(100)   NOT NULL DEFAULT 'application/octet-stream',
  ai_provider      VARCHAR(64)    NULL,

  UNIQUE KEY uq_audiobooks_audio_path (audio_path(255)),
  KEY idx_audiobooks_status (status),
  KEY idx_audiobooks_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE audiobook_category_types (
  id            BIGINT        NOT NULL AUTO_INCREMENT PRIMARY KEY,
  label         VARCHAR(64)   NOT NULL,
  created_at    DATETIME(6)   NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at    DATETIME(6)   NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),

  UNIQUE KEY uq_act_label (label)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE audiobook_categories (
  audiobook_id   VARCHAR(64)  NOT NULL,
  category_id    BIGINT       NOT NULL,
  idx_pos        INT          NOT NULL,
  PRIMARY KEY (audiobook_id, idx_pos),
  CONSTRAINT fk_ac_book FOREIGN KEY (audiobook_id) REFERENCES audiobooks(id) ON DELETE CASCADE,
  CONSTRAINT fk_ac_category FOREIGN KEY (category_id) REFERENCES audiobook_category_types(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY idx_ac_category_id (category_id)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE cart_items (
  user_id      VARCHAR(64) NOT NULL,
  audiobook_id VARCHAR(64) NOT NULL,
  created_at   DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at   DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (user_id, audiobook_id),
  CONSTRAINT fk_ci_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_ci_book FOREIGN KEY (audiobook_id) REFERENCES audiobooks(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE orders (
  id          BIGINT       NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_uid   VARCHAR(64)  NOT NULL,
  user_id     VARCHAR(64)  NOT NULL,
  total_cents BIGINT       NOT NULL,
  created_at  DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),

  UNIQUE KEY uq_orders_order_uid (order_uid),
  KEY idx_orders_user (user_id),
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE order_items (
  order_id     BIGINT      NOT NULL,
  audiobook_id VARCHAR(64) NOT NULL,
  price_cents  BIGINT      NOT NULL,
  PRIMARY KEY (order_id, audiobook_id),
  CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_oi_book  FOREIGN KEY (audiobook_id) REFERENCES audiobooks(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE purchases (
  user_id      VARCHAR(64) NOT NULL,
  audiobook_id VARCHAR(64) NOT NULL,
  price_cents  BIGINT      NOT NULL,
  purchased_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (user_id, audiobook_id),
  CONSTRAINT fk_p_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_p_book FOREIGN KEY (audiobook_id) REFERENCES audiobooks(id) ON DELETE CASCADE,
  KEY idx_purchased_at (purchased_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
