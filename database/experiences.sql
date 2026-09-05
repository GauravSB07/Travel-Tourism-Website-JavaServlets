CREATE TABLE IF NOT EXISTS experiences (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    location VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    reviewer_name VARCHAR(120) NOT NULL,
    trip_type VARCHAR(80) NOT NULL,
    rating INT NOT NULL DEFAULT 5,
    image_url VARCHAR(300) NOT NULL DEFAULT '',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT chk_experience_rating CHECK (rating BETWEEN 1 AND 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO experiences (title, location, description, reviewer_name, trip_type, rating, image_url) VALUES
('Amazing Goa Beach Vacation', 'Goa', 'The trip was absolutely amazing. The beaches, food and nightlife made the entire journey unforgettable. Everything was well planned and we had a wonderful time. Would highly recommend to anyone looking for a beach getaway.', 'Rahul Sharma', 'Family Trip', 5, 'goa.jpg'),
('Peaceful Kerala Backwaters', 'Kerala', 'Kerala was beautiful from start to finish. The backwaters and greenery were incredible. The houseboat experience was the highlight. It was one of the most relaxing trips I have ever taken.', 'Priya Patel', 'Couple Trip', 5, 'kerala.jpg'),
('Adventure in Himachal', 'Himachal Pradesh', 'If you love adventure, Himachal is the place to go. The mountains, trekking and weather made this an unforgettable experience. Paragliding in Solang Valley was the absolute highlight of our trip.', 'Arjun Mehta', 'Adventure Trip', 5, 'himachal.jpg'),
('Magical Rajasthan Heritage Tour', 'Rajasthan', 'Rajasthan took us back in time. The forts, palaces and the desert safari under the stars were magical. The hospitality was world class and the food was incredible. A must visit for history lovers.', 'Sneha Reddy', 'Cultural Trip', 5, 'rajasthan.jpg'),
('Breathtaking Ladakh Journey', 'Ladakh', 'Ladakh is a dream destination and this trip exceeded every expectation. Pangong Lake at sunrise is something I will never forget. The monasteries, the passes, and the stark beauty left us speechless.', 'Vikram Singh', 'Adventure Trip', 5, 'ladakh.jpg'),
('Serene Andaman Islands', 'Andaman & Nicobar Islands', 'Crystal clear waters, white sand beaches, and the most vibrant coral reefs I have ever seen. Scuba diving at Havelock was a life-changing experience. Perfect for anyone who loves the ocean.', 'Meera Nair', 'Honeymoon Trip', 5, 'andaman.jpg'),
('Spiritual Varanasi Experience', 'Varanasi', 'The evening Ganga Aarti was one of the most moving experiences of my life. The sunrise boat ride, the ancient temples and the energy of the city were unforgettable. Varanasi is truly a spiritual awakening.', 'Karthik Krishnan', 'Solo Trip', 4, 'varanasi.jpg'),
('Enchanting Udaipur Getaway', 'Udaipur', 'The city of lakes did not disappoint. Lake Pichola at sunset, the City Palace, and the romantic ambiance made our anniversary truly special. Udaipur is the Venice of the East for good reason.', 'Deepa Iyer', 'Couple Trip', 5, 'udaipur.jpg'),
('Thrilling Rishikesh Adventure', 'Rishikesh', 'White water rafting on the Ganges was an absolute thrill. The camping by the river, bungee jumping and the peaceful ashrams created a perfect blend of adventure and spirituality. Rishikesh has something for everyone.', 'Amit Kumar', 'Friends Trip', 4, 'rishikesh.jpg'),
('Mesmerizing Darjeeling Retreat', 'Darjeeling', 'Watching the sunrise over Kanchenjunga from Tiger Hill was surreal. The toy train, tea gardens and the cool mountain air made for a perfect escape from the city heat. Darjeeling is a slice of paradise.', 'Nisha Agarwal', 'Family Trip', 5, 'darjeeling.jpg'),
('Royal Golden Triangle', 'Delhi - Agra - Jaipur', 'Seeing the Taj Mahal in person brought tears to my eyes. Delhi was vibrant and chaotic in the best way, and Jaipur was a colorful dream. The Golden Triangle is the best introduction to India.', 'Rohit Gupta', 'Group Tour', 5, 'golden-triangle.jpg'),
('Incredible Munnar Hills', 'Munnar', 'The rolling tea plantations stretching as far as the eye can see were breathtaking. Eravikulam National Park and the misty mornings made this trip magical. Munnar is perfect for nature lovers seeking tranquility.', 'Ananya Joshi', 'Family Trip', 4, 'munnar.jpg');
