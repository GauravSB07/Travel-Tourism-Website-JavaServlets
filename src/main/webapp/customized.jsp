<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${not holidaysLoaded}"><c:redirect url="/customize"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Customized Holidays | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/destinations.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customized.css">
</head>
<body class="customized-page">
<%@ include file="common/header.jsp" %>
<main>
    <section class="destinations-intro">
        <div class="destinations-intro-inner">
            <p class="destinations-eyebrow">YOUR OCCASION. YOUR KIND OF HOLIDAY.</p>
            <h1>Customized Holidays</h1>
            <p class="destinations-lead">Find your next celebration. Explore birthdays, honeymoons, anniversaries and family celebrations, choose your favourite package and make room for the moments you love.</p>
        </div>
    </section>
    <section class="destinations-layout" aria-label="Holiday packages">
        <div class="destinations-container">
            <aside class="filters-panel-modern">
                <form action="${pageContext.request.contextPath}/customize" method="get">
                    <h2 class="filter-title">Find your celebration</h2>
                    <p class="filter-help">Choose an occasion, departure city or budget.</p>
                    <div class="filter-group">
                        <label for="occasion">Occasion</label>
                        <select id="occasion" name="occasion">
                            <option value="">All occasions</option>
                            <c:forEach var="item" items="${occasions}"><option value="<c:out value='${item}'/>" ${param.occasion == item ? 'selected' : ''}><c:out value="${item}"/></option></c:forEach>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="city">Departure city</label>
                        <select id="city" name="city">
                            <option value="">All cities</option>
                            <c:forEach var="item" items="${cities}"><option value="<c:out value='${item}'/>" ${param.city == item ? 'selected' : ''}><c:out value="${item}"/></option></c:forEach>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="duration">Duration</label>
                        <select id="duration" name="duration">
                            <option value="0">Any duration</option>
                            <c:forEach var="days" items="${durations}"><option value="${days}" ${selectedDuration == days ? 'selected' : ''}>${days} days</option></c:forEach>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="budget">Maximum price per person (₹)</label>
                        <input id="budget" name="budget" type="number" min="0" step="1" value="${selectedBudget}" placeholder="Any budget">
                    </div>
                    <button class="filter-btn" type="submit">Find holidays</button>
                    <a class="holiday-reset" href="${pageContext.request.contextPath}/customize">Clear filters</a>
                </form>
            </aside>
            <div class="results-panel-modern">
                <c:choose>
                    <c:when test="${loadError}">
                        <div class="no-results" role="alert"><h2>Holidays are temporarily unavailable</h2><p>Please try again shortly, or contact us to plan your holiday.</p><a href="${pageContext.request.contextPath}/customize">Try again</a> · <a href="${pageContext.request.contextPath}/contact">Contact us</a></div>
                    </c:when>
                    <c:otherwise>
                        <div class="results-toolbar"><div><p class="eyebrow">CELEBRATE YOUR WAY</p><h2>${resultCount} occasion getaways to explore</h2></div></div>
                        <p class="holiday-note">Choose a package, explore the itinerary, then tell us about your travellers and preferences. Your travel dates and any special arrangements are subject to confirmation.</p>
                        <c:forEach var="holiday" items="${holidays}">
                            <article class="tour-card-modern">
                                <div class="holiday-art" aria-hidden="true"><span class="holiday-art-symbol">✦</span><span><c:out value="${holiday.occasion}"/></span><small>Choose your travel date</small></div>
                                <div class="tour-content">
                                    <div class="tour-content-top"><h3><c:out value="${holiday.name}"/></h3><p class="tour-price">₹<fmt:formatNumber value="${holiday.price}" groupingUsed="true"/><small>per person</small></p></div>
                                    <div class="tour-meta-row"><span>From <c:out value="${holiday.departureCity}"/></span><span>${holiday.duration} days</span><span>Choose your travel date</span></div>
                                    <p class="tour-description"><c:out value="${holiday.shortDescription}"/></p>
                                    <div class="tour-actions">
                                        <c:url var="detailsUrl" value="/holiday-details"><c:param name="id" value="${holiday.id}"/></c:url>
                                        <a class="primary-btn-small" href="${detailsUrl}">View Details</a>
                                        <a class="outline-btn-small" href="${pageContext.request.contextPath}/contact">Ask for a different itinerary</a>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                        <c:if test="${empty holidays}"><div class="no-results"><p class="eyebrow">MORE ROOM TO EXPLORE</p><h3>No holidays match your search.</h3><p>Try another occasion, duration or budget, or contact us for a personal itinerary.</p><a href="${pageContext.request.contextPath}/customize">Clear filters</a> · <a href="${pageContext.request.contextPath}/contact">Plan with us</a></div></c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
</main>
<%@ include file="common/footer.jsp" %>
</body>
</html>
