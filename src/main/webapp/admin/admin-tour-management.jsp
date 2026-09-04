<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String message = (String) request.getAttribute("adminMessage");

    if (message == null) {
        message = request.getParameter("message");
    }

    java.util.List<java.util.Map<String, Object>> tours =
            (java.util.List<java.util.Map<String, Object>>)
                    request.getAttribute("tours");

    java.util.Map<String, Object> selectedTour =
            (java.util.Map<String, Object>)
                    request.getAttribute("selectedTour");

    Integer selectedTourId = null;

    if (selectedTour != null && selectedTour.get("id") != null) {
        selectedTourId =
                ((Number) selectedTour.get("id")).intValue();
    }

    /*
     * selectedTour == null means CREATE mode.
     * selectedTour != null means EDIT mode.
     */
    boolean createMode = selectedTour == null;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Tour Management</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        /* =========================================================
           GLOBAL
        ========================================================= */

        * {
            box-sizing: border-box;
        }

        :root {
            --primary: #1d4ed8;
            --primary-dark: #1e40af;
            --primary-soft: #eff6ff;

            --success: #15803d;
            --success-soft: #f0fdf4;

            --danger: #dc2626;
            --danger-soft: #fef2f2;

            --warning: #b45309;
            --warning-soft: #fffbeb;

            --dark: #172033;
            --text: #263247;
            --muted: #718096;

            --border: #e5e9f0;
            --border-dark: #d5dbe5;

            --background: #f5f7fb;
            --white: #ffffff;

            --radius: 14px;

            --shadow:
                0 5px 20px rgba(15, 23, 42, .055);

            --shadow-hover:
                0 10px 28px rgba(15, 23, 42, .10);
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;

            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                Arial,
                sans-serif;

            background: var(--background);
            color: var(--text);
            line-height: 1.5;
        }

        button,
        input,
        select,
        textarea {
            font: inherit;
        }


        /* =========================================================
           HEADER
        ========================================================= */

        .header {
            background:
                linear-gradient(
                    135deg,
                    #172033 0%,
                    #202c43 55%,
                    #263653 100%
                );

            color: white;

            padding: 28px 40px;

            border-bottom:
                1px solid rgba(255,255,255,.06);
        }

        .header-inner {
            max-width: 1550px;
            margin: auto;
        }

        .header h1 {
            margin: 0;

            font-size: 27px;
            font-weight: 700;

            letter-spacing: -.4px;
        }

        .header p {
            margin: 7px 0 0;

            color: #b9c4d6;

            font-size: 14px;
        }


        /* =========================================================
           MAIN CONTAINER
        ========================================================= */

        .container {
            width: 94%;
            max-width: 1550px;

            margin: 28px auto 50px;
        }


        /* =========================================================
           MESSAGE
        ========================================================= */

        .message {
            background: var(--success-soft);

            color: #166534;

            border: 1px solid #bbf7d0;

            padding: 13px 17px;

            border-radius: 10px;

            margin-bottom: 22px;

            font-size: 14px;
            font-weight: 600;

            box-shadow:
                0 2px 8px rgba(22,101,52,.04);
        }


        /* =========================================================
           MAIN DASHBOARD
        ========================================================= */

        .dashboard {
            display: grid;

            grid-template-columns:
                335px
                minmax(0, 1fr);

            gap: 24px;

            align-items: start;
        }


        /* =========================================================
           LEFT SIDEBAR
        ========================================================= */

        .sidebar {
            position: sticky;
            top: 20px;

            background: var(--white);

            border:
                1px solid var(--border);

            border-radius: var(--radius);

            box-shadow: var(--shadow);

            overflow: hidden;
        }

        .sidebar-header {
            padding: 20px 20px 16px;

            border-bottom:
                1px solid var(--border);
        }

        .sidebar-title-row {
            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 10px;
        }

        .sidebar-title {
            margin: 0;

            font-size: 18px;

            font-weight: 700;

            color: var(--dark);
        }

        .tour-count {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            min-width: 27px;
            height: 27px;

            padding: 0 8px;

            border-radius: 999px;

            background: #eef2f7;

            color: #566277;

            font-size: 12px;

            font-weight: 700;
        }

        .sidebar-subtitle {
            margin: 5px 0 15px;

            color: var(--muted);

            font-size: 12px;
        }


        /* =========================================================
           ADD NEW TOUR BUTTON
        ========================================================= */

        .add-tour-btn {
            display: flex;

            align-items: center;
            justify-content: center;

            gap: 8px;

            width: 100%;

            padding: 11px 14px;

            border-radius: 9px;

            background: var(--primary);

            color: white;

            text-decoration: none;

            font-size: 13px;

            font-weight: 700;

            transition:
                background .2s ease,
                transform .2s ease,
                box-shadow .2s ease;
        }

        .add-tour-btn:hover {
            background: var(--primary-dark);

            transform: translateY(-1px);

            box-shadow:
                0 5px 14px rgba(29,78,216,.22);
        }

        .add-tour-btn.active {
            background: var(--primary-dark);

            box-shadow:
                0 5px 14px rgba(29,78,216,.20);
        }

        .plus-icon {
            font-size: 17px;
            line-height: 1;
        }


        /* =========================================================
           TOUR SEARCH
        ========================================================= */

        .tour-search {
            position: relative;

            margin-top: 15px;
        }

        .tour-search input {
            width: 100%;

            height: 40px;

            padding:
                9px 36px 9px 37px;

            border:
                1px solid var(--border-dark);

            border-radius: 9px;

            background: #f8fafc;

            color: var(--text);

            font-size: 12px;

            outline: none;

            transition:
                border-color .2s ease,
                background .2s ease,
                box-shadow .2s ease;
        }

        .tour-search input::placeholder {
            color: #9aa4b4;
        }

        .tour-search input:focus {
            background: #ffffff;

            border-color: #93b4f5;

            box-shadow:
                0 0 0 3px rgba(37,99,235,.08);
        }

        .search-icon {
            position: absolute;

            left: 12px;
            top: 50%;

            transform: translateY(-50%);

            width: 15px;
            height: 15px;

            color: #7b8798;

            pointer-events: none;
        }

        .search-icon::before {
            content: "";

            position: absolute;

            width: 8px;
            height: 8px;

            border:
                1.7px solid currentColor;

            border-radius: 50%;

            left: 0;
            top: 0;
        }

        .search-icon::after {
            content: "";

            position: absolute;

            width: 6px;
            height: 1.7px;

            background: currentColor;

            border-radius: 2px;

            transform: rotate(45deg);

            left: 8px;
            top: 10px;
        }

        .clear-search {
            position: absolute;

            right: 9px;
            top: 50%;

            transform: translateY(-50%);

            width: 22px;
            height: 22px;

            display: none;

            align-items: center;
            justify-content: center;

            border: none;

            background: transparent;

            color: #8b95a5;

            cursor: pointer;

            border-radius: 50%;

            font-size: 15px;

            padding: 0;
        }

        .clear-search:hover {
            background: #e9eef5;
            color: #475569;
        }

        .search-result-count {
            display: none;

            margin-top: 7px;

            color: var(--muted);

            font-size: 10.5px;
        }


        /* =========================================================
           TOUR LIST
        ========================================================= */

        .tour-list {
            max-height:
                calc(100vh - 270px);

            overflow-y: auto;

            padding: 12px;
        }

        .tour-list::-webkit-scrollbar {
            width: 6px;
        }

        .tour-list::-webkit-scrollbar-track {
            background: transparent;
        }

        .tour-list::-webkit-scrollbar-thumb {
            background: #d5dbe5;
            border-radius: 20px;
        }

        .tour-item {
            display: block;

            text-decoration: none;

            color: inherit;

            border:
                1px solid transparent;

            border-radius: 11px;

            padding: 14px;

            margin-bottom: 8px;

            background: transparent;

            transition:
                background .2s ease,
                border-color .2s ease,
                transform .2s ease,
                box-shadow .2s ease;
        }

        .tour-item:last-child {
            margin-bottom: 0;
        }

        .tour-item:hover {
            background: #f8fafc;

            border-color: var(--border);

            transform: translateX(2px);
        }

        .tour-item.active {
            background: var(--primary-soft);

            border-color: #bfdbfe;

            box-shadow:
                inset 3px 0 0 var(--primary);
        }

        .tour-item.search-hidden {
            display: none;
        }

        .tour-name {
            font-size: 14px;

            font-weight: 700;

            color: var(--dark);

            margin-bottom: 7px;

            line-height: 1.35;
        }

        .tour-item.active .tour-name {
            color: #1e40af;
        }

        .tour-meta {
            color: var(--muted);

            font-size: 11.5px;

            line-height: 1.65;
        }

        .tour-meta strong {
            color: #596579;
        }

        .status-badge {
            display: inline-flex;

            align-items: center;

            margin-top: 7px;

            padding: 3px 8px;

            border-radius: 999px;

            font-size: 10px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: .35px;
        }

        .status-active {
            background: #dcfce7;
            color: #166534;
        }

        .status-inactive {
            background: #f1f5f9;
            color: #64748b;
        }

        .search-empty {
            display: none;

            padding: 35px 20px;

            text-align: center;

            color: var(--muted);

            font-size: 12px;
        }

        .search-empty.visible {
            display: block;
        }

        .search-empty-icon {
            width: 40px;
            height: 40px;

            display: flex;

            align-items: center;
            justify-content: center;

            margin: 0 auto 10px;

            border-radius: 50%;

            background: #f1f5f9;

            color: #64748b;

            font-size: 17px;
        }


        /* =========================================================
           RIGHT WORKSPACE
        ========================================================= */

        .workspace {
            min-width: 0;
        }

        .workspace-header {
            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;

            background: white;

            border:
                1px solid var(--border);

            border-radius: var(--radius);

            padding: 18px 22px;

            margin-bottom: 18px;

            box-shadow: var(--shadow);
        }

        .workspace-title {
            min-width: 0;
        }

        .workspace-title small {
            display: block;

            color: var(--muted);

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: .7px;

            margin-bottom: 4px;
        }

        .workspace-title h2 {
            margin: 0;

            color: var(--dark);

            font-size: 21px;

            line-height: 1.3;
        }

        .workspace-title p {
            margin: 4px 0 0;

            color: var(--muted);

            font-size: 12px;
        }

        .workspace-badge {
            flex-shrink: 0;

            padding: 7px 11px;

            border-radius: 8px;

            background: #f1f5f9;

            color: #64748b;

            font-size: 11px;

            font-weight: 700;
        }


        /* =========================================================
           CARDS
        ========================================================= */

        .card {
            background: var(--white);

            border:
                1px solid var(--border);

            border-radius: var(--radius);

            padding: 24px;

            box-shadow: var(--shadow);

            margin-bottom: 18px;
        }

        .card:last-child {
            margin-bottom: 0;
        }

        .card-header {
            display: flex;

            align-items: flex-start;

            justify-content: space-between;

            gap: 15px;

            margin-bottom: 20px;

            padding-bottom: 15px;

            border-bottom:
                1px solid var(--border);
        }

        .card-header h2 {
            margin: 0;

            color: var(--dark);

            font-size: 17px;

            font-weight: 700;
        }

        .card-header p {
            margin: 4px 0 0;

            color: var(--muted);

            font-size: 12px;
        }


        /* =========================================================
           FORMS
        ========================================================= */

        label {
            display: block;

            margin: 15px 0 7px;

            font-weight: 700;

            font-size: 12px;

            color: #445066;
        }

        input,
        select,
        textarea {
            width: 100%;

            padding: 11px 12px;

            border:
                1px solid var(--border-dark);

            border-radius: 8px;

            background: #fff;

            color: var(--text);

            outline: none;

            transition:
                border-color .2s ease,
                box-shadow .2s ease;
        }

        input::placeholder,
        textarea::placeholder {
            color: #a3acba;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #93b4f5;

            box-shadow:
                0 0 0 3px rgba(37,99,235,.08);
        }

        textarea {
            min-height: 125px;

            resize: vertical;

            line-height: 1.55;
        }

        .small-textarea {
            min-height: 95px;
        }

        .row {
            display: grid;

            grid-template-columns:
                1fr 1fr;

            gap: 18px;
        }

        .row-3 {
            display: grid;

            grid-template-columns:
                1fr 1fr 1fr;

            gap: 18px;
        }

        .form-note {
            color: var(--muted);

            font-size: 11px;

            margin-top: 6px;
        }


        /* =========================================================
           BUTTONS
        ========================================================= */

        .button {
            border: none;

            border-radius: 8px;

            padding: 10px 15px;

            cursor: pointer;

            font-size: 12px;

            font-weight: 700;

            margin-top: 14px;

            transition:
                transform .2s ease,
                box-shadow .2s ease,
                opacity .2s ease;
        }

        .button:hover {
            transform: translateY(-1px);
            opacity: .96;
        }

        .button:active {
            transform: translateY(0);
        }

        .primary {
            background: var(--primary);

            color: white;

            box-shadow:
                0 4px 10px rgba(29,78,216,.13);
        }

        .primary:hover {
            background: var(--primary-dark);
        }

        .success {
            background: var(--success);
            color: white;
        }

        .danger {
            background: var(--danger);
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


        /* =========================================================
           DANGER ZONE
        ========================================================= */

        .danger-zone {
            border:
                1px solid #fecaca;

            background:
                var(--danger-soft);

            border-radius: 10px;

            padding: 17px;

            margin-top: 24px;
        }

        .danger-zone strong {
            color: #991b1b;

            font-size: 13px;
        }

        .danger-zone p {
            margin: 6px 0;

            color: #7f1d1d;
        }


        /* =========================================================
           TABLES
        ========================================================= */

        .table-wrapper {
            overflow-x: auto;

            border:
                1px solid var(--border);

            border-radius: 10px;

            margin-top: 20px;
        }

        table {
            width: 100%;

            border-collapse: collapse;

            margin: 0;

            min-width: 760px;
        }

        th,
        td {
            border-bottom:
                1px solid var(--border);

            padding: 11px;

            text-align: left;

            vertical-align: top;
        }

        tr:last-child td {
            border-bottom: none;
        }

        th {
            background: #f8fafc;

            color: #596579;

            font-size: 11px;

            text-transform: uppercase;

            letter-spacing: .4px;
        }

        td {
            font-size: 12px;
        }

        td form {
            margin: 0 0 6px;
        }

        td form:last-child {
            margin-bottom: 0;
        }

        td .button {
            margin-top: 0;
        }


        /* =========================================================
           IMAGE SECTION
        ========================================================= */

        .image-grid {
            display: grid;

            grid-template-columns:
                repeat(
                    auto-fill,
                    minmax(190px, 1fr)
                );

            gap: 16px;

            margin-top: 20px;
        }

        .image-card {
            border:
                1px solid var(--border);

            border-radius: 11px;

            overflow: hidden;

            background: white;

            transition:
                box-shadow .2s ease,
                transform .2s ease;
        }

        .image-card:hover {
            transform: translateY(-2px);

            box-shadow:
                var(--shadow-hover);
        }

        .image-card img {
            width: 100%;

            height: 145px;

            object-fit: cover;

            display: block;

            background: #f1f5f9;
        }

        .image-info {
            padding: 13px;
        }

        .image-info strong {
            display: block;

            color: var(--dark);

            font-size: 12px;

            word-break: break-word;
        }

        .cover {
            display: inline-block;

            background: #fef3c7;

            color: #92400e;

            padding: 4px 8px;

            border-radius: 5px;

            font-size: 10px;

            font-weight: 800;

            letter-spacing: .3px;

            margin-top: 6px;
        }

        .image-actions {
            margin-top: 9px;
        }

        .image-actions form {
            display: inline-block;

            margin-right: 4px;
        }

        .image-actions .button {
            margin-top: 5px;

            padding: 7px 9px;

            font-size: 10px;
        }


        /* =========================================================
           EMPTY STATE
        ========================================================= */

        .empty {
            padding: 35px 20px;

            text-align: center;

            color: var(--muted);

            font-size: 13px;
        }

        .empty-icon {
            width: 42px;
            height: 42px;

            display: flex;

            align-items: center;
            justify-content: center;

            margin: 0 auto 10px;

            border-radius: 50%;

            background: #f1f5f9;

            color: #64748b;

            font-size: 18px;
        }

        .muted {
            color: var(--muted);

            font-size: 12px;
        }


        /* =========================================================
           CREATE TOUR INTRO
        ========================================================= */

        .create-intro {
            background:
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #ffffff
                );

            border:
                1px solid #dbeafe;

            border-radius: 11px;

            padding: 16px;

            margin-bottom: 22px;

            color: #475569;

            font-size: 12px;
        }

        .create-intro strong {
            display: block;

            color: #1e40af;

            font-size: 13px;

            margin-bottom: 3px;
        }


        /* =========================================================
           RESPONSIVE
        ========================================================= */

        @media (max-width: 1100px) {

            .dashboard {
                grid-template-columns:
                    280px
                    minmax(0, 1fr);
            }

            .row-3 {
                grid-template-columns:
                    1fr 1fr;
            }
        }

        @media (max-width: 900px) {

            .header {
                padding: 24px;
            }

            .container {
                width: 94%;
            }

            .dashboard {
                grid-template-columns: 1fr;
            }

            .sidebar {
                position: static;
            }

            .tour-list {
                max-height: 350px;
            }
        }

        @media (max-width: 650px) {

            .container {
                width: 95%;
            }

            .card {
                padding: 18px;
            }

            .workspace-header {
                align-items: flex-start;

                flex-direction: column;
            }

            .row,
            .row-3 {
                grid-template-columns: 1fr;
            }

            .header h1 {
                font-size: 23px;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     HEADER
========================================================= -->

<div class="header">

    <div class="header-inner">

        <h1>Tour Management</h1>

        <p>
            Create, edit and manage tour packages,
            itinerary, hotels, details and images.
        </p>

    </div>

</div>


<div class="container">


    <!-- =====================================================
         MESSAGE
    ====================================================== -->

    <% if (message != null && !message.trim().isEmpty()) { %>

        <div class="message">

            <%= message %>

        </div>

    <% } %>


    <!-- =====================================================
         MAIN DASHBOARD
    ====================================================== -->

    <div class="dashboard">


        <!-- =================================================
             LEFT SIDE
        ================================================== -->

        <aside class="sidebar">


            <!-- SIDEBAR HEADER -->

            <div class="sidebar-header">

                <div class="sidebar-title-row">

                    <h2 class="sidebar-title">
                        Tour Packages
                    </h2>

                    <span class="tour-count">
                        <%= tours != null ? tours.size() : 0 %>
                    </span>

                </div>


                <p class="sidebar-subtitle">
                    Select a package to edit its
                    information and content.
                </p>


                <!-- NEW TOUR BUTTON -->

                <a
                    href="<%= request.getContextPath() %>/admin/tours"
                    class="add-tour-btn <%= createMode ? "active" : "" %>"
                >

                    <span class="plus-icon">+</span>

                    Create New Tour

                </a>


                <!-- TOUR SEARCH -->

                <div class="tour-search">

                    <span class="search-icon"></span>

                    <input
                        type="search"
                        id="tourSearch"
                        placeholder="Search tour packages..."
                        autocomplete="off"
                        aria-label="Search tour packages"
                    >

                    <button
                        type="button"
                        id="clearTourSearch"
                        class="clear-search"
                        aria-label="Clear search"
                    >
                        ×
                    </button>

                </div>

                <div
                    id="searchResultCount"
                    class="search-result-count"
                ></div>

            </div>


            <!-- =================================================
                 EXISTING TOUR LIST
            =================================================== -->

            <div class="tour-list" id="tourList">

                <%
                    if (tours != null && !tours.isEmpty()) {

                        for (
                            java.util.Map<String,Object> tour
                            : tours
                        ) {

                            Integer id = null;

                            if (tour.get("id") != null) {

                                id =
                                    ((Number)
                                        tour.get("id"))
                                        .intValue();
                            }

                            boolean active =
                                selectedTourId != null &&
                                selectedTourId.equals(id);

                            String status =
                                String.valueOf(
                                    tour.get("status")
                                );

                            boolean isActive =
                                "active".equalsIgnoreCase(status);
                %>


                    <!-- INDIVIDUAL TOUR -->

                    <a
                        href="<%= request.getContextPath() %>/admin/tours?tourId=<%= id %>"
                        class="tour-item <%= active ? "active" : "" %>"
                        data-tour-search="<%= String.valueOf(tour.get("name")) %> <%= String.valueOf(tour.get("category")) %> <%= String.valueOf(tour.get("departure_city")) %> <%= String.valueOf(tour.get("duration")) %> <%= String.valueOf(tour.get("price")) %> <%= status %>"
                    >

                        <div class="tour-name">

                            <%= tour.get("name") %>

                        </div>


                        <div class="tour-meta">

                            <strong>
                                <%= tour.get("category") %>
                            </strong>

                            <br>

                            <%= tour.get("duration") %> days
                            · ₹<%= tour.get("price") %>

                            <br>

                            <%= tour.get("departure_city") %>

                        </div>


                        <span
                            class="status-badge <%= isActive
                                ? "status-active"
                                : "status-inactive" %>"
                        >

                            <%= status %>

                        </span>

                    </a>


                <%
                        }

                    } else {
                %>


                    <!-- NO TOURS -->

                    <div class="empty">

                        <div class="empty-icon">
                            +
                        </div>

                        No tour packages created yet.

                    </div>


                <%
                    }
                %>


                <!-- SEARCH EMPTY STATE -->

                <div
                    id="searchEmpty"
                    class="search-empty"
                >

                    <div class="search-empty-icon">
                        ⌕
                    </div>

                    No matching tour packages found.

                </div>

            </div>

        </aside>



        <!-- =================================================
             RIGHT SIDE WORKSPACE
        =================================================== -->

        <main class="workspace">


            <!-- =================================================
                 WORKSPACE HEADER
            =================================================== -->

            <div class="workspace-header">

                <div class="workspace-title">

                    <% if (createMode) { %>

                        <small>
                            Tour Management
                        </small>

                        <h2>
                            Create a New Tour Package
                        </h2>

                        <p>
                            Add a new package to your tour collection.
                        </p>

                    <% } else { %>

                        <small>
                            Editing Tour Package
                        </small>

                        <h2>
                            <%= selectedTour.get("name") %>
                        </h2>

                        <p>
                            Manage all information related to this package.
                        </p>

                    <% } %>

                </div>


                <div class="workspace-badge">

                    <%= createMode
                            ? "NEW PACKAGE"
                            : "PACKAGE #" + selectedTour.get("id") %>

                </div>

            </div>



            <!-- =================================================
                 CREATE NEW TOUR
            ================================================= -->

            <% if (createMode) { %>


                <div class="card">

                    <div class="card-header">

                        <div>

                            <h2>
                                Create New Tour
                            </h2>

                            <p>
                                Enter the basic information for the
                                new tour package.
                            </p>

                        </div>

                    </div>


                    <div class="create-intro">

                        <strong>
                            New tour package
                        </strong>

                        After creating the tour, it will immediately
                        become available in the left-side package list.
                        Select it from there to manage its complete
                        details, itinerary, hotels and images.

                    </div>


                                        <form id="createTourForm" method="post" action="<%= request.getContextPath() %>/admin/tours">
                        <input type="hidden" name="action" value="createTour">
                        
                        <div style="display: flex; gap: 10px; align-items: flex-end; margin-bottom: 20px;">
                            <div style="flex: 1;">
                                <label style="margin-bottom: 5px; display: block;">Tour Name</label>
                                <input type="text" id="tourName" name="name" required maxlength="150" placeholder="Example: Goa Beach Holiday" style="margin-bottom: 0;">
                            </div>
                            <button type="button" class="button primary" onclick="generateDetails()" id="btnGenerate" style="white-space: nowrap;">
                                ✨ Generate Details
                            </button>
                        </div>

                        <div class="row">
                            <div><label>Category</label><input type="text" id="category" name="category" required maxlength="50" placeholder="Nature"></div>
                            <div><label>Departure City</label><input type="text" id="departureCity" name="departure_city" required maxlength="50" placeholder="Mumbai"></div>
                        </div>

                        <div class="row">
                            <div><label>Duration (Days)</label><input type="number" id="duration" name="duration" min="1" required placeholder="5"></div>
                            <div><label>Price</label><input type="number" id="price" name="price" min="0" step="0.01" required placeholder="24999"></div>
                        </div>
                        
                        <label>Short Description (1-2 sentences)</label>
                        <input type="text" id="shortDescription" name="short_description" required placeholder="A beautiful trip..." maxlength="255">

                        <label>Long Description (Min 250 chars)</label>
                        <textarea id="longDescription" name="long_description" required minlength="250" class="small-textarea"></textarea>

                        <div class="row">
                            <div><label>Duration Text</label><input type="text" id="durationText" name="duration_text" required placeholder="5 Days / 4 Nights"></div>
                            <div><label>Best Time</label><input type="text" id="bestTime" name="best_time" required placeholder="October to March"></div>
                        </div>

                        <div class="row">
                            <div><label>States Covered</label><input type="text" id="statesCovered" name="states_covered" required></div>
                            <div><label>Cities Covered</label><input type="text" id="citiesCovered" name="cities_covered" required></div>
                        </div>

                        <label>Route</label>
                        <textarea id="route" name="route" required class="small-textarea"></textarea>

                        <label>Highlights</label>
                        <textarea id="highlights" name="highlights" required class="small-textarea"></textarea>

                        <label>Inclusions</label>
                        <textarea id="inclusions" name="inclusions" required class="small-textarea"></textarea>

                        <label>Exclusions</label>
                        <textarea id="exclusions" name="exclusions" required class="small-textarea"></textarea>

                        <label>Preparation</label>
                        <textarea id="preparation" name="preparation" required class="small-textarea"></textarea>

                        <label>Payment Terms</label>
                        <textarea id="paymentTerms" name="payment_terms" required class="small-textarea"></textarea>

                        <label>Upgrades Information</label>
                        <textarea id="upgradesInfo" name="upgrades_info" required class="small-textarea"></textarea>

                        <label>Status</label>
                        <select name="status">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>

                        <button type="submit" class="button primary">Create Tour Package & Auto-Embed</button>
                    </form>

                    <script>
                    function generateDetails() {
                        const title = document.getElementById('tourName').value;
                        if (!title) {
                            alert('Please enter a tour name first!');
                            return;
                        }
                        const btn = document.getElementById('btnGenerate');
                        btn.disabled = true;
                        btn.innerText = '✨ Generating...';
                        
                        fetch('<%= request.getContextPath() %>/admin/generate-details', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ title: title })
                        })
                        .then(res => res.json())
                        .then(data => {
                            btn.disabled = false;
                            btn.innerText = '✨ Generate Details';
                            
                            if(data.error) {
                                alert('Error: ' + data.error);
                                return;
                            }
                            
                            // Parse Gemini format
                            let jsonStr = data.candidates[0].content.parts[0].text;
                            jsonStr = jsonStr.replace(/```json/g, '').replace(/```/g, ''); // strip markdown if any
                            const details = JSON.parse(jsonStr);
                            
                            if(details.category) document.getElementById('category').value = details.category;
                            if(details.departureCity) document.getElementById('departureCity').value = details.departureCity;
                            if(details.duration) document.getElementById('duration').value = details.duration;
                            if(details.price) document.getElementById('price').value = details.price;
                            if(details.shortDescription) document.getElementById('shortDescription').value = details.shortDescription;
                            if(details.longDescription) document.getElementById('longDescription').value = details.longDescription;
                            if(details.durationText) document.getElementById('durationText').value = details.durationText;
                            if(details.bestTime) document.getElementById('bestTime').value = details.bestTime;
                            if(details.statesCovered) document.getElementById('statesCovered').value = details.statesCovered;
                            if(details.citiesCovered) document.getElementById('citiesCovered').value = details.citiesCovered;
                            if(details.route) document.getElementById('route').value = details.route;
                            if(details.highlights) document.getElementById('highlights').value = details.highlights;
                            if(details.inclusions) document.getElementById('inclusions').value = details.inclusions;
                            if(details.exclusions) document.getElementById('exclusions').value = details.exclusions;
                            if(details.preparation) document.getElementById('preparation').value = details.preparation;
                            if(details.paymentTerms) document.getElementById('paymentTerms').value = details.paymentTerms;
                            if(details.upgradesInfo) document.getElementById('upgradesInfo').value = details.upgradesInfo;
                        })
                        .catch(err => {
                            btn.disabled = false;
                            btn.innerText = '✨ Generate Details';
                            alert('An error occurred. See console.');
                            console.error(err);
                        });
                    }
                    </script>


                </div>


            <% } else { %>


                <!-- =================================================
                     EDIT EXISTING TOUR
                ================================================== -->


                <!-- =================================================
                     BASIC TOUR INFORMATION
                ================================================== -->

                <div class="card">

                    <div class="card-header">

                        <div>

                            <h2>
                                Basic Tour Information
                            </h2>

                            <p>
                                Update the primary information
                                displayed for this package.
                            </p>

                        </div>

                    </div>


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


                        <label>
                            Tour Name
                        </label>

                        <input
                            type="text"
                            name="name"
                            value="<%= selectedTour.get("name") %>"
                            required
                            maxlength="150"
                        >


                        <div class="row">

                            <div>

                                <label>
                                    Category
                                </label>

                                <input
                                    type="text"
                                    name="category"
                                    value="<%= selectedTour.get("category") %>"
                                    required
                                    maxlength="50"
                                >

                            </div>


                            <div>

                                <label>
                                    Departure City
                                </label>

                                <input
                                    type="text"
                                    name="departure_city"
                                    value="<%= selectedTour.get("departure_city") %>"
                                    required
                                    maxlength="50"
                                >

                            </div>

                        </div>


                        <div class="row-3">

                            <div>

                                <label>
                                    Duration
                                </label>

                                <input
                                    type="number"
                                    name="duration"
                                    value="<%= selectedTour.get("duration") %>"
                                    min="1"
                                    required
                                >

                            </div>


                            <div>

                                <label>
                                    Price
                                </label>

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

                                <label>
                                    Status
                                </label>

                                <select name="status">

                                    <option
                                        value="active"
                                        <%= "active".equals(
                                            String.valueOf(
                                                selectedTour.get("status")
                                            )
                                        ) ? "selected" : "" %>
                                    >
                                        Active
                                    </option>

                                    <option
                                        value="inactive"
                                        <%= "inactive".equals(
                                            String.valueOf(
                                                selectedTour.get("status")
                                            )
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


                    <!-- DELETE TOUR -->

                    <div class="danger-zone">

                        <strong>
                            Delete this tour
                        </strong>

                        <p class="muted">
                            Deleting the tour will also delete its
                            details, images, itinerary and hotel
                            records because your database uses
                            ON DELETE CASCADE.
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



                <!-- =================================================
                     TOUR DETAILS
                ================================================== -->

                <%
                    java.util.Map<String,Object> details =
                            (java.util.Map<String,Object>)
                                request.getAttribute("tourDetails");
                %>


                <div class="card">

                    <div class="card-header">

                        <div>

                            <h2>
                                Tour Details
                            </h2>

                            <p>
                                Add the description, route,
                                highlights and other package information.
                            </p>

                        </div>

                    </div>


                    <form
                        method="post"
                        action="<%= request.getContextPath() %>/admin/tours"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="updateDetails"
                        >

                        <input
                            type="hidden"
                            name="tourId"
                            value="<%= selectedTour.get("id") %>"
                        >


                        <label>
                            Long Description
                        </label>

                        <textarea name="long_description"><%=
                            details != null &&
                            details.get("long_description") != null
                            ? details.get("long_description")
                            : ""
                        %></textarea>


                        <div class="row">

                            <div>

                                <label>
                                    Duration Text
                                </label>

                                <input
                                    type="text"
                                    name="duration_text"
                                    value="<%=
                                        details != null &&
                                        details.get("duration_text") != null
                                        ? details.get("duration_text")
                                        : ""
                                    %>"
                                    placeholder="5 Days / 4 Nights"
                                >

                            </div>


                            <div>

                                <label>
                                    Best Time
                                </label>

                                <input
                                    type="text"
                                    name="best_time"
                                    value="<%=
                                        details != null &&
                                        details.get("best_time") != null
                                        ? details.get("best_time")
                                        : ""
                                    %>"
                                    placeholder="October to March"
                                >

                            </div>

                        </div>


                        <div class="row">

                            <div>

                                <label>
                                    States Covered
                                </label>

                                <input
                                    type="text"
                                    name="states_covered"
                                    value="<%=
                                        details != null &&
                                        details.get("states_covered") != null
                                        ? details.get("states_covered")
                                        : ""
                                    %>"
                                >

                            </div>


                            <div>

                                <label>
                                    Cities Covered
                                </label>

                                <input
                                    type="text"
                                    name="cities_covered"
                                    value="<%=
                                        details != null &&
                                        details.get("cities_covered") != null
                                        ? details.get("cities_covered")
                                        : ""
                                    %>"
                                >

                            </div>

                        </div>


                        <label>
                            Route
                        </label>

                        <textarea
                            name="route"
                            class="small-textarea"
                        ><%=
                            details != null &&
                            details.get("route") != null
                            ? details.get("route")
                            : ""
                        %></textarea>


                        <label>
                            Highlights
                        </label>

                        <textarea
                            name="highlights"
                            class="small-textarea"
                        ><%=
                            details != null &&
                            details.get("highlights") != null
                            ? details.get("highlights")
                            : ""
                        %></textarea>


                        <label>
                            Inclusions
                        </label>

                        <textarea
                            name="inclusions"
                            class="small-textarea"
                        ><%=
                            details != null &&
                            details.get("inclusions") != null
                            ? details.get("inclusions")
                            : ""
                        %></textarea>


                        <label>
                            Exclusions
                        </label>

                        <textarea
                            name="exclusions"
                            class="small-textarea"
                        ><%=
                            details != null &&
                            details.get("exclusions") != null
                            ? details.get("exclusions")
                            : ""
                        %></textarea>


                        <label>
                            Preparation
                        </label>

                        <textarea
                            name="preparation"
                            class="small-textarea"
                        ><%=
                            details != null &&
                            details.get("preparation") != null
                            ? details.get("preparation")
                            : ""
                        %></textarea>


                        <label>
                            Payment Terms
                        </label>

                        <textarea
                            name="payment_terms"
                            class="small-textarea"
                        ><%=
                            details != null &&
                            details.get("payment_terms") != null
                            ? details.get("payment_terms")
                            : ""
                        %></textarea>


                        <label>
                            Upgrades Information
                        </label>

                        <textarea
                            name="upgrades_info"
                            class="small-textarea"
                        ><%=
                            details != null &&
                            details.get("upgrades_info") != null
                            ? details.get("upgrades_info")
                            : ""
                        %></textarea>


                        <label>
                            Google Maps Embed URL
                        </label>

                        <textarea
                            name="map_embed"
                            class="small-textarea"
                            placeholder="https://www.google.com/maps/embed?..."
                        ><%=
                            details != null &&
                            details.get("map_embed") != null
                            ? details.get("map_embed")
                            : ""
                        %></textarea>


                        <button
                            type="submit"
                            class="button success"
                        >
                            Save Tour Details
                        </button>

                    </form>

                </div>



                <!-- =================================================
                     ITINERARY
                ================================================== -->

                <div class="card">

                    <div class="card-header">

                        <div>

                            <h2>
                                Tour Itinerary
                            </h2>

                            <p>
                                Build and manage the day-by-day
                                travel schedule.
                            </p>

                        </div>

                    </div>


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

                                <label>
                                    Day Number
                                </label>

                                <input
                                    type="number"
                                    name="day_number"
                                    min="1"
                                    required
                                >

                            </div>


                            <div>

                                <label>
                                    Day Title
                                </label>

                                <input
                                    type="text"
                                    name="day_title"
                                    maxlength="150"
                                    required
                                    placeholder="Arrival & City Tour"
                                >

                            </div>

                        </div>


                        <label>
                            Day Description
                        </label>

                        <textarea
                            name="day_description"
                            required
                            placeholder="Describe the activities, sightseeing and experiences for this day..."
                        ></textarea>


                        <button
                            type="submit"
                            class="button primary"
                        >
                            Add Itinerary Day
                        </button>

                    </form>


                    <%
                        java.util.List<java.util.Map<String,Object>> itinerary =
                            (java.util.List<java.util.Map<String,Object>>)
                                request.getAttribute("itinerary");
                    %>


                    <% if (itinerary != null &&
                           !itinerary.isEmpty()) { %>


                        <div class="table-wrapper">

                            <table>

                                <thead>

                                    <tr>

                                        <th>Day</th>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Action</th>

                                    </tr>

                                </thead>


                                <tbody>

                                <% for (
                                    java.util.Map<String,Object> day
                                    : itinerary
                                ) { %>


                                    <tr>

                                        <td colspan="4">

                                            <form
                                                method="post"
                                                action="<%= request.getContextPath() %>/admin/tours"
                                                style="margin:0;"
                                            >

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
                                                    name="id"
                                                    value="<%= day.get("id") %>"
                                                >


                                                <div
                                                    style="
                                                        display:grid;
                                                        grid-template-columns:
                                                            90px
                                                            1fr
                                                            2fr
                                                            160px;
                                                        gap:12px;
                                                        align-items:start;
                                                    "
                                                >

                                                    <div>

                                                        <input
                                                            type="number"
                                                            name="day_number"
                                                            value="<%= day.get("day_number") %>"
                                                            min="1"
                                                            required
                                                        >

                                                    </div>


                                                    <div>

                                                        <input
                                                            type="text"
                                                            name="day_title"
                                                            value="<%= day.get("day_title") %>"
                                                            required
                                                        >

                                                    </div>


                                                    <div>

                                                        <textarea
                                                            name="day_description"
                                                            class="small-textarea"
                                                            required
                                                        ><%= day.get("day_description") %></textarea>

                                                    </div>


                                                    <div>

                                                        <button
                                                            type="submit"
                                                            class="button primary"
                                                        >
                                                            Save
                                                        </button>

                                                    </div>

                                                </div>

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
                                                    name="id"
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

                                </tbody>

                            </table>

                        </div>


                    <% } else { %>


                        <div class="empty">

                            <div class="empty-icon">
                                +
                            </div>

                            No itinerary days added yet.

                        </div>


                    <% } %>

                </div>



                <!-- =================================================
                     HOTELS
                ================================================== -->

                <div class="card">

                    <div class="card-header">

                        <div>

                            <h2>
                                Hotels
                            </h2>

                            <p>
                                Add accommodation information
                                for the tour.
                            </p>

                        </div>

                    </div>


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

                                <label>
                                    City
                                </label>

                                <input
                                    type="text"
                                    name="city"
                                    maxlength="100"
                                    required
                                >

                            </div>


                            <div>

                                <label>
                                    Hotel Name
                                </label>

                                <input
                                    type="text"
                                    name="hotel_name"
                                    maxlength="150"
                                    required
                                >

                            </div>

                        </div>


                        <div class="row">

                            <div>

                                <label>
                                    Check In
                                </label>

                                <input
                                    type="date"
                                    name="check_in"
                                >

                            </div>


                            <div>

                                <label>
                                    Check Out
                                </label>

                                <input
                                    type="date"
                                    name="check_out"
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
                        java.util.List<java.util.Map<String,Object>> hotels =
                            (java.util.List<java.util.Map<String,Object>>)
                                request.getAttribute("hotels");
                    %>


                    <% if (hotels != null &&
                           !hotels.isEmpty()) { %>


                        <div class="table-wrapper">

                            <table>

                                <thead>

                                    <tr>

                                        <th>City</th>
                                        <th>Hotel</th>
                                        <th>Check In</th>
                                        <th>Check Out</th>
                                        <th>Action</th>

                                    </tr>

                                </thead>


                                <tbody>

                                <% for (
                                    java.util.Map<String,Object> hotel
                                    : hotels
                                ) { %>


                                    <tr>

                                        <td>
                                            <%= hotel.get("city") %>
                                        </td>


                                        <td>

                                            <strong>
                                                <%= hotel.get("hotel_name") %>
                                            </strong>

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
                                                onsubmit="return confirm('Delete this hotel?');"
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
                                                    name="id"
                                                    value="<%= hotel.get("id") %>"
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

                                </tbody>

                            </table>

                        </div>


                    <% } else { %>


                        <div class="empty">

                            <div class="empty-icon">
                                +
                            </div>

                            No hotels added yet.

                        </div>


                    <% } %>

                </div>



                <!-- =================================================
                     COVER & GALLERY IMAGES (BLOB)
                ================================================== -->

                <div class="card">

                    <div class="card-header">

                        <div>

                            <h2>
                                Cover &amp; Gallery Images
                            </h2>

                            <p>
                                Upload images for this tour. They are
                                stored as BLOB in the database.
                                Cover images appear on the tour hero;
                                all uploaded images appear in the
                                Gallery section on the tour details page.
                            </p>

                        </div>

                    </div>


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


                        <label>
                            Add Gallery Image
                        </label>

                        <input
                            type="file"
                            name="image"
                            accept="image/jpeg,image/png,image/webp,image/gif"
                            required
                        >


                        <label>

                            <input
                                type="checkbox"
                                name="is_cover"
                                value="true"
                                style="width:auto;margin-right:6px;"
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
                        java.util.List<java.util.Map<String,Object>> images =
                            (java.util.List<java.util.Map<String,Object>>)
                                request.getAttribute("images");
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


                                        <%
                                            boolean isCover =
                                                Boolean.TRUE.equals(
                                                    image.get("is_cover")
                                                );
                                        %>


                                        <% if (isCover) { %>

                                            <span class="cover">
                                                COVER IMAGE
                                            </span>

                                        <% } %>


                                        <div class="image-actions">


                                            <% if (!isCover) { %>


                                                <form
                                                    method="post"
                                                    action="<%= request.getContextPath() %>/admin/tours"
                                                >

                                                    <input
                                                        type="hidden"
                                                        name="action"
                                                        value="setCoverImage"
                                                    >

                                                    <input
                                                        type="hidden"
                                                        name="tourId"
                                                        value="<%= selectedTour.get("id") %>"
                                                    >

                                                    <input
                                                        type="hidden"
                                                        name="id"
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
                                                    name="id"
                                                    value="<%= image.get("id") %>"
                                                >

                                                <button
                                                    type="submit"
                                                    class="button danger"
                                                >
                                                    Delete
                                                </button>

                                            </form>


                                        </div>

                                    </div>

                                </div>


                            <% } %>

                        </div>


                    <% } else { %>


                        <div class="empty">

                            <div class="empty-icon">
                                +
                            </div>

                            No images uploaded for this tour.

                        </div>


                    <% } %>

                </div>


            <% } %>


        </main>

    </div>

</div>


<!-- =========================================================
     TOUR SEARCH JAVASCRIPT
========================================================= -->

<script>

    document.addEventListener("DOMContentLoaded", function () {

        const searchInput =
            document.getElementById("tourSearch");

        const clearButton =
            document.getElementById("clearTourSearch");

        const resultCount =
            document.getElementById("searchResultCount");

        const searchEmpty =
            document.getElementById("searchEmpty");

        const tourItems =
            Array.from(
                document.querySelectorAll(".tour-item")
            );


        if (!searchInput || !tourItems.length) {
            return;
        }


        function performTourSearch() {

            const query =
                searchInput.value
                    .trim()
                    .toLowerCase();


            let visibleCount = 0;


            tourItems.forEach(function (tour) {

                const searchableText =
                    (
                        tour.getAttribute("data-tour-search")
                        || ""
                    ).toLowerCase();


                const matches =
                    query === ""
                    ||
                    searchableText.includes(query);


                if (matches) {

                    tour.classList.remove(
                        "search-hidden"
                    );

                    visibleCount++;

                } else {

                    tour.classList.add(
                        "search-hidden"
                    );

                }

            });


            if (query.length > 0) {

                clearButton.style.display = "flex";

            } else {

                clearButton.style.display = "none";

            }


            if (query.length > 0) {

                resultCount.style.display = "block";


                if (visibleCount === 1) {

                    resultCount.textContent =
                        "1 tour package found";

                } else {

                    resultCount.textContent =
                        visibleCount +
                        " tour packages found";

                }

            } else {

                resultCount.style.display = "none";

                resultCount.textContent = "";

            }


            if (
                query.length > 0 &&
                visibleCount === 0
            ) {

                searchEmpty.classList.add(
                    "visible"
                );

            } else {

                searchEmpty.classList.remove(
                    "visible"
                );

            }

        }


        searchInput.addEventListener(
            "input",
            performTourSearch
        );


        clearButton.addEventListener(
            "click",
            function () {

                searchInput.value = "";

                performTourSearch();

                searchInput.focus();

            }
        );


        searchInput.addEventListener(
            "keydown",
            function (event) {

                if (event.key === "Escape") {

                    searchInput.value = "";

                    performTourSearch();

                }

            }
        );

    });

</script>


</body>

</html>