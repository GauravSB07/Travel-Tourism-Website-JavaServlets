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
            cursor: pointer;
            outline: none;
        }
        .experience-card-modern:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }
        .experience-card-modern:focus-visible {
            outline: 2px solid #f28c28;
            outline-offset: 2px;
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
        .read-more-cue {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            margin-top: 0.6rem;
            color: #f28c28;
            font-size: 0.85rem;
            font-weight: 600;
            transition: transform 0.2s ease, color 0.2s ease;
        }
        .experience-card-modern:hover .read-more-cue {
            transform: translateX(3px);
            color: #e07b1a;
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
        /* ====== EXPERIENCE POPUP / MODAL ====== */
        dialog.experience-modal {
            padding: 0;
            border: none;
            border-radius: 16px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            max-width: 680px;
            width: 92%;
            max-height: 88vh;
            background: #fff;
            overflow: hidden;
            margin: auto;
        }
        dialog.experience-modal::backdrop {
            background-color: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            -webkit-backdrop-filter: blur(4px);
        }
        .modal-dialog-content {
            display: flex;
            flex-direction: column;
            max-height: 88vh;
            position: relative;
            overflow-y: auto;
        }
        .modal-close-btn {
            position: absolute;
            top: 14px;
            right: 14px;
            z-index: 10;
            background: rgba(0, 0, 0, 0.6);
            color: #fff;
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            font-size: 22px;
            line-height: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }
        .modal-close-btn:hover,
        .modal-close-btn:focus-visible {
            background: rgba(0, 0, 0, 0.85);
            transform: scale(1.08);
            outline: none;
        }
        .modal-image-wrapper {
            position: relative;
            width: 100%;
            height: 280px;
            background-color: #f2f2f2;
            overflow: hidden;
        }
        .modal-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .modal-image-wrapper .trip-type-badge {
            position: absolute;
            top: 16px;
            left: 16px;
            background: rgba(0, 0, 0, 0.7);
            color: #fff;
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            padding: 5px 12px;
            border-radius: 4px;
        }
        .modal-body-wrapper {
            padding: 1.75rem 2rem 2rem;
            display: flex;
            flex-direction: column;
        }
        .modal-meta {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: #888;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }
        .modal-title {
            font-size: 1.5rem;
            line-height: 1.3;
            margin: 0 0 1rem;
            color: #222;
        }
        .modal-review-text {
            color: #444;
            line-height: 1.75;
            font-size: 1rem;
            white-space: pre-line;
            margin-bottom: 1.5rem;
        }
        .modal-footer {
            padding-top: 1.25rem;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-footer .reviewer-name {
            display: block;
            font-weight: 600;
            font-size: 0.95rem;
            color: #222;
        }
        .modal-footer .reviewer-sub {
            display: block;
            font-weight: 400;
            font-size: 0.8rem;
            color: #888;
            margin-top: 2px;
        }
        .modal-footer .rating-stars {
            color: #f28c28;
            font-size: 1.3rem;
            letter-spacing: 2px;
        }
        @media (max-width: 600px) {
            dialog.experience-modal {
                width: 95%;
                border-radius: 12px;
            }
            .modal-image-wrapper {
                height: 200px;
            }
            .modal-body-wrapper {
                padding: 1.25rem;
            }
            .modal-title {
                font-size: 1.25rem;
            }
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
                <article class="experience-card-modern"
                         role="button"
                         tabindex="0"
                         aria-haspopup="dialog"
                         data-id="<c:out value='${exp.id}'/>"
                         data-title="<c:out value='${exp.title}'/>"
                         data-location="<c:out value='${exp.location}'/>"
                         data-trip-type="<c:out value='${exp.tripType}'/>"
                         data-image="${pageContext.request.contextPath}/images/<c:out value='${exp.imageUrl}'/>"
                         data-reviewer="<c:out value='${exp.reviewerName}'/>"
                         data-stars="<c:out value='${exp.stars}'/>">
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
                        <span class="read-more-cue">Read full story &rarr;</span>
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
                    <div class="hidden-full-review" style="display: none;"><c:out value="${exp.description}"/></div>
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

    <!-- EXPERIENCE DETAILS MODAL -->
    <dialog id="experienceModal" class="experience-modal" closedby="any" aria-labelledby="modalExpTitle">
        <div class="modal-dialog-content">
            <button type="button" class="modal-close-btn" id="modalCloseBtn" aria-label="Close dialog">&times;</button>
            <div class="modal-image-wrapper">
                <img id="modalExpImg" src="" alt="">
                <span class="trip-type-badge" id="modalTripType"></span>
            </div>
            <div class="modal-body-wrapper">
                <div class="modal-meta">
                    <span id="modalLocation"></span>
                </div>
                <h2 id="modalExpTitle" class="modal-title"></h2>
                <div class="modal-review-text" id="modalExpDescription"></div>
                <div class="modal-footer">
                    <div class="reviewer">
                        <span id="modalReviewer" class="reviewer-name"></span>
                        <span id="modalTripSub" class="reviewer-sub"></span>
                    </div>
                    <div class="rating-stars" id="modalStars"></div>
                </div>
            </div>
        </div>
    </dialog>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var dialog = document.getElementById('experienceModal');
            if (!dialog) return;

            var modalImg = document.getElementById('modalExpImg');
            var modalTripType = document.getElementById('modalTripType');
            var modalLocation = document.getElementById('modalLocation');
            var modalTitle = document.getElementById('modalExpTitle');
            var modalDesc = document.getElementById('modalExpDescription');
            var modalReviewer = document.getElementById('modalReviewer');
            var modalTripSub = document.getElementById('modalTripSub');
            var modalStars = document.getElementById('modalStars');
            var closeBtn = document.getElementById('modalCloseBtn');

            function openModal(card) {
                var title = card.getAttribute('data-title') || '';
                var location = card.getAttribute('data-location') || '';
                var tripType = card.getAttribute('data-trip-type') || '';
                var imageSrc = card.getAttribute('data-image') || '';
                var reviewer = card.getAttribute('data-reviewer') || '';
                var stars = card.getAttribute('data-stars') || '';
                var hiddenDescEl = card.querySelector('.hidden-full-review');
                var description = hiddenDescEl ? hiddenDescEl.textContent.trim() : '';

                modalTitle.textContent = title;
                modalLocation.textContent = '📍 ' + location;
                modalTripType.textContent = tripType;
                modalTripSub.textContent = tripType;
                modalReviewer.textContent = reviewer;
                modalStars.textContent = stars;
                modalDesc.textContent = description;

                if (imageSrc) {
                    modalImg.src = imageSrc;
                    modalImg.alt = title || location;
                    modalImg.parentElement.style.display = 'block';
                } else {
                    modalImg.parentElement.style.display = 'none';
                }

                if (typeof dialog.showModal === 'function') {
                    dialog.showModal();
                } else {
                    dialog.setAttribute('open', '');
                }

                var content = dialog.querySelector('.modal-dialog-content');
                if (content) content.scrollTop = 0;
            }

            var cards = document.querySelectorAll('.experience-card-modern');
            cards.forEach(function (card) {
                card.addEventListener('click', function () {
                    openModal(card);
                });
                card.addEventListener('keydown', function (e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        openModal(card);
                    }
                });
            });

            if (closeBtn) {
                closeBtn.addEventListener('click', function () {
                    dialog.close();
                });
            }

            // Fallback for browsers without 'closedBy' support (light-dismiss when clicking outside)
            if (!('closedBy' in HTMLDialogElement.prototype)) {
                dialog.addEventListener('click', function (event) {
                    if (event.target !== dialog) return;
                    var rect = dialog.getBoundingClientRect();
                    var isInside = (
                        rect.top <= event.clientY &&
                        event.clientY <= rect.bottom &&
                        rect.left <= event.clientX &&
                        event.clientX <= rect.right
                    );
                    if (!isInside) {
                        dialog.close();
                    }
                });
            }
        });
    </script>

    <%@ include file="common/footer.jsp" %>

</body>
</html>