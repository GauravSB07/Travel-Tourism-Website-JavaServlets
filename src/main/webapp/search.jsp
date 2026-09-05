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
</head>
<body class="destinations-premium">
<%@ include file="common/header.jsp" %>
<main style="padding-top: 80px;">
    <section class="destinations-layout" id="journey-collection">
        <div class="destinations-container" style="max-width: 1200px; margin: 0 auto; display: block;">
            <div class="results-panel-modern" style="width: 100%;">
                <div class="results-toolbar"><div><p class="eyebrow">SEARCH RESULTS</p><h2>${resultCount} journeys found for "<c:out value="${query}"/>"</h2></div></div>
                <div class="collection-grid" style="margin-top: 2rem;">
                    <c:forEach var="tour" items="${tours}">
                        <article class="tour-card-modern">
                            <a class="tour-image-wrapper" href="${pageContext.request.contextPath}/tour-details?id=${tour.id}" aria-label="View details of <c:out value='${tour.name}'/>">
                                <c:choose><c:when test="${tour.imageId > 0}"><img src="${pageContext.request.contextPath}/TourImageServlet?id=${tour.imageId}" alt="<c:out value='${tour.name}'/>" loading="lazy"></c:when><c:otherwise><div class="tour-image-placeholder">Tour photograph not available</div></c:otherwise></c:choose>
                                <span class="collection-category"><c:out value="${tour.category}"/></span><span class="collection-image-arrow" aria-hidden="true">↗</span>
                            </a>
                            <div class="tour-content">
                                <div class="tour-meta-row"><span>${tour.duration} DAYS</span><span>FROM <c:out value="${tour.departureCity}"/></span></div>
                                <h3><a href="${pageContext.request.contextPath}/tour-details?id=${tour.id}"><c:out value="${tour.name}"/></a></h3>
                                <c:if test="${not empty tour.shortDescription}"><p class="tour-description"><c:out value="${tour.shortDescription}"/></p></c:if>
                                <div class="collection-card-footer"><p class="tour-price">₹<fmt:formatNumber value="${tour.price}" groupingUsed="true"/><small>per person</small></p><a class="primary-btn-small" href="${pageContext.request.contextPath}/tour-details?id=${tour.id}">View Details <span aria-hidden="true">↗</span></a></div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
                <c:if test="${empty tours}"><div class="no-results" style="text-align: center; padding: 4rem 2rem;"><p class="eyebrow">NO MATCHES</p><h3>No journeys match your search term.</h3><p>Try searching for a different destination or journey name.</p><a href="${pageContext.request.contextPath}/destinations">Explore all journeys ↗</a></div></c:if>
            </div>
        </div>
    </section>
</main>
<%@ include file="common/footer.jsp" %>
</body>
</html>
