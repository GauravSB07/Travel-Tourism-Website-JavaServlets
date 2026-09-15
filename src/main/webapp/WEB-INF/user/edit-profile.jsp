<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
</head>
<body class="user-page">

<%@ include file="/common/header.jsp" %>

<main class="user-dashboard-page profile-page">
    <section class="dashboard-hero compact-hero">
        <div class="dashboard-container dashboard-hero-inner">
            <div>
                <p class="dashboard-eyebrow">ACCOUNT SETTINGS</p>
                <h1>Edit your profile</h1>
                <p class="dashboard-subtitle">Keep your contact details up to date for a smoother travel experience.</p>
            </div>
        </div>
    </section>

    <div class="dashboard-container form-page-content">
        <a href="${pageContext.request.contextPath}/user-dashboard" class="back-link">← Back to Dashboard</a>

        <div class="profile-form-card">
            <div class="form-card-heading">
                <div class="profile-avatar large-avatar">
                    <c:out value="${empty fullName ? '?' : fullName.substring(0,1).toUpperCase()}"/>
                </div>
                <div>
                    <p class="section-kicker">PERSONAL INFORMATION</p>
                    <h2>Update your details</h2>
                    <p>These details are used to make your booking and enquiry experience easier.</p>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="dashboard-alert error-alert">
                    <span>!</span>
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/edit-profile" method="post" class="profile-form">
                <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.profileCsrfToken}'/>">

                <div class="form-grid">
                    <div class="form-field full-width">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" maxlength="100" required
                               value="<c:out value='${fullName}'/>" autocomplete="name">
                    </div>

                    <div class="form-field">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" maxlength="150" required
                               value="<c:out value='${email}'/>" autocomplete="email">
                    </div>

                    <div class="form-field">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" maxlength="30" required
                               value="<c:out value='${phone}'/>" autocomplete="tel"
                               placeholder="e.g. +91 9876543210">
                    </div>
                </div>

                <div class="form-note">
                    <span>ⓘ</span>
                    <p>Your email must be unique to your TravelTourism account.</p>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/user-dashboard" class="secondary-form-btn">Cancel</a>
                    <button type="submit" class="dashboard-primary-btn">Save Changes <span>→</span></button>
                </div>
            </form>
        </div>
    </div>
</main>

<%@ include file="/common/footer.jsp" %>

</body>
</html>
