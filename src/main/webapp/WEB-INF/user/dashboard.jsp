<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Dashboard | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/user-dashboard.css">

</head>


<body class="user-page">

<%@ include file="/common/header.jsp" %>


<main class="user-dashboard-page">


    <!-- ================= DASHBOARD HERO ================= -->

    <section class="dashboard-hero">

        <div class="dashboard-container dashboard-hero-inner">

            <div>

                <p class="dashboard-eyebrow">
                    MY TRAVEL SPACE
                </p>

                <h1>

                    Welcome back,
                    <c:out value="${profile.full_name}"/>
                    !

                    <span>✦</span>

                </h1>

                <p class="dashboard-subtitle">

                    Manage your profile, keep track of your bookings
                    and plan your next journey.

                </p>

            </div>


            <a href="${pageContext.request.contextPath}/destinations"
               class="dashboard-primary-btn">

                Explore Destinations

                <span>→</span>

            </a>

        </div>

    </section>



    <div class="dashboard-container dashboard-content">


        <!-- ================= ALERTS ================= -->

        <c:if test="${not empty sessionScope.profileNotice}">

            <div class="dashboard-alert success-alert">

                <span>✓</span>

                <c:out value="${sessionScope.profileNotice}"/>

                <% session.removeAttribute("profileNotice"); %>

            </div>

        </c:if>


        <c:if test="${not empty sessionScope.passwordNotice}">

            <div class="dashboard-alert success-alert">

                <span>✓</span>

                <c:out value="${sessionScope.passwordNotice}"/>

                <% session.removeAttribute("passwordNotice"); %>

            </div>

        </c:if>


        <c:if test="${not empty loadError}">

            <div class="dashboard-alert error-alert">

                <span>!</span>

                <c:out value="${loadError}"/>

            </div>

        </c:if>



        <!-- ================= QUICK OVERVIEW ================= -->

        <section class="dashboard-section">

            <div class="section-heading-row">

                <div>

                    <p class="section-kicker">
                        YOUR TRAVEL OVERVIEW
                    </p>

                    <h2>
                        Everything in one place
                    </h2>

                </div>

            </div>



            <div class="dashboard-stat-grid">


                <!-- TOTAL BOOKINGS -->

                <a href="${pageContext.request.contextPath}/user-bookings"
                   class="dashboard-stat-card">

                    <div class="stat-icon">
                        ✈
                    </div>

                    <div>

                        <span class="stat-number">

                            <c:out value="${bookingStats.total != null
                                ? bookingStats.total
                                : 0}"/>

                        </span>

                        <span class="stat-label">
                            Total Bookings
                        </span>

                    </div>

                    <span class="stat-arrow">
                        →
                    </span>

                </a>



                <!-- ACTIVE TRIPS -->

                <a href="${pageContext.request.contextPath}/user-bookings?status=active"
                   class="dashboard-stat-card">

                    <div class="stat-icon">
                        ◷
                    </div>

                    <div>

                        <span class="stat-number">

                            <c:out value="${bookingStats.active != null
                                ? bookingStats.active
                                : 0}"/>

                        </span>

                        <span class="stat-label">
                            Active Trips
                        </span>

                    </div>

                    <span class="stat-arrow">
                        →
                    </span>

                </a>



                <!-- CONFIRMED TRIPS -->

                <a href="${pageContext.request.contextPath}/user-bookings?status=confirmed"
                   class="dashboard-stat-card">

                    <div class="stat-icon">
                        ✓
                    </div>

                    <div>

                        <span class="stat-number">

                            <c:out value="${bookingStats.confirmed != null
                                ? bookingStats.confirmed
                                : 0}"/>

                        </span>

                        <span class="stat-label">
                            Confirmed Trips
                        </span>

                    </div>

                    <span class="stat-arrow">
                        →
                    </span>

                </a>



                <!-- SAVED TOURS -->

                <a href="${pageContext.request.contextPath}/saved-tours"
                   class="dashboard-stat-card">

                    <div class="stat-icon">
                        ♡
                    </div>

                    <div>

                        <span class="stat-number">

                            <c:out value="${savedToursCount != null
                                ? savedToursCount
                                : 0}"/>

                        </span>

                        <span class="stat-label">
                            Saved Tours
                        </span>

                    </div>

                    <span class="stat-arrow">
                        →
                    </span>

                </a>



                <!-- PROFILE -->

                <a href="${pageContext.request.contextPath}/edit-profile"
                   class="dashboard-stat-card profile-stat-card">

                    <div class="stat-icon">
                        ♡
                    </div>

                    <div>

                        <span class="stat-number">
                            Profile
                        </span>

                        <span class="stat-label">
                            Keep your details updated
                        </span>

                    </div>

                    <span class="stat-arrow">
                        →
                    </span>

                </a>


            </div>

        </section>



        <!-- ================= PROFILE + QUICK ACTIONS ================= -->

        <section class="dashboard-main-grid">


            <!-- PROFILE CARD -->

            <div class="dashboard-card profile-card">

                <div class="card-heading">

                    <div>

                        <p class="section-kicker">
                            ACCOUNT
                        </p>

                        <h2>
                            My Profile
                        </h2>

                    </div>


                    <a href="${pageContext.request.contextPath}/edit-profile"
                       class="text-action">

                        Edit Profile

                    </a>

                </div>



                <div class="profile-identity">

                    <div class="profile-avatar">

                        <c:out value="${empty profile.full_name
                            ? '?'
                            : profile.full_name.substring(0,1).toUpperCase()}"/>

                    </div>


                    <div>

                        <h3>
                            <c:out value="${profile.full_name}"/>
                        </h3>

                        <p>
                            TravelTourism Member
                        </p>

                    </div>

                </div>



                <div class="profile-details">


                    <div class="detail-row">

                        <span class="detail-label">
                            Email
                        </span>

                        <span class="detail-value">

                            <c:out value="${profile.email}"/>

                        </span>

                    </div>



                    <div class="detail-row">

                        <span class="detail-label">
                            Phone
                        </span>

                        <span class="detail-value">

                            <c:choose>

                                <c:when test="${not empty profile.phone}">

                                    <c:out value="${profile.phone}"/>

                                </c:when>

                                <c:otherwise>

                                    Not added yet

                                </c:otherwise>

                            </c:choose>

                        </span>

                    </div>



                    <div class="detail-row">

                        <span class="detail-label">
                            Member since
                        </span>

                        <span class="detail-value">

                            <fmt:formatDate
                                value="${profile.created_at}"
                                pattern="dd MMM yyyy"/>

                        </span>

                    </div>


                </div>



                <a href="${pageContext.request.contextPath}/change-password"
                   class="security-link">

                    <span>
                        🔒 Change Password
                    </span>

                    <span>
                        →
                    </span>

                </a>

            </div>



            <!-- QUICK ACTIONS -->

            <div class="dashboard-card actions-card">

                <div class="card-heading">

                    <div>

                        <p class="section-kicker">
                            QUICK ACTIONS
                        </p>

                        <h2>
                            Plan your journey
                        </h2>

                    </div>

                </div>



                <div class="action-list">


                    <!-- EXPLORE -->

                    <a href="${pageContext.request.contextPath}/destinations"
                       class="action-item">

                        <span class="action-icon">
                            ⌕
                        </span>

                        <span>

                            <strong>
                                Explore Destinations
                            </strong>

                            <small>
                                Find your next place to visit
                            </small>

                        </span>

                        <span class="action-arrow">
                            →
                        </span>

                    </a>



                    <!-- CUSTOMIZE -->

                    <a href="${pageContext.request.contextPath}/customize"
                       class="action-item">

                        <span class="action-icon">
                            ✦
                        </span>

                        <span>

                            <strong>
                                Customize a Holiday
                            </strong>

                            <small>
                                Create a trip around your preferences
                            </small>

                        </span>

                        <span class="action-arrow">
                            →
                        </span>

                    </a>



                    <!-- MY BOOKINGS -->

                    <a href="${pageContext.request.contextPath}/user-bookings"
                       class="action-item">

                        <span class="action-icon">
                            ✈
                        </span>

                        <span>

                            <strong>
                                My Bookings
                            </strong>

                            <small>
                                View and track your trips
                            </small>

                        </span>

                        <span class="action-arrow">
                            →
                        </span>

                    </a>



                    <!-- SAVED TOURS -->

                    <a href="${pageContext.request.contextPath}/saved-tours"
                       class="action-item">

                        <span class="action-icon">
                            ♡
                        </span>

                        <span>

                            <strong>
                                Saved Tours
                            </strong>

                            <small>
                                View your favourite tours
                            </small>

                        </span>

                        <span class="action-arrow">
                            →
                        </span>

                    </a>



                    <!-- CONTACT -->

                    <a href="${pageContext.request.contextPath}/contact"
                       class="action-item">

                        <span class="action-icon">
                            ✉
                        </span>

                        <span>

                            <strong>
                                Contact a Travel Specialist
                            </strong>

                            <small>
                                Need help planning your trip?
                            </small>

                        </span>

                        <span class="action-arrow">
                            →
                        </span>

                    </a>



                    <!-- LOGOUT -->

                    <a href="${pageContext.request.contextPath}/logout"
                       class="action-item logout-action">

                        <span class="action-icon">
                            ↪
                        </span>

                        <span>

                            <strong>
                                Logout
                            </strong>

                            <small>
                                Sign out of your account
                            </small>

                        </span>

                        <span class="action-arrow">
                            →
                        </span>

                    </a>


                </div>

            </div>

        </section>



        <!-- ================= TRAVEL JOURNEY ================= -->

        <section class="dashboard-card next-features-card">


            <div class="next-feature-copy">

                <p class="section-kicker">
                    YOUR TRAVEL JOURNEY
                </p>


                <h2>
                    Keep your trips organized
                </h2>


                <p>

                    View your bookings, save your favourite tours
                    and keep track of your travel plans —
                    all from one place.

                </p>


                <a href="${pageContext.request.contextPath}/user-bookings"
                   class="dashboard-primary-btn journey-bookings-btn">

                    View My Bookings

                    <span>
                        →
                    </span>

                </a>

            </div>



            <div class="next-feature-pills">

                <a href="${pageContext.request.contextPath}/user-bookings">
                    My Bookings
                </a>

                <a href="${pageContext.request.contextPath}/saved-tours">
                    Saved Tours
                </a>

                <span>
                    My Enquiries
                </span>

                <span>
                    Notifications
                </span>

            </div>


        </section>


    </div>

</main>


<%@ include file="/common/footer.jsp" %>


</body>

</html>