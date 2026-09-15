<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Booking Details | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/user-dashboard.css">

    <style>

        /* =====================================================
           BOOKING DETAILS
           ===================================================== */

        .booking-details-page {
            width: 92%;
            max-width: 1100px;
            margin: 0 auto;
            padding: 42px 0 70px;
        }

        .details-back {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            margin-bottom: 23px;
            color: #687786;
            font-size: 12px;
            font-weight: 650;
            text-decoration: none;
        }

        .details-back:hover {
            color: #e88a3d;
        }

        .details-header {
            margin-bottom: 25px;
        }

        .details-header h1 {
            margin: 0 0 8px;
            color: #173f5f;
            font-size: 32px;
            line-height: 1.2;
        }

        .details-header p {
            margin: 0;
            color: #7a8795;
            font-size: 13px;
            line-height: 1.6;
        }

        /* =====================================================
           ERROR
           ===================================================== */

        .error-box {
            margin-bottom: 22px;
            padding: 14px 17px;
            border: 1px solid #f0cdca;
            border-radius: 8px;
            background: #fff1f0;
            color: #9f3028;
            font-size: 13px;
        }

        /* =====================================================
           MAIN CARD
           ===================================================== */

        .booking-details-card {
            background: #ffffff;
            border: 1px solid #e5e9ee;
            border-radius: 11px;
            box-shadow: 0 5px 22px rgba(23, 63, 95, 0.05);
            overflow: hidden;
        }

        /* =====================================================
           BOOKING HEADER
           ===================================================== */

        .booking-main-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 25px;
            padding: 27px;
            background: linear-gradient(
                120deg,
                #ffffff 0%,
                #fbfaf8 100%
            );
            border-bottom: 1px solid #edf0f3;
        }

        .package-info h2 {
            margin: 0 0 8px;
            color: #173f5f;
            font-size: 25px;
            line-height: 1.3;
        }

        .reference {
            color: #8a949f;
            font-size: 11px;
        }

        .reference strong {
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
            min-height: 31px;
            padding: 0 13px;
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
           SECTIONS
           ===================================================== */

        .booking-section {
            padding: 26px 27px;
            border-bottom: 1px solid #edf0f3;
        }

        .booking-section:last-child {
            border-bottom: none;
        }

        .section-title {
            margin: 0 0 19px;
            color: #173f5f;
            font-size: 17px;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
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
            line-height: 1.45;
        }

        .empty-value {
            color: #9aa3ac;
            font-weight: 400;
        }

        /* =====================================================
           PRICE
           ===================================================== */

        .price-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            padding: 18px 20px;
            border: 1px solid #eee4da;
            border-radius: 9px;
            background: #fffaf5;
        }

        .price-label {
            color: #6e6259;
            font-size: 12px;
        }

        .price-value {
            color: #173f5f;
            font-size: 23px;
            font-weight: 700;
        }

        /* =====================================================
           NOTES
           ===================================================== */

        .notes-box {
            padding: 15px 17px;
            border: 1px solid #edf0f3;
            border-radius: 8px;
            background: #f8f9fa;
            color: #53616d;
            font-size: 12px;
            line-height: 1.65;
            white-space: pre-wrap;
            overflow-wrap: anywhere;
        }

        .admin-note {
            background: #fffaf5;
            border-color: #eee4da;
        }

        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 800px) {

            .details-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .booking-main-header {
                flex-direction: column;
            }

        }

        @media (max-width: 550px) {

            .booking-details-page {
                width: 90%;
                padding-top: 30px;
            }

            .details-header h1 {
                font-size: 27px;
            }

            .booking-main-header,
            .booking-section {
                padding: 21px;
            }

            .details-grid {
                grid-template-columns: 1fr;
                gap: 17px;
            }

            .price-box {
                align-items: flex-start;
                flex-direction: column;
                gap: 7px;
            }

        }

    </style>

</head>

<body class="user-page">

<%@ include file="../../common/header.jsp" %>

<main class="booking-details-page">

    <!-- BACK -->

    <a class="details-back"
       href="${pageContext.request.contextPath}/user-bookings">

        ← Back to My Bookings

    </a>


    <!-- HEADER -->

    <div class="details-header">

        <p class="section-kicker">
            YOUR TRAVEL JOURNEY
        </p>

        <h1>
            Booking Details
        </h1>

        <p>
            View the complete information for your selected booking.
        </p>

    </div>


    <!-- ERROR -->

    <c:if test="${not empty bookingError}">

        <div class="error-box">

            <c:out value="${bookingError}"/>

        </div>

    </c:if>


    <!-- BOOKING -->

    <c:if test="${not empty booking}">

        <div class="booking-details-card">


            <!-- =================================================
                 BOOKING HEADER
                 ================================================= -->

            <div class="booking-main-header">

                <div class="package-info">

                    <h2>
                        <c:out value="${booking.packageName}"/>
                    </h2>

                    <div class="reference">

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


            <!-- =================================================
                 TRIP INFORMATION
                 ================================================= -->

            <section class="booking-section">

                <h3 class="section-title">
                    Trip Information
                </h3>


                <div class="details-grid">


                    <div class="detail-item">

                        <span class="detail-label">
                            Package
                        </span>

                        <span class="detail-value">
                            <c:out value="${booking.packageName}"/>
                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Package Type
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.packageType}">
                                    <c:out value="${booking.packageType}"/>
                                </c:when>

                                <c:otherwise>—</c:otherwise>

                            </c:choose>

                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Departure City
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.departureCity}">
                                    <c:out value="${booking.departureCity}"/>
                                </c:when>

                                <c:otherwise>—</c:otherwise>

                            </c:choose>

                        </span>

                    </div>


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


                    <div class="detail-item">

                        <span class="detail-label">
                            Travelers
                        </span>

                        <span class="detail-value">
                            <c:out value="${booking.travelers}"/>
                        </span>

                    </div>


                </div>

            </section>


            <!-- =================================================
                 CUSTOMER INFORMATION
                 ================================================= -->

            <section class="booking-section">

                <h3 class="section-title">
                    Customer Information
                </h3>


                <div class="details-grid">


                    <div class="detail-item">

                        <span class="detail-label">
                            Name
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.customerName}">
                                    <c:out value="${booking.customerName}"/>
                                </c:when>

                                <c:otherwise>—</c:otherwise>

                            </c:choose>

                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Email
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.email}">
                                    <c:out value="${booking.email}"/>
                                </c:when>

                                <c:otherwise>—</c:otherwise>

                            </c:choose>

                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Phone
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.phone}">
                                    <c:out value="${booking.phone}"/>
                                </c:when>

                                <c:otherwise>—</c:otherwise>

                            </c:choose>

                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Contact Preference
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.contactPreference}">
                                    <c:out value="${booking.contactPreference}"/>
                                </c:when>

                                <c:otherwise>—</c:otherwise>

                            </c:choose>

                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Pickup Location
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.pickupLocation}">
                                    <c:out value="${booking.pickupLocation}"/>
                                </c:when>

                                <c:otherwise>
                                    Not specified
                                </c:otherwise>

                            </c:choose>

                        </span>

                    </div>


                </div>

            </section>


            <!-- =================================================
                 PAYMENT
                 ================================================= -->

            <section class="booking-section">

                <h3 class="section-title">
                    Payment Summary
                </h3>


                <div class="details-grid"
                     style="margin-bottom: 19px;">


                    <div class="detail-item">

                        <span class="detail-label">
                            Price Per Person
                        </span>

                        <span class="detail-value">

                            ₹<c:out value="${booking.pricePerPerson}"/>

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


                </div>


                <div class="price-box">

                    <span class="price-label">
                        Total Booking Amount
                    </span>

                    <span class="price-value">

                        ₹<c:out value="${booking.totalPrice}"/>

                    </span>

                </div>

            </section>


            <!-- =================================================
                 SPECIAL PREFERENCES
                 ================================================= -->

            <c:if test="${not empty booking.preferences}">

                <section class="booking-section">

                    <h3 class="section-title">
                        Special Preferences
                    </h3>

                    <div class="notes-box">

                        <c:out value="${booking.preferences}"/>

                    </div>

                </section>

            </c:if>


            <!-- =================================================
                 ADMIN NOTES
                 ================================================= -->

            <c:if test="${not empty booking.adminNotes}">

                <section class="booking-section">

                    <h3 class="section-title">
                        Update from Travel Team
                    </h3>

                    <div class="notes-box admin-note">

                        <c:out value="${booking.adminNotes}"/>

                    </div>

                </section>

            </c:if>


            <!-- =================================================
                 BOOKING INFORMATION
                 ================================================= -->

            <section class="booking-section">

                <h3 class="section-title">
                    Booking Information
                </h3>


                <div class="details-grid">


                    <div class="detail-item">

                        <span class="detail-label">
                            Booking Created
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.createdAt}">
                                    <c:out value="${booking.createdAt}"/>
                                </c:when>

                                <c:otherwise>—</c:otherwise>

                            </c:choose>

                        </span>

                    </div>


                    <div class="detail-item">

                        <span class="detail-label">
                            Last Updated
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty booking.updatedAt}">
                                    <c:out value="${booking.updatedAt}"/>
                                </c:when>

                                <c:otherwise>—</c:otherwise>

                            </c:choose>

                        </span>

                    </div>


                    <c:if test="${not empty booking.followUpDate}">

                        <div class="detail-item">

                            <span class="detail-label">
                                Follow-up Date
                            </span>

                            <span class="detail-value">
                                <c:out value="${booking.followUpDate}"/>
                            </span>

                        </div>

                    </c:if>


                </div>

            </section>


        </div>

    </c:if>

</main>


<%@ include file="../../common/footer.jsp" %>

</body>

</html>