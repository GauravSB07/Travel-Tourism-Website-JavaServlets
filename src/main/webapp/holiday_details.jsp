<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty holiday}"><c:redirect url="/customize"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${holiday.name}"/> | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/destinations.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customized.css">
</head>
<body class="customized-page">
<%@ include file="common/header.jsp" %>
<main>
    <section class="destinations-intro holiday-details-intro">
        <nav class="holiday-breadcrumb" aria-label="Breadcrumb">
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a><span aria-hidden="true">›</span>
            <a href="${pageContext.request.contextPath}/customize">Customized Holidays</a><span aria-hidden="true">›</span>
            <span aria-current="page"><c:out value="${holiday.name}"/></span>
        </nav>
        <p class="destinations-eyebrow"><c:out value="${holiday.occasion}"/> GETAWAY</p>
        <h1><c:out value="${holiday.name}"/></h1>
        <p class="destinations-lead"><c:out value="${holiday.shortDescription}"/></p>
    </section>
    <div class="holiday-details-layout">
        <div class="holiday-details-content">
            <section class="holiday-detail-section" aria-labelledby="overview-title">
                <p class="eyebrow">A JOURNEY MADE PERSONAL</p>
                <h2 id="overview-title">Your celebration, thoughtfully planned</h2>
                <div class="tour-meta-row"><span><c:out value="${holiday.occasion}"/></span><span>${holiday.duration} days</span><span>From <c:out value="${holiday.departureCity}"/></span><span>Flexible travel dates</span></div>
                <p>Start with this itinerary and make it your own. Choose your travel date when booking, and share room preferences, dietary needs or celebration requests with us.</p>
                <p>Additional arrangements and itinerary changes are subject to availability and may change the final price.</p>
            </section>
            <section class="holiday-detail-section" aria-labelledby="itinerary-title">
                <p class="eyebrow">DAY BY DAY</p><h2 id="itinerary-title">Your holiday itinerary</h2>
                <c:choose>
                    <c:when test="${not empty holiday.itinerary}">
                        <ol class="holiday-day-list"><c:forEach var="day" items="${holiday.itinerary}" varStatus="status">
                            <li><span class="holiday-day-number">Day ${status.count}</span><p><c:out value="${day}"/></p></li>
                        </c:forEach></ol>
                    </c:when>
                    <c:otherwise><p>Contact us for a personalised day-by-day itinerary for this holiday.</p></c:otherwise>
                </c:choose>
            </section>
            <section class="holiday-detail-section" aria-labelledby="included-title"><h2 id="included-title">What's included</h2><p class="holiday-preserve-lines"><c:out value="${holiday.inclusions}"/></p></section>
            <section class="holiday-detail-section" aria-labelledby="excluded-title"><h2 id="excluded-title">What's not included</h2><p class="holiday-preserve-lines"><c:out value="${holiday.exclusions}"/></p></section>
        </div>
        <aside class="holiday-booking-panel" aria-label="Price and booking">
            <div class="holiday-art holiday-details-art" aria-hidden="true"><span class="holiday-art-symbol">✦</span><span><c:out value="${holiday.occasion}"/></span></div>
            <div class="holiday-booking-inner">
                <p class="eyebrow">YOUR CELEBRATION STARTS HERE</p>
                <p class="holiday-detail-price">₹<fmt:formatNumber value="${holiday.price}"/></p>
                <p class="holiday-note">Per person · ${holiday.duration} days</p>
                <p>Departing from <strong><c:out value="${holiday.departureCity}"/></strong>. Choose your preferred date on the booking page.</p>
                <c:url var="bookingUrl" value="/booking"><c:param name="holiday_id" value="${holiday.id}"/></c:url>
                <a class="primary-btn-small" href="${bookingUrl}">Book this holiday</a>
                <a class="outline-btn-small" href="${pageContext.request.contextPath}/contact">Enquire about this holiday</a>
                <p class="holiday-note">Your booking request will be reviewed for availability. No payment is collected at this step.</p>
            </div>
        </aside>
    </div>
</main>
<%@ include file="common/footer.jsp" %>
</body>
</html>
