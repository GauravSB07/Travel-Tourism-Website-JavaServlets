<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Contact Us | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            color: #333;
        }


        /* HERO SECTION */

        .contact-hero {
            height: 300px;

            background:
                linear-gradient(
                    rgba(0, 0, 0, 0.45),
                    rgba(0, 0, 0, 0.45)
                ),
                url('${pageContext.request.contextPath}/images/contact-bg.jpg');

            background-size: cover;
            background-position: center;

            display: flex;
            flex-direction: column;

            justify-content: center;
            align-items: center;

            text-align: center;

            color: white;
        }

        .contact-hero h1 {
            font-size: 46px;
            margin: 0 0 12px;
        }

        .contact-hero p {
            font-size: 18px;
            max-width: 650px;
            line-height: 1.6;
        }


        /* MAIN CONTACT SECTION */

        .contact-section {
            max-width: 1100px;

            margin: 50px auto;

            padding: 0 25px;

            display: grid;

            grid-template-columns: 1fr 1.3fr;

            gap: 30px;

            align-items: start;
        }


        /* CONTACT INFORMATION */

        .contact-info {
            background: white;

            padding: 30px;

            border-radius: 12px;

            box-shadow:
                0 3px 12px rgba(0, 0, 0, 0.08);
        }

        .contact-info h2 {
            margin-top: 0;

            font-size: 28px;

            margin-bottom: 10px;
        }

        .contact-info > p {
            color: #666;

            line-height: 1.6;

            margin-bottom: 25px;
        }


        /* CONTACT ITEM */

        .contact-item {
            display: flex;

            gap: 15px;

            margin-bottom: 25px;

            align-items: flex-start;
        }

        .contact-icon {
            width: 42px;

            height: 42px;

            min-width: 42px;

            border-radius: 50%;

            background: #fff1e4;

            display: flex;

            justify-content: center;

            align-items: center;

            font-size: 20px;
        }

        .contact-item h3 {
            margin: 0 0 5px;

            font-size: 16px;
        }

        .contact-item p {
            margin: 0;

            color: #666;

            line-height: 1.5;

            font-size: 14px;
        }


        /* CONTACT FORM */

        .contact-form {
            background: white;

            padding: 30px;

            border-radius: 12px;

            box-shadow:
                0 3px 12px rgba(0, 0, 0, 0.08);
        }

        .contact-form h2 {
            margin-top: 0;

            font-size: 28px;

            margin-bottom: 25px;
        }


        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;

            font-weight: bold;

            margin-bottom: 7px;

            font-size: 14px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {

            width: 100%;

            box-sizing: border-box;

            padding: 11px;

            border: 1px solid #ccc;

            border-radius: 6px;

            font-family: Arial, sans-serif;

            font-size: 14px;

            outline: none;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {

            border-color: #f28c28;

        }

        .form-group textarea {

            height: 140px;

            resize: vertical;

        }


        /* SUBMIT BUTTON */

        .submit-button {

            border: none;

            padding: 12px 28px;

            background: #f28c28;

            color: white;

            border-radius: 6px;

            font-size: 15px;

            font-weight: bold;

            cursor: pointer;
        }

        .submit-button:hover {

            background: #e07815;

        }


        /* BUSINESS HOURS */

        .hours-section {

            max-width: 1100px;

            margin: 0 auto 50px;

            padding: 0 25px;

        }

        .hours-card {

            background: #102d47;

            color: white;

            padding: 30px;

            border-radius: 12px;

            text-align: center;

        }

        .hours-card h2 {

            margin-top: 0;

            font-size: 28px;

        }

        .hours-card p {

            color: #d6e0e8;

            line-height: 1.7;

            margin: 5px 0;

        }


        /* RESPONSIVE */

        @media (max-width: 800px) {

            .contact-section {

                grid-template-columns: 1fr;

            }

            .contact-hero h1 {

                font-size: 36px;

            }

        }

    </style>

</head>


<body>


    <%@ include file="common/header.jsp" %>


    <!-- HERO SECTION -->

    <section class="contact-hero">

        <h1>Contact Us</h1>

        <p>
            Have a question about your trip?
            Our travel support team is here to help.
        </p>

    </section>


    <!-- CONTACT SECTION -->

    <section class="contact-section">


        <!-- CONTACT INFORMATION -->

        <div class="contact-info">

            <h2>Get In Touch</h2>

            <p>
                Whether you need help planning your trip,
                have a question about a tour, or need assistance
                with a booking, feel free to contact us.
            </p>


            <!-- ADDRESS -->

            <div class="contact-item">

                <div class="contact-icon">
                    📍
                </div>

                <div>

                    <h3>Our Office</h3>

                    <p>
                        Mumbai, Maharashtra, India
                    </p>

                </div>

            </div>


            <!-- PHONE -->

            <div class="contact-item">

                <div class="contact-icon">
                    📞
                </div>

                <div>

                    <h3>Phone</h3>

                    <p>
                        +91 XXXXX XXXXX
                    </p>

                </div>

            </div>


            <!-- EMAIL -->

            <div class="contact-item">

                <div class="contact-icon">
                    ✉️
                </div>

                <div>

                    <h3>Email</h3>

                    <p>
                        info@traveltourism.com
                    </p>

                </div>

            </div>


            <!-- SUPPORT -->

            <div class="contact-item">

                <div class="contact-icon">
                    💬
                </div>

                <div>

                    <h3>Customer Support</h3>

                    <p>
                        Our team is available to assist you
                        with your travel requirements.
                    </p>

                </div>

            </div>

        </div>


        <!-- CONTACT FORM -->

        <div class="contact-form">

            <h2>Send Us a Message</h2>


            <form action="#" method="post">


                <!-- NAME -->

                <div class="form-group">

                    <label for="name">
                        Full Name
                    </label>

                    <input type="text"
                           id="name"
                           name="name"
                           placeholder="Enter your name"
                           required>

                </div>


                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="Enter your email"
                           required>

                </div>


                <!-- PHONE -->

                <div class="form-group">

                    <label for="phone">
                        Phone Number
                    </label>

                    <input type="tel"
                           id="phone"
                           name="phone"
                           placeholder="Enter your phone number"
                           required>

                </div>


                <!-- SUBJECT -->

                <div class="form-group">

                    <label for="subject">
                        Subject
                    </label>

                    <select id="subject"
                            name="subject">

                        <option value="">
                            Select a subject
                        </option>

                        <option value="booking">
                            Booking Enquiry
                        </option>

                        <option value="tour">
                            Tour Information
                        </option>

                        <option value="customized">
                            Customized Holiday
                        </option>

                        <option value="support">
                            Customer Support
                        </option>

                        <option value="other">
                            Other
                        </option>

                    </select>

                </div>


                <!-- MESSAGE -->

                <div class="form-group">

                    <label for="message">
                        Message
                    </label>

                    <textarea id="message"
                              name="message"
                              placeholder="Write your message here..."
                              required></textarea>

                </div>


                <!-- SUBMIT -->

                <button type="submit"
                        class="submit-button">

                    Send Message

                </button>


            </form>

        </div>


    </section>


    <!-- BUSINESS HOURS -->

    <section class="hours-section">

        <div class="hours-card">

            <h2>Customer Support Hours</h2>

            <p>
                Monday – Saturday: 9:00 AM – 7:00 PM
            </p>

            <p>
                Sunday: 10:00 AM – 5:00 PM
            </p>

            <p>
                We aim to respond to all enquiries
                as soon as possible.
            </p>

        </div>

    </section>


    <%@ include file="common/footer.jsp" %>


</body>

</html>