<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty receipt}"><c:redirect url="/booking-confirmation"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Booking Request Received | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking.css?v=3">
</head>
<body>
<%@ include file="common/header.jsp" %>
<main class="booking-container">
    <p class="booking-eyebrow">THANK YOU FOR TRAVELLING WITH US</p>
    <h1>Booking request received</h1>
    <p>Your request has been saved. Availability and requested changes are pending confirmation.</p>
    <p class="booking-reference">Reference: <strong><c:out value="${receipt.reference}"/></strong></p>
    <section class="booking-summary">
        <h2><c:out value="${receipt.name}"/></h2>
        <p><strong>Traveller:</strong> <c:out value="${receipt.customerName}"/></p>
        <p><strong>Email:</strong> <c:out value="${receipt.email}"/></p>
        <p><strong>Phone:</strong> <c:out value="${receipt.phone}"/></p>
        <p><strong>Departure:</strong> <c:out value="${receipt.departure}"/> · <c:out value="${receipt.date}"/></p>
        <p><strong>Duration:</strong> ${receipt.duration} days · <strong>Travellers:</strong> ${receipt.travelers}</p>
        <p><strong>Price per person:</strong> ₹<fmt:formatNumber value="${receipt.price}"/></p>
        <p><strong>Estimated total:</strong> ₹<fmt:formatNumber value="${receipt.total}"/></p>
        <c:if test="${not empty receipt.preferences}"><p class="booking-preferences"><strong>Your preferences:</strong> <c:out value="${receipt.preferences}"/></p></c:if>
    </section>
    <a class="booking-submit" href="${pageContext.request.contextPath}/customize">Explore customized holidays</a>
</main>
<%@ include file="common/footer.jsp" %>
</body>
</html>
