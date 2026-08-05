<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- TOP HEADER -->
<div class="top-header">
    <div class="logo">Travel Tourism</div>

    <input type="text" class="search-bar" placeholder="Search tours, places, packages...">

    <div class="contact-info">
        <span class="phone-icon">📞</span>
        <span>+91 XXXXXXXXXX</span>
    </div>

    <button class="login-btn">Login</button>

    <div class="global-icon">🌐 Global</div>
</div>

<!-- NAVIGATION BAR -->
<div class="nav-bar">
    <a href="HomeServlet">Home</a>
    <a href="DestinationsServlet">Destinations</a>
    <a href="CustomizedHolidaysServlet">Customized Holidays</a>
    <a href="ExperienceServlet">Travel Experiences</a>
    <a href="Contact_usServlet">Contact Us</a>
    <a href="About_usServlet">About Us</a>
</div>

<!-- HEADER CSS -->
<style>
    .top-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background: #ffffff;
        padding: 12px 20px;
        border-bottom: 1px solid #ddd;
    }

    .logo {
        font-size: 22px;
        font-weight: bold;
        color: #d32f2f;
    }

    .search-bar {
        width: 35%;
        padding: 8px;
        border-radius: 6px;
        border: 1px solid #ccc;
    }

    .contact-info {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 14px;
    }

    .login-btn {
        background: #1976d2;
        color: white;
        border: none;
        padding: 8px 14px;
        border-radius: 6px;
        cursor: pointer;
    }

    .global-icon {
        font-size: 18px;
    }

    .nav-bar {
        background: #0d47a1;
        padding: 10px 20px;
    }

    .nav-bar a {
        color: white;
        margin-right: 20px;
        text-decoration: none;
        font-size: 15px;
    }

    .nav-bar a:hover {
        text-decoration: underline;
    }
</style>
