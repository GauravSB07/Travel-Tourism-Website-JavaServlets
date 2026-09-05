<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Compare Journeys | TravelTourism</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/compare-premium.css?v=1">
</head>
<body>
<%@ include file="common/header.jsp" %>
<main class="compare-premium">
<section class="compare-intro">
<div class="compare-intro-copy">
<p class="compare-kicker">YOUR SHORTLIST, SIDE BY SIDE</p>
<h1>Choose the journey<br><em>that feels right.</em></h1>
<p>Compare the pace, departure point and price of your selected tours, then open the full itinerary before you book.</p>
<a href="${pageContext.request.contextPath}/destinations">← Return to all destinations</a>
</div>
<div class="compare-intro-note">
<span><c:out value="${tours.size()}"/></span>
<p>journeys in<br>your comparison</p>
</div>
</section>

<c:choose>
<c:when test="${empty tours}">
<section class="compare-empty">
<span aria-hidden="true">◇</span>
<p class="compare-kicker">START A SHORTLIST</p>
<h2>Your comparison is waiting</h2>
<p>Choose two or three tours from the Destinations page to see their essential details together.</p>
<a class="compare-primary" href="${pageContext.request.contextPath}/destinations">Explore destinations <span>→</span></a>
</section>
</c:when>
<c:otherwise>
<section class="comparison-shell" aria-label="Selected tour comparison">
<div class="comparison-guide"><p><strong>Compare ${tours.size()} journeys</strong><span>Each column is one complete package. Scroll horizontally on smaller screens.</span></p><span class="comparison-guide-mark">01 — ${tours.size()}</span></div>
<div class="comparison-board comparison-columns-${tours.size()}">
<c:forEach var="tour" items="${tours}" varStatus="status">
<article class="journey-column">
<div class="journey-image">
<c:choose>
<c:when test="${tour.imageId > 0}"><img src="${pageContext.request.contextPath}/TourImageServlet?id=${tour.imageId}" alt="<c:out value="${tour.name}"/>"></c:when>
<c:otherwise><div class="journey-placeholder"><span>TT</span><small>TravelTourism</small></div></c:otherwise>
</c:choose>
<div class="journey-number">0${status.count}</div>
<span class="journey-category"><c:out value="${tour.category}"/></span>
</div>
<div class="journey-heading">
<p>CURATED JOURNEY</p>
<h2><c:out value="${tour.name}"/></h2>
<div class="journey-price"><span>From</span><strong>₹<fmt:formatNumber value="${tour.price}" maxFractionDigits="0"/></strong><small>per traveller</small></div>
</div>
<dl class="journey-facts">
<div><dt><span aria-hidden="true">◷</span> Duration</dt><dd><c:out value="${tour.duration}"/> days</dd></div>
<div><dt><span aria-hidden="true">⌖</span> Departure</dt><dd><c:out value="${tour.departureCity}"/></dd></div>
<div><dt><span aria-hidden="true">◇</span> Travel style</dt><dd><c:out value="${tour.category}"/></dd></div>
</dl>
<div class="journey-overview">
<h3>Why consider this journey</h3>
<p><c:out value="${tour.shortDescription}"/></p>
</div>
<div class="journey-actions">
<a class="compare-secondary" href="${pageContext.request.contextPath}/tour-details?id=${tour.id}">View full details <span>↗</span></a>
<a class="compare-primary" href="${pageContext.request.contextPath}/booking?tour_id=${tour.id}">Book this tour <span>→</span></a>
</div>
</article>
</c:forEach>
</div>
<div class="compare-footnote"><p><span>Need another look?</span> Return to Destinations to adjust your shortlist.</p><a href="${pageContext.request.contextPath}/destinations">Change compared tours →</a></div>
</section>
</c:otherwise>
</c:choose>
</main>
<%@ include file="common/footer.jsp" %>
</body>
</html>