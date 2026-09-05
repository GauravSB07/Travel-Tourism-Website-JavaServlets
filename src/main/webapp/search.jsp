<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Search Results | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/destinations.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/destinations-premium.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/holiday-premium.css">
</head>
<body class="destinations-premium">
<%@ include file="common/header.jsp" %>
<main style="padding-top: 80px;">
    <section class="destinations-layout" id="journey-collection">
        <div class="destinations-container" style="max-width: 1200px; margin: 0 auto; display: block;">
            <div class="results-panel-modern" style="width: 100%;">
                <div class="results-toolbar"><div><p class="eyebrow">SEARCH RESULTS</p><h2>${resultCount} results found for "<c:out value="${query}"/>"</h2></div></div>

                <%-- ===== TOUR RESULTS ===== --%>
                <c:if test="${not empty tours}">
                <h3 style="margin: 2rem 0 1rem; font-size: 1.1rem; letter-spacing: 0.05em; text-transform: uppercase; color: #888;">Destination Tours</h3>
                <div class="collection-grid">
                    <c:forEach var="tour" items="${tours}">
                        <article class="tour-card-modern">
                            <a class="tour-image-wrapper" href="${pageContext.request.contextPath}/tour-details?id=${tour.id}" aria-label="View details of <c:out value='${tour.name}'/>"><c:choose><c:when test="${tour.imageId > 0}"><img src="${pageContext.request.contextPath}/TourImageServlet?id=${tour.imageId}" alt="<c:out value='${tour.name}'/>" loading="lazy"></c:when><c:otherwise><div class="tour-image-placeholder">Tour photograph not available</div></c:otherwise></c:choose><span class="collection-category"><c:out value="${tour.category}"/></span><span class="collection-image-arrow" aria-hidden="true">↗</span></a>
                            <div class="tour-content">
                                <div class="tour-meta-row"><span>${tour.duration} DAYS</span><span>FROM <c:out value="${tour.departureCity}"/></span></div>
                                <h3><a href="${pageContext.request.contextPath}/tour-details?id=${tour.id}"><c:out value="${tour.name}"/></a></h3>
                                <c:if test="${not empty tour.shortDescription}"><p class="tour-description"><c:out value="${tour.shortDescription}"/></p></c:if>
                                <div class="collection-card-footer"><p class="tour-price">₹<fmt:formatNumber value="${tour.price}" groupingUsed="true"/><small>per person</small></p><a class="primary-btn-small" href="${pageContext.request.contextPath}/tour-details?id=${tour.id}">View Details <span aria-hidden="true">↗</span></a></div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
                </c:if>

                <%-- ===== HOLIDAY RESULTS ===== --%>
                <c:if test="${not empty holidays}">
                <h3 style="margin: 2rem 0 1rem; font-size: 1.1rem; letter-spacing: 0.05em; text-transform: uppercase; color: #888;">Customized Holidays</h3>
                <div class="holiday-card-grid">
                    <c:forEach var="holiday" items="${holidays}">
                        <c:url var="detailsUrl" value="/holiday-details"><c:param name="id" value="${holiday.id}"/></c:url>
                        <c:url var="coverUrl" value="/holiday-image"><c:param name="id" value="${holiday.id}"/></c:url>
                        <article class="occasion-card">
                            <a class="occasion-cover" href="${detailsUrl}" aria-label="Explore <c:out value='${holiday.name}'/>"><img src="${coverUrl}" alt="<c:out value='${holiday.name}'/> cover" width="1200" height="800" loading="lazy" decoding="async"><span class="occasion-label"><c:out value="${holiday.occasion}"/></span><span class="occasion-cover-caption">A getaway made personal <span aria-hidden="true">↗</span></span></a>
                            <div class="occasion-card-body">
                                <p class="occasion-meta"><span>From <c:out value="${holiday.departureCity}"/></span><span>${holiday.duration} days</span></p>
                                <h3><a href="${detailsUrl}"><c:out value="${holiday.name}"/></a></h3>
                                <p class="occasion-description"><c:out value="${holiday.shortDescription}"/></p>
                                <div class="occasion-card-footer"><p class="occasion-price"><small>Per person</small>₹<fmt:formatNumber value="${holiday.price}" groupingUsed="true"/></p><a class="occasion-details-link" href="${detailsUrl}">View details <span aria-hidden="true">→</span></a></div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
                </c:if>

                <c:if test="${empty tours and empty holidays}"><div class="no-results" style="text-align: center; padding: 4rem 2rem;"><p class="eyebrow">NO MATCHES</p><h3>No journeys match your search term.</h3><p>Try searching for a different destination or journey name.</p><a href="${pageContext.request.contextPath}/destinations">Explore all journeys ↗</a></div></c:if>
            </div>
        </div>
    </section>
</main>
<%@ include file="common/footer.jsp" %>
</body>
</html>
