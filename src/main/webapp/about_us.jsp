<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>About Us | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            color: #333;
        }

        /* HERO SECTION */

        .about-hero {
            height: 350px;

            background:
                linear-gradient(
                    rgba(0, 0, 0, 0.45),
                    rgba(0, 0, 0, 0.45)
                ),
                url('${pageContext.request.contextPath}/images/about-bg.jpg');

            background-size: cover;
            background-position: center;

            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;

            text-align: center;
            color: white;
        }

        .about-hero h1 {
            font-size: 48px;
            margin: 0 0 15px;
        }

        .about-hero p {
            font-size: 18px;
            max-width: 700px;
            line-height: 1.6;
        }


        /* ABOUT SECTION */

        .about-section {
            max-width: 1100px;
            margin: 60px auto;
            padding: 0 25px;

            display: flex;
            gap: 50px;
            align-items: center;
        }

        .about-image {
            width: 50%;
        }

        .about-image img {
            width: 100%;
            height: 350px;

            object-fit: cover;

            border-radius: 12px;

            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.12);
        }

        .about-content {
            width: 50%;
        }

        .about-content h2 {
            font-size: 32px;
            margin-bottom: 15px;
        }

        .about-content p {
            color: #666;
            line-height: 1.7;
            font-size: 16px;
        }


        /* MISSION / VISION */

        .mission-section {
            background: white;
            padding: 60px 25px;
        }

        .mission-container {
            max-width: 1100px;
            margin: auto;

            display: grid;
            grid-template-columns: repeat(2, 1fr);

            gap: 30px;
        }

        .mission-card {
            padding: 30px;

            border-radius: 12px;

            background: #f7f7f7;

            box-shadow:
                0 3px 12px rgba(0, 0, 0, 0.08);
        }

        .mission-card h2 {
            margin-top: 0;
            color: #f28c28;
        }

        .mission-card p {
            color: #666;
            line-height: 1.7;
        }


        /* WHY CHOOSE US */

        .why-section {
            max-width: 1100px;
            margin: 60px auto;

            padding: 0 25px;

            text-align: center;
        }

        .why-section h2 {
            font-size: 32px;
            margin-bottom: 35px;
        }

        .why-container {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 25px;
        }

        .why-card {
            background: white;

            padding: 30px 20px;

            border-radius: 12px;

            box-shadow:
                0 3px 12px rgba(0, 0, 0, 0.08);
        }

        .why-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }

        .why-card h3 {
            margin-bottom: 10px;
        }

        .why-card p {
            color: #666;
            line-height: 1.6;
        }


        /* CALL TO ACTION */

        .about-cta {
            background: #102d47;

            color: white;

            text-align: center;

            padding: 55px 20px;
        }

        .about-cta h2 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .about-cta p {
            color: #d6e0e8;
            margin-bottom: 25px;
        }

        .cta-button {
            display: inline-block;

            padding: 12px 25px;

            background: #f28c28;

            color: white;

            text-decoration: none;

            border-radius: 6px;

            font-weight: bold;
        }

        .cta-button:hover {
            background: #e07815;
        }


        /* RESPONSIVE */

        @media (max-width: 800px) {

            .about-section {
                flex-direction: column;
            }

            .about-image,
            .about-content {
                width: 100%;
            }

            .mission-container {
                grid-template-columns: 1fr;
            }

            .why-container {
                grid-template-columns: 1fr;
            }

            .about-hero h1 {
                font-size: 36px;
            }

        }

    </style>

</head>


<body>


    <%@ include file="common/header.jsp" %>


    <!-- HERO SECTION -->

    <section class="about-hero">

        <h1>About TravelTourism</h1>

        <p>
            Discover India your way. Explore beautiful destinations,
            experience diverse cultures and create memories that last
            a lifetime.
        </p>

    </section>


    <!-- ABOUT US -->

    <section class="about-section">

        <div class="about-image">

            <img src="${pageContext.request.contextPath}/images/about-us.jpg"
                 alt="TravelTourism">

        </div>


        <div class="about-content">

            <h2>Who We Are</h2>

            <p>
                TravelTourism is a travel platform created to make
                exploring India simple, enjoyable and memorable.
                We bring together beautiful destinations, exciting
                experiences and carefully planned holiday packages
                in one place.
            </p>

            <p>
                Whether you are looking for a relaxing beach holiday,
                an adventurous mountain trip, a cultural experience
                or a customized vacation, TravelTourism helps you
                find a journey that suits you.
            </p>

            <p>
                Our goal is to help travelers discover new places,
                experience different cultures and create memories
                that stay with them long after their journey ends.
            </p>

        </div>

    </section>


    <!-- MISSION AND VISION -->

    <section class="mission-section">

        <div class="mission-container">


            <div class="mission-card">

                <h2>Our Mission</h2>

                <p>
                    Our mission is to make travel planning simple,
                    accessible and enjoyable. We aim to provide
                    travelers with reliable information, diverse
                    holiday options and memorable travel experiences.
                </p>

            </div>


            <div class="mission-card">

                <h2>Our Vision</h2>

                <p>
                    Our vision is to become a trusted travel platform
                    that inspires people to explore India, discover
                    its beauty and experience the diversity of its
                    destinations and cultures.
                </p>

            </div>


        </div>

    </section>


    <!-- WHY CHOOSE US -->

    <section class="why-section">

        <h2>Why Choose TravelTourism?</h2>


        <div class="why-container">


            <div class="why-card">

                <div class="why-icon">
                    🌍
                </div>

                <h3>Explore More</h3>

                <p>
                    Discover popular destinations as well as
                    unique places across India.
                </p>

            </div>


            <div class="why-card">

                <div class="why-icon">
                    ✈️
                </div>

                <h3>Easy Travel Planning</h3>

                <p>
                    Find tours, experiences and holiday packages
                    designed to make planning easier.
                </p>

            </div>


            <div class="why-card">

                <div class="why-icon">
                    ❤️
                </div>

                <h3>Memorable Experiences</h3>

                <p>
                    Create meaningful memories through journeys
                    designed around your interests.
                </p>

            </div>


        </div>

    </section>


    <!-- CALL TO ACTION -->

    <section class="about-cta">

        <h2>Ready to Start Your Journey?</h2>

        <p>
            Explore destinations and discover your next
            unforgettable adventure.
        </p>

        <a href="${pageContext.request.contextPath}/destinations"
           class="cta-button">

            Explore Destinations

        </a>

    </section>


    <%@ include file="common/footer.jsp" %>


</body>

</html>