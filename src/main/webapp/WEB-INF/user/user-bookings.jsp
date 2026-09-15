<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Bookings | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/user-dashboard.css">

    <style>

        /* =====================================================
           MY BOOKINGS PAGE
           ===================================================== */

        .bookings-page {
            width: 92%;
            max-width: 1240px;
            margin: 0 auto;
            padding: 42px 0 70px;
        }

        .bookings-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 25px;
            margin-bottom: 25px;
        }

        .bookings-header-text h1 {
            margin: 0 0 8px;
            color: #173f5f;
            font-size: 32px;
            line-height: 1.2;
        }

        .bookings-header-text p {
            margin: 0;
            color: #7a8795;
            font-size: 13px;
            line-height: 1.6;
        }

        .bookings-count {
            color: #8a949f;
            font-size: 12px;
            white-space: nowrap;
        }

        /* =====================================================
           FILTERS
           ===================================================== */

        .booking-filters {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 24px;
        }

        .booking-filter {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 36px;
            padding: 0 14px;
            border: 1px solid #dfe5ea;
            border-radius: 20px;
            background: #ffffff;
            color: #687786;
            font-size: 11px;
            font-weight: 650;
            text-decoration: none;
            transition: 0.2s ease;
        }

        .booking-filter:hover {
            border-color: #e3a06c;
            color: #e88a3d;
            background: #fffaf6;
        }

        .booking-filter.active {
            border-color: #e88a3d;
            background: #e88a3d;
            color: #ffffff;
        }

        /* =====================================================
           ERROR
           ===================================================== */

        .booking-error {
            display: flex;
            gap: 10px;
            align-items: flex-start;
            margin-bottom: 22px;
            padding: 13px 16px;
            border: 1px solid #f0cdca;
            border-radius: 8px;
            background: #fff1f0;
            color: #9f3028;
            font-size: 13px;
            line-height: 1.5;
        }

        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .no-bookings {
            padding: 65px 25px;
            text-align: center;
            background: #ffffff;
            border: 1px solid #e5e9ee;
            border-radius: 12px;
            box-shadow: 0 5px 22px rgba(23, 63, 95, 0.05);
        }

        .empty-icon {
            width: 58px;
            height: 58px;
            margin: 0 auto 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #fff3e9;
            color: #e88a3d;
            font-size: 24px;
        }

        .no-bookings h2 {
            margin: 0 0 9px;
            color: #173f5f;
            font-size: 22px;
        }

        .no-bookings p {
            max-width: 500px;
            margin: 0 auto 24px;
            color: #7a8795;
            font-size: 13px;
            line-height: 1.6;
        }

        .browse-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 42px;
            padding: 0 18px;
            border-radius: 6px;
            background: #e88a3d;
            color: #ffffff;
            font-size: 12px;
            font-weight: 650;
            text-decoration: none;
            transition: 0.2s ease;
        }

        .browse-button:hover {
            background: #d9772f;
            color: #ffffff;
            transform: translateY(-1px);
        }

        /* =====================================================
           BOOKING LIST
           ===================================================== */

        .booking-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .booking-card {
            background: #ffffff;
            border: 1px solid #e5e9ee;
            border-radius: 11px;
            padding: 24px;
            box-shadow: 0 5px 22px rgba(23, 63, 95, 0.05);
            transition: 0.22s ease;
        }

        .booking-card:hover {
            border-color: #d8e0e6;
            box-shadow: 0 9px 27px rgba(23, 63, 95, 0.08);
            transform: translateY(-1px);
        }

        /* =====================================================
           BOOKING TOP
           ===================================================== */

        .booking-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 19px;
        }

        .booking-title h2 {
            margin: 0 0 7px;
            color: #173f5f;
            font-size: 20px;
            line-height: 1.3;
        }

        .booking-reference {
            color: #8a949f;
            font-size: 11px;
        }

        .booking-reference strong {
            color: #53616d;
            font-weight: 650;
        }

        /* =====================================================
           STATUS
           ===================================================== */

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 29px;
            padding: 0 11px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
            text-transform: capitalize;
            white-space: nowrap;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-reviewing {
            background: #e5efff;
            color: #24558a;
        }

        .status-confirmed {
            background: #e6f5ec;
            color: #21623e;
        }

        .status-completed {
            background: #e9f1f5;
            color: #28556d;
        }

        .status-cancelled {
            background: #fff0f0;
            color: #a33b34;
        }

        /* =====================================================
           BOOKING DETAILS
           ===================================================== */

        .booking-details {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            padding: 18px 0;
            border-top: 1px solid #edf0f3;
            border-bottom: 1px solid #edf0f3;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
            min-width: 0;
        }

        .detail-label {
            color: #8a949f;
            font-size: 9px;
            font-weight: 650;
            letter-spacing: 0.7px;
            text-transform: uppercase;
        }

        .detail-value {
            overflow-wrap: anywhere;
            color: #374151;
            font-size: 12px;
            font-weight: 650;
        }

        /* =====================================================
           BOOKING BOTTOM
           ===================================================== */

        .booking-bottom {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            margin-top: 18px;
        }

        .total-price {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .total-label {
            color: #8a949f;
            font-size: 10px;
        }

        .total-value {
            color: #173f5f;
            font-size: 19px;
            font-weight: 700;
        }

        .view-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            min-height: 38px;
            padding: 0 15px;
            border: 1px solid #d8dfe5;
            border-radius: 6px;
            background: #ffffff;
            color: #536575;
            font-size: 11px;
            font-weight: 650;
            text-decoration: none;
            transition: 0.2s ease;
        }

        .view-button:hover {
            border-color: #e88a3d;
            background: #fff8f2;
            color: #e88a3d;
        }

        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 900px) {

            .booking-details {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 700px) {

            .bookings-header {
                align-items: flex-start;
                flex-direction: column;
                gap: 8px;
            }

            .booking-top {
                flex-direction: column;
            }

        }

        @media (max-width: 520px) {

            .bookings-page {
                width: 90%;
                padding-top: 30px;
            }

            .bookings-header-text h1 {
                font-size: 27px;
            }

            .booking-card {
                padding: 19px;
            }

            .booking-details {
                grid-template-columns: 1fr;
            }

            .booking-bottom {
                align-items: flex-start;
                flex-direction: column;
            }

            .view-button {
                width: 100%;
                box-sizing: border-box;
            }

        }

    </style>

</head>

<body class="user-page">

<%@ include file="../../common/header.jsp" %>

<main class="bookings-page">

    <!-- =====================================================
         HEADER
         ===================================================== -->

    <div class="bookings-header">

        <div class="bookings-header-text">

            <p class="section-kicker">YOUR TRAVEL JOURNEY</p>

            <h1>My Bookings</h1>

            <p>
                View and manage all your travel bookings in one place.
            </p>

        </div>

        <div class="bookings-count">

            <c:choose>

                <c:when test="${statusFilter == 'active'}">
                    Showing active trips
                </c:when>

                <c:when test="${statusFilter == 'confirmed'}">
                    Showing confirmed trips
                </c:when>

                <c:otherwise>
                    Showing all bookings
                </c:otherwise>

            </c:choose>

        </div>

    </div>


    <!-- =====================================================
         FILTERS
         ===================================================== -->

    <div class="booking-filters">

        <a href="${pageContext.request.contextPath}/user-bookings"
           class="booking-filter ${empty statusFilter ? 'active' : ''}">
            All Bookings
        </a>

        <a href="${pageContext.request.contextPath}/user-bookings?status=active"
           class="booking-filter ${statusFilter == 'active' ? 'active' : ''}">
            Active Trips
        </a>

        <a href="${pageContext.request.contextPath}/user-bookings?status=confirmed"
           class="booking-filter ${statusFilter == 'confirmed' ? 'active' : ''}">
            Confirmed Trips
        </a>

    </div>


    <!-- =====================================================
         ERROR
         ===================================================== -->

    <c:if test="${not empty loadError}">

        <div class="booking-error">

            <span>!</span>

            <c:out value="${loadError}"/>

        </div>

    </c:if>


    <!-- =====================================================
         NO BOOKINGS
         ===================================================== -->

    <c:choose>

        <c:when test="${empty bookings}">

            <div class="no-bookings">

                <div class="empty-icon">
                    ✈
                </div>

                <h2>
                    No bookings found
                </h2>

                <p>

                    <c:choose>

                        <c:when test="${statusFilter == 'active'}">
                            You currently have no active trips.
                        </c:when>

                        <c:when test="${statusFilter == 'confirmed'}">
                            You currently have no confirmed trips.
                        </c:when>

                        <c:otherwise>
                            You haven't made any bookings yet.
                            Explore our destinations and plan your next journey.
                        </c:otherwise>

                    </c:choose>

                </p>

                <a class="browse-button"
                   href="${pageContext.request.contextPath}/destinations">

                    Explore Destinations →

                </a>

            </div>

        </c:when>


        <c:otherwise>

            <!-- =================================================
                 BOOKINGS LIST
                 ================================================= -->

            <div class="booking-list">

                <c:forEach var="booking" items="${bookings}">

                    <article class="booking-card">

                        <!-- TOP -->

                        <div class="booking-top">

                            <div class="booking-title">

                                <h2>
                                    <c:out value="${booking.packageName}"/>
                                </h2>

                                <div class="booking-reference">

                                    Booking Reference:

                                    <strong>
                                        <c:out value="${booking.reference}"/>
                                    </strong>

                                </div>

                            </div>


                            <c:set var="status"
                                   value="${empty booking.status ? 'pending' : booking.status}"/>

                            <span class="status status-${status}">

                                <c:out value="${status}"/>

                            </span>

                        </div>


                        <!-- DETAILS -->

                        <div class="booking-details">

                            <div class="detail-item">

                                <span class="detail-label">
                                    Travel Date
                                </span>

                                <span class="detail-value">

                                    <c:choose>

                                        <c:when test="${not empty booking.travelDate}">
                                            <c:out value="${booking.travelDate}"/>
                                        </c:when>

                                        <c:otherwise>
                                            Not specified
                                        </c:otherwise>

                                    </c:choose>

                                </span>

                            </div>


                            <div class="detail-item">

                                <span class="detail-label">
                                    Travelers
                                </span>

                                <span class="detail-value">
                                    <c:out value="${booking.travelers}"/>
                                </span>

                            </div>


                            <div class="detail-item">

                                <span class="detail-label">
                                    Departure
                                </span>

                                <span class="detail-value">

                                    <c:choose>

                                        <c:when test="${not empty booking.departureCity}">
                                            <c:out value="${booking.departureCity}"/>
                                        </c:when>

                                        <c:otherwise>
                                            —
                                        </c:otherwise>

                                    </c:choose>

                                </span>

                            </div>


                            <div class="detail-item">

                                <span class="detail-label">
                                    Duration
                                </span>

                                <span class="detail-value">

                                    <c:out value="${booking.duration}"/>

                                    <c:choose>

                                        <c:when test="${booking.duration == 1}">
                                            day
                                        </c:when>

                                        <c:otherwise>
                                            days
                                        </c:otherwise>

                                    </c:choose>

                                </span>

                            </div>

                        </div>


                        <!-- BOTTOM -->

                        <div class="booking-bottom">

                            <div class="total-price">

                                <span class="total-label">
                                    Total Booking Amount
                                </span>

                                <span class="total-value">

                                    ₹<c:out value="${booking.totalPrice}"/>

                                </span>

                            </div>


                            <a class="view-button"
                               href="${pageContext.request.contextPath}/booking-details?reference=${booking.reference}">

                                View Details →

                            </a>

                        </div>

                    </article>

                </c:forEach>

            </div>

        </c:otherwise>

    </c:choose>

</main>


<%@ include file="../../common/footer.jsp" %>

</body>

</html>