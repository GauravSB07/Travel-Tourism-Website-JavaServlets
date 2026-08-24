<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Talk to a Travel Specialist | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/travel-flow.css">
</head>

<body>

<%@ include file="common/header.jsp" %>

<main class="flow-page">

    <section class="flow-hero">
        <p>WE ARE HERE TO HELP</p>
        <h1>Let’s talk travel</h1>
        <span>Ask a question, request a tailored recommendation, or begin planning today.</span>
    </section>

    <section class="contact-layout">

        <div class="contact-copy">
            <p class="eyebrow">TRAVEL WITH CONFIDENCE</p>
            <h2>Every great trip begins with a conversation.</h2>
            <p>Our travel specialists can help shape the right route, pace and stay for your journey.</p>

            <div class="contact-points">
                <span>✦ Personal itinerary advice</span>
                <span>✦ Transparent planning support</span>
                <span>✦ Assistance from first idea to departure</span>
            </div>
        </div>

        <form class="premium-form" action="${pageContext.request.contextPath}/contact" method="post">

            <c:if test="${submitted}">
                <div class="form-success">
                    Thank you, ${guestName}. Your message is on its way to our team.
                </div>
            </c:if>

            <label>Full name
                <input name="name" required placeholder="Your name">
            </label>

            <label>Email address
                <input type="email" name="email" required placeholder="you@example.com">
            </label>

            <label>How can we help?
                <textarea name="message" rows="6" required placeholder="Tell us about the journey you have in mind"></textarea>
            </label>

            <button class="flow-primary" type="submit">
                Send message <span>→</span>
            </button>

        </form>

    </section>

</main>

<%@ include file="common/footer.jsp" %>

</body>
</html>
