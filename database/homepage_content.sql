-- Run this script in your ALREADY HOSTED TravelTourism database.
-- It does not create or select another database.

CREATE TABLE IF NOT EXISTS homepage_content (
    id TINYINT UNSIGNED NOT NULL,
    hero_label VARCHAR(120) NOT NULL,
    hero_title VARCHAR(120) NOT NULL,
    hero_accent VARCHAR(120) NOT NULL,
    hero_description VARCHAR(700) NOT NULL,
    destination_label VARCHAR(120) NOT NULL,
    destination_title VARCHAR(120) NOT NULL,
    destination_description VARCHAR(700) NOT NULL,
    holiday_label VARCHAR(120) NOT NULL,
    holiday_title VARCHAR(120) NOT NULL,
    holiday_description VARCHAR(700) NOT NULL,
    holiday_button VARCHAR(120) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO homepage_content (
    id, hero_label, hero_title, hero_accent, hero_description,
    destination_label, destination_title, destination_description,
    holiday_label, holiday_title, holiday_description, holiday_button
) VALUES (
    1,
    'DISCOVER • EXPERIENCE • REMEMBER',
    'Your Journey.',
    'Your Way.',
    'Explore India''s most beautiful destinations, discover unforgettable experiences and find a holiday designed around your occasion.',
    'EXPLORE INDIA',
    'Popular Destinations',
    'From beaches and mountains to heritage cities, discover places worth remembering.',
    'MADE FOR YOUR MOMENT',
    'Holidays for Every Occasion',
    'Choose a celebration that matters to you, then explore thoughtfully designed birthday, honeymoon, anniversary, family and group holiday packages.',
    'Explore Customized Holidays'
);

CREATE TABLE IF NOT EXISTS homepage_images (
    slot_key VARCHAR(30) NOT NULL,
    image_data MEDIUMBLOB NOT NULL,
    mime_type VARCHAR(30) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (slot_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
