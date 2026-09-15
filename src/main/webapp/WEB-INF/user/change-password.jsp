<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
</head>
<body class="user-page">

<%@ include file="/common/header.jsp" %>

<main class="user-dashboard-page profile-page">
    <section class="dashboard-hero compact-hero">
        <div class="dashboard-container dashboard-hero-inner">
            <div>
                <p class="dashboard-eyebrow">ACCOUNT SECURITY</p>
                <h1>Change your password</h1>
                <p class="dashboard-subtitle">Use a strong password to keep your TravelTourism account secure.</p>
            </div>
        </div>
    </section>

    <div class="dashboard-container form-page-content narrow-form-content">
        <a href="${pageContext.request.contextPath}/user-dashboard" class="back-link">← Back to Dashboard</a>

        <div class="profile-form-card">
            <div class="form-card-heading">
                <div class="security-large-icon">🔒</div>
                <div>
                    <p class="section-kicker">PASSWORD & SECURITY</p>
                    <h2>Update your password</h2>
                    <p>Enter your current password and choose a new password for your account.</p>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="dashboard-alert error-alert">
                    <span>!</span>
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/change-password" method="post" class="profile-form">
                <input type="hidden" name="csrfToken" value="<c:out value='${sessionScope.passwordCsrfToken}'/>">

                <div class="form-field">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" required autocomplete="current-password">
                </div>

                <div class="form-field">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required minlength="8" autocomplete="new-password">
                </div>

                <div class="form-field">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8" autocomplete="new-password">
                </div>

                <div class="password-rules">
                    <strong>Password requirements</strong>
                    <ul>
                        <li>At least 8 characters</li>
                        <li>One uppercase letter</li>
                        <li>One lowercase letter</li>
                        <li>One number</li>
                        <li>One special character</li>
                    </ul>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/user-dashboard" class="secondary-form-btn">Cancel</a>
                    <button type="submit" class="dashboard-primary-btn">Change Password <span>→</span></button>
                </div>
            </form>
        </div>
    </div>
</main>

<%@ include file="/common/footer.jsp" %>

</body>
</html>
