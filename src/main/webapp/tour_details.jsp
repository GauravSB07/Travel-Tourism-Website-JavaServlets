<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>${tour.name} | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tour_details.css">

</head>


<body>

<%@ include file="common/header.jsp" %>


<!-- =====================================================
     TOP BAR
     ===================================================== -->

<section class="tourdetails-topbar">

    <div class="tourdetails-topbar-inner">

        <div class="tourdetails-breadcrumb">

            <a href="${pageContext.request.contextPath}/home">
                Home
            </a>

            <span>›</span>

            <a href="${pageContext.request.contextPath}/destinations">
                Destinations
            </a>

            <span>›</span>

            <b>${tour.name}</b>

        </div>


        <p>CURATED INDIA JOURNEYS</p>

        <h2>Every detail, beautifully considered.</h2>

    </div>

</section>



<main class="page-container">


<!-- =====================================================
     HERO SECTION
     ===================================================== -->

<div class="hero-banner">

    <c:choose>

        <c:when test="${tour.imageId > 0}">

            <img
                src="${pageContext.request.contextPath}/TourImageServlet?id=${tour.imageId}"
                alt="${tour.name}">

        </c:when>

        <c:otherwise>

            <div class="hero-image-placeholder">
                No image available
            </div>

        </c:otherwise>

    </c:choose>


    <div class="hero-overlay">

        <h1>${tour.name}</h1>

        <p>${tour.shortDescription}</p>


        <div class="meta-bar">

            <span>
                <strong>Duration:</strong>
                ${tour.duration} Days
            </span>


            <span>
                <strong>Category:</strong>
                ${tour.category}
            </span>


            <span>
                <strong>Departure:</strong>
                ${tour.departureCity}
            </span>


            <span>
                <strong>Best Time:</strong>

                <c:choose>

                    <c:when test="${details != null}">
                        ${details.bestTime}
                    </c:when>

                    <c:otherwise>
                        Not specified
                    </c:otherwise>

                </c:choose>

            </span>

        </div>


        <a href="#itinerary-section"
           class="view-itinerary-btn">

            View Day-wise Itinerary

        </a>

    </div>

</div>



<!-- =====================================================
     QUICK INFORMATION
     ===================================================== -->

<section class="tour-quick-info"
         aria-label="Tour at a glance">


    <div class="quick-info-item">

        <div class="quick-info-icon">
            ◷
        </div>

        <div class="quick-info-text">

            <span class="quick-info-label">
                Duration
            </span>

            <span class="quick-info-value">
                ${tour.duration} memorable days
            </span>

        </div>

    </div>



    <div class="quick-info-item">

        <div class="quick-info-icon">
            ⌖
        </div>

        <div class="quick-info-text">

            <span class="quick-info-label">
                Departure
            </span>

            <span class="quick-info-value">
                ${tour.departureCity}
            </span>

        </div>

    </div>



    <div class="quick-info-item">

        <div class="quick-info-icon">
            ✦
        </div>

        <div class="quick-info-text">

            <span class="quick-info-label">
                Travel style
            </span>

            <span class="quick-info-value">
                ${tour.category}
            </span>

        </div>

    </div>



    <div class="quick-info-item">

        <div class="quick-info-icon">
            ₹
        </div>

        <div class="quick-info-text">

            <span class="quick-info-label">
                Starting from
            </span>

            <span class="quick-info-value">
                ₹${tour.price} per person
            </span>

        </div>

    </div>

</section>



<!-- =====================================================
     OVERVIEW
     ===================================================== -->

<div class="card">

    <h2>Overview</h2>


    <c:choose>

        <c:when test="${details != null}">

            <p>
                ${details.longDescription}
            </p>

        </c:when>

        <c:otherwise>

            <p>
                Details are not available for this tour yet.
            </p>

        </c:otherwise>

    </c:choose>

</div>



<!-- =====================================================
     HIGHLIGHTS
     ===================================================== -->

<div class="card">

    <h2>Tour Highlights</h2>


    <ul class="highlight-list">

        <c:choose>

            <c:when test="${details != null && not empty details.highlights}">

                <c:forEach
                    var="h"
                    items="${fn:split(details.highlights, ',')}">

                    <li>
                        ${h}
                    </li>

                </c:forEach>

            </c:when>


            <c:otherwise>

                <li>
                    Tour highlights are not available yet.
                </li>

            </c:otherwise>

        </c:choose>

    </ul>

</div>



<!-- =====================================================
     GALLERY
     ===================================================== -->

<div class="gallery-section">

    <h2>Gallery</h2>


    <div class="gallery-grid">


        <c:choose>


            <c:when test="${not empty images}">


                <c:forEach
                    var="img"
                    items="${images}">


                    <div class="gallery-item">


                        <c:choose>

                            <c:when test="${img.id > 0}">

                                <img
                                    src="${pageContext.request.contextPath}/TourImageServlet?id=${img.id}"
                                    alt="${tour.name} gallery image">

                            </c:when>


                            <c:otherwise>

                                <div class="gallery-image-placeholder">
                                    Image unavailable
                                </div>

                            </c:otherwise>

                        </c:choose>


                    </div>


                </c:forEach>


            </c:when>


            <c:otherwise>


                <div class="no-gallery-images">

                    <p>
                        No gallery images have been uploaded for this tour yet.
                    </p>

                </div>


            </c:otherwise>


        </c:choose>


    </div>

</div>



<!-- =====================================================
     DAY-WISE ITINERARY
     ===================================================== -->

<div class="card"
     id="itinerary-section">


    <h2>Day-wise Itinerary</h2>


    <div class="timeline">


        <c:choose>


            <c:when test="${not empty itinerary}">


                <c:forEach
                    var="day"
                    items="${itinerary}">


                    <div class="timeline-item">


                        <div class="timeline-day">

                            Day ${day.dayNumber}

                        </div>


                        <div class="timeline-content">

                            <h3>
                                ${day.dayTitle}
                            </h3>


                            <p>
                                ${day.dayDescription}
                            </p>

                        </div>


                    </div>


                </c:forEach>


            </c:when>


            <c:otherwise>


                <p>
                    Itinerary information is not available yet.
                </p>


            </c:otherwise>


        </c:choose>


    </div>

</div>



<!-- =====================================================
     ACCOMMODATION DETAILS
     ===================================================== -->

<div class="card">

    <h2>Accommodation Details</h2>


    <table class="hotel-table">


        <tr>

            <th>City</th>

            <th>Hotel</th>

            <th>Check-in</th>

            <th>Check-out</th>

        </tr>


        <c:choose>


            <c:when test="${not empty hotels}">


                <c:forEach
                    var="h"
                    items="${hotels}">


                    <tr>

                        <td>
                            ${h.city}
                        </td>

                        <td>
                            ${h.hotelName}
                        </td>

                        <td>
                            ${h.checkIn}
                        </td>

                        <td>
                            ${h.checkOut}
                        </td>

                    </tr>


                </c:forEach>


            </c:when>


            <c:otherwise>


                <tr>

                    <td colspan="4">

                        Accommodation information
                        is not available yet.

                    </td>

                </tr>


            </c:otherwise>


        </c:choose>


    </table>

</div>



<!-- =====================================================
     TOUR INFORMATION TABS
     ===================================================== -->

<div class="info-tabs">


    <div class="tab-buttons">

        <button
            class="tab-btn active"
            onclick="openTab(event, 'inclusions')">

            Inclusions

        </button>


        <button
            class="tab-btn"
            onclick="openTab(event, 'exclusions')">

            Exclusions

        </button>


        <button
            class="tab-btn"
            onclick="openTab(event, 'preparation')">

            Preparation

        </button>

    </div>



    <!-- INCLUSIONS -->

    <div id="inclusions"
         class="tab-content active">


        <ul>


            <c:choose>


                <c:when test="${details != null && not empty details.inclusions}">


                    <c:forEach
                        var="i"
                        items="${fn:split(details.inclusions, ',')}">

                        <li>
                            ${i}
                        </li>

                    </c:forEach>


                </c:when>


                <c:otherwise>

                    <li>
                        Inclusion information is not available yet.
                    </li>

                </c:otherwise>


            </c:choose>


        </ul>


    </div>



    <!-- EXCLUSIONS -->

    <div id="exclusions"
         class="tab-content">


        <ul>


            <c:choose>


                <c:when test="${details != null && not empty details.exclusions}">


                    <c:forEach
                        var="e"
                        items="${fn:split(details.exclusions, ',')}">

                        <li>
                            ${e}
                        </li>

                    </c:forEach>


                </c:when>


                <c:otherwise>

                    <li>
                        Exclusion information is not available yet.
                    </li>

                </c:otherwise>


            </c:choose>


        </ul>


    </div>



    <!-- PREPARATION -->

    <div id="preparation"
         class="tab-content">


        <c:choose>


            <c:when test="${details != null && not empty details.preparation}">

                <p>
                    ${details.preparation}
                </p>

            </c:when>


            <c:otherwise>

                <p>
                    Preparation information is not available yet.
                </p>

            </c:otherwise>


        </c:choose>


    </div>


</div>



<!-- =====================================================
     PAYMENT TERMS
     ===================================================== -->

<div class="card">

    <h2>Payment Terms</h2>


    <c:choose>

        <c:when test="${details != null && not empty details.paymentTerms}">

            <p>
                ${details.paymentTerms}
            </p>

        </c:when>

        <c:otherwise>

            <p>
                Payment terms are not available yet.
            </p>

        </c:otherwise>

    </c:choose>

</div>



<!-- =====================================================
     UPGRADES
     ===================================================== -->

<div class="card">

    <h2>Upgrades Available</h2>


    <c:choose>

        <c:when test="${details != null && not empty details.upgradesInfo}">

            <p>
                ${details.upgradesInfo}
            </p>

        </c:when>

        <c:otherwise>

            <p>
                No upgrade information is available yet.
            </p>

        </c:otherwise>

    </c:choose>

</div>



<!-- =====================================================
     MAP
     ===================================================== -->

<div class="card">

    <h2>Location Map</h2>


    <c:choose>


        <c:when test="${details != null && not empty details.mapEmbed}">

            <iframe
                src="${details.mapEmbed}"
                loading="lazy"
                allowfullscreen>
            </iframe>

        </c:when>


        <c:otherwise>

            <p>
                Location map is not available yet.
            </p>

        </c:otherwise>


    </c:choose>


</div>



<!-- =====================================================
     BOOKING CTA
     ===================================================== -->

<div class="book-btn-container">

    <p>
        READY WHEN YOU ARE
    </p>


    <h2>
        Make this journey yours.
    </h2>


    <p>
        Reserve your preferred dates and let our specialists
        tailor every detail.
    </p>


    <a
        href="${pageContext.request.contextPath}/booking?tour_id=${tour.id}"
        class="book-btn">

        Book This Tour

    </a>

</div>



<!-- =====================================================
     TAB SCRIPT
     ===================================================== -->

<script>

function openTab(evt, tabName) {

    var i;

    var tabcontent =
        document.getElementsByClassName("tab-content");

    for (i = 0; i < tabcontent.length; i++) {

        tabcontent[i].style.display = "none";

        tabcontent[i].classList.remove("active");

    }


    var tabbtns =
        document.getElementsByClassName("tab-btn");

    for (i = 0; i < tabbtns.length; i++) {

        tabbtns[i].classList.remove("active");

    }


    document.getElementById(tabName).style.display = "block";

    document.getElementById(tabName).classList.add("active");

    evt.currentTarget.classList.add("active");

}

</script>


</main>


<%@ include file="common/footer.jsp" %>


</body>

</html>