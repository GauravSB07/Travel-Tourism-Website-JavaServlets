<%@ page
    contentType="text/html;charset=UTF-8"
    language="java"
%>

<%@ page import="java.util.List" %>
<%@ page import="com.traveltourism.controller.SavedToursServlet.SavedTour" %>
<%@ page import="com.traveltourism.model.Tour" %>
<%@ page import="com.traveltourism.model.HolidayPackage" %>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>
        Saved Tours | Travel & Tourism
    </title>


    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/style.css"
    >

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/user-dashboard.css"
    >


    <style>

        /* =========================================================
           PAGE
           ========================================================= */

        .saved-page {

            max-width: 1200px;

            margin: 0 auto;

            padding: 60px 25px 90px;
        }


        /* =========================================================
           HEADER
           ========================================================= */

        .saved-header {

            margin-bottom: 35px;
        }

        .saved-eyebrow {

            color: #e88a3d;

            font-size: 12px;

            font-weight: 700;

            letter-spacing: 1.5px;

            margin-bottom: 8px;
        }

        .saved-header h1 {

            margin: 0 0 10px;

            color: #173f5f;

            font-size: 40px;
        }

        .saved-header p {

            margin: 0;

            color: #6b7280;

            font-size: 15px;

            line-height: 1.7;
        }


        /* =========================================================
           GRID
           ========================================================= */

        .saved-grid {

            display: grid;

            grid-template-columns:
                repeat(auto-fill, minmax(300px, 1fr));

            gap: 26px;
        }


        /* =========================================================
           CARD
           ========================================================= */

        .saved-card {

            overflow: hidden;

            background: #ffffff;

            border: 1px solid #e8ebee;

            border-radius: 16px;

            box-shadow:
                0 8px 30px rgba(0,0,0,0.07);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;
        }

        .saved-card:hover {

            transform: translateY(-5px);

            box-shadow:
                0 15px 35px rgba(0,0,0,0.11);
        }


        /* =========================================================
           IMAGE
           ========================================================= */

        .saved-image-wrapper {

            position: relative;

            height: 220px;

            overflow: hidden;

            background: #f1f3f5;
        }

        .saved-image-wrapper img {

            width: 100%;

            height: 100%;

            object-fit: cover;

            display: block;

            transition:
                transform 0.4s ease;
        }

        .saved-card:hover
        .saved-image-wrapper img {

            transform: scale(1.04);
        }


        .saved-image-placeholder {

            width: 100%;

            height: 100%;

            display: flex;

            align-items: center;

            justify-content: center;

            color: #777;

            font-size: 13px;
        }


        /* =========================================================
           HEART
           ========================================================= */

        .saved-heart {

            position: absolute;

            top: 14px;

            right: 14px;

            width: 42px;

            height: 42px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 50%;

            background: rgba(255,255,255,0.95);

            color: #e53935;

            font-size: 24px;

            box-shadow:
                0 5px 16px rgba(0,0,0,0.15);
        }


        /* =========================================================
           CONTENT
           ========================================================= */

        .saved-content {

            padding: 22px;
        }


        .saved-type {

            display: inline-block;

            padding: 6px 10px;

            margin-bottom: 12px;

            border-radius: 20px;

            background: #fff2e8;

            color: #c96d2a;

            font-size: 10px;

            font-weight: 700;

            letter-spacing: 0.7px;

            text-transform: uppercase;
        }


        .saved-content h3 {

            margin: 0 0 9px;

            color: #173f5f;

            font-size: 21px;

            line-height: 1.35;
        }


        .saved-content h3 a {

            color: inherit;

            text-decoration: none;
        }

        .saved-content h3 a:hover {

            color: #e88a3d;
        }


        .saved-description {

            min-height: 43px;

            margin: 0 0 18px;

            color: #6b7280;

            font-size: 13px;

            line-height: 1.65;
        }


        /* =========================================================
           META
           ========================================================= */

        .saved-meta {

            display: flex;

            flex-wrap: wrap;

            gap: 8px 15px;

            margin-bottom: 20px;

            color: #59636e;

            font-size: 12px;

            font-weight: 600;
        }


        /* =========================================================
           PRICE
           ========================================================= */

        .saved-price {

            margin-bottom: 20px;

            color: #173f5f;

            font-size: 20px;

            font-weight: 700;
        }

        .saved-price small {

            margin-left: 5px;

            color: #777;

            font-size: 11px;

            font-weight: 400;
        }


        /* =========================================================
           ACTIONS
           ========================================================= */

        .saved-actions {

            display: flex;

            gap: 10px;

            flex-wrap: wrap;
        }


        .saved-btn {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            min-height: 40px;

            padding: 0 16px;

            border-radius: 7px;

            text-decoration: none;

            font-size: 13px;

            font-weight: 600;

            transition:
                transform 0.2s ease,
                background 0.2s ease;
        }


        .saved-btn:hover {

            transform: translateY(-1px);
        }


        .view-btn {

            background: #173f5f;

            color: #ffffff;
        }

        .view-btn:hover {

            background: #102f48;
        }


        .remove-btn {

            background: #f3f4f6;

            color: #374151;
        }

        .remove-btn:hover {

            background: #e5e7eb;
        }


        /* =========================================================
           EMPTY
           ========================================================= */

        .empty-saved {

            padding: 80px 25px;

            text-align: center;

            background: #fafafa;

            border: 1px solid #eeeeee;

            border-radius: 18px;
        }


        .empty-heart {

            margin-bottom: 15px;

            color: #e88a3d;

            font-size: 55px;

            line-height: 1;
        }


        .empty-saved h2 {

            margin: 0 0 10px;

            color: #173f5f;

            font-size: 25px;
        }


        .empty-saved p {

            max-width: 500px;

            margin: 0 auto 25px;

            color: #666;

            line-height: 1.7;

            font-size: 14px;
        }


        .browse-btn {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            min-height: 44px;

            padding: 0 22px;

            background: #173f5f;

            color: #ffffff;

            border-radius: 7px;

            text-decoration: none;

            font-size: 13px;

            font-weight: 600;
        }


        /* =========================================================
           MOBILE
           ========================================================= */

        @media (max-width: 600px) {

            .saved-page {

                padding: 40px 18px 65px;
            }

            .saved-header h1 {

                font-size: 32px;
            }

            .saved-grid {

                grid-template-columns: 1fr;
            }

            .saved-image-wrapper {

                height: 205px;
            }
        }

    </style>

</head>


<body>


<jsp:include
    page="../../common/header.jsp"
/>


<main class="saved-page">


    <!-- PAGE HEADER -->

    <div class="saved-header">

        <p class="saved-eyebrow">
            YOUR JOURNEYS
        </p>

        <h1>
            Saved Tours
        </h1>

        <p>
            Keep your favourite journeys here
            and come back whenever you are ready
            to plan your next adventure.
        </p>

    </div>


    <%
        List<SavedTour> savedTours =
            (List<SavedTour>)
            request.getAttribute("savedTours");
    %>


    <!-- EMPTY STATE -->

    <% if (savedTours == null
            || savedTours.isEmpty()) { %>


        <div class="empty-saved">

            <div class="empty-heart">
                ♡
            </div>

            <h2>
                No Saved Tours Yet
            </h2>

            <p>
                Explore our destinations and click
                the heart on any journey you love.
                Your saved tours will appear here.
            </p>

            <a
                class="browse-btn"
                href="${pageContext.request.contextPath}/destinations"
            >
                Explore Destinations →
            </a>

        </div>


    <% } else { %>


        <!-- SAVED TOUR GRID -->

        <div class="saved-grid">


            <%
                for (SavedTour savedTour : savedTours) {

                    Tour tour =
                        savedTour.getTour();

                    HolidayPackage holiday =
                        savedTour.getHoliday();

                    boolean isDestination =
                        "destination".equals(
                            savedTour.getTourType()
                        );

                    boolean isHoliday =
                        "holiday".equals(
                            savedTour.getTourType()
                        );
            %>


            <!-- =================================================
                 DESTINATION TOUR
                 ================================================= -->

            <% if (isDestination && tour != null) { %>


                <article class="saved-card">


                    <div class="saved-image-wrapper">


                        <% if (tour.getImageId() > 0) { %>

                            <img
                                src="${pageContext.request.contextPath}/TourImageServlet?id=<%= tour.getImageId() %>"
                                alt="<%= tour.getName() %>"
                                loading="lazy"
                            >

                        <% } else { %>

                            <div class="saved-image-placeholder">
                                Tour photograph not available
                            </div>

                        <% } %>


                        <span class="saved-heart">
                            ♥
                        </span>


                    </div>


                    <div class="saved-content">


                        <span class="saved-type">

                            <%= tour.getCategory() %>

                        </span>


                        <h3>

                            <a
                                href="${pageContext.request.contextPath}/tour-details?id=<%= tour.getId() %>"
                            >
                                <%= tour.getName() %>
                            </a>

                        </h3>


                        <%
                            String description =
                                tour.getShortDescription();

                            if (description == null
                                    || description.isBlank()) {

                                description =
                                    "Discover this beautiful journey with TravelTourism.";
                            }

                            if (description.length() > 120) {

                                description =
                                    description.substring(
                                        0,
                                        120
                                    )
                                    + "...";
                            }
                        %>


                        <p class="saved-description">
                            <%= description %>
                        </p>


                        <div class="saved-meta">

                            <span>
                                📍
                                <%= tour.getDepartureCity() %>
                            </span>

                            <span>
                                🕒
                                <%= tour.getDuration() %> DAYS
                            </span>

                        </div>


                        <div class="saved-price">

                            ₹<%= String.format(
                                "%,d",
                                tour.getPrice()
                            ) %>

                            <small>
                                per person
                            </small>

                        </div>


                        <div class="saved-actions">


                            <a
                                class="saved-btn view-btn"
                                href="${pageContext.request.contextPath}/tour-details?id=<%= tour.getId() %>"
                            >
                                View Tour →
                            </a>


                            <a
                                class="saved-btn remove-btn"
                                href="${pageContext.request.contextPath}/remove-saved-tour?tour_id=<%= tour.getId() %>&tour_type=destination&return_url=/saved-tours"
                            >
                                Remove
                            </a>


                        </div>


                    </div>


                </article>


            <!-- =================================================
                 CUSTOMIZED HOLIDAY
                 ================================================= -->

            <% } else if (isHoliday && holiday != null) { %>


                <article class="saved-card">


                    <div class="saved-image-wrapper">


                        <img
                            src="${pageContext.request.contextPath}/holiday-image?id=<%= holiday.getId() %>"
                            alt="<%= holiday.getName() %>"
                            loading="lazy"
                        >


                        <span class="saved-heart">
                            ♥
                        </span>


                    </div>


                    <div class="saved-content">


                        <span class="saved-type">

                            <%= holiday.getOccasion() %>

                        </span>


                        <h3>

                            <a
                                href="${pageContext.request.contextPath}/holiday-details?id=<%= holiday.getId() %>"
                            >
                                <%= holiday.getName() %>
                            </a>

                        </h3>


                        <%
                            String holidayDescription =
                                holiday.getShortDescription();

                            if (holidayDescription == null
                                    || holidayDescription.isBlank()) {

                                holidayDescription =
                                    "A special holiday designed around your occasion.";
                            }

                            if (holidayDescription.length() > 120) {

                                holidayDescription =
                                    holidayDescription.substring(
                                        0,
                                        120
                                    )
                                    + "...";
                            }
                        %>


                        <p class="saved-description">

                            <%= holidayDescription %>

                        </p>


                        <div class="saved-meta">

                            <span>
                                📍
                                <%= holiday.getDepartureCity() %>
                            </span>

                            <span>
                                🕒
                                <%= holiday.getDuration() %> DAYS
                            </span>

                        </div>


                        <div class="saved-price">

                            ₹<%= String.format(
                                "%,d",
                                holiday.getPrice()
                            ) %>

                            <small>
                                per person
                            </small>

                        </div>


                        <div class="saved-actions">


                            <a
                                class="saved-btn view-btn"
                                href="${pageContext.request.contextPath}/holiday-details?id=<%= holiday.getId() %>"
                            >
                                View Holiday →
                            </a>


                            <a
                                class="saved-btn remove-btn"
                                href="${pageContext.request.contextPath}/remove-saved-tour?tour_id=<%= holiday.getId() %>&tour_type=holiday&return_url=/saved-tours"
                            >
                                Remove
                            </a>


                        </div>


                    </div>


                </article>


            <!-- =================================================
                 MISSING ORIGINAL PACKAGE
                 ================================================= -->

            <% } else { %>


                <article class="saved-card">


                    <div class="saved-content">


                        <span class="saved-type">
                            <%= savedTour.getTourType() %>
                        </span>


                        <h3>
                            This tour is no longer available
                        </h3>


                        <p class="saved-description">

                            This saved package could not be
                            found in the current tour collection.

                        </p>


                        <div class="saved-meta">

                            <span>
                                Saved Tour ID:
                                <%= savedTour.getTourId() %>
                            </span>

                        </div>


                        <div class="saved-actions">


                            <a
                                class="saved-btn remove-btn"
                                href="${pageContext.request.contextPath}/remove-saved-tour?tour_id=<%= savedTour.getTourId() %>&tour_type=<%= savedTour.getTourType() %>&return_url=/saved-tours"
                            >
                                Remove
                            </a>


                        </div>


                    </div>


                </article>


            <% } %>


            <%
                }
            %>


        </div>


    <% } %>


</main>


<jsp:include
    page="../../common/footer.jsp"
/>


</body>

</html>