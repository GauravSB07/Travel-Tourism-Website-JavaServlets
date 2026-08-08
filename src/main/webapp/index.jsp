<%--
    Document   : index
    Created on : Aug 8, 2026, 1:07:44 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>TravelTourism | Explore India</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">


<!-- =====================================================
     COMMON HEADER
     ===================================================== -->

<%@ include file="common/header.jsp" %>


<!-- =====================================================
     MAIN CONTENT
     ===================================================== -->

<main>


    <!-- =================================================
         HERO SECTION
         ================================================= -->

    <section class="hero">

        <div class="hero-content">

            <p class="hero-tagline">
                DISCOVER • EXPERIENCE • REMEMBER
            </p>

            <h1>
                Your Journey.
                <br>
                <span>Your Way.</span>
            </h1>

            <p class="hero-description">
                Explore India's most beautiful destinations,
                discover unforgettable experiences and create
                a holiday designed around you.
            </p>

            <div class="hero-actions">

                <a href="${pageContext.request.contextPath}/destinations"
                   class="primary-btn">
                    Explore Destinations
                </a>

                <a href="${pageContext.request.contextPath}/customize"
                   class="outline-btn">
                    Customize My Holiday
                </a>

            </div>

        </div>

    </section>


    <!-- =================================================
         SEARCH SECTION
         ================================================= -->

    <section class="home-search-section">

        <div class="home-search-container">

            <p class="home-search-label">
                PLAN YOUR JOURNEY
            </p>

            <h2>
                Where do you want to go?
            </h2>

            <p class="home-search-description">
                Search for destinations, experiences and places
                to make your perfect Indian holiday.
            </p>

            <form class="home-search-form"
                  action="${pageContext.request.contextPath}/search"
                  method="get">

                <div class="home-search-input">

                    <span>
                        🔍
                    </span>

                    <input type="text"
                           name="query"
                           placeholder="Search destinations, experiences, places..."
                           required>

                </div>

                <button type="submit"
                        class="home-search-button">
                    Search
                </button>

            </form>

        </div>

    </section>


    <!-- =================================================
         POPULAR DESTINATIONS
         ================================================= -->

    <section class="destinations-section">

        <!-- SECTION HEADING -->

        <div class="section-heading">

            <p>
                EXPLORE INDIA
            </p>

            <h2>
                Popular Destinations
            </h2>

            <span>
                From beaches and mountains to heritage cities,
                discover places worth remembering.
            </span>

        </div>


        <!-- DESTINATION GRID -->

        <div class="destination-grid">


            <!-- ================= GOA ================= -->

            <article class="destination-card">

                <div class="destination-image goa-image">

                    <span class="destination-tag">
                        BEACH
                    </span>

                </div>

                <div class="destination-content">

                    <h3>
                        Goa
                    </h3>

                    <p>
                        Relax on beautiful beaches, enjoy vibrant
                        nightlife and experience Goa's unique culture.
                    </p>

                    <a href="${pageContext.request.contextPath}/destinations?place=goa">
                        Explore Goa →
                    </a>

                </div>

            </article>


            <!-- ================= KERALA ================= -->

            <article class="destination-card">

                <div class="destination-image kerala-image">

                    <span class="destination-tag">
                        NATURE
                    </span>

                </div>

                <div class="destination-content">

                    <h3>
                        Kerala
                    </h3>

                    <p>
                        Discover peaceful backwaters, lush landscapes
                        and the natural beauty of God's Own Country.
                    </p>

                    <a href="${pageContext.request.contextPath}/destinations?place=kerala">
                        Explore Kerala →
                    </a>

                </div>

            </article>


            <!-- ================= RAJASTHAN ================= -->

            <article class="destination-card">

                <div class="destination-image rajasthan-image">

                    <span class="destination-tag">
                        HERITAGE
                    </span>

                </div>

                <div class="destination-content">

                    <h3>
                        Rajasthan
                    </h3>

                    <p>
                        Experience magnificent forts, royal palaces,
                        colourful markets and timeless traditions.
                    </p>

                    <a href="${pageContext.request.contextPath}/destinations?place=rajasthan">
                        Explore Rajasthan →
                    </a>

                </div>

            </article>


            <!-- ================= KASHMIR ================= -->

            <article class="destination-card">

                <div class="destination-image kashmir-image">

                    <span class="destination-tag">
                        MOUNTAINS
                    </span>

                </div>

                <div class="destination-content">

                    <h3>
                        Kashmir
                    </h3>

                    <p>
                        Explore breathtaking valleys, peaceful lakes
                        and stunning Himalayan landscapes.
                    </p>

                    <a href="${pageContext.request.contextPath}/destinations?place=kashmir">
                        Explore Kashmir →
                    </a>

                </div>

            </article>


            <!-- ================= HIMACHAL ================= -->

            <article class="destination-card">

                <div class="destination-image himachal-image">

                    <span class="destination-tag">
                        ADVENTURE
                    </span>

                </div>

                <div class="destination-content">

                    <h3>
                        Himachal Pradesh
                    </h3>

                    <p>
                        Escape to mountain towns, scenic valleys
                        and unforgettable outdoor adventures.
                    </p>

                    <a href="${pageContext.request.contextPath}/destinations?place=himachal">
                        Explore Himachal →
                    </a>

                </div>

            </article>


            <!-- ================= MAHARASHTRA ================= -->

            <article class="destination-card">

                <div class="destination-image maharashtra-image">

                    <span class="destination-tag">
                        CULTURE
                    </span>

                </div>

                <div class="destination-content">

                    <h3>
                        Maharashtra
                    </h3>

                    <p>
                        Discover historic forts, bustling cities,
                        beautiful beaches and rich cultural heritage.
                    </p>

                    <a href="${pageContext.request.contextPath}/destinations?place=maharashtra">
                        Explore Maharashtra →
                    </a>

                </div>

            </article>

        </div>


        <!-- VIEW ALL DESTINATIONS -->

        <div class="section-button">

            <a href="${pageContext.request.contextPath}/destinations"
               class="view-all-btn">
                View All Destinations →
            </a>

        </div>

    </section>


    <!-- =================================================
         UNFORGETTABLE EXPERIENCES
         ================================================= -->

    <section class="experiences-section">

        <!-- SECTION HEADING -->

        <div class="section-heading">

            <p>
                EXPERIENCE INDIA
            </p>

            <h2>
                Unforgettable Experiences
            </h2>

            <span>
                Discover the many ways to experience India's
                culture, nature, adventure and flavours.
            </span>

        </div>


        <!-- EXPERIENCE GRID -->

        <div class="experience-grid">


            <!-- ================= ADVENTURE ================= -->

            <article class="experience-card">

                <div class="experience-icon">
                    🏔️
                </div>

                <div class="experience-content">

                    <h3>
                        Adventure
                    </h3>

                    <p>
                        Trek through mountains, explore hidden trails
                        and experience thrilling adventures across India.
                    </p>

                    <a href="${pageContext.request.contextPath}/experiences?type=adventure">
                        Discover Adventure →
                    </a>

                </div>

            </article>


            <!-- ================= CULTURE ================= -->

            <article class="experience-card">

                <div class="experience-icon">
                    🏛️
                </div>

                <div class="experience-content">

                    <h3>
                        Culture &amp; Heritage
                    </h3>

                    <p>
                        Explore ancient monuments, royal palaces,
                        traditional festivals and India's rich heritage.
                    </p>

                    <a href="${pageContext.request.contextPath}/experiences?type=culture">
                        Explore Culture →
                    </a>

                </div>

            </article>


            <!-- ================= NATURE ================= -->

            <article class="experience-card">

                <div class="experience-icon">
                    🌿
                </div>

                <div class="experience-content">

                    <h3>
                        Nature &amp; Wildlife
                    </h3>

                    <p>
                        Discover peaceful forests, beautiful landscapes,
                        wildlife sanctuaries and breathtaking scenery.
                    </p>

                    <a href="${pageContext.request.contextPath}/experiences?type=nature">
                        Explore Nature →
                    </a>

                </div>

            </article>


            <!-- ================= FOOD ================= -->

            <article class="experience-card">

                <div class="experience-icon">
                    🍛
                </div>

                <div class="experience-content">

                    <h3>
                        Food &amp; Flavours
                    </h3>

                    <p>
                        Taste India's diverse cuisine and discover
                        authentic flavours from different regions.
                    </p>

                    <a href="${pageContext.request.contextPath}/experiences?type=food">
                        Discover Flavours →
                    </a>

                </div>

            </article>

        </div>


        <!-- VIEW ALL EXPERIENCES -->

        <div class="section-button">

            <a href="${pageContext.request.contextPath}/experiences"
               class="view-all-btn">
                View All Experiences →
            </a>

        </div>

    </section>


    <!-- =================================================
         WHY CHOOSE TRAVELTOURISM
         ================================================= -->

    <section class="why-section">

        <!-- SECTION HEADING -->

        <div class="section-heading">

            <p>
                WHY TRAVEL WITH US
            </p>

            <h2>
                Travel Made Simple
            </h2>

            <span>
                We help you discover India your way,
                with experiences designed around you.
            </span>

        </div>


        <!-- WHY GRID -->

        <div class="why-grid">


            <!-- ================= LOCAL EXPERTISE ================= -->

            <div class="why-card">

                <div class="why-icon">
                    🧭
                </div>

                <h3>
                    Local Expertise
                </h3>

                <p>
                    Discover destinations through carefully
                    selected places, experiences and travel ideas.
                </p>

            </div>


            <!-- ================= PERSONALIZED ================= -->

            <div class="why-card">

                <div class="why-icon">
                    ✨
                </div>

                <h3>
                    Personalized Holidays
                </h3>

                <p>
                    Create a holiday that matches your interests,
                    travel style and preferred experiences.
                </p>

            </div>


            <!-- ================= TRUSTED ================= -->

            <div class="why-card">

                <div class="why-icon">
                    🛡️
                </div>

                <h3>
                    Trusted &amp; Reliable
                </h3>

                <p>
                    Plan your journey with clear information,
                    dependable services and a simple booking process.
                </p>

            </div>


            <!-- ================= SUPPORT ================= -->

            <div class="why-card">

                <div class="why-icon">
                    💬
                </div>

                <h3>
                    Dedicated Support
                </h3>

                <p>
                    Get helpful assistance throughout your
                    travel planning and booking experience.
                </p>

            </div>

        </div>

    </section>
    <!-- =================================================
     CREATE YOUR OWN HOLIDAY
     ================================================= -->

    <section class="custom-holiday-section">

        <div class="custom-holiday-container">


            <!-- ================= CONTENT ================= -->

            <div class="custom-holiday-content">

                <p class="custom-holiday-label">
                    YOUR TRIP. YOUR WAY.
                </p>


                <h2>
                    Create Your Own Holiday
                </h2>


                <p class="custom-holiday-description">
                    Don't want a standard package?
                    Build a holiday that is completely yours.
                    Choose your destination, experiences and travel
                    preferences and create a journey designed around you.
                </p>


                <!-- ================= STEPS ================= -->

                <div class="custom-holiday-steps">


                    <!-- ================= STEP 1 ================= -->

                    <div class="custom-step">

                        <div class="custom-step-number">
                            01
                        </div>


                        <div class="custom-step-content">

                            <h3>
                                Choose Your Destination
                            </h3>


                            <p>
                                Pick the places you want to explore
                                across India.
                            </p>

                        </div>

                    </div>


                    <!-- ================= STEP 2 ================= -->

                    <div class="custom-step">

                        <div class="custom-step-number">
                            02
                        </div>


                        <div class="custom-step-content">

                            <h3>
                                Select Your Experiences
                            </h3>


                            <p>
                                Choose from adventure, culture,
                                nature, food and more.
                            </p>

                        </div>

                    </div>


                    <!-- ================= STEP 3 ================= -->

                    <div class="custom-step">

                        <div class="custom-step-number">
                            03
                        </div>


                        <div class="custom-step-content">

                            <h3>
                                Build Your Perfect Holiday
                            </h3>


                            <p>
                                Create a personalized itinerary
                                that matches your travel style.
                            </p>

                        </div>

                    </div>

                </div>


                <!-- ================= BUTTON ================= -->

                <a href="${pageContext.request.contextPath}/customize"
                   class="custom-holiday-btn">

                    Start Customizing →

                </a>

            </div>


            <!-- ================= VISUAL ================= -->

            <div class="custom-holiday-visual">

                <div class="custom-visual-overlay">

                    <span>
                        ✈️
                    </span>


                    <h3>
                        Your Journey,
                        Your Rules.
                    </h3>


                    <p>
                        Make every moment of your holiday
                        truly yours.
                    </p>

                </div>

            </div>

        </div>

    </section>


</main>


<!-- =====================================================
     COMMON FOOTER
     ===================================================== -->

<%@ include file="common/footer.jsp" %>