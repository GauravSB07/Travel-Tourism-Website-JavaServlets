-- Run this entire file in your EXISTING travel_tourism database.
-- No database is created, dropped, or replaced. Existing tours tables are untouched.
-- MySQL 8+. Sample prices/itineraries are editable; review before offering commercially.

CREATE TABLE IF NOT EXISTS holiday_packages (
    id VARCHAR(80) NOT NULL PRIMARY KEY,
    name VARCHAR(180) NOT NULL,
    occasion VARCHAR(80) NOT NULL DEFAULT '',
    festival VARCHAR(80) NOT NULL DEFAULT '' COMMENT 'Legacy field; occasion packages do not use it',
    departure_city VARCHAR(120) NOT NULL,
    departure_date DATE NULL,
    duration INT NOT NULL,
    price INT NOT NULL COMMENT 'INR per person',
    description TEXT NOT NULL,
    inclusions TEXT NOT NULL,
    exclusions TEXT NOT NULL,
    source_url VARCHAR(500),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_holiday_departure (active, departure_date),
    CONSTRAINT chk_holiday_duration CHECK (duration > 0),
    CONSTRAINT chk_holiday_price CHECK (price >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS holiday_itinerary (
    holiday_id VARCHAR(80) NOT NULL,
    day_number INT NOT NULL,
    description TEXT NOT NULL,
    PRIMARY KEY (holiday_id, day_number),
    CONSTRAINT fk_itinerary_holiday FOREIGN KEY (holiday_id)
        REFERENCES holiday_packages(id) ON DELETE CASCADE,
    CONSTRAINT chk_itinerary_day CHECK (day_number > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Shared by destination and customized-holiday booking requests.
-- Package details are saved as a snapshot so later price/name changes do not alter a request.
-- No foreign key to your existing tours table is needed.
CREATE TABLE IF NOT EXISTS booking_requests (
    reference CHAR(36) NOT NULL PRIMARY KEY,
    request_token CHAR(36) NOT NULL UNIQUE,
    package_type ENUM('destination', 'holiday') NOT NULL,
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
    status ENUM('pending', 'confirmed', 'cancelled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_booking_created (created_at),
    CONSTRAINT chk_booking_travelers CHECK (travelers BETWEEN 1 AND 30),
    CONSTRAINT chk_booking_price CHECK (price_per_person >= 0 AND total_price >= 0),
    CONSTRAINT chk_booking_duration CHECK (duration > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Upgrade the earlier festival schema if you already ran the previous file.
-- These statements run only when YOU execute this file in your selected database.
SET @occasion_column_exists = (
    SELECT COUNT(*) FROM information_schema.columns
    WHERE table_schema = DATABASE() AND table_name = 'holiday_packages' AND column_name = 'occasion'
);
SET @occasion_upgrade = IF(@occasion_column_exists = 0,
    'ALTER TABLE holiday_packages ADD COLUMN occasion VARCHAR(80) NOT NULL DEFAULT '''' AFTER name',
    'SELECT 1');
PREPARE occasion_upgrade_statement FROM @occasion_upgrade;
EXECUTE occasion_upgrade_statement;
DEALLOCATE PREPARE occasion_upgrade_statement;

-- Preserve legacy festival data while allowing flexible dates for occasion packages.
ALTER TABLE holiday_packages
    MODIFY COLUMN festival VARCHAR(80) NOT NULL DEFAULT '',
    MODIFY COLUMN departure_date DATE NULL;

START TRANSACTION;

-- Sample offers: edit prices and inclusions to suit your business.
-- Repeat execution leaves your existing package and itinerary edits intact.
INSERT INTO holiday_packages
(id, name, occasion, departure_city, duration, price, description, inclusions, exclusions)
VALUES
('goa-birthday-escape', 'Goa Birthday Escape', 'Birthday', 'Goa', 3, 12900,
 'Celebrate another wonderful year with beach time, a relaxed coastal stay and a birthday dinner.',
 'Two nights in a standard hotel; breakfast; local sightseeing transfers; one birthday cake and a set-menu celebration dinner.',
 'Travel to Goa; water sports; drinks; other meals; room upgrades and additional decorations.'),
('kerala-honeymoon-retreat', 'Kerala Honeymoon Retreat', 'Honeymoon', 'Kochi', 5, 28900,
 'Spend time together among Munnar tea gardens and the backwaters, with an unhurried itinerary for two.',
 'Four nights in standard accommodation; breakfast; sightseeing transfers; one set-menu dinner for two. Price is per person.',
 'Travel to Kochi; private houseboat upgrades; spa treatments; entry fees; other meals and personal expenses.'),
('udaipur-anniversary', 'Udaipur Anniversary Getaway', 'Anniversary', 'Udaipur', 4, 21900,
 'Mark your milestone with lakeside walks, palace heritage and a special evening together.',
 'Three nights in a standard hotel; breakfast; sightseeing transfers; one set-menu anniversary dinner.',
 'Travel to Udaipur; monument tickets; boat rides; premium dining upgrades; other meals and personal expenses.'),
('jaipur-family-celebration', 'Jaipur Family Celebration', 'Family Celebration', 'Jaipur', 4, 16900,
 'Bring everyone together for a leisurely mix of forts, crafts and shared family experiences.',
 'Three nights in a standard hotel; breakfast; local sightseeing transfers; one family set-menu dinner. Price is per person.',
 'Travel to Jaipur; monument tickets; workshops; extra beds; other meals and personal expenses.')
ON DUPLICATE KEY UPDATE id = holiday_packages.id;

INSERT INTO holiday_itinerary (holiday_id, day_number, description) VALUES
('goa-birthday-escape', 1, 'Arrive in Goa, settle into your hotel and enjoy a relaxed evening by the beach.'),
('goa-birthday-escape', 2, 'Explore the coast at your own pace, then celebrate with a birthday cake and a set-menu dinner. Tell us your preferred celebration date when booking.'),
('goa-birthday-escape', 3, 'Enjoy breakfast and time for a final beach walk before departure.'),
('kerala-honeymoon-retreat', 1, 'Arrive in Kochi and transfer to Munnar for a quiet evening together.'),
('kerala-honeymoon-retreat', 2, 'Explore tea gardens and scenic viewpoints with time for a relaxed afternoon.'),
('kerala-honeymoon-retreat', 3, 'Travel towards the backwaters and check into your accommodation.'),
('kerala-honeymoon-retreat', 4, 'Spend the day at leisure near the backwaters and enjoy your included dinner for two.'),
('kerala-honeymoon-retreat', 5, 'Return to Kochi after breakfast for your onward journey.'),
('udaipur-anniversary', 1, 'Arrive in Udaipur and take a leisurely walk around the lakeside.'),
('udaipur-anniversary', 2, 'Discover palace architecture and local markets at a comfortable pace.'),
('udaipur-anniversary', 3, 'Enjoy free time together before your included anniversary dinner. Additional arrangements can be requested when booking.'),
('udaipur-anniversary', 4, 'Enjoy breakfast and depart with time for last-minute shopping.'),
('jaipur-family-celebration', 1, 'Arrive in Jaipur, settle in and gather for an easy evening together.'),
('jaipur-family-celebration', 2, 'Explore Amber Fort and the old city with breaks to suit the family.'),
('jaipur-family-celebration', 3, 'Browse local craft markets and come together for your included family dinner.'),
('jaipur-family-celebration', 4, 'Enjoy a relaxed breakfast before your departure.')
ON DUPLICATE KEY UPDATE holiday_id = holiday_itinerary.holiday_id;

COMMIT;

-- Legacy festival rows are preserved, but are not listed unless given an occasion.
-- Add future offers with an occasion and itinerary; travellers choose their own date.
-- SELECT * FROM holiday_packages WHERE occasion <> '' ORDER BY occasion;
-- SELECT * FROM booking_requests ORDER BY created_at DESC;
