-- Run this script in your ALREADY HOSTED TravelTourism database.
-- It does not create or select another database.

CREATE TABLE IF NOT EXISTS contact_enquiries (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(254) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    enquiry_type ENUM('general','destination','customized_holiday','existing_booking') NOT NULL,
    preferred_destination VARCHAR(120) NULL,
    travel_month VARCHAR(20) NULL,
    travellers TINYINT UNSIGNED NULL,
    budget_range VARCHAR(40) NULL,
    message TEXT NOT NULL,
    tour_id INT NULL,
    status ENUM('new','in_progress','responded','closed') NOT NULL DEFAULT 'new',
    admin_notes TEXT NULL,
    follow_up_date DATE NULL,
    archived BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    INDEX idx_contact_enquiries_workflow (archived, status, created_at),
    INDEX idx_contact_enquiries_follow_up (follow_up_date),
    INDEX idx_contact_enquiries_email (email),
    INDEX idx_contact_enquiries_tour (tour_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
