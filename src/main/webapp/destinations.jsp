<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Destinations | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/destinations.css">
</head>

<body>

<%@ include file="common/header.jsp" %>

<!-- =====================================================
     TOP BAR (Small, colorful, homepage-matching)
     ===================================================== -->
<section class="destinations-topbar">
    <p>EXPLORE INDIA</p>
    <h2>Destinations & Travel Packages</h2>
</section>

<!-- =====================================================
     MAIN LAYOUT (Filters + Results)
     ===================================================== -->
<section class="destinations-layout">

    <div class="destinations-container">

        <!-- ============================
             FILTERS PANEL (Left side)
             ============================ -->
        <aside class="filters-panel-modern">

            <form action="${pageContext.request.contextPath}/destinations"
                  method="get">

                <h3 class="filter-title">Filter Your Search</h3>

                <!-- PRICE -->
                <div class="filter-group">
                    <label>Price Range</label>
                    <input type="number" name="price_min"
                           placeholder="Min Price">
                    <input type="number" name="price_max"
                           placeholder="Max Price">
                </div>

                <!-- CITY -->
                <div class="filter-group">
                    <label>Departure City</label>
                    <select name="city">
                        <option value="all">All Cities</option>
                        <option value="Mumbai">Mumbai</option>
                        <option value="Delhi">Delhi</option>
                        <option value="Jaipur">Jaipur</option>
                    </select>
                </div>

                <!-- CATEGORY -->
                <div class="filter-group">
                    <label>Category</label>
                    <select name="category">
                        <option value="all">All Categories</option>
                        <option value="Family">Family</option>
                        <option value="Adventure">Adventure</option>
                        <option value="Culture">Culture</option>
                    </select>
                </div>

                <!-- DURATION -->
                <div class="filter-group">
                    <label>Duration</label>
                    <select name="duration">
                        <option value="0">Any Duration</option>
                        <option value="5">5 Days</option>
                        <option value="6">6 Days</option>
                        <option value="7">7 Days</option>
                    </select>
                </div>

                <button type="submit" class="filter-btn">
                    Apply Filters
                </button>

            </form>

        </aside>


        <!-- ============================
             RESULTS PANEL (Right side)
             ============================ -->
        <div class="results-panel-modern">

            <c:forEach var="tour" items="${tours}">

                <article class="tour-card-modern">

                    <!-- IMAGE -->
                    <div class="tour-image-wrapper">
                        <img src="${pageContext.request.contextPath}/images/${tour.image}"
                             alt="${tour.name}">
                    </div>

                    <!-- CONTENT -->
                    <div class="tour-content">

                        <h3>${tour.name}</h3>

                        <p class="tour-meta">
                            <span>Category:</span> ${tour.category}
                        </p>

                        <p class="tour-meta">
                            <span>Departure:</span> ${tour.departureCity}
                        </p>

                        <p class="tour-meta">
                            <span>Duration:</span> ${tour.duration} days
                        </p>

                        <p class="tour-price">
                            ₹${tour.price}
                        </p>

                        <div class="tour-actions">
                            <a class="primary-btn-small"
                               href="${pageContext.request.contextPath}/tour-details?id=${tour.id}">
                                View Details
                            </a>

                            <a class="outline-btn-small" href="#">
                                Compare
                            </a>

                            <a class="outline-btn-small" href="#">
                                Enquire
                            </a>
                        </div>

                    </div>

                </article>

            </c:forEach>

        </div>

    </div>

</section>

<%@ include file="common/footer.jsp" %>

</body>
</html>
