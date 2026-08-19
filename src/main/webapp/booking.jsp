<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <title>Book Your Tour</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
        }

        .booking-container {
            width: 700px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .booking-container h1 {
            margin-bottom: 25px;
        }

        .tour-details {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .tour-details p {
            margin: 8px 0;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }

        .book-button {
            padding: 12px 25px;
            border: none;
            background: #f28c28;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            font-size: 15px;
        }

        .book-button:hover {
            background: #e07815;
        }

    </style>

</head>

<body>

    <%@ include file="common/header.jsp" %>

    <div class="booking-container">

        <h1>Book Your Tour</h1>

        <!-- TOUR DETAILS -->

        <div class="tour-details">

            <h2>${param.name}</h2>

            <p>
                <strong>Departure:</strong>
                ${param.departure}
            </p>

            <p>
                <strong>Duration:</strong>
                ${param.duration} days
            </p>

            <p>
                <strong>Price:</strong>
                ₹${param.price}
            </p>

        </div>


        <!-- BOOKING FORM -->

        <form action="${pageContext.request.contextPath}/booking_confirmation.jsp" method="post">

            <!-- Tour information -->

            <input type="hidden"
                   name="tourName"
                   value="${param.name}">

            <input type="hidden"
                   name="price"
                   value="${param.price}">

            <input type="hidden"
                   name="duration"
                   value="${param.duration}">

            <input type="hidden"
                   name="departure"
                   value="${param.departure}">


            <!-- Customer information -->

            <div class="form-group">

                <label>Full Name</label>

                <input type="text"
                       name="customerName"
                       required>

            </div>


            <div class="form-group">

                <label>Email</label>

                <input type="email"
                       name="email"
                       required>

            </div>


            <div class="form-group">

                <label>Phone Number</label>

                <input type="tel"
                       name="phone"
                       required>

            </div>


            <div class="form-group">

                <label>Number of Travelers</label>

                <input type="number"
                       name="travelers"
                       min="1"
                       required>

            </div>


            <div class="form-group">

                <label>Travel Date</label>

                <input type="date"
                       name="travelDate"
                       required>

            </div>


            <button type="submit" class="book-button">
                Confirm Booking
            </button>

        </form>

    </div>

    <%@ include file="common/footer.jsp" %>

</body>

</html>