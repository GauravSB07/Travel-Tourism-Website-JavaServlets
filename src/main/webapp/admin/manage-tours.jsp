<%@ page import="java.util.List" %>
<%@ page import="com.traveltourism.controller.TourAdminServlet.Tour" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Manage Tours</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f5f6f8;
            margin: 0;
        }

        .header {
            background: #1f2937;
            color: white;
            padding: 20px 35px;
        }

        .container {
            width: 94%;
            max-width: 1400px;
            margin: 30px auto;
        }

        .top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .btn {
            border: 0;
            padding: 9px 14px;
            border-radius: 6px;
            color: white;
            text-decoration: none;
            cursor: pointer;
        }

        .blue {
            background: #2563eb;
        }

        .green {
            background: #16a34a;
        }

        .red {
            background: #dc2626;
        }

        .grey {
            background: #6b7280;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th,
        td {
            padding: 13px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #f1f5f9;
        }

        .form-box {
            background: white;
            padding: 25px;
            margin-bottom: 30px;
            border-radius: 10px;
        }

        .grid {
            display: grid;
            grid-template-columns:
                repeat(2, 1fr);
            gap: 15px;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        textarea {
            min-height: 100px;
        }

        .full {
            grid-column: 1 / -1;
        }

        .actions {
            display: flex;
            gap: 7px;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>Manage Tours</h1>

</div>


<div class="container">

    <a
            class="btn grey"
            href="${pageContext.request.contextPath}/admin-dashboard">
        ← Dashboard
    </a>


    <%
        String message =
                request.getParameter("message");

        if (message != null) {
    %>

    <p><strong><%= message %></strong></p>

    <%
        }
    %>


    <!-- ===================================== -->
    <!-- ADD / EDIT FORM -->
    <!-- ===================================== -->

    <div class="form-box">

        <%
            Tour editTour =
                    (Tour) request.getAttribute("tour");

            boolean editing =
                    editTour != null;
        %>

        <h2>
            <%= editing ? "Edit Tour" : "Add New Tour" %>
        </h2>


        <form
                method="post"
                action="${pageContext.request.contextPath}/tour-admin">

            <input
                    type="hidden"
                    name="action"
                    value="<%= editing ? "update" : "add" %>">


            <% if (editing) { %>

            <input
                    type="hidden"
                    name="id"
                    value="<%= editTour.getId() %>">

            <% } %>


            <div class="grid">

                <div>

                    <label>Tour Name</label>

                    <input
                            type="text"
                            name="name"
                            required
                            value="<%= editing ? editTour.getName() : "" %>">

                </div>


                <div>

                    <label>Category</label>

                    <input
                            type="text"
                            name="category"
                            required
                            value="<%= editing ? editTour.getCategory() : "" %>">

                </div>


                <div>

                    <label>Departure City</label>

                    <input
                            type="text"
                            name="departureCity"
                            required
                            value="<%= editing ? editTour.getDepartureCity() : "" %>">

                </div>


                <div>

                    <label>Duration (days)</label>

                    <input
                            type="number"
                            name="duration"
                            min="1"
                            required
                            value="<%= editing ? editTour.getDuration() : "" %>">

                </div>


                <div>

                    <label>Price</label>

                    <input
                            type="number"
                            name="price"
                            min="0"
                            step="0.01"
                            required
                            value="<%= editing ? editTour.getPrice() : "" %>">

                </div>


                <div>

                    <label>Status</label>

                    <select name="status">

                        <option value="active"
                            <%= editing &&
                                "active".equals(editTour.getStatus())
                                ? "selected" : "" %>>
                            Active
                        </option>

                        <option value="inactive"
                            <%= editing &&
                                "inactive".equals(editTour.getStatus())
                                ? "selected" : "" %>>
                            Inactive
                        </option>

                    </select>

                </div>


                <div class="full">

                    <label>Short Description</label>

                    <textarea
                            name="shortDescription"><%= editing &&
                            editTour.getShortDescription() != null
                            ? editTour.getShortDescription()
                            : "" %></textarea>

                </div>

            </div>


            <br>

            <button
                    class="btn blue"
                    type="submit">

                <%= editing ? "Update Tour" : "Add Tour" %>

            </button>


            <% if (editing) { %>

            <a
                    class="btn grey"
                    href="${pageContext.request.contextPath}/tour-admin">
                Cancel
            </a>

            <% } %>

        </form>

    </div>


    <!-- ===================================== -->
    <!-- TOUR LIST -->
    <!-- ===================================== -->

    <h2>Existing Tours</h2>

    <table>

        <tr>

            <th>ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Departure</th>
            <th>Duration</th>
            <th>Price</th>
            <th>Status</th>
            <th>Actions</th>

        </tr>


        <%

            List<Tour> tours =
                    (List<Tour>)
                            request.getAttribute("tours");

            if (tours != null) {

                for (Tour tour : tours) {

        %>

        <tr>

            <td><%= tour.getId() %></td>

            <td><%= tour.getName() %></td>

            <td><%= tour.getCategory() %></td>

            <td><%= tour.getDepartureCity() %></td>

            <td><%= tour.getDuration() %> days</td>

            <td>₹<%= tour.getPrice() %></td>

            <td><%= tour.getStatus() %></td>

            <td>

                <div class="actions">

                    <a
                            class="btn blue"
                            href="${pageContext.request.contextPath}/tour-admin?action=edit&id=<%= tour.getId() %>">
                        Edit
                    </a>


                    <a
                            class="btn green"
                            href="${pageContext.request.contextPath}/tour-details?tourId=<%= tour.getId() %>">
                        Details
                    </a>


                    <a
                            class="btn green"
                            href="${pageContext.request.contextPath}/tour-itinerary?tourId=<%= tour.getId() %>">
                        Itinerary
                    </a>


                    <a
                            class="btn green"
                            href="${pageContext.request.contextPath}/tour-hotel?tourId=<%= tour.getId() %>">
                        Hotels
                    </a>


                    <a
                            class="btn green"
                            href="${pageContext.request.contextPath}/tour-image-admin?tourId=<%= tour.getId() %>">
                        Images
                    </a>


                    <form
                            method="post"
                            action="${pageContext.request.contextPath}/tour-admin"
                            onsubmit="return confirm('Delete this tour and all related data?');">

                        <input
                                type="hidden"
                                name="action"
                                value="delete">

                        <input
                                type="hidden"
                                name="id"
                                value="<%= tour.getId() %>">

                        <button
                                class="btn red"
                                type="submit">
                            Delete
                        </button>

                    </form>

                </div>

            </td>

        </tr>

        <%
                }
            }
        %>

    </table>

</div>

</body>
</html>