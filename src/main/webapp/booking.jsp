<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty selection}"><c:redirect url="/booking"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Book Your Holiday | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking.css">
</head>
<body>
<%@ include file="common/header.jsp" %>
<main class="booking-container">
    <a class="booking-back" href="${pageContext.request.contextPath}/${selection.type == 'holiday' ? 'customize' : 'destinations'}">← Explore more packages</a>
    <p class="booking-eyebrow">YOUR NEXT JOURNEY</p>
    <h1>Book your ${selection.type == 'holiday' ? 'customized holiday' : 'tour'}</h1>
    <section class="booking-summary" aria-label="Selected package">
        <h2><c:out value="${selection.name}"/></h2>
        <p>From <strong><c:out value="${selection.departure}"/></strong> · ${selection.duration} days</p>
        <p>₹<fmt:formatNumber value="${selection.price}"/> per person</p>
        <c:if test="${selection.type == 'holiday'}"><p><c:out value="${selection.occasion}"/></p></c:if>
    </section>
    <c:if test="${not empty error}"><p class="booking-error" role="alert"><c:out value="${error}"/></p></c:if>
    <form action="${pageContext.request.contextPath}/booking-confirmation" method="post">
        <input type="hidden" name="bookingToken" value="<c:out value='${sessionScope.bookingToken}'/>">
        <input type="hidden" name="${selection.type == 'holiday' ? 'holiday_id' : 'tour_id'}" value="<c:out value='${selection.id}'/>">
        <div class="booking-grid">
            <div class="booking-field"><label for="customerName">Full name</label><input id="customerName" name="customerName" autocomplete="name" maxlength="120" value="<c:out value='${param.customerName}'/>" required></div>
            <div class="booking-field"><label for="email">Email</label><input id="email" name="email" type="email" autocomplete="email" maxlength="254" value="<c:out value='${param.email}'/>" required></div>
            <div class="booking-field"><label for="phone">Phone number</label><input id="phone" name="phone" type="tel" autocomplete="tel" minlength="7" maxlength="30" value="<c:out value='${param.phone}'/>" required></div>
            <div class="booking-field"><label for="travelers">Number of travellers</label><input id="travelers" name="travelers" type="number" min="1" max="30" value="<c:out value='${empty param.travelers ? 1 : param.travelers}'/>" required></div>
            <div class="booking-field"><label for="travelDate">Departure date</label><input id="travelDate" name="travelDate" type="date" min="${today}" value="<c:out value='${param.travelDate}'/>" required></div>
        </div>
        <c:if test="${selection.type == 'holiday'}"><p class="booking-help">Choose your preferred travel date and tell us how you would like to celebrate. Availability will be confirmed with you.</p></c:if>
        <div class="booking-field"><label for="preferences">Make it yours <span>(optional)</span></label><textarea id="preferences" name="preferences" rows="4" maxlength="2000" placeholder="Tell us about dietary needs, room preferences, accessibility requirements or itinerary changes."><c:out value="${param.preferences}"/></textarea></div>
        <p class="booking-total">Estimated package total: <strong id="bookingTotal" data-price="${selection.price}">₹<fmt:formatNumber value="${selection.price}"/> for one traveller</strong></p>
        <p class="booking-help">Submit a booking request for this package. Availability and any requested changes will be confirmed separately. No payment is collected here.</p>
        <button class="booking-submit" type="submit">Submit booking request</button>
    </form>
</main>
<%@ include file="common/footer.jsp" %>
<script>
(function () {
    const travelers = document.getElementById('travelers');
    const total = document.getElementById('bookingTotal');
    function update() {
        const count = Number(travelers.value);
        total.textContent = Number.isInteger(count) && count >= 1 && count <= 30
            ? new Intl.NumberFormat('en-IN', {style: 'currency', currency: 'INR', maximumFractionDigits: 0}).format(count * Number(total.dataset.price))
            : 'Choose 1–30 travellers';
    }
    travelers.addEventListener('input', update);
    update();
})();
</script>
</body>
</html>
