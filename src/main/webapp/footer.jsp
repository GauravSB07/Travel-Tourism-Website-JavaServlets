<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- FOOTER -->
<div class="footer-container">

    <!-- TOP SECTION -->
    <div class="footer-top">
        <button class="explore-btn">Explore Travel Tourism</button>

        <div class="footer-links">
            <a href="DestinationsServlet">Destinations</a>
            <a href="CustomizedHolidaysServlet">Customized Holidays</a>
            <a href="ExperienceServlet">Travel Experiences</a>
            <a href="Contact_usServlet">Contact Us</a>
        </div>

        <p class="footer-highlight">
            Building memorable journeys for travellers across India.
        </p>
    </div>

    <!-- MAIN COLUMNS -->
    <div class="footer-columns">

        <!-- DISCOVER US -->
        <div class="footer-col">
            <h3>Discover Us</h3>
            <ul>
                <li><a href="About_usServlet">About Us</a></li>
                <li><a href="TeamServlet">Our Team</a></li>
                <li><a href="Contact_usServlet">Contact</a></li>
                <li><a href="CareersServlet">Careers</a></li>
            </ul>
        </div>

        <!-- SUPPORT -->
        <div class="footer-col">
            <h3>Support</h3>
            <ul>
                <li><a href="FAQServlet">FAQ</a></li>
                <li><a href="HowToBookServlet">How to Book</a></li>
                <li><a href="FeedbackServlet">Leave Feedback</a></li>
                <li><a href="DealsServlet">Travel Deals</a></li>
            </ul>
        </div>

        <!-- RESOURCES -->
        <div class="footer-col">
            <h3>Resources</h3>
            <ul>
                <li><a href="BlogServlet">Blog</a></li>
                <li><a href="ArticlesServlet">Articles</a></li>
                <li><a href="GalleryServlet">Gallery</a></li>
                <li><a href="TravelTipsServlet">Travel Tips</a></li>
            </ul>
        </div>

        <!-- SUBSCRIBE -->
        <div class="footer-col subscribe-col">
            <h3>Get Travel Inspiration</h3>

            <div class="subscribe-form">
                <input type="text" placeholder="Full Name">
                <input type="email" placeholder="Email ID">
                <input type="text" placeholder="Mobile No.">
                <button class="subscribe-btn">Subscribe</button>
            </div>
        </div>

    </div>

    <!-- WARNING -->
    <p class="footer-warning">
        Beware of fake travel offers. Contact only through our official website.
    </p>

</div>

<!-- FOOTER CSS -->
<style>
    .footer-container {
        background: #111;
        color: #fff;
        padding: 50px 40px;
        margin-top: 40px;
        font-family: Arial, sans-serif;
    }

    /* TOP SECTION */
    .footer-top {
        text-align: center;
        margin-bottom: 40px;
    }

    .explore-btn {
        background: #fbc02d;
        border: none;
        padding: 12px 24px;
        font-weight: bold;
        border-radius: 6px;
        cursor: pointer;
        margin-bottom: 20px;
    }

    .footer-links a {
        margin: 0 18px;
        color: #fbc02d;
        text-decoration: none;
        font-size: 15px;
        font-weight: 500;
    }

    .footer-highlight {
        margin-top: 15px;
        font-size: 16px;
        color: #ddd;
    }

    /* COLUMNS */
    .footer-columns {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 40px;
        margin-bottom: 40px;
    }

    .footer-col {
        width: 22%;
        min-width: 200px;
    }

    .footer-col h3 {
        margin-bottom: 15px;
        color: #fbc02d;
        font-size: 18px;
    }

    .footer-col ul {
        list-style: none;
        padding: 0;
    }

    .footer-col ul li {
        margin-bottom: 10px;
    }

    .footer-col a {
        color: #ccc;
        text-decoration: none;
        font-size: 14px;
    }

    .footer-col a:hover {
        color: #fff;
    }

    /* SUBSCRIBE FORM */
    .subscribe-form input {
        width: 100%;
        margin-bottom: 12px;
        padding: 10px;
        border-radius: 6px;
        border: none;
        font-size: 14px;
    }

    .subscribe-btn {
        background: #fbc02d;
        border: none;
        padding: 12px;
        width: 100%;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
        font-size: 15px;
    }

    /* WARNING */
    .footer-warning {
        text-align: center;
        font-size: 13px;
        color: #bbb;
        margin-top: 20px;
    }
</style>
