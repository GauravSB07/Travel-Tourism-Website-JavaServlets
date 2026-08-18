<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>${tour.name} | TravelTourism</title>
    <link rel="stylesheet" href="css/tour_details.css">
</head>

<body>

<!-- HEADER -->
<div class="page-header">
    <span class="label">DESTINATION DETAILS</span>
    <h1>${tour.name}</h1>
</div>

<!-- MAIN IMAGE -->
<div class="main-image">
    <img src="${tour.image}" alt="${tour.name}">
</div>

<!-- GALLERY -->
<div class="gallery-section">
    <h2>Gallery</h2>
    <div class="gallery-grid">
        <c:forEach var="img" items="${images}">
            <img src="${img.imagePath}" alt="Tour Image">
        </c:forEach>
    </div>
</div>

<!-- DESCRIPTION -->
<div class="card">
    <h2>Overview</h2>
    <p>${details.long_description}</p>
</div>

<!-- ITINERARY -->
<div class="card">
    <h2>Itinerary</h2>
    <pre class="itinerary">${details.itinerary}</pre>
</div>

<!-- HIGHLIGHTS -->
<div class="card">
    <h2>Highlights</h2>
    <ul>
        <c:forEach var="h" items="${fn:split(details.highlights, ',')}">
            <li>${h}</li>
        </c:forEach>
    </ul>
</div>

<!-- INCLUSIONS / EXCLUSIONS -->
<div class="two-column">
    <div class="card">
        <h2>Inclusions</h2>
        <ul>
            <c:forEach var="i" items="${fn:split(details.inclusions, ',')}">
                <li>${i}</li>
            </c:forEach>
        </ul>
    </div>

    <div class="card">
        <h2>Exclusions</h2>
        <ul>
            <c:forEach var="e" items="${fn:split(details.exclusions, ',')}">
                <li>${e}</li>
            </c:forEach>
        </ul>
    </div>
</div>

<!-- BEST TIME -->
<div class="card">
    <h2>Best Time to Visit</h2>
    <p>${details.best_time}</p>
</div>

<!-- MAP -->
<div class="card">
    <h2>Location Map</h2>
    <iframe src="${details.map_embed}" loading="lazy"></iframe>
</div>

<!-- BOOK BUTTON -->
<div class="book-btn-container">
    <a href="#" class="book-btn">Book This Tour</a>
</div>

</body>
</html>
