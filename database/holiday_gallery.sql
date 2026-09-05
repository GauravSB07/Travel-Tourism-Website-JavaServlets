-- Run in your EXISTING hosted database. No database or existing table is replaced.
-- Main cover photos stay in holiday_images; this table holds additional gallery photos.
CREATE TABLE IF NOT EXISTS holiday_gallery (
    id BIGINT NOT NULL AUTO_INCREMENT,
    holiday_id VARCHAR(80) NOT NULL,
    image_data MEDIUMBLOB NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    caption VARCHAR(200) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    INDEX idx_holiday_gallery (holiday_id, id),
    CONSTRAINT fk_gallery_holiday FOREIGN KEY (holiday_id)
        REFERENCES holiday_packages(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
