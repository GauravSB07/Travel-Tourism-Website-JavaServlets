<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Travel Experiences | TravelTourism</title>

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

        .experience-hero {
            background: linear-gradient(
                rgba(0, 0, 0, 0.45),
                rgba(0, 0, 0, 0.45)
            ),
            url('${pageContext.request.contextPath}/images/experience-bg.jpg');

            background-size: cover;
            background-position: center;

            height: 350px;

            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;

            text-align: center;
            color: white;
        }

        .experience-hero h1 {
            font-size: 48px;
            margin: 0 0 15px;
        }

        .experience-hero p {
            font-size: 18px;
            max-width: 650px;
            line-height: 1.6;
        }


        /* INTRODUCTION */

        .experience-intro {
            text-align: center;
            padding: 50px 20px 30px;
        }

        .experience-intro h2 {
            font-size: 32px;
            margin-bottom: 12px;
        }

        .experience-intro p {
            color: #666;
            max-width: 700px;
            margin: auto;
            line-height: 1.6;
        }


        /* EXPERIENCE GRID */

        .experience-container {
            max-width: 1200px;
            margin: 20px auto 60px;

            padding: 0 20px;

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 25px;
        }


        /* EXPERIENCE CARD */

        .experience-card {
            background: white;

            border-radius: 12px;

            overflow: hidden;

            box-shadow:
                0 3px 12px rgba(0, 0, 0, 0.10);

            transition: transform 0.2s,
                        box-shadow 0.2s;
        }

        .experience-card:hover {
            transform: translateY(-5px);

            box-shadow:
                0 7px 20px rgba(0, 0, 0, 0.15);
        }


        /* USER IMAGE */

        .user-image {
            width: 100%;
            height: 220px;

            object-fit: cover;
        }


        /* CARD CONTENT */

        .experience-content {
            padding: 22px;
        }

        .experience-content h3 {
            margin: 0 0 8px;

            font-size: 21px;
        }

        .experience-location {
            color: #f28c28;

            font-weight: bold;

            font-size: 14px;

            margin-bottom: 12px;
        }

        .experience-text {
            color: #666;

            line-height: 1.6;

            font-size: 15px;
        }


        /* USER NAME */

        .user-name {
            margin-top: 18px;

            padding-top: 15px;

            border-top: 1px solid #eee;

            font-weight: bold;
        }

        .user-name span {
            color: #888;

            font-size: 13px;

            font-weight: normal;
        }


        /* RATING */

        .rating {
            margin-top: 8px;

            color: #f28c28;

            font-size: 18px;
        }


        /* WRITE EXPERIENCE */

        .share-experience {
            text-align: center;

            background: white;

            padding: 50px 20px;

            margin-top: 20px;
        }

        .share-experience h2 {
            margin-bottom: 10px;
        }

        .share-experience p {
            color: #666;

            margin-bottom: 25px;
        }

        .share-button {
            display: inline-block;

            padding: 12px 25px;

            background: #f28c28;

            color: white;

            text-decoration: none;

            border-radius: 6px;

            font-weight: bold;
        }


        /* RESPONSIVE */

        @media (max-width: 900px) {

            .experience-container {
                grid-template-columns:
                    repeat(2, 1fr);
            }

        }

        @media (max-width: 600px) {

            .experience-container {
                grid-template-columns: 1fr;
            }

            .experience-hero h1 {
                font-size: 34px;
            }

        }

    </style>

</head>


<body>


    <%@ include file="common/header.jsp" %>


    <!-- HERO -->

    <section class="experience-hero">

        <h1>Travel Experiences</h1>

        <p>
            Discover unforgettable journeys shared by
            travelers who explored the world with TravelTourism.
        </p>

    </section>


    <!-- INTRODUCTION -->

    <section class="experience-intro">

        <h2>Stories From Our Travelers</h2>

        <p>
            Every journey creates a story. Read about the
            adventures, memories and experiences shared by
            our travelers.
        </p>

    </section>


    <!-- EXPERIENCES -->

    <section class="experience-container">


        <!-- EXPERIENCE 1 -->

        <div class="experience-card">

            <img src="${pageContext.request.contextPath}/images/goa.jpg"
                 alt="Goa"
                 class="user-image">

            <div class="experience-content">

                <h3>Amazing Goa Experience</h3>

                <div class="experience-location">
                    📍 Goa
                </div>

                <p class="experience-text">
                    The trip was absolutely amazing. The beaches,
                    food and nightlife made the entire journey
                    unforgettable. Everything was well planned
                    and we had a wonderful time.
                </p>

                <div class="rating">
                    ★★★★★
                </div>

                <div class="user-name">
                    Rahul Sharma
                    <br>
                    <span>Family Trip</span>
                </div>

            </div>

        </div>


        <!-- EXPERIENCE 2 -->

        <div class="experience-card">

            <img src="${pageContext.request.contextPath}/images/kerala.jpg"
                 alt="Kerala"
                 class="user-image">

            <div class="experience-content">

                <h3>Peaceful Kerala Journey</h3>

                <div class="experience-location">
                    📍 Kerala
                </div>

                <p class="experience-text">
                    Kerala was beautiful from start to finish.
                    The backwaters and greenery were incredible.
                    It was one of the most relaxing trips
                    I have ever taken.
                </p>

                <div class="rating">
                    ★★★★★
                </div>

                <div class="user-name">
                    Priya Patel
                    <br>
                    <span>Couple Trip</span>
                </div>

            </div>

        </div>


        <!-- EXPERIENCE 3 -->

        <div class="experience-card">

            <img src="${pageContext.request.contextPath}/images/himachal.jpg"
                 alt="Himachal"
                 class="user-image">

            <div class="experience-content">

                <h3>Adventure in Himachal</h3>

                <div class="experience-location">
                    📍 Himachal Pradesh
                </div>

                <p class="experience-text">
                    If you love adventure, Himachal is the place
                    to go. The mountains, trekking and weather
                    made this an unforgettable experience.
                </p>

                <div class="rating">
                    ★★★★★
                </div>

                <div class="user-name">
                    Arjun Mehta
                    <br>
                    <span>Adventure Trip</span>
                </div>

            </div>

        </div>


    </section>


    <!-- SHARE EXPERIENCE -->

    <section class="share-experience">

        <h2>Share Your Experience</h2>

        <p>
            Have you travelled with us?
            Share your journey and inspire other travelers.
        </p>

        <a href="#"
           class="share-button">

            Share Your Story

        </a>

    </section>


    <%@ include file="common/footer.jsp" %>


</body>

</html>