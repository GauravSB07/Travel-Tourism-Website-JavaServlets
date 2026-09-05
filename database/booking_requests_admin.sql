-- Run this script in your ALREADY HOSTED TravelTourism database.
-- It creates/upgrades booking_requests only. It does not create another database.

CREATE TABLE IF NOT EXISTS booking_requests (
    reference CHAR(36) NOT NULL PRIMARY KEY,
    request_token CHAR(36) NOT NULL UNIQUE,
    package_type ENUM('destination','holiday') NOT NULL,
    package_id VARCHAR(80) NOT NULL,
    package_name VARCHAR(180) NOT NULL,
    departure_city VARCHAR(120) NOT NULL,
    duration INT NOT NULL,
    price_per_person INT NOT NULL,
    customer_name VARCHAR(120) NOT NULL,
    email VARCHAR(254) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    travelers INT NOT NULL,
    travel_date DATE NOT NULL,
    preferences TEXT NOT NULL,
    total_price BIGINT NOT NULL,
    status ENUM('pending','reviewing','confirmed','completed','cancelled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    contact_preference ENUM('email','phone','whatsapp') NOT NULL DEFAULT 'email',
    pickup_location VARCHAR(180) NULL,
    terms_accepted_at TIMESTAMP NULL,
    booking_channel ENUM('guest','account') NOT NULL DEFAULT 'guest',
    user_id BIGINT NULL,
    admin_notes TEXT NULL,
    follow_up_date DATE NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    INDEX idx_booking_created (created_at),
    INDEX idx_booking_workflow (archived,status,created_at),
    INDEX idx_booking_follow_up (follow_up_date),
    INDEX idx_booking_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE booking_requests
    MODIFY COLUMN status ENUM('pending','reviewing','confirmed','completed','cancelled') NOT NULL DEFAULT 'pending';

SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='updated_at');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN contact_preference ENUM(''email'',''phone'',''whatsapp'') NOT NULL DEFAULT ''email'' AFTER preferences','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='contact_preference');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN pickup_location VARCHAR(180) NULL AFTER contact_preference','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='pickup_location');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN terms_accepted_at TIMESTAMP NULL AFTER pickup_location','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='terms_accepted_at');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN booking_channel ENUM(''guest'',''account'') NOT NULL DEFAULT ''guest'' AFTER terms_accepted_at','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='booking_channel');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN user_id BIGINT NULL AFTER booking_channel','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='user_id');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN admin_notes TEXT NULL AFTER user_id','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='admin_notes');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN follow_up_date DATE NULL AFTER admin_notes','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='follow_up_date');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
SET @q=(SELECT IF(COUNT(*)=0,'ALTER TABLE booking_requests ADD COLUMN archived BOOLEAN NOT NULL DEFAULT FALSE AFTER follow_up_date','SELECT 1') FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='booking_requests' AND column_name='archived');PREPARE s FROM @q;EXECUTE s;DEALLOCATE PREPARE s;
