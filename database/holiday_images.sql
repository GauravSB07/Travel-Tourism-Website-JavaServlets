-- Select your EXISTING hosted database in MySQL, then run this script.
-- This creates only an image table. It does not create a database or change existing tables.
-- Each customized holiday has one cover photo (JPEG or PNG).
CREATE TABLE IF NOT EXISTS holiday_images (
    holiday_id VARCHAR(80) NOT NULL,
    image_data MEDIUMBLOB NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    PRIMARY KEY (holiday_id),
    CONSTRAINT fk_holiday_cover_package FOREIGN KEY (holiday_id)
        REFERENCES holiday_packages(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
