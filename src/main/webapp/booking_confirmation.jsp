<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <title>Booking Confirmation | TravelTourism</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
        }

        .confirmation-container {
            width: 700px;
            margin: 50px auto;
            background: white;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .success {
            text-align: center;
            margin-bottom: 30px;
        }

        .success h1 {
            color: #1b7f3a;
        }

        .booking-details {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
        }

        .booking-details p {
            margin: 10px 0;
        }

        .home-button {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 20px;
            background: #f28c28;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

    </style>

</head>

<body>

    <%@ include file="common/header.jsp" %>

    <div class="confirmation-container">

        <div class="success">

            <h1>Booking Confirmed!</h1>

            <p>
                Thank you for booking with TravelTourism.
            </p>

        </div>


        <div class="booking-details">

            <h2>Booking Details</h2>

            <p>
                <strong>Name:</strong>
                ${param.customerName}
            </p>

            <p>
                <strong>Email:</strong>
                ${param.email}
            </p>

            <p>
                <strong>Phone:</strong>
                ${param.phone}
            </p>

            <p>
                <strong>Tour:</strong>
                ${param.tourName}
            </p>

            <p>
                <strong>Departure:</strong>
                ${param.departure}
            </p>

            <p>
                <strong>Duration:</strong>
                ${param.duration} days
            </p>

            <p>
                <strong>Number of Travelers:</strong>
                ${param.travelers}
            </p>

            <p>
                <strong>Travel Date:</strong>
                ${param.travelDate}
            </p>

            <p>
                <strong>Price per person:</strong>
                ₹${param.price}
            </p>

        </div>


        <a href="${pageContext.request.contextPath}/index.jsp"
           class="home-button">
            Back to Home
        </a>

    </div>

    <%@ include file="common/footer.jsp" %>

</body>

</html>