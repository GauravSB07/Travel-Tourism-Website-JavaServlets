<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String message = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Tour Management</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f6f8;
            color: #222;
        }

        .header {
            background: #1f2937;
            color: white;
            padding: 22px 30px;
        }

        .header h1 {
            margin: 0;
            font-size: 25px;
        }

        .header p {
            margin: 6px 0 0;
            color: #cbd5e1;
        }

        .container {
            width: 94%;
            max-width: 1450px;
            margin: 30px auto;
        }

        .message {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
            padding: 13px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .grid {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 25px;
            align-items: start;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 22px;
            box-shadow: 0 2px 10px rgba(0,0,0,.06);
            margin-bottom: 25px;
        }

        .card h2 {
            margin-top: 0;
            font-size: 20px;
            color: #1f2937;
        }

        .card h3 {
            color: #374151;
            margin-top: 25px;
        }

        .tour-list {
            max-height: 750px;
            overflow-y: auto;
        }

        .tour-item {
            display: block;
            text-decoration: none;
            color: #222;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 13px;
            margin-bottom: 10px;
            transition: .2s;
        }

        .tour-item:hover {
            background: #f8fafc;
            border-color: #94a3b8;
        }

        .tour-item.active {
            border-color: #2563eb;
            background: #eff6ff;
        }

        .tour-name {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .tour-meta {
            font-size: 13px;
            color: #64748b;
        }

        label {
            display: block;
            margin: 14px 0 6px;
            font-weight: bold;
            font-size: 14px;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 11px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            font: inherit;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .small-textarea {
            min-height: 90px;
        }

        .button {
            border: none;
            border-radius: 7px;
            padding: 10px 15px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 12px;
        }

        .primary {
            background: #2563eb;
            color: white;
        }

        .success {
            background: #15803d;
            color: white;
        }

        .danger {
            background: #dc2626;
            color: white;
        }

        .secondary {
            background: #475569;
            color: white;
        }

        .warning {
            background: #d97706;
            color: white;
        }

        .button:hover {
            opacity: .9;
        }

        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .row-3 {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 18px;
        }

        .section {
            border-top: 1px solid #e5e7eb;
            padding-top: 20px;
            margin-top: 25px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th,
        td {
            border: 1px solid #e5e7eb;
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }

        th {
            background: #f8fafc;
        }

        .image-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fill, minmax(190px, 1fr));
            gap: 18px;
            margin-top: 20px;
        }

        .image-card {
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            overflow: hidden;
            background: white;
        }

        .image-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            display: block;
        }

        .image-info {
            padding: 12px;
        }

        .cover {
            display: inline-block;
            background: #fef3c7;
            color: #92400e;
            padding: 4px 8px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: bold;
        }

        .muted {
            color: #64748b;
            font-size: 13px;
        }

        .danger-zone {
            border: 1px solid #fecaca;
            background: #fff7f7;
        }

        .empty {
            padding: 30px;
            text-align: center;
            color: #64748b;
        }

        @media (max-width: 1000px) {

            .grid {
                grid-template-columns: 1fr;
            }

        }

        @media (max-width: 700px) {

            .row,
            .row-3 {
                grid-template-columns: 1fr;
            }

            .container {
                width: 96%;
            }

        }

    </style>

</head>

<body>

<div class="header">

    <h1>Tour Management</h1>

    <p>
        Create, edit and manage tours, details,
        itinerary, hotels and images.
    </p>

</div>


<div class="container">

    <% if (message != null && !message.trim().isEmpty()) { %>

        <div class="message">
            <%= message %>
        </div>

    <% } %>


    <div class="grid">

        <!-- =====================================================
             LEFT SIDE
        ====================================================== -->

        <div>

            <div class="card">

                <h2>All Tours</h2>

                <a href="<%= request.getContextPath() %>/admin/tours"
                   class="button secondary"
                   style="display:block;text-align:center;text-decoration:none;">
                    + Create New Tour
                </a>

                <div class="tour-list">

                    <%
                        java.util.List<java.util.Map<String,Object>>
                                tours =
                                (java.util.List<java.util.Map<String,Object>>)
                                        request.getAttribute("tours");

                        Integer selectedTourId =
                                null;

                        Object selectedTourObject =
                                request.getAttribute("selectedTour");

                        if (selectedTourObject != null) {

                            java.util.Map<String,Object>
                                    selectedTour =
                                    (java.util.Map<String,Object>)
                                            selectedTourObject;

                            selectedTourId =
                                    (Integer)
                                            selectedTour.get("id");
                        }

                        if (tours != null &&
                                !tours.isEmpty()) {

                            for (
                                java.util.Map<String,Object> tour
                                : tours
                            ) {

                                Integer id =
                                        (Integer)
                                                tour.get("id");

                                boolean active =
                                        selectedTourId != null &&
                                        selectedTourId.equals(id);
                    %>

                        <a
                            href="<%= request.getContextPath() %>/admin/tours?tourId=<%= id %>"
                            class="tour-item <%= active ? "active" : "" %>"
                        >

                            <div class="tour-name">
                                <%= tour.get("name") %>
                            </div>

                            <div class="tour-meta">

                                <%= tour.get("category") %>
                                ·
                                <%= tour.get("duration") %> days

                                <br>

                                <%= tour.get("departure_city") %>
                                · ₹<%= tour.get("price") %>

                                <br>

                                Status:
                                <%= tour.get("status") %>

                            </div>

                        </a>

                    <%
                            }

                        } else {
                    %>

                        <div class="empty">
                            No tours found.
                        </div>

                    <%
                        }
                    %>

                </div>

            </div>

        </div>


        <!-- =====================================================
             RIGHT SIDE
        ====================================================== -->

        <div>

            <%
                java.util.Map<String,Object>
                        selectedTour =
                        (java.util.Map<String,Object>)
                                request.getAttribute(
                                        "selectedTour"
                                );
            %>


            <!-- =================================================
                 CREATE TOUR
            ================================================== -->

            <% if (selectedTour == null) { %>

                <div class="card">

                    <h2>Create New Tour</h2>

                    <form
                        method="post"
                        action="<%= request.getContextPath() %>/admin/tours"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="createTour"
                        >

                        <label>Tour Name</label>

                        <input
                            type="text"
                            name="name"
                            required
                            maxlength="150"
                            placeholder="Example: Goa Beach Holiday"
                        >


                        <div class="row">

                            <div>

                                <label>Category</label>

                                <input
                                    type="text"
                                    name="category"
                                    required
                                    maxlength="50"
                                    placeholder="Nature"
                                >

                            </div>

                            <div>

                                <label>Departure City</label>

                                <input
                                    type="text"
                                    name="departureCity"
                                    required
                                    maxlength="50"
                                    placeholder="Mumbai"
                                >

                            </div>

                        </div>


                        <div class="row">

                            <div>

                                <label>Duration (Days)</label>

                                <input
                                    type="number"
                                    name="duration"
                                    min="1"
                                    required
                                >

                            </div>

                            <div>

                                <label>Price</label>

                                <input
                                    type="number"
                                    name="price"
                                    min="0"
                                    step="0.01"
                                    required
                                >

                            </div>

                        </div>


                        <label>Status</label>

                        <select name="status">

                            <option value="active">
                                Active
                            </option>

                            <option value="inactive">
                                Inactive
                            </option>

                        </select>


                        <button
                            type="submit"
                            class="button primary"
                        >
                            Create Tour
                        </button>

                    </form>

                </div>

            <% } else { %>


                <!-- =============================================
                     BASIC TOUR INFORMATION
                ============================================== -->

                <div class="card">

                    <h2>Edit Tour</h2>

                    <form
                        method="post"
                        action="<%= request.getContextPath() %>/admin/tours"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="updateTour"
                        >

                        <input
                            type="hidden"
                            name="tourId"
                            value="<%= selectedTour.get("id") %>"
                        >


                        <label>Tour Name</label>

                        <input
                            type="text"
                            name="name"
                            value="<%= selectedTour.get("name") %>"
                            required
                            maxlength="150"
                        >


                        <div class="row">

                            <div>

                                <label>Category</label>

                                <input
                                    type="text"
                                    name="category"
                                    value="<%= selectedTour.get("category") %>"
                                    required
                                    maxlength="50"
                                >

                            </div>

                            <div>

                                <label>Departure City</label>

                                <input
                                    type="text"
                                    name="departureCity"
                                    value="<%= selectedTour.get("departure_city") %>"
                                    required
                                    maxlength="50"
                                >

                            </div>

                        </div>


                        <div class="row-3">

                            <div>

                                <label>Duration</label>

                                <input
                                    type="number"
                                    name="duration"
                                    value="<%= selectedTour.get("duration") %>"
                                    min="1"
                                    required
                                >

                            </div>

                            <div>

                                <label>Price</label>

                                <input
                                    type="number"
                                    name="price"
                                    value="<%= selectedTour.get("price") %>"
                                    min="0"
                                    step="0.01"
                                    required
                                >

                            </div>

                            <div>

                                <label>Status</label>

                                <select name="status">

                                    <option
                                        value="active"
                                        <%= "active".equals(
                                                selectedTour.get("status")
                                        ) ? "selected" : "" %>
                                    >
                                        Active
                                    </option>

                                    <option
                                        value="inactive"
                                        <%= "inactive".equals(
                                                selectedTour.get("status")
                                        ) ? "selected" : "" %>
                                    >
                                        Inactive
                                    </option>

                                </select>

                            </div>

                        </div>


                        <button
                            type="submit"
                            class="button primary"
                        >
                            Save Tour Changes
                        </button>

                    </form>


                    <div class="section danger-zone"
                         style="padding:15px;">

                        <strong>Delete this tour</strong>

                        <p class="muted">
                            Deleting the tour will also delete
                            its details, images, itinerary and
                            hotel records because your database
                            uses ON DELETE CASCADE.
                        </p>

                        <form
                            method="post"
                            action="<%= request.getContextPath() %>/admin/tours"
                            onsubmit="return confirm('Delete this entire tour and all related data?');"
                        >

                            <input
                                type="hidden"
                                name="action"
                                value="deleteTour"
                            >

                            <input
                                type="hidden"
                                name="tourId"
                                value="<%= selectedTour.get("id") %>"
                            >

                            <button
                                type="submit"
                                class="button danger"
                            >
                                Delete Entire Tour
                            </button>

                        </form>

                    </div>

                </div>


                <!-- =============================================
                     TOUR DETAILS
                ============================================== -->

                <%
                    java.util.Map<String,Object>
                            details =
                            (java.util.Map<String,Object>)
                                    request.getAttribute(
                                            "tourDetails"
                                    );
                %>

                <div class="card">

                    <h2>Tour Details</h2>

                    <form
                        method="post"
                        action="<%= request.getContextPath() %>/admin/tours"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="saveDetails"
                        >

                        <input
                            type="hidden"
                            name="tourId"
                            value="<%= selectedTour.get("id") %>"
                        >


                        <label>Long Description</label>

                        <textarea
                            name="longDescription"
                        ><%= details != null && details.get("long_description") != null
                                ? details.get("long_description")
                                : "" %></textarea>


                        <div class="row">

                            <div>

                                <label>Duration Text</label>

                                <input
                                    type="text"
                                    name="durationText"
                                    value="<%= details != null && details.get("duration_text") != null
                                            ? details.get("duration_text")
                                            : "" %>"
                                    placeholder="5 Days / 4 Nights"
                                >

                            </div>

                            <div>

                                <label>Best Time</label>

                                <input
                                    type="text"
                                    name="bestTime"
                                    value="<%= details != null && details.get("best_time") != null
                                            ? details.get("best_time")
                                            : "" %>"
                                    placeholder="October to March"
                                >

                            </div>

                        </div>


                        <div class="row">

                            <div>

                                <label>States Covered</label>

                                <input
                                    type="text"
                                    name="statesCovered"
                                    value="<%= details != null && details.get("states_covered") != null
                                            ? details.get("states_covered")
                                            : "" %>"
                                >

                            </div>

                            <div>

                                <label>Cities Covered</label>

                                <input
                                    type="text"
                                    name="citiesCovered"
                                    value="<%= details != null && details.get("cities_covered") != null
                                            ? details.get("cities_covered")
                                            : "" %>"
                                >

                            </div>

                        </div>


                        <label>Route</label>

                        <textarea
                            name="route"
                            class="small-textarea"
                        ><%= details != null && details.get("route") != null
                                ? details.get("route")
                                : "" %></textarea>


                        <label>Highlights</label>

                        <textarea
                            name="highlights"
                            class="small-textarea"
                        ><%= details != null && details.get("highlights") != null
                                ? details.get("highlights")
                                : "" %></textarea>


                        <label>Inclusions</label>

                        <textarea
                            name="inclusions"
                            class="small-textarea"
                        ><%= details != null && details.get("inclusions") != null
                                ? details.get("inclusions")
                                : "" %></textarea>


                        <label>Exclusions</label>

                        <textarea
                            name="exclusions"
                            class="small-textarea"
                        ><%= details != null && details.get("exclusions") != null
                                ? details.get("exclusions")
                                : "" %></textarea>


                        <label>Preparation</label>

                        <textarea
                            name="preparation"
                            class="small-textarea"
                        ><%= details != null && details.get("preparation") != null
                                ? details.get("preparation")
                                : "" %></textarea>


                        <label>Payment Terms</label>

                        <textarea
                            name="paymentTerms"
                            class="small-textarea"
                        ><%= details != null && details.get("payment_terms") != null
                                ? details.get("payment_terms")
                                : "" %></textarea>


                        <label>Upgrades Information</label>

                        <textarea
                            name="upgradesInfo"
                            class="small-textarea"
                        ><%= details != null && details.get("upgrades_info") != null
                                ? details.get("upgrades_info")
                                : "" %></textarea>


                        <label>Google Maps Embed URL</label>

                        <textarea
                            name="mapEmbed"
                            class="small-textarea"
                            placeholder="https://www.google.com/maps/embed?..."
                        ><%= details != null && details.get("map_embed") != null
                                ? details.get("map_embed")
                                : "" %></textarea>


                        <button
                            type="submit"
                            class="button success"
                        >
                            Save Tour Details
                        </button>

                    </form>

                </div>


                <!-- =============================================
                     ITINERARY
                ============================================== -->

                <div class="card">

                    <h2>Tour Itinerary</h2>

                    <form
                        method="post"
                        action="<%= request.getContextPath() %>/admin/tours"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="addItinerary"
                        >

                        <input
                            type="hidden"
                            name="tourId"
                            value="<%= selectedTour.get("id") %>"
                        >


                        <div class="row">

                            <div>

                                <label>Day Number</label>

                                <input
                                    type="number"
                                    name="dayNumber"
                                    min="1"
                                    required
                                >

                            </div>

                            <div>

                                <label>Day Title</label>

                                <input
                                    type="text"
                                    name="dayTitle"
                                    maxlength="150"
                                    required
                                    placeholder="Arrival & City Tour"
                                >

                            </div>

                        </div>


                        <label>Day Description</label>

                        <textarea
                            name="dayDescription"
                            required
                        ></textarea>


                        <button
                            type="submit"
                            class="button primary"
                        >
                            Add Itinerary Day
                        </button>

                    </form>


                    <%
                        java.util.List<java.util.Map<String,Object>>
                                itinerary =
                                (java.util.List<java.util.Map<String,Object>>)
                                        request.getAttribute(
                                                "itinerary"
                                        );
                    %>


                    <% if (itinerary != null &&
                            !itinerary.isEmpty()) { %>

                        <div class="table-wrapper">

                            <table>

                                <tr>

                                    <th>Day</th>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Action</th>

                                </tr>

                                <% for (
                                    java.util.Map<String,Object> day
                                    : itinerary
                                ) { %>

                                    <tr>

                                        <form
                                            method="post"
                                            action="<%= request.getContextPath() %>/admin/tours"
                                        >

                                            <td>

                                                <input
                                                    type="number"
                                                    name="dayNumber"
                                                    value="<%= day.get("day_number") %>"
                                                    min="1"
                                                    required
                                                >

                                            </td>

                                            <td>

                                                <input
                                                    type="text"
                                                    name="dayTitle"
                                                    value="<%= day.get("day_title") %>"
                                                    required
                                                >

                                            </td>

                                            <td>

                                                <textarea
                                                    name="dayDescription"
                                                    class="small-textarea"
                                                    required
                                                ><%= day.get("day_description") %></textarea>

                                            </td>

                                            <td>

                                                <input
                                                    type="hidden"
                                                    name="action"
                                                    value="updateItinerary"
                                                >

                                                <input
                                                    type="hidden"
                                                    name="tourId"
                                                    value="<%= selectedTour.get("id") %>"
                                                >

                                                <input
                                                    type="hidden"
                                                    name="itineraryId"
                                                    value="<%= day.get("id") %>"
                                                >

                                                <button
                                                    type="submit"
                                                    class="button primary"
                                                >
                                                    Save
                                                </button>

                                        </form>


                                        <form
                                            method="post"
                                            action="<%= request.getContextPath() %>/admin/tours"
                                            onsubmit="return confirm('Delete this itinerary day?');"
                                        >

                                            <input
                                                type="hidden"
                                                name="action"
                                                value="deleteItinerary"
                                            >

                                            <input
                                                type="hidden"
                                                name="tourId"
                                                value="<%= selectedTour.get("id") %>"
                                            >

                                            <input
                                                type="hidden"
                                                name="itineraryId"
                                                value="<%= day.get("id") %>"
                                            >

                                            <button
                                                type="submit"
                                                class="button danger"
                                            >
                                                Delete
                                            </button>

                                        </form>

                                            </td>

                                    </tr>

                                <% } %>

                            </table>

                        </div>

                    <% } else { %>

                        <div class="empty">
                            No itinerary days added yet.
                        </div>

                    <% } %>

                </div>


                <!-- =============================================
                     HOTELS
                ============================================== -->

                <div class="card">

                    <h2>Hotels</h2>

                    <form
                        method="post"
                        action="<%= request.getContextPath() %>/admin/tours"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="addHotel"
                        >

                        <input
                            type="hidden"
                            name="tourId"
                            value="<%= selectedTour.get("id") %>"
                        >


                        <div class="row">

                            <div>

                                <label>City</label>

                                <input
                                    type="text"
                                    name="city"
                                    maxlength="100"
                                    required
                                >

                            </div>

                            <div>

                                <label>Hotel Name</label>

                                <input
                                    type="text"
                                    name="hotelName"
                                    maxlength="150"
                                    required
                                >

                            </div>

                        </div>


                        <div class="row">

                            <div>

                                <label>Check In</label>

                                <input
                                    type="date"
                                    name="checkIn"
                                >

                            </div>

                            <div>

                                <label>Check Out</label>

                                <input
                                    type="date"
                                    name="checkOut"
                                >

                            </div>

                        </div>


                        <button
                            type="submit"
                            class="button primary"
                        >
                            Add Hotel
                        </button>

                    </form>


                    <%
                        java.util.List<java.util.Map<String,Object>>
                                hotels =
                                (java.util.List<java.util.Map<String,Object>>)
                                        request.getAttribute(
                                                "hotels"
                                        );
                    %>


                    <% if (hotels != null &&
                            !hotels.isEmpty()) { %>

                        <div class="table-wrapper">

                            <table>

                                <tr>

                                    <th>City</th>
                                    <th>Hotel</th>
                                    <th>Check In</th>
                                    <th>Check Out</th>
                                    <th>Action</th>

                                </tr>


                                <% for (
                                    java.util.Map<String,Object> hotel
                                    : hotels
                                ) { %>

                                    <tr>

                                        <td>

                                            <%= hotel.get("city") %>

                                        </td>

                                        <td>

                                            <%= hotel.get("hotel_name") %>

                                        </td>

                                        <td>

                                            <%= hotel.get("check_in") != null
                                                    ? hotel.get("check_in")
                                                    : "-" %>

                                        </td>

                                        <td>

                                            <%= hotel.get("check_out") != null
                                                    ? hotel.get("check_out")
                                                    : "-" %>

                                        </td>

                                        <td>

                                            <form
                                                method="post"
                                                action="<%= request.getContextPath() %>/admin/tours"
                                            >

                                                <input
                                                    type="hidden"
                                                    name="action"
                                                    value="deleteHotel"
                                                >

                                                <input
                                                    type="hidden"
                                                    name="tourId"
                                                    value="<%= selectedTour.get("id") %>"
                                                >

                                                <input
                                                    type="hidden"
                                                    name="hotelId"
                                                    value="<%= hotel.get("id") %>"
                                                >

                                                <button
                                                    type="submit"
                                                    class="button danger"
                                                    onclick="return confirm('Delete this hotel?');"
                                                >
                                                    Delete
                                                </button>

                                            </form>

                                        </td>

                                    </tr>

                                <% } %>

                            </table>

                        </div>

                    <% } else { %>

                        <div class="empty">
                            No hotels added yet.
                        </div>

                    <% } %>

                </div>


                <!-- =============================================
                     IMAGES
                ============================================== -->

                <div class="card">

                    <h2>Cover &amp; Gallery Images</h2>

                    <p class="muted">
                        Upload images stored as BLOB in the database.
                        Cover images appear on the tour hero; all
                        uploads appear in the Gallery on tour details.
                    </p>


                    <form
                        method="post"
                        action="<%= request.getContextPath() %>/admin/tours"
                        enctype="multipart/form-data"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="uploadImage"
                        >

                        <input
                            type="hidden"
                            name="tourId"
                            value="<%= selectedTour.get("id") %>"
                        >


                        <label>Add Gallery Image</label>

                        <input
                            type="file"
                            name="image"
                            accept="image/jpeg,image/png,image/webp,image/gif"
                            required
                        >


                        <label>

                            <input
                                type="checkbox"
                                name="isCover"
                                value="true"
                                style="width:auto;"
                            >

                            Also use as cover image

                        </label>


                        <button
                            type="submit"
                            class="button primary"
                        >
                            Upload to Gallery
                        </button>

                    </form>


                    <%
                        java.util.List<java.util.Map<String,Object>>
                                images =
                                (java.util.List<java.util.Map<String,Object>>)
                                        request.getAttribute(
                                                "images"
                                        );
                    %>


                    <% if (images != null &&
                            !images.isEmpty()) { %>

                        <div class="image-grid">

                            <% for (
                                java.util.Map<String,Object> image
                                : images
                            ) { %>

                                <div class="image-card">

                                    <img
                                        src="<%= request.getContextPath() %>/TourImageServlet?id=<%= image.get("id") %>"
                                        alt="<%= image.get("original_name") %>"
                                    >


                                    <div class="image-info">

                                        <strong>
                                            <%= image.get("original_name") %>
                                        </strong>

                                        <br><br>


                                        <% if (
                                            Boolean.TRUE.equals(
                                                image.get("is_cover")
                                            )
                                        ) { %>

                                            <span class="cover">
                                                COVER IMAGE
                                            </span>

                                        <% } %>


                                        <div>

                                            <% if (
                                                !Boolean.TRUE.equals(
                                                    image.get("is_cover")
                                                )
                                            ) { %>

                                                <form
                                                    method="post"
                                                    action="<%= request.getContextPath() %>/admin/tours"
                                                >

                                                    <input
                                                        type="hidden"
                                                        name="action"
                                                        value="setCover"
                                                    >

                                                    <input
                                                        type="hidden"
                                                        name="tourId"
                                                        value="<%= selectedTour.get("id") %>"
                                                    >

                                                    <input
                                                        type="hidden"
                                                        name="imageId"
                                                        value="<%= image.get("id") %>"
                                                    >

                                                    <button
                                                        type="submit"
                                                        class="button warning"
                                                    >
                                                        Set Cover
                                                    </button>

                                                </form>

                                            <% } %>


                                            <form
                                                method="post"
                                                action="<%= request.getContextPath() %>/admin/tours"
                                                onsubmit="return confirm('Delete this image?');"
                                            >

                                                <input
                                                    type="hidden"
                                                    name="action"
                                                    value="deleteImage"
                                                >

                                                <input
                                                    type="hidden"
                                                    name="tourId"
                                                    value="<%= selectedTour.get("id") %>"
                                                >

                                                <input
                                                    type="hidden"
                                                    name="imageId"
                                                    value="<%= image.get("id") %>"
                                                >

                                                <button
                                                    type="submit"
                                                    class="button danger"
                                                >
                                                    Delete Image
                                                </button>

                                            </form>

                                        </div>

                                    </div>

                                </div>

                            <% } %>

                        </div>

                    <% } else { %>

                        <div class="empty">
                            No images uploaded for this tour.
                        </div>

                    <% } %>

                </div>

            <% } %>

        </div>

    </div>

</div>

</body>

</html>