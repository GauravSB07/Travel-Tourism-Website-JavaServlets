<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Destinations</title>
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/style.css">

        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                margin: 0;
                padding: 20px;
            }

            h1 {
                margin-bottom: 20px;
            }

            .page-container {
                display: flex;
                gap: 20px;
                align-items: flex-start;
            }

            .filters-panel {
                width: 25%;
                background: #ffffff;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }

            .filters-panel h3 {
                margin-top: 15px;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .filters-panel input,
            .filters-panel select,
            .filters-panel button {
                width: 100%;
                margin-bottom: 10px;
                padding: 8px;
                font-size: 13px;
            }

            .packages-panel {
                width: 75%;
            }

            .tour-card {
                display: flex;
                gap: 15px;
                background: #ffffff;
                padding: 15px;
                margin-bottom: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }

            .tour-img {
                width: 140px;
                height: 90px;
                object-fit: cover;
                border-radius: 6px;
            }

            .tour-info h3 {
                margin: 0 0 8px 0;
            }

            .tour-info p {
                margin: 2px 0;
                font-size: 13px;
            }

            .tour-info button {
                margin-top: 8px;
                margin-right: 6px;
                padding: 6px 10px;
                font-size: 12px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>

        <%@ include file="common/header.jsp" %>

        <h1>Destinations</h1>

        <div class="page-container">

            <!-- LEFT: FILTERS -->
            <div class="filters-panel">
                <form action="${pageContext.request.contextPath}/destinations" method="get">

                    <h3>Price Range</h3>
                    <input type="number" name="price_min" placeholder="Min Price">
                    <input type="number" name="price_max" placeholder="Max Price">

                    <h3>Departure City</h3>
                    <select name="city">
                        <option value="all">All Cities</option>
                        <option value="Mumbai">Mumbai</option>
                        <option value="Delhi">Delhi</option>
                        <option value="Jaipur">Jaipur</option>
                    </select>

                    <h3>Category</h3>
                    <select name="category">
                        <option value="all">All Categories</option>
                        <option value="Family">Family</option>
                        <option value="Adventure">Adventure</option>
                        <option value="Culture">Culture</option>
                    </select>

                    <h3>Duration</h3>
                    <select name="duration">
                        <option value="0">Any Duration</option>
                        <option value="5">5 Days</option>
                        <option value="6">6 Days</option>
                        <option value="7">7 Days</option>
                    </select>

                    <button type="submit">Apply Filters</button>
                </form>
            </div>

            <!-- RIGHT: PACKAGES LIST -->
            <div class="packages-panel">

                <c:forEach var="tour" items="${tours}">
                    <div class="tour-card">

                        <img src="${pageContext.request.contextPath}/images/${tour.image}" alt="${tour.name}" class="tour-img" />

                        <div class="tour-info">
                            <h3>${tour.name}</h3>

                            <p>Category: ${tour.category}</p>
                            <p>Departure: ${tour.departureCity}</p>
                            <p>Duration: ${tour.duration} days</p>
                            <p>Price: ₹${tour.price}</p>

                            <button>View Details</button>
                            <button>Compare</button>
                            <button>Enquire Now</button>
                        </div>

                    </div>
                </c:forEach>

            </div>

        </div>

        <%@ include file="common/footer.jsp" %>

    </body>
</html>
