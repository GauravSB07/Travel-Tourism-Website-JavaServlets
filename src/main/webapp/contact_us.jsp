<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="draft" value="${contactDraft}"/>

<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Talk to a Travel Specialist | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/contact-premium.css?v=1">
</head>

<body>

<%@ include file="common/header.jsp" %>

<main class="contact-premium">

    <!-- =========================
         CONTACT HERO
         ========================= -->

    <section class="contact-hero">

        <div class="contact-hero-copy">

            <p class="contact-kicker">
                A JOURNEY STARTS WITH A CONVERSATION
            </p>

            <h1>
                Tell us where<br>
                <em>you want to go.</em>
            </h1>

            <p>
                Share the shape of the trip you have in mind.
                Our team will have the context needed to guide
                your next step.
            </p>

            <a href="#contact-form">
                Start your enquiry <span>↓</span>
            </a>

        </div>

        <div class="contact-hero-aside">

            <span class="contact-monogram">TT</span>

            <blockquote>
                Thoughtful travel begins with listening.
            </blockquote>

            <div>
                <span>Destination advice</span>
                <span>Occasion holidays</span>
                <span>Booking support</span>
            </div>

        </div>

    </section>


    <!-- =========================
         TRUST SECTION
         ========================= -->

    <section class="contact-trust">

        <p>HOW WE CAN HELP</p>

        <div>
            <span>
                <b>01</b> Find the right journey
            </span>

            <span>
                <b>02</b> Shape the details
            </span>

            <span>
                <b>03</b> Plan your next step
            </span>
        </div>

    </section>


    <!-- =========================
         CONTACT WORKSPACE
         ========================= -->

    <section class="contact-workspace" id="contact-form">

        <aside class="contact-story">

            <p class="contact-kicker">
                PLAN WITH CONFIDENCE
            </p>

            <h2>
                Your ideas.<br>
                Our attention.
            </h2>

            <p>
                Whether you are comparing destinations,
                arranging a special occasion or asking
                about a booking, one clear enquiry helps
                us understand what matters to you.
            </p>

            <dl>

                <div>
                    <dt>Response</dt>
                    <dd>
                        Your enquiry is recorded for our
                        team to review.
                    </dd>
                </div>

                <div>
                    <dt>Privacy</dt>
                    <dd>
                        Your details are used to respond
                        to this travel request.
                    </dd>
                </div>

                <div>
                    <dt>No payment</dt>
                    <dd>
                        This form begins a conversation
                        and does not collect payment.
                    </dd>
                </div>

            </dl>

        </aside>


        <!-- =========================
             FORM CARD
             ========================= -->

        <div class="contact-form-card">

            <c:if test="${not empty contactSuccess}">
                <div class="contact-success" role="status">

                    <span>✓</span>

                    <div>
                        <strong>Enquiry received</strong>

                        <p>
                            <c:out value="${contactSuccess}"/>
                        </p>
                    </div>

                </div>
            </c:if>


            <c:if test="${not empty contactError}">
                <div class="contact-error" role="alert">

                    <strong>Please check your enquiry</strong>

                    <p>
                        <c:out value="${contactError}"/>
                    </p>

                </div>
            </c:if>


            <div class="contact-form-heading">

                <p class="contact-kicker">
                    YOUR TRAVEL ENQUIRY
                </p>

                <h2>
                    Let’s begin with the essentials.
                </h2>

                <span>
                    Fields marked * are required
                </span>

            </div>


            <form action="${pageContext.request.contextPath}/contact"
                  method="post">

                <input type="hidden"
                       name="csrf"
                       value="<c:out value='${sessionScope.contactCsrf}'/>">

                <input type="hidden"
                       name="tourId"
                       value="<c:out value='${not empty draft.tourId ? draft.tourId : param.tour_id}'/>">


                <div class="contact-fields">


                    <!-- =========================
                         FULL NAME
                         ========================= -->

                    <label>
                        Full name *

                        <input name="name"
                               autocomplete="name"
                               maxlength="120"

                               value="<c:out value='${not empty draft.name ? draft.name : sessionScope.userName}'/>"

                               placeholder="Your full name"
                               required>
                    </label>


                    <!-- =========================
                         EMAIL
                         ========================= -->

                    <label>
                        Email address *

                        <input type="email"
                               name="email"
                               autocomplete="email"
                               maxlength="254"

                               value="<c:out value='${not empty draft.email ? draft.email : sessionScope.userEmail}'/>"

                               placeholder="you@example.com"
                               required>
                    </label>


                    <!-- =========================
                         PHONE
                         ========================= -->

                    <label>
                        Phone number *

                        <input type="tel"
                               name="phone"
                               autocomplete="tel"
                               minlength="7"
                               maxlength="30"

                               value="<c:out value='${not empty draft.phone ? draft.phone : sessionScope.userPhone}'/>"

                               placeholder="+91 98765 43210"
                               required>
                    </label>


                    <!-- =========================
                         ENQUIRY TYPE
                         ========================= -->

                    <label>
                        How can we help? *

                        <select name="enquiryType" required>

                            <option value="">
                                Choose one
                            </option>

                            <option value="general"
                                <c:if test="${draft.enquiryType == 'general'}">selected</c:if>>
                                General travel advice
                            </option>

                            <option value="destination"
                                <c:if test="${draft.enquiryType == 'destination'}">selected</c:if>>
                                Destination or tour
                            </option>

                            <option value="customized_holiday"
                                <c:if test="${draft.enquiryType == 'customized_holiday'}">selected</c:if>>
                                Customized holiday
                            </option>

                            <option value="existing_booking"
                                <c:if test="${draft.enquiryType == 'existing_booking'}">selected</c:if>>
                                Existing booking
                            </option>

                        </select>
                    </label>


                    <!-- =========================
                         DESTINATION
                         ========================= -->

                    <label>
                        Destination in mind

                        <input name="destination"
                               maxlength="120"
                               value="<c:out value='${draft.destination}'/>"
                               placeholder="For example, Kerala">
                    </label>


                    <!-- =========================
                         TRAVEL MONTH
                         ========================= -->

                    <label>
                        Preferred travel month

                        <input type="month"
                               name="travelMonth"
                               value="<c:out value='${draft.travelMonth}'/>">
                    </label>


                    <!-- =========================
                         TRAVELLERS
                         ========================= -->

                    <label>
                        Number of travellers

                        <input type="number"
                               name="travellers"
                               min="1"
                               max="50"
                               value="<c:out value='${draft.travellers}'/>"
                               placeholder="2">
                    </label>


                    <!-- =========================
                         BUDGET
                         ========================= -->

                    <label>
                        Approximate budget

                        <select name="budget">

                            <option value="">
                                Still deciding
                            </option>

                            <option value="Under ₹25,000"
                                <c:if test="${draft.budget == 'Under ₹25,000'}">selected</c:if>>
                                Under ₹25,000
                            </option>

                            <option value="₹25,000 – ₹50,000"
                                <c:if test="${draft.budget == '₹25,000 – ₹50,000'}">selected</c:if>>
                                ₹25,000 – ₹50,000
                            </option>

                            <option value="₹50,000 – ₹1,00,000"
                                <c:if test="${draft.budget == '₹50,000 – ₹1,00,000'}">selected</c:if>>
                                ₹50,000 – ₹1,00,000
                            </option>

                            <option value="Above ₹1,00,000"
                                <c:if test="${draft.budget == 'Above ₹1,00,000'}">selected</c:if>>
                                Above ₹1,00,000
                            </option>

                        </select>
                    </label>


                    <!-- =========================
                         MESSAGE
                         ========================= -->

                    <label class="contact-message">

                        Tell us about your journey *

                        <textarea name="message"
                                  rows="7"
                                  minlength="10"
                                  maxlength="3000"
                                  placeholder="Occasion, places, preferred pace, room needs or anything else that would help us understand your trip."
                                  required><c:out value="${draft.message}"/></textarea>

                        <small>
                            Up to 3,000 characters
                        </small>

                    </label>

                </div>


                <!-- =========================
                     SUBMIT
                     ========================= -->

                <div class="contact-submit-row">

                    <p>
                        By sending this form, you are asking
                        our team to review and respond to
                        your travel enquiry.
                    </p>

                    <button type="submit">
                        Send my enquiry <span>→</span>
                    </button>

                </div>

            </form>

        </div>

    </section>

</main>

<%@ include file="common/footer.jsp" %>

</body>
</html>
