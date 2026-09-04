<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results | TravelTourism</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/destinations.css">
    <style>
        .search-results-layout {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem 2rem 4rem 2rem;
        }
        .section-header {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eaeaea;
        }
        .section-header h2 {
            font-size: 1.75rem;
            color: #1a1a1a;
            margin-bottom: 0.5rem;
        }
        .section-header p {
            color: #666;
            font-size: 1.1rem;
        }
        
        /* New AI Banner - Scaled down, Darker Transparent Emerald */
        .ai-banner {
            background-color: rgba(4, 120, 87, 0.75); /* Darker transparent emerald green */
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 8px;
            padding: 0.6rem 1rem;
            margin-bottom: 1.5rem;
            display: inline-flex;
            align-items: center;
            justify-content: space-between;
            color: #ffffff; /* Crisp white text */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(4, 120, 87, 0.9);
            flex-wrap: nowrap;
            gap: 1rem;
            max-width: 50%; /* Half width */
        }
        .ai-banner-title {
            font-size: 1.1rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            letter-spacing: -0.2px;
            white-space: nowrap;
        }
        .ai-console {
            background-color: rgba(15, 23, 42, 0.95);
            color: #38bdf8;
            font-family: 'Fira Code', 'Courier New', monospace;
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            font-size: 0.75rem;
            line-height: 1.3;
            min-width: 220px;
            border: 1px solid rgba(255,255,255,0.1);
            box-shadow: inset 0 1px 5px rgba(0,0,0,0.4);
            white-space: nowrap;
        }
        .ai-console-line:before {
            content: "> ";
            color: #34d399;
        }
        .ai-console-cursor {
            display: inline-block;
            width: 6px;
            height: 10px;
            background: #38bdf8;
            animation: pulse-cursor 1s infinite alternate;
            vertical-align: middle;
            margin-left: 3px;
        }
        @keyframes pulse-cursor {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        /* Override constraints to make cards compact, rich, and full without empty space */
        .search-results-layout .cards-grid {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        
        .search-results-layout .tour-card-modern {
            grid-template-columns: 210px 1fr !important;
            min-height: 135px;
            border: 1px solid #e2e8f0 !important;
        }
        
        .search-results-layout .tour-image-wrapper {
            min-height: 135px !important; 
        }
        
        .search-results-layout .tour-image-wrapper img, 
        .search-results-layout .tour-image-placeholder {
            min-height: 135px !important;
            height: 100%;
        }
        
        .search-results-layout .tour-content {
            padding: 14px 20px !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: space-between !important;
        }
        
        .search-results-layout .tour-content-top {
            margin-bottom: 4px !important;
            gap: 10px !important;
        }
        
        .search-results-layout .tour-content h3 {
            font-size: 17px !important;
            font-weight: 700 !important;
        }
        
        .search-results-layout .tour-price {
            font-size: 17px !important;
            font-weight: 800 !important;
        }
        
        .search-results-layout .tour-meta-row {
            margin-bottom: 6px !important;
            gap: 6px !important;
        }
        
        .search-results-layout .tour-meta-row span {
            padding: 3px 8px !important;
            font-size: 11px !important;
            background: #f1f5f9 !important;
            border: 1px solid #cbd5e1 !important;
            color: #334155 !important;
        }
        
        .search-results-layout .tour-description {
            font-size: 13px !important;
            margin: 0 0 6px !important;
            line-height: 1.45 !important;
            color: #475569 !important;
            display: -webkit-box !important;
            -webkit-line-clamp: 2 !important; /* Shows 2 full lines to fill empty space */
            -webkit-box-orient: vertical !important;
            overflow: hidden !important;
        }
        
        .search-results-layout .tour-actions {
            padding-top: 2px !important;
            margin-top: auto !important;
            display: flex !important;
            gap: 8px !important;
            align-items: center !important;
        }
        
        .search-results-layout .primary-btn-small, 
        .search-results-layout .outline-btn-small {
            padding: 6px 14px !important;
            font-size: 12px !important;
            font-weight: 600 !important;
        }
    </style>
</head>
<body>

<%@ include file="common/header.jsp" %>

<!-- MAIN LAYOUT -->
<section class="search-results-layout">

    <c:if test="${not empty searchQuery}">
        
        <!-- =======================================
             NORMAL RESULTS
             ======================================= -->
        <div class="section-header">
            <h2>Normal Results</h2>
            <p>Exact title matches for your search query.</p>
        </div>

        <c:choose>
            <c:when test="${not empty normalResults}">
                <div class="cards-grid">
                    <c:forEach var="tour" items="${normalResults}">
                        <article class="tour-card-modern">
                            <div class="tour-image-wrapper">
                                <c:choose>
                                    <c:when test="${tour.imageId > 0}">
                                        <img src="${pageContext.request.contextPath}/TourImageServlet?id=${tour.imageId}"
                                             alt="${tour.name}"
                                             loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="tour-image-placeholder">
                                            No image available
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="tour-content">
                                <div class="tour-content-top">
                                    <h3>${tour.name}</h3>
                                    <p class="tour-price">₹${tour.price}</p>
                                </div>
                                <div class="tour-meta-row">
                                    <span>${tour.category}</span>
                                    <span>${tour.departureCity}</span>
                                    <span>${tour.duration} days</span>
                                </div>
                                <c:if test="${not empty tour.shortDescription}">
                                    <p class="tour-description">
                                        ${tour.shortDescription}
                                    </p>
                                </c:if>
                                <div class="tour-actions">
                                    <a class="primary-btn-small"
                                       href="${pageContext.request.contextPath}/tour-details?id=${tour.id}">
                                        View Details
                                    </a>
                                    <label class="outline-btn-small compare-label">
                                        <input class="tour-check"
                                               type="checkbox"
                                               value="${tour.id}">
                                        Compare
                                    </label>
                                    <a class="outline-btn-small"
                                       href="${pageContext.request.contextPath}/contact?tour_id=${tour.id}">
                                        Enquire
                                    </a>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-results" style="margin-bottom: 4rem;">
                    <p>No exact title matches found.</p>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- =======================================
             AI / SMART RESULTS
             ======================================= -->
        <br>
        <div class="ai-banner">
            <div class="ai-banner-title">
                🧠 AI Semantic Smart Search
            </div>
            <div class="ai-console">
                <div class="ai-console-line">query_engine: bge-m3-onnx</div>
                <div class="ai-console-line">metric: EXACT COSINE_DISTANCE</div>
                <div class="ai-console-line">extracting_top_results...<span class="ai-console-cursor"></span></div>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty aiResults}">
                <div class="cards-grid">
                    <c:forEach var="tour" items="${aiResults}">
                        <article class="tour-card-modern">
                            <div class="tour-image-wrapper">
                                <c:choose>
                                    <c:when test="${tour.imageId > 0}">
                                        <img src="${pageContext.request.contextPath}/TourImageServlet?id=${tour.imageId}"
                                             alt="${tour.name}"
                                             loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="tour-image-placeholder">
                                            No image available
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="tour-content">
                                <div class="tour-content-top">
                                    <h3>${tour.name}</h3>
                                    <p class="tour-price">₹${tour.price}</p>
                                </div>
                                <div class="tour-meta-row">
                                    <span>${tour.category}</span>
                                    <span>${tour.departureCity}</span>
                                    <span>${tour.duration} days</span>
                                </div>
                                <c:if test="${not empty tour.shortDescription}">
                                    <p class="tour-description">
                                        ${tour.shortDescription}
                                    </p>
                                </c:if>
                                <div class="tour-actions">
                                    <a class="primary-btn-small"
                                       href="${pageContext.request.contextPath}/tour-details?id=${tour.id}">
                                        View Details
                                    </a>
                                    <label class="outline-btn-small compare-label">
                                        <input class="tour-check"
                                               type="checkbox"
                                               value="${tour.id}">
                                        Compare
                                    </label>
                                    <a class="outline-btn-small"
                                       href="${pageContext.request.contextPath}/contact?tour_id=${tour.id}">
                                        Enquire
                                    </a>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-results" style="margin-bottom: 4rem;">
                    <p>No semantic matches found.</p>
                </div>
            </c:otherwise>
        </c:choose>

    </c:if>
    <c:if test="${empty searchQuery}">
        <div class="no-results" style="margin-top: 4rem; text-align: center;">
            <h2>Please enter a search query.</h2>
        </div>
    </c:if>

</section>

<%@ include file="common/footer.jsp" %>
</body>
</html>
