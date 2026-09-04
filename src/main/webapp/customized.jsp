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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/holiday-premium.css"></head>
<body class="customized-page occasion-collection-page">
<%@ include file="common/header.jsp" %>
<main>
    <section class="occasion-hero"><div class="occasion-hero-copy"><p class="holiday-kicker">BIRTHDAYS. HONEYMOONS. MOMENTS THAT ARE YOURS.</p><h1>Make room for<br><em>something special.</em></h1><p class="occasion-hero-lead">Customized holidays for the people and occasions that matter. Find an experience you love, then bring your own plans to it.</p><a href="#occasion-collection" class="occasion-hero-link">Find your kind of getaway <span aria-hidden="true">↓</span></a><div class="occasion-hero-notes"><span>Occasion-led journeys</span><span>Your preferred dates</span><span>Room for personal touches</span></div></div>
<div class="occasion-hero-visual"><c:choose><c:when test="${not empty holidays}"><c:url var="introCover" value="/holiday-image"><c:param name="id" value="${holidays[0].id}"/></c:url><img src="${introCover}" alt="<c:out value='${holidays[0].name}'/>" width="900" height="1000" fetchpriority="high"><div class="occasion-hero-caption"><small>A LITTLE INSPIRATION</small><strong><c:out value="${holidays[0].name}"/></strong><span><c:out value="${holidays[0].occasion}"/> collection</span></div></c:when><c:otherwise><img src="${pageContext.request.contextPath}/images/holiday-cover-placeholder.svg" alt="" width="900" height="1000"><div class="occasion-hero-caption"><small>YOUR NEXT CHAPTER</small><strong>A holiday with a personal touch.</strong></div></c:otherwise></c:choose><span class="occasion-hero-stamp" aria-hidden="true">✦</span></div></section>
<nav class="occasion-quick-links" aria-label="Browse by occasion"><span>What's the occasion?</span><a href="${pageContext.request.contextPath}/customize#occasion-collection" class="${empty param.occasion ? 'selected' : ''}">All getaways</a><c:forEach var="occasionName" items="${occasions}"><c:url var="occasionLink" value="/customize"><c:param name="occasion" value="${occasionName}"/><c:param name="city" value="${param.city}"/><c:param name="duration" value="${selectedDuration}"/><c:param name="budget" value="${selectedBudget}"/></c:url><a href="${occasionLink}#occasion-collection" class="${param.occasion == occasionName ? 'selected' : ''}"><c:out value="${occasionName}"/></a></c:forEach></nav>
    <section id="occasion-collection" class="destinations-layout" aria-label="Holiday packages">
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
                        <div class="holiday-card-grid">
                        <c:forEach var="holiday" items="${holidays}">
                            <c:url var="detailsUrl" value="/holiday-details"><c:param name="id" value="${holiday.id}"/></c:url>
                            <c:url var="coverUrl" value="/holiday-image"><c:param name="id" value="${holiday.id}"/></c:url>
                            <article class="occasion-card">
                                <a class="occasion-cover" href="${detailsUrl}" aria-label="Explore <c:out value='${holiday.name}'/>">
                                    <img src="${coverUrl}" alt="<c:out value='${holiday.name}'/> cover" width="1200" height="800" loading="lazy" decoding="async">
                                    <span class="occasion-label"><c:out value="${holiday.occasion}"/></span>
                                    <span class="occasion-cover-caption">A getaway made personal <span aria-hidden="true">↗</span></span>
                                </a>
                                <div class="occasion-card-body">
                                    <p class="occasion-meta"><span>From <c:out value="${holiday.departureCity}"/></span><span>${holiday.duration} days</span></p>
                                    <h3><a href="${detailsUrl}"><c:out value="${holiday.name}"/></a></h3>
                                    <p class="occasion-description"><c:out value="${holiday.shortDescription}"/></p>
                                    <p class="occasion-flexible"><span aria-hidden="true">✦</span> Your occasion. Your preferred travel date.</p>
                                    <div class="occasion-card-footer">
                                        <p class="occasion-price"><small>Per person</small>₹<fmt:formatNumber value="${holiday.price}" groupingUsed="true"/></p>
                                        <a class="occasion-details-link" href="${detailsUrl}">View details <span aria-hidden="true">→</span></a>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                        </div>
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
