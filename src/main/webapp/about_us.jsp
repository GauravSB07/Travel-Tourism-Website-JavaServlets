<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>About Us - TravelTourism</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, Helvetica, sans-serif;
    background: #f8f9fa;
    color: #173b4d;
    line-height: 1.6;
}

a {
    text-decoration: none;
    color: inherit;
}


/* NAVBAR */

.navbar {
    height: 70px;
    background: white;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 4%;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
}

.logo {
    font-size: 27px;
    font-weight: bold;
    color: #123b51;
}

.logo span {
    color: #ed8b32;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 28px;
}

.nav-links a {
    font-size: 15px;
    font-weight: 500;
    color: #263b46;
}

.nav-links a:hover {
    color: #ed8b32;
}

.search-box {
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 8px;
    height: 42px;
    width: 210px;
    padding: 0 12px;
}

.search-box input {
    border: none;
    outline: none;
    width: 170px;
}

.book-btn {
    background: #ed8b32;
    color: white;
    padding: 12px 22px;
    border-radius: 7px;
    font-weight: bold;
}


/* HERO */

.hero {
    height: 430px;
    background: linear-gradient(
        110deg,
        #123e54,
        #285e70,
        #64959a
    );

    display: flex;
    align-items: center;
    padding: 60px 7%;
    color: white;
}

.hero-content {
    max-width: 700px;
}

.small-title {
    color: #f0a05a;
    font-size: 13px;
    font-weight: bold;
    letter-spacing: 4px;
    margin-bottom: 18px;
}

.hero h1 {
    font-size: 58px;
    line-height: 1.1;
    margin-bottom: 25px;
}

.orange-line {
    width: 65px;
    height: 4px;
    background: #ed8b32;
    margin: 20px 0;
}

.hero p {
    font-size: 18px;
    color: #e8eeee;
}


/* ABOUT */

.about-section {
    padding: 80px 7%;
    background: white;
}

.about-container {
    max-width: 1200px;
    margin: auto;

    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 70px;
    align-items: center;
}

.about-image {
    height: 430px;
    border-radius: 14px;
    overflow: hidden;
}

.about-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.about-text h2 {
    font-family: Georgia, serif;
    font-size: 43px;
    line-height: 1.2;
    color: #123e52;
    margin-bottom: 25px;
}

.about-text p {
    color: #66757b;
    font-size: 16px;
    margin-bottom: 18px;
}

.read-more {
    display: inline-block;
    margin-top: 15px;
    background: #173f4c;
    color: white;
    padding: 13px 25px;
    border-radius: 5px;
    font-weight: bold;
}


/* STATS */

.stats {
    background: #f3f5f3;
    padding: 55px 7%;
}

.stats-container {
    max-width: 1100px;
    margin: auto;

    display: grid;
    grid-template-columns: repeat(4, 1fr);
    text-align: center;
}

.stat-box {
    padding: 25px;
}

.stat-box h3 {
    font-size: 38px;
    color: #ed8b32;
}

.stat-box p {
    color: #66757b;
}


/* STORY */

.story {
    padding: 80px 7%;
    background: white;
}

.section-heading {
    text-align: center;
    max-width: 700px;
    margin: auto auto 50px;
}

.section-heading h2 {
    font-family: Georgia, serif;
    font-size: 43px;
    color: #143e50;
}

.section-heading p {
    color: #707d81;
}


/* CARDS */

.cards {
    max-width: 1150px;
    margin: auto;

    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

.card {
    background: white;
    border: 1px solid #e5e8e8;
    padding: 35px 30px;
    border-radius: 10px;
}

.card-icon {
    width: 55px;
    height: 55px;
    border-radius: 50%;
    background: #f8e7d5;
    color: #e9822b;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 25px;
    margin-bottom: 20px;
}

.card h3 {
    color: #173e51;
    font-size: 22px;
    margin-bottom: 12px;
}

.card p {
    color: #707d81;
}


/* WHY US */

.why-section {
    padding: 80px 7%;
    background: #f4f6f5;
}

.why-container {
    max-width: 1150px;
    margin: auto;

    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 60px;
}

.why-text h2 {
    font-family: Georgia, serif;
    font-size: 42px;
    color: #143e50;
}

.why-text p {
    color: #68777c;
    margin-top: 20px;
}

.feature {
    display: flex;
    gap: 18px;
    margin-bottom: 25px;
}

.feature-number {
    min-width: 42px;
    height: 42px;

    background: #173f4c;
    color: white;

    border-radius: 50%;

    display: flex;
    align-items: center;
    justify-content: center;

    font-weight: bold;
}

.feature h3 {
    color: #173e51;
}

.feature p {
    color: #707d81;
}


/* MISSION */

.mission {
    padding: 80px 7%;
    background: #173f4c;
    color: white;
    text-align: center;
}

.mission-container {
    max-width: 800px;
    margin: auto;
}

.mission h2 {
    font-family: Georgia, serif;
    font-size: 45px;
    margin-bottom: 20px;
}

.mission p {
    color: #d7e1e3;
    font-size: 17px;
}


/* CTA */

.cta {
    padding: 70px 7%;
    background: white;
    text-align: center;
}

.cta h2 {
    font-family: Georgia, serif;
    color: #143e50;
    font-size: 40px;
}

.cta p {
    color: #707d81;
    margin: 15px 0 25px;
}

.cta-btn {
    display: inline-block;
    background: #ed8b32;
    color: white;
    padding: 14px 30px;
    border-radius: 6px;
    font-weight: bold;
}


/* FOOTER */

footer {
    background: #102f3e;
    color: white;
    padding: 50px 7% 25px;
}

.footer-container {
    max-width: 1150px;
    margin: auto;

    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    gap: 50px;
}

.footer-logo {
    font-size: 27px;
    font-weight: bold;
}

.footer-logo span {
    color: #ed8b32;
}

.footer p {
    color: #bdcbd0;
    font-size: 14px;
}

.footer h3 {
    margin-bottom: 15px;
}

.footer a {
    display: block;
    color: #bdcbd0;
    margin-bottom: 8px;
}


/* MOBILE */

@media(max-width:900px) {

    .nav-links {
        display: none;
    }

    .hero h1 {
        font-size: 42px;
    }

    .about-container,
    .why-container {
        grid-template-columns: 1fr;
    }

    .cards {
        grid-template-columns: 1fr;
    }

    .stats-container {
        grid-template-columns: repeat(2,1fr);
    }

    .footer-container {
        grid-template-columns: 1fr;
    }
}

</style>

</head>


<body>


<!-- NAVIGATION -->

<header class="navbar">

    <div class="logo">
        Travel<span>Tourism</span>
    </div>

    <nav class="nav-links">

        <a href="newjava.html">Home</a>
        <a href="newjava.html">Destinations</a>
        <a href="newjava.html">Experiences</a>
        <a href="newjava.html">Customized Holidays</a>
        <a href="newjava.html">About Us</a>
        <a href="newjava.html">Contact Us</a>

    </nav>

    <div class="search-box">

        <input type="text"
               placeholder="Search destinations...">

        <span>🔍</span>

    </div>

    <a href="newjava.html" class="book-btn">
        Book Now
    </a>

</header>



<!-- HERO -->

<section class="hero">

    <div class="hero-content">

        <div class="small-title">
            WHO WE ARE
        </div>

        <h1>
            Travel with purpose.<br>
            Discover with us.
        </h1>

        <div class="orange-line"></div>

        <p>
            We create meaningful journeys across India,
            connecting travellers with beautiful places,
            unforgettable experiences and local culture.
        </p>

    </div>

</section>



<!-- ABOUT SECTION -->

<section class="about-section">

    <div class="about-container">


        <!-- YOUR PHOTO -->

        <div class="about-image">

            <img src="goa.jpg"
                 alt="Goa Beach">

        </div>


        <div class="about-text">

            <div class="small-title">
                ABOUT TRAVELTOURISM
            </div>

            <h2>
                Journeys made for
                curious travellers.
            </h2>

            <p>
                TravelTourism is a travel and tourism company
                created for people who want to explore India
                in a comfortable, memorable and meaningful way.
            </p>

            <p>
                From peaceful beaches and beautiful hill stations
                to historic cities and cultural destinations,
                we help travellers discover experiences that
                stay with them long after the journey ends.
            </p>

            <p>
                Our goal is simple — make travel easier,
                enjoyable and accessible while helping you
                discover the beauty of India.
            </p>

            <a href="newjava.html" class="read-more">
                Explore Destinations →
            </a>

        </div>

    </div>

</section>



<!-- STATISTICS -->

<section class="stats">

    <div class="stats-container">

        <div class="stat-box">
            <h3>40+</h3>
            <p>Curated Journeys</p>
        </div>

        <div class="stat-box">
            <h3>25+</h3>
            <p>Destinations</p>
        </div>

        <div class="stat-box">
            <h3>10+</h3>
            <p>Travel Experiences</p>
        </div>

        <div class="stat-box">
            <h3>100%</h3>
            <p>Passion for Travel</p>
        </div>

    </div>

</section>



<!-- OUR STORY -->

<section class="story">

    <div class="section-heading">

        <div class="small-title">
            OUR STORY
        </div>

        <h2>
            More than just a holiday.
        </h2>

        <p>
            We believe that travelling is about more than
            visiting a destination. It is about discovering
            new perspectives, meeting people and creating
            memories.
        </p>

    </div>


    <div class="cards">


        <div class="card">

            <div class="card-icon">
                ✈
            </div>

            <h3>
                Meaningful Journeys
            </h3>

            <p>
                Every journey is carefully designed to give
                travellers a comfortable and memorable
                experience.
            </p>

        </div>


        <div class="card">

            <div class="card-icon">
                ★
            </div>

            <h3>
                Authentic Experiences
            </h3>

            <p>
                Discover local culture, food, traditions,
                landscapes and experiences that make every
                destination unique.
            </p>

        </div>


        <div class="card">

            <div class="card-icon">
                ♥
            </div>

            <h3>
                Traveller First
            </h3>

            <p>
                Your comfort and preferences are at the heart
                of every journey we create.
            </p>

        </div>

    </div>

</section>



<!-- WHY CHOOSE US -->

<section class="why-section">

    <div class="why-container">


        <div class="why-text">

            <div class="small-title">
                WHY TRAVEL WITH US
            </div>

            <h2>
                Designed around
                your journey.
            </h2>

            <p>
                From choosing a destination to planning
                your itinerary, we make the travel process
                simple and enjoyable.
            </p>

        </div>


        <div>


            <div class="feature">

                <div class="feature-number">
                    01
                </div>

                <div>
                    <h3>Carefully Curated Trips</h3>

                    <p>
                        Explore thoughtfully planned travel
                        packages for different travel styles.
                    </p>
                </div>

            </div>


            <div class="feature">

                <div class="feature-number">
                    02
                </div>

                <div>
                    <h3>Flexible Travel Options</h3>

                    <p>
                        Choose destinations, durations and
                        experiences according to your needs.
                    </p>
                </div>

            </div>


            <div class="feature">

                <div class="feature-number">
                    03
                </div>

                <div>
                    <h3>Simple Booking</h3>

                    <p>
                        Browse your favourite journey and
                        enquire or book it easily.
                    </p>
                </div>

            </div>


            <div class="feature">

                <div class="feature-number">
                    04
                </div>

                <div>
                    <h3>Memorable Experiences</h3>

                    <p>
                        We focus on creating experiences that
                        travellers remember.
                    </p>
                </div>

            </div>


        </div>

    </div>

</section>



<!-- MISSION -->

<section class="mission">

    <div class="mission-container">

        <div class="small-title">
            OUR MISSION
        </div>

        <h2>
            Make every journey
            worth remembering.
        </h2>

        <p>
            Our mission is to make travel across India
            easier, more personal and more enjoyable.
            We want every traveller to return home with
            stories worth sharing.
        </p>

    </div>

</section>



<!-- CTA -->

<section class="cta">

    <h2>
        Ready to discover India?
    </h2>

    <p>
        Find your next journey and start exploring.
    </p>

    <a href="newjava.html" class="cta-btn">
        Explore Journeys →
    </a>

</section>



<!-- FOOTER -->

<footer>

    <div class="footer-container">


        <div>

            <div class="footer-logo">
                Travel<span>Tourism</span>
            </div>

            <p>
                Discover beautiful destinations,
                meaningful experiences and unforgettable
                journeys across India.
            </p>

        </div>


        <div>

            <h3>
                Quick Links
            </h3>

            <a href="newjava.html">Home</a>
            <a href="newjava.html">Destinations</a>
            <a href="newjava.html">Experiences</a>
            <a href="newjava.html">About Us</a>

        </div>


        <div>

            <h3>
                Contact
            </h3>

            <p>
                Mumbai, Maharashtra, India
            </p>

            <p>
                Email: info@traveltourism.com
            </p>

            <p>
                Phone: +91 98765 43210
            </p>

        </div>

    </div>


    <div class="copyright">

        © 2026 TravelTourism. All Rights Reserved.

    </div>

</footer>


</body>
</html>