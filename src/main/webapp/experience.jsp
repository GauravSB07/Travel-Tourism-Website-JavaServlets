<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Travel Experiences | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/destinations.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/destinations-premium.css">
    <style>
        /* ====== EXPERIENCE PAGE STYLES ====== */
        .experience-hero {
            background: linear-gradient(rgba(0, 0, 0, 0.45), rgba(0, 0, 0, 0.45)), url('${pageContext.request.contextPath}/images/experience-bg.jpg');
            background-size: cover;
            background-position: center;
            min-height: 350px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            padding: 80px 20px 40px;
        }
        .experience-hero h1 {
            font-size: 48px;
            margin: 0 0 15px;
            letter-spacing: -0.02em;
        }
        .experience-hero p {
            font-size: 18px;
            max-width: 650px;
            line-height: 1.6;
            opacity: 0.9;
        }
        /* ====== EXPERIENCE GRID - MATCHES DESTINATIONS STYLE ====== */
        .experience-grid-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 3rem 20px 4rem;
        }
        .experience-grid-header {
            margin-bottom: 2rem;
        }
        .experience-grid-header .eyebrow {
            font-size: 0.75rem;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 0.5rem;
        }
        .experience-grid-header h2 {
            font-size: 1.6rem;
            margin: 0;
        }
        .experience-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }
        /* ====== EXPERIENCE CARD - MATCHES TOUR CARD STYLE ====== */
        .experience-card-modern {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            display: flex;
            flex-direction: column;
        }
        .experience-card-modern:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }
        .experience-card-image {
            position: relative;
            aspect-ratio: 16 / 10;
            overflow: hidden;
        }
        .experience-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        .experience-card-modern:hover .experience-card-image img {
            transform: scale(1.05);
        }
        .experience-card-image .trip-type-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            background: rgba(0, 0, 0, 0.65);
            color: #fff;
            font-size: 0.7rem;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            padding: 4px 10px;
            border-radius: 4px;
        }
        .experience-card-body {
            padding: 1.25rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .experience-card-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: #888;
            margin-bottom: 0.5rem;
        }
        .experience-card-body h3 {
            font-size: 1.15rem;
            margin: 0 0 0.6rem;
            line-height: 1.35;
        }
        .experience-card-body .experience-text {
            color: #666;
            line-height: 1.6;
            font-size: 0.9rem;
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .experience-card-footer {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .experience-card-footer .reviewer {
            font-weight: 600;
            font-size: 0.9rem;
        }
        .experience-card-footer .reviewer span {
            display: block;
            font-weight: 400;
            font-size: 0.78rem;
            color: #888;
            margin-top: 2px;
        }
        .experience-card-footer .rating-stars {
            color: #f28c28;
            font-size: 1.1rem;
            letter-spacing: 1px;
        }
        /* ====== SHARE SECTION ====== */
        .share-experience {
            text-align: center;
            background: #fff;
            padding: 3.5rem 20px;
            border-top: 1px solid #eee;
        }
        .share-experience h2 {
            margin-bottom: 10px;
            font-size: 1.6rem;
        }
        .share-experience p {
            color: #666;
            margin-bottom: 25px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }
        .share-button {
            display: inline-block;
            padding: 12px 28px;
            background: #f28c28;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background 0.2s;
        }
        .share-button:hover {
            background: #e07b1a;
        }
        /* ====== RESPONSIVE ====== */
        @media (max-width: 900px) {
            .experience-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 600px) {
            .experience-grid {
                grid-template-columns: 1fr;
            }
            .experience-hero h1 {
                font-size: 34px;
            }
        }
    </style>
</head>
<body class="destinations-premium">

    <%@ include file="common/header.jsp" %>

    <!-- HERO -->
    <section class="experience-hero">
        <h1>Travel Experiences</h1>
        <p>
            Discover unforgettable journeys shared by
            travelers who explored the world with TravelTourism.
        </p>
    </section>

    <!-- EXPERIENCES GRID -->
    <section class="experience-grid-section">
        <div class="experience-grid-header">
            <p class="eyebrow">STORIES FROM OUR TRAVELERS</p>
            <h2>${resultCount} experiences shared by our travelers</h2>
        </div>
        <div class="experience-grid">
            <c:forEach var="exp" items="${experiences}">
                <article class="experience-card-modern">
                    <div class="experience-card-image">
                        <img src="${pageContext.request.contextPath}/images/<c:out value='${exp.imageUrl}'/>"
                             alt="<c:out value='${exp.location}'/>"
                             loading="lazy">
                        <span class="trip-type-badge"><c:out value="${exp.tripType}"/></span>
                    </div>
                    <div class="experience-card-body">
                        <div class="experience-card-meta">
                            <span>📍 <c:out value="${exp.location}"/></span>
                        </div>
                        <h3><c:out value="${exp.title}"/></h3>
                        <p class="experience-text">
                            <c:out value="${exp.description}"/>
                        </p>
                        <div class="experience-card-footer">
                            <div class="reviewer">
                                <c:out value="${exp.reviewerName}"/>
                                <span><c:out value="${exp.tripType}"/></span>
                            </div>
                            <div class="rating-stars">
                                <c:out value="${exp.stars}"/>
                            </div>
                        </div>
                    </div>
                </article>
            </c:forEach>
        </div>
        <c:if test="${empty experiences}">
            <div style="text-align: center; padding: 4rem 2rem;">
                <p class="eyebrow">NO EXPERIENCES YET</p>
                <h3>Experiences are coming soon.</h3>
                <p>Check back later to read stories from our travelers.</p>
            </div>
        </c:if>
    </section>

    <!-- SHARE EXPERIENCE -->
    <section class="share-experience">
        <h2>Share Your Experience</h2>
        <p>
            Have you travelled with us?
            Share your journey and inspire other travelers.
        </p>
        <a href="#" class="share-button">
            Share Your Story
        </a>
    </section>

    <%@ include file="common/footer.jsp" %>

</body>
</html>