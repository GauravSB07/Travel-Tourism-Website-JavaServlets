<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Book Your Tour | TravelTourism</title>

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
            max-width: 90%;
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

        .tour-details h2 {
            margin-top: 0;
            margin-bottom: 15px;
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
            border: 1px solid #ccc;
            border-radius: 5px;
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


        <!-- SELECTED TOUR DETAILS -->

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
                ₹${param.price} per person
            </p>

        </div>


        <!-- BOOKING FORM -->

        <form action="${pageContext.request.contextPath}/booking_confirmation.jsp"
              method="post">


            <!-- TOUR INFORMATION -->

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


            <!-- CUSTOMER INFORMATION -->

            <div class="form-group">

                <label for="customerName">
                    Full Name
                </label>

                <input type="text"
                       id="customerName"
                       name="customerName"
                       required>

            </div>


            <div class="form-group">

                <label for="email">
                    Email
                </label>

                <input type="email"
                       id="email"
                       name="email"
                       required>

            </div>


            <div class="form-group">

                <label for="phone">
                    Phone Number
                </label>

                <input type="tel"
                       id="phone"
                       name="phone"
                       required>

            </div>


            <div class="form-group">

                <label for="travelers">
                    Number of Travelers
                </label>

                <input type="number"
                       id="travelers"
                       name="travelers"
                       min="1"
                       value="1"
                       required>

            </div>


            <div class="form-group">

                <label for="travelDate">
                    Travel Date
                </label>

                <input type="date"
                       id="travelDate"
                       name="travelDate"
                       required>

            </div>


            <button type="submit"
                    class="book-button">

                Confirm Booking

            </button>

        </form>

    </div>


    <%@ include file="common/footer.jsp" %>

</body>

</html>