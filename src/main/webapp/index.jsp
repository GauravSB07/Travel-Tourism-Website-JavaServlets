<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Travel Tourism</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #fafafa;
        }

        /* TOP BAR (Logo + Search + Phone + Login + Global) */
        .top-bar {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            color: #e63946;
            margin-right: 40px;
        }

        .search-box input {
            width: 300px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .top-right {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .phone {
            font-weight: bold;
            color: #333;
        }

        .login-btn {
            text-decoration: none;
            background-color: #007bff;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 14px;
        }

        .login-btn:hover {
            background-color: #0056b3;
        }

        /* TAB BAR (Your Servlets) */
        .tab-bar {
            display: flex;
            background-color: #1a2b49;
            padding: 12px 20px;
            gap: 30px;
        }

        .tab-bar a {
            text-decoration: none;
            color: #ffffff;
            font-weight: 600;
            font-size: 15px;
        }

        .tab-bar a:hover {
            color: #ffdd57;
        }

        /* PAGE CONTENT */
        .content {
            padding: 20px;
        }
    </style>
</head>

<body>

<!-- ⭐ TOP BAR -->
<div class="top-bar">
    <div class="logo">Travel Tourism</div>

    <div class="search-box">
        <input type="text" placeholder="Search tours, places, packages...">
    </div>

    <div class="top-right">
        <div class="phone">📞 +91 XXXXXXXXXX</div>
        <a class="login-btn" href="#">Login</a>
        <div class="global">🌐 Global</div>
    </div>
</div>

<!-- ⭐ TAB BAR USING YOUR EXACT SERVLET NAMES -->
<div class="tab-bar">
    <a href="HomeServlet">Home</a>
    <a href="DestinationsServlet">Destinations</a>
    <a href="CustomizedHolidaysServlet">Customized Holidays</a>
    <a href="ExperienceServlet">Travel Experiences</a>
    <a href="Contact_usServlet">Contact Us</a>
    <a href="About_usServlet">About Us</a>
</div>

<!-- ⭐ PAGE CONTENT -->
<div class="content">
    <h2>Welcome!</h2>
    <p>This is home page. Use the tabs above to navigate through the website.</p>
</div>

</body>
</html>
