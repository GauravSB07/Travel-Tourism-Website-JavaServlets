<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>${tour.name} | TravelTourism</title>
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/tour_details.css">
</head>

<body>
<%@ include file="common/header.jsp" %>
<section class="tourdetails-topbar">
    <div class="tourdetails-topbar-inner">
        <div class="tourdetails-breadcrumb"><a href="${pageContext.request.contextPath}/home">Home</a><span>›</span><a href="${pageContext.request.contextPath}/destinations">Destinations</a><span>›</span><b>${tour.name}</b></div>
        <p>CURATED INDIA JOURNEYS</p>
        <h2>Every detail, beautifully considered.</h2>
    </div>
</section>
<main class="page-container">

<!-- ===========================
     HERO SECTION
=========================== -->
<div class="hero-banner">
    <img src="${pageContext.request.contextPath}/images/${tour.image}" alt="${tour.name}">
    <div class="hero-overlay">
        <h1>${tour.name}</h1>
        <p>${tour.shortDescription}</p>

        <div class="meta-bar">
            <span><strong>Duration:</strong> ${tour.duration} Days</span>
            <span><strong>Category:</strong> ${tour.category}</span>
            <span><strong>Departure:</strong> ${tour.departureCity}</span>
            <span><strong>Best Time:</strong> ${details.bestTime}</span>
        </div>

        <a href="#itinerary-section" class="view-itinerary-btn">View Day-wise Itinerary</a>
    </div>
</div>

<section class="tour-quick-info" aria-label="Tour at a glance">
    <div class="quick-info-item"><div class="quick-info-icon">◷</div><div class="quick-info-text"><span class="quick-info-label">Duration</span><span class="quick-info-value">${tour.duration} memorable days</span></div></div>
    <div class="quick-info-item"><div class="quick-info-icon">⌖</div><div class="quick-info-text"><span class="quick-info-label">Departure</span><span class="quick-info-value">${tour.departureCity}</span></div></div>
    <div class="quick-info-item"><div class="quick-info-icon">✦</div><div class="quick-info-text"><span class="quick-info-label">Travel style</span><span class="quick-info-value">${tour.category}</span></div></div>
    <div class="quick-info-item"><div class="quick-info-icon">₹</div><div class="quick-info-text"><span class="quick-info-label">Starting from</span><span class="quick-info-value">₹${tour.price} per person</span></div></div>
</section>


<!-- ===========================
     OVERVIEW
=========================== -->
<div class="card">
    <h2>Overview</h2>
    <p>${details != null ? details.longDescription : 'Details are not available for this tour yet.'}</p>
</div>


<!-- ===========================
     HIGHLIGHTS
=========================== -->
<div class="card">
    <h2>Tour Highlights</h2>
    <ul class="highlight-list">
        <c:forEach var="h" items="${details != null ? fn:split(details.highlights, ',') : emptyList}">
            <li>${h}</li>
        </c:forEach>
    </ul>
</div>


<!-- ===========================
     GALLERY
=========================== -->
<div class="gallery-section">
    <h2>Gallery</h2>
    <div class="gallery-grid">
        <c:forEach var="img" items="${images}">
            <div class="gallery-item"><img src="${img.imageUrl}" alt="${tour.name} gallery image"></div>
        </c:forEach>
    </div>
</div>


<!-- ===========================
     DAY-WISE ITINERARY
=========================== -->
<div class="card" id="itinerary-section">
    <h2>Day-wise Itinerary</h2>

    <div class="timeline">
        <c:forEach var="day" items="${itinerary}">
            <div class="timeline-item">
                <div class="timeline-day">Day ${day.dayNumber}</div>
                <div class="timeline-content">
                    <h3>${day.dayTitle}</h3>
                    <p>${day.dayDescription}</p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<!-- ===========================
     ACCOMMODATION DETAILS
=========================== -->
<div class="card">
    <h2>Accommodation Details</h2>

    <table class="hotel-table">
        <tr>
            <th>City</th>
            <th>Hotel</th>
            <th>Check-in</th>
            <th>Check-out</th>
        </tr>

        <c:forEach var="h" items="${hotels}">
            <tr>
                <td>${h.city}</td>
                <td>${h.hotelName}</td>
                <td>${h.checkIn}</td>
                <td>${h.checkOut}</td>
            </tr>
        </c:forEach>
    </table>
</div>


<!-- ===========================
     TOUR INFORMATION TABS
=========================== -->
<div class="info-tabs">

    <div class="tab-buttons">
        <button class="tab-btn active" onclick="openTab(event, 'inclusions')">Inclusions</button>
        <button class="tab-btn" onclick="openTab(event, 'exclusions')">Exclusions</button>
        <button class="tab-btn" onclick="openTab(event, 'preparation')">Preparation</button>
    </div>

    <div id="inclusions" class="tab-content active">
        <ul>
            <c:forEach var="i" items="${details != null ? fn:split(details.inclusions, ',') : emptyList}">
                <li>${i}</li>
            </c:forEach>
        </ul>
    </div>

    <div id="exclusions" class="tab-content">
        <ul>
            <c:forEach var="e" items="${details != null ? fn:split(details.exclusions, ',') : emptyList}">
                <li>${e}</li>
            </c:forEach>
        </ul>
    </div>

    <div id="preparation" class="tab-content">
        <p>${details.preparation}</p>
    </div>

</div>


<!-- ===========================
     PAYMENT TERMS
=========================== -->
<div class="card">
    <h2>Payment Terms</h2>
    <p>${details.paymentTerms}</p>
</div>


<!-- ===========================
     UPGRADES
=========================== -->
<div class="card">
    <h2>Upgrades Available</h2>
    <p>${details.upgradesInfo}</p>
</div>


<!-- ===========================
     MAP
=========================== -->
<div class="card">
    <h2>Location Map</h2>
    <iframe src="${details.mapEmbed}" loading="lazy"></iframe>
</div>


<!-- ===========================
     BOOKING CTA
=========================== -->
<div class="book-btn-container">
    <p>READY WHEN YOU ARE</p>
    <h2>Make this journey yours.</h2>
    <p>Reserve your preferred dates and let our specialists tailor every detail.</p>
    <a href="${pageContext.request.contextPath}/booking?tour_id=${tour.id}" class="book-btn">Book This Tour</a>
</div>


<!-- ===========================
     TAB SCRIPT
=========================== -->
<script>
function openTab(evt, tabName) {
    var i, tabcontent, tabbtns;

    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
        tabcontent[i].classList.remove("active");
    }

    tabbtns = document.getElementsByClassName("tab-btn");
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
