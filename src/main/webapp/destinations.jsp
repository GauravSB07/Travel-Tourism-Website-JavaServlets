<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Destinations | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/destinations.css">

</head>


<body>


<%@ include file="common/header.jsp" %>


<!-- =====================================================
     PAGE INTRO
===================================================== -->

<section class="destinations-intro">

    <div class="destinations-intro-inner">

        <p class="destinations-eyebrow">
            EXPLORE INDIA
        </p>

        <h1>
            Destinations &amp; Travel Packages
        </h1>

        <p class="destinations-lead">
            Browse curated journeys across India —
            filter by city, category and duration to find
            the trip that feels made for you.
        </p>

    </div>

</section>


<!-- =====================================================
     MAIN LAYOUT
===================================================== -->

<section class="destinations-layout">

    <div class="destinations-container">


        <!-- =================================================
             FILTERS
        ================================================== -->

        <aside class="filters-panel-modern">

            <form action="${pageContext.request.contextPath}/destinations"
                  method="get">


                <h3 class="filter-title">
                    Filter Your Search
                </h3>


                <p class="filter-help">
                    Narrow the list to match your travel style.
                </p>


                <!-- PRICE -->

                <div class="filter-group">

                    <label for="price_min">
                        Price Range
                    </label>

                    <input type="number"
                           id="price_min"
                           name="price_min"
                           placeholder="Min Price"
                           value="${param.price_min}">

                    <input type="number"
                           id="price_max"
                           name="price_max"
                           placeholder="Max Price"
                           value="${param.price_max}">

                </div>


                <!-- CITY -->

                <div class="filter-group">

                    <label for="city">
                        Departure City
                    </label>

                    <select name="city"
                            id="city">

                        <option value="all">
                            All Cities
                        </option>

                        <option value="Mumbai">
                            Mumbai
                        </option>

                        <option value="Delhi">
                            Delhi
                        </option>

                        <option value="Jaipur">
                            Jaipur
                        </option>

                    </select>

                </div>


                <!-- CATEGORY -->

                <div class="filter-group">

                    <label for="category">
                        Category
                    </label>

                    <select name="category"
                            id="category">

                        <option value="all">
                            All Categories
                        </option>

                        <option value="Family">
                            Family
                        </option>

                        <option value="Adventure">
                            Adventure
                        </option>

                        <option value="Culture">
                            Culture
                        </option>

                        <option value="Nature">
                            Nature
                        </option>

                        <option value="Beach">
                            Beach
                        </option>

                        <option value="Pilgrimage">
                            Pilgrimage
                        </option>

                        <option value="Wildlife">
                            Wildlife
                        </option>

                        <option value="Luxury">
                            Luxury
                        </option>

                    </select>

                </div>


                <!-- DURATION -->

                <div class="filter-group">

                    <label for="duration">
                        Duration
                    </label>

                    <select name="duration"
                            id="duration">

                        <option value="0">
                            Any Duration
                        </option>

                        <option value="5">
                            5 Days
                        </option>

                        <option value="6">
                            6 Days
                        </option>

                        <option value="7">
                            7 Days
                        </option>

                    </select>

                </div>


                <button type="submit"
                        class="filter-btn">

                    Apply Filters

                </button>


            </form>

        </aside>


        <!-- =================================================
             RESULTS
        ================================================== -->

        <div class="results-panel-modern">


            <!-- TOOLBAR -->

            <div class="results-toolbar">

                <div>

                    <p class="eyebrow">
                        CURATED JOURNEYS
                    </p>

                    <h2>
                        ${resultCount} journeys to explore
                    </h2>

                </div>


                <a id="compare-button"
                   class="compare-button is-disabled"
                   href="#">

                    Compare selected
                    <span>0</span>

                </a>

            </div>


            <!-- =================================================
                 TOUR CARDS
            ================================================== -->

            <c:forEach var="tour"
                       items="${tours}">


                <article class="tour-card-modern">


                    <!-- =================================================
                         IMAGE
                    ================================================= -->

                    <div class="tour-image-wrapper">

                        <c:choose>

                            <c:when test="${tour.imageId > 0}">

                                <img src="${pageContext.request.contextPath}/TourImageServlet?id=${tour.imageId}"
                                     alt="${tour.name}"
                                     loading="lazy">

                            </c:when>


                            <c:otherwise>

                                <div class="tour-image-placeholder">
                                    No image available
                                </div>

                            </c:otherwise>

                        </c:choose>

                    </div>


                    <!-- =================================================
                         TOUR CONTENT
                    ================================================== -->

                    <div class="tour-content">


                        <div class="tour-content-top">

                            <h3>
                                ${tour.name}
                            </h3>

                            <p class="tour-price">
                                ₹${tour.price}
                            </p>

                        </div>


                        <div class="tour-meta-row">

                            <span>
                                ${tour.category}
                            </span>

                            <span>
                                ${tour.departureCity}
                            </span>

                            <span>
                                ${tour.duration} days
                            </span>

                        </div>


                        <c:if test="${not empty tour.shortDescription}">

                            <p class="tour-description">
                                ${tour.shortDescription}
                            </p>

                        </c:if>


                        <!-- ACTIONS -->

                        <div class="tour-actions">


                            <a class="primary-btn-small"
                               href="${pageContext.request.contextPath}/tour-details?id=${tour.id}">

                                View Details

                            </a>


                            <label class="outline-btn-small compare-label">

                                <input class="tour-check"
                                       type="checkbox"
                                       value="${tour.id}">

                                Compare

                            </label>


                            <a class="outline-btn-small"
                               href="${pageContext.request.contextPath}/contact?tour_id=${tour.id}">

                                Enquire

                            </a>


                        </div>


                    </div>


                </article>


            </c:forEach>


            <!-- =================================================
                 NO RESULTS
            ================================================== -->

            <c:if test="${empty tours}">


                <div class="no-results">

                    <p class="eyebrow">
                        NO MATCHES
                    </p>

                    <h3>
                        No journeys match those filters.
                    </h3>

                    <p>
                        Try widening your price range
                        or choosing another departure city.
                    </p>

                    <a href="${pageContext.request.contextPath}/destinations">

                        Clear filters

                    </a>

                </div>


            </c:if>


        </div>


    </div>

</section>


<%@ include file="common/footer.jsp" %>


<!-- =====================================================
     COMPARISON JAVASCRIPT
===================================================== -->

<script>

    const checks =
        document.querySelectorAll('.tour-check');

    const compareButton =
        document.getElementById('compare-button');


    function updateComparison() {

        const ids = [

            ...new Set(

                [...checks]

                    .filter(check => check.checked)

                    .map(check => check.value)

            )

        ].slice(0, 3);


        checks.forEach(check => {

            if (!ids.includes(check.value)) {

                check.checked = false;

            }

        });


        compareButton
            .querySelector('span')
            .textContent = ids.length;


        compareButton.href = ids.length

            ? '${pageContext.request.contextPath}/compare-tours?ids='
              + ids.join(',')

            : '#';


        compareButton.classList.toggle(
            'is-disabled',
            !ids.length
        );

    }


    checks.forEach(check => {

        check.addEventListener(
            'change',
            updateComparison
        );

    });

</script>


</body>

</html>
