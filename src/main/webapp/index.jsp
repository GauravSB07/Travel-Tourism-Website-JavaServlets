
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.Map,com.traveltourism.model.HomepageDataAccess" %>
<%! private String homeEsc(String value){if(value==null)return "";return value.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("''","&#39;");} %>
<% Map<String,String> hp=HomepageDataAccess.load(); %>
<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>TravelTourism | Explore India</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css?v=homepage-2">


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

    <section class="hero" style="background-image:linear-gradient(90deg,rgba(12,36,54,.94),rgba(12,43,61,.62),rgba(13,50,56,.18)),url('${pageContext.request.contextPath}/homepage-image?slot=hero')">

        <div class="hero-content">

            <p class="hero-tagline">
                <%=homeEsc(hp.get("hero_label"))%>
            </p>

            <h1>
                <%=homeEsc(hp.get("hero_title"))%>
                <br>
                <span><%=homeEsc(hp.get("hero_accent"))%></span>
            </h1>

            <p class="hero-description"><%=homeEsc(hp.get("hero_description"))%></p>

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
                <%=homeEsc(hp.get("destination_label"))%>
            </p>

            <h2><%=homeEsc(hp.get("destination_title"))%></h2>

            <span><%=homeEsc(hp.get("destination_description"))%></span>

        </div>


        <!-- DESTINATION GRID -->

        <div class="destination-grid">


            <!-- ================= GOA ================= -->

            <article class="destination-card">

                <div class="destination-image goa-image" style="background-image:linear-gradient(180deg,rgba(12,38,52,.02),rgba(12,38,52,.34)),url('${pageContext.request.contextPath}/homepage-image?slot=goa')!important">

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

                <div class="destination-image kerala-image" style="background-image:linear-gradient(180deg,rgba(12,38,52,.02),rgba(12,38,52,.34)),url('${pageContext.request.contextPath}/homepage-image?slot=kerala')!important">

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

                <div class="destination-image rajasthan-image" style="background-image:linear-gradient(180deg,rgba(12,38,52,.02),rgba(12,38,52,.34)),url('${pageContext.request.contextPath}/homepage-image?slot=rajasthan')!important">

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

                <div class="destination-image kashmir-image" style="background-image:linear-gradient(180deg,rgba(12,38,52,.02),rgba(12,38,52,.34)),url('${pageContext.request.contextPath}/homepage-image?slot=kashmir')!important">

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

                <div class="destination-image himachal-image" style="background-image:linear-gradient(180deg,rgba(12,38,52,.02),rgba(12,38,52,.34)),url('${pageContext.request.contextPath}/homepage-image?slot=himachal')!important">

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

                <div class="destination-image maharashtra-image" style="background-image:linear-gradient(180deg,rgba(12,38,52,.02),rgba(12,38,52,.34)),url('${pageContext.request.contextPath}/homepage-image?slot=maharashtra')!important">

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
                    Occasion-ready Holidays
                </h3>

                <p>
                    Find birthday, honeymoon, anniversary and family packages designed for the moment.
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
     CUSTOMIZED HOLIDAYS BY OCCASION
     ================================================= -->

    <section class="custom-holiday-section">

        <div class="custom-holiday-container">


            <!-- ================= CONTENT ================= -->

            <div class="custom-holiday-content">

                <p class="custom-holiday-label">
                    <%=homeEsc(hp.get("holiday_label"))%>
                </p>


                <h2>
                    <%=homeEsc(hp.get("holiday_title"))%>
                </h2>


                <p class="custom-holiday-description"><%=homeEsc(hp.get("holiday_description"))%></p>


                <!-- ================= STEPS ================= -->

                <div class="custom-holiday-steps">


                    <!-- ================= STEP 1 ================= -->

                    <div class="custom-step">

                        <div class="custom-step-number">
                            01
                        </div>


                        <div class="custom-step-content">

                            <h3>
                                Choose Your Occasion
                            </h3>


                            <p>
                                Start with a birthday, honeymoon, anniversary, family celebration or group escape.
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
                                Compare Curated Packages
                            </h3>


                            <p>
                                View package details, inclusions, galleries and prices before deciding.
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
                                Book Your Favourite
                            </h3>


                            <p>
                                Select the package that fits your moment and continue through the familiar booking flow.
                            </p>

                        </div>

                    </div>

                </div>


                <!-- ================= BUTTON ================= -->

                <a href="${pageContext.request.contextPath}/customize"
                   class="custom-holiday-btn">

                    <%=homeEsc(hp.get("holiday_button"))%> →

                </a>

            </div>


            <!-- ================= VISUAL ================= -->

            <div class="custom-holiday-visual" style="background-image:linear-gradient(180deg,rgba(16,47,61,.08),rgba(13,43,54,.84)),url('${pageContext.request.contextPath}/homepage-image?slot=holiday')!important">

                <div class="custom-visual-overlay">

                    <span>
                        ✈️
                    </span>


                    <h3>
                        Celebrate Your Way.
                    </h3>


                    <p>
                        Occasion-led escapes, thoughtfully presented and ready to book.
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