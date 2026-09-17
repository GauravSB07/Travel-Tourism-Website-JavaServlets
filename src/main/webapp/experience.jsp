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
        /* ====== EXPERIENCE PREMIUM STYLES (MATCHES DESTINATIONS) ====== */
        .experience-container {
            width: min(1240px, 88%);
            margin: 0 auto;
        }
        .experience-grid-premium {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 26px;
            margin-top: 24px;
        }
        .experience-card-modern {
            display: flex;
            flex-direction: column;
            border: 1px solid #e0e4dc;
            border-radius: 5px;
            background: #fff;
            box-shadow: none;
            min-width: 0;
            transition: box-shadow 0.25s ease, transform 0.25s ease;
            cursor: pointer;
            text-align: left;
            overflow: hidden;
            outline: none;
        }
        .experience-card-modern:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(23, 61, 70, 0.1);
        }
        .experience-card-modern:focus-visible {
            outline: 3px solid #ac7d43;
            outline-offset: 4px;
        }
        .experience-image-wrapper {
            position: relative;
            height: 220px;
            min-height: 0;
            overflow: hidden;
            background: #e5e9df;
        }
        .experience-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
            display: block;
        }
        .experience-card-modern:hover .experience-image-wrapper img {
            transform: scale(1.03);
        }
        .experience-category-badge {
            position: absolute;
            top: 16px;
            left: 16px;
            padding: 6px 10px;
            background: #fffffff0;
            color: #264b4f;
            font-size: 9px;
            letter-spacing: 0.8px;
            border-radius: 2px;
            font-weight: 600;
            text-transform: uppercase;
        }
        .experience-image-arrow {
            position: absolute;
            right: 16px;
            bottom: 16px;
            display: grid;
            place-items: center;
            width: 32px;
            height: 32px;
            border: 1px solid #ffffffb0;
            border-radius: 50%;
            background: #1e363333;
            color: #fff;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }
        .experience-card-modern:hover .experience-image-arrow {
            background: #193f49;
            transform: scale(1.08);
        }
        .experience-card-content {
            padding: 22px 24px 0;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .experience-meta-row {
            display: flex;
            gap: 10px;
            margin-bottom: 14px;
            align-items: center;
        }
        .experience-meta-row span {
            border: 0;
            background: none;
            padding: 0;
            font-size: 8px;
            letter-spacing: 1px;
            color: #7a8379;
            font-weight: 500;
            text-transform: uppercase;
        }
        .experience-meta-row span + span {
            border-left: 1px solid #cfd4ca;
            padding-left: 10px;
        }
        .experience-card-content h3 {
            font: 400 23px/1.25 Georgia, serif;
            margin: 0 0 12px;
            color: var(--collection-ink);
        }
        .experience-description {
            font-size: 12px;
            line-height: 1.85;
            color: #748078;
            margin-bottom: 18px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            flex: 1;
        }
        .experience-card-footer {
            margin-top: auto;
            display: flex;
            gap: 12px;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 18px;
            border-bottom: 1px solid #e8ebe4;
        }
        .experience-reviewer-info {
            display: flex;
            flex-direction: column;
        }
        .experience-reviewer-name {
            font: 400 16px Georgia, serif;
            color: var(--collection-ink);
        }
        .experience-reviewer-sub {
            font-size: 9px;
            color: #899086;
            margin-top: 2px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }
        .experience-stars {
            color: #a27749;
            font-size: 1rem;
            letter-spacing: 1.5px;
        }
        .experience-action-row {
            padding: 13px 0 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .experience-action-row .read-story-btn {
            background: #1b424a;
            color: #fff;
            border: none;
            border-radius: 3px;
            font-size: 10px;
            padding: 10px 14px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }
        .experience-card-modern:hover .read-story-btn {
            background: #2f5b61;
        }
        .experience-action-row .read-story-label {
            color: #758078;
            font-size: 9px;
            letter-spacing: 0.5px;
        }

        /* ====== SHARE BANNER - MATCHES DESTINATIONS PREMIUM ====== */
        .collection-share-section {
            width: min(1240px, 88%);
            margin: 20px auto 70px;
            background: #173d47;
            border-radius: 5px;
            padding: 56px 44px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 30px;
        }
        .collection-share-content {
            max-width: 600px;
        }
        .collection-share-content h2 {
            font: 400 clamp(28px, 3vw, 38px)/1.2 Georgia, serif;
            color: #fff;
            margin: 10px 0 14px;
        }
        .collection-share-content p {
            color: #c3d2d0;
            line-height: 1.8;
            font-size: 13px;
            margin: 0;
        }
        .collection-share-btn {
            background: #d5b896;
            color: #173d47;
            text-decoration: none;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.5px;
            padding: 14px 28px;
            border-radius: 3px;
            white-space: nowrap;
            transition: background 0.2s ease, transform 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .collection-share-btn:hover {
            background: #e4ccb1;
            transform: translateY(-2px);
        }

        /* ====== EXPERIENCE MODAL POPUP ====== */
        dialog.experience-modal {
            padding: 0;
            border: 1px solid #d8ded5;
            border-radius: 8px;
            box-shadow: 0 25px 60px rgba(17, 45, 52, 0.35);
            max-width: 720px;
            width: 92%;
            max-height: 88vh;
            background: #fdfdfc;
            color: var(--collection-ink);
            overflow: hidden;
            margin: auto;
        }
        dialog.experience-modal::backdrop {
            background-color: rgba(18, 42, 47, 0.65);
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
            top: 16px;
            right: 16px;
            z-index: 10;
            background: rgba(23, 61, 71, 0.75);
            color: #fff;
            border: 1px solid rgba(255, 255, 255, 0.4);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            font-size: 20px;
            line-height: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }
        .modal-close-btn:hover,
        .modal-close-btn:focus-visible {
            background: #173d47;
            transform: scale(1.08);
            outline: none;
        }
        .modal-image-wrapper {
            position: relative;
            width: 100%;
            height: 300px;
            background-color: #e5e9df;
            overflow: hidden;
        }
        .modal-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .modal-image-wrapper .modal-badge {
            position: absolute;
            top: 16px;
            left: 16px;
            padding: 6px 12px;
            background: #fffffff0;
            color: #264b4f;
            font-size: 9px;
            letter-spacing: 0.8px;
            border-radius: 2px;
            font-weight: 600;
            text-transform: uppercase;
        }
        .modal-body-wrapper {
            padding: 28px 32px 32px;
            display: flex;
            flex-direction: column;
        }
        .modal-meta-row {
            display: flex;
            gap: 12px;
            font-size: 9px;
            letter-spacing: 1.2px;
            text-transform: uppercase;
            color: #a27749;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .modal-title {
            font: 400 clamp(24px, 3vw, 32px)/1.2 Georgia, serif;
            margin: 0 0 16px;
            color: var(--collection-ink);
            letter-spacing: -0.3px;
        }
        .modal-review-text {
            color: #55625c;
            line-height: 1.9;
            font-size: 14px;
            white-space: pre-line;
            margin-bottom: 24px;
        }
        .modal-footer {
            padding-top: 18px;
            border-top: 1px solid #e7ebe3;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-footer .modal-reviewer-name {
            display: block;
            font: 400 18px Georgia, serif;
            color: var(--collection-ink);
        }
        .modal-footer .modal-reviewer-sub {
            display: block;
            font-size: 10px;
            color: #899086;
            margin-top: 2px;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }
        .modal-footer .modal-stars {
            color: #a27749;
            font-size: 1.25rem;
            letter-spacing: 2px;
        }

        /* ====== RESPONSIVE ====== */
        @media (max-width: 1050px) {
            .experience-grid-premium {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 20px;
            }
        }
        @media (max-width: 850px) {
            .collection-share-section {
                flex-direction: column;
                align-items: flex-start;
                padding: 40px 28px;
            }
        }
        @media (max-width: 650px) {
            .experience-grid-premium {
                grid-template-columns: 1fr;
            }
            .modal-image-wrapper {
                height: 210px;
            }
            .modal-body-wrapper {
                padding: 20px 20px 24px;
            }
            .modal-title {
                font-size: 22px;
            }
        }
    </style>
</head>
<body class="destinations-premium">

    <%@ include file="common/header.jsp" %>

    <main>
        <!-- COLLECTION INTRO HERO (MATCHING DESTINATIONS PAGE) -->
        <section class="collection-intro">
            <div class="collection-title">
                <p class="collection-eyebrow">THE TRAVELER COLLECTION</p>
                <h1>Stories that<br>stay with you.</h1>
                <p>Authentic journeys, personal memories, and unforgettable moments shared by travelers who explored India with us.</p>
                <a href="#experiences-collection">Explore the stories <span aria-hidden="true">↓</span></a>
            </div>
            <div class="collection-visual">
                <c:choose>
                    <c:when test="${not empty experiences}">
                        <img src="${pageContext.request.contextPath}/experience-image?id=${experiences[0].id}"
                             alt="<c:out value='${experiences[0].location}'/>"
                             fetchpriority="high">
                        <div class="collection-photo-caption">
                            <span>FEATURED STORY</span>
                            <p><c:out value="${experiences[0].title}"/></p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="collection-placeholder">
                            <span aria-hidden="true">⌖</span>
                            <p>Discover traveler stories</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- EXPERIENCES COLLECTION LAYOUT -->
        <section class="destinations-layout" id="experiences-collection">
            <div class="experience-container">
                <div class="results-panel-modern">
                    <div class="results-toolbar">
                        <div>
                            <p class="eyebrow">STORIES FROM OUR TRAVELERS</p>
                            <h2>${resultCount} experiences shared by our travelers</h2>
                        </div>
                    </div>
                    <p class="collection-compare-help">Click on any story card to read the complete traveler experience and journey notes.</p>

                    <div class="experience-grid-premium">
                        <c:forEach var="exp" items="${experiences}">
                            <article class="experience-card-modern"
                                     role="button"
                                     tabindex="0"
                                     aria-haspopup="dialog"
                                     data-id="<c:out value='${exp.id}'/>"
                                     data-title="<c:out value='${exp.title}'/>"
                                     data-location="<c:out value='${exp.location}'/>"
                                     data-trip-type="<c:out value='${exp.tripType}'/>"
                                     data-image="${pageContext.request.contextPath}/experience-image?id=${exp.id}"
                                     data-reviewer="<c:out value='${exp.reviewerName}'/>"
                                     data-stars="<c:out value='${exp.stars}'/>">
                                <div class="experience-image-wrapper">
                                    <img src="${pageContext.request.contextPath}/experience-image?id=${exp.id}"
                                         alt="<c:out value='${exp.location}'/>"
                                         loading="lazy">
                                    <span class="experience-category-badge"><c:out value="${exp.tripType}"/></span>
                                    <span class="experience-image-arrow" aria-hidden="true">↗</span>
                                </div>
                                <div class="experience-card-content">
                                    <div class="experience-meta-row">
                                        <span>📍 <c:out value="${exp.location}"/></span>
                                        <span><c:out value="${exp.tripType}"/></span>
                                    </div>
                                    <h3><c:out value="${exp.title}"/></h3>
                                    <p class="experience-description">
                                        <c:out value="${exp.description}"/>
                                    </p>
                                    <div class="experience-card-footer">
                                        <div class="experience-reviewer-info">
                                            <span class="experience-reviewer-name"><c:out value="${exp.reviewerName}"/></span>
                                            <span class="experience-reviewer-sub"><c:out value="${exp.tripType}"/></span>
                                        </div>
                                        <div class="experience-stars">
                                            <c:out value="${exp.stars}"/>
                                        </div>
                                    </div>
                                    <div class="experience-action-row">
                                        <span class="read-story-label">Full journey notes</span>
                                        <button type="button" class="read-story-btn" tabindex="-1">Read Story <span aria-hidden="true">↗</span></button>
                                    </div>
                                </div>
                                <div class="hidden-full-review" style="display: none;"><c:out value="${exp.description}"/></div>
                            </article>
                        </c:forEach>
                    </div>

                    <c:if test="${empty experiences}">
                        <div class="no-results" style="background: #fff; padding: 60px 24px; border: 1px solid #e0e4dc; border-radius: 5px; text-align: center;">
                            <p class="eyebrow">STORIES COMING SOON</p>
                            <h3 style="font: 400 26px Georgia, serif; color: var(--collection-ink); margin: 8px 0 12px;">No experiences shared yet.</h3>
                            <p style="color: #78837e; font-size: 13px;">Check back soon to explore inspiring accounts from our travelers.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>

        <!-- SHARE YOUR STORY SECTION (MATCHING COLLECTION AESTHETIC) -->
        <section class="collection-share-section">
            <div class="collection-share-content">
                <p class="collection-eyebrow">SHARE YOUR JOURNEY</p>
                <h2>Have you travelled with us?</h2>
                <p>Inspire fellow travelers by sharing your personal journey, favourite memories, and travel tips across India.</p>
            </div>
            <a href="${pageContext.request.contextPath}/contact" class="collection-share-btn">
                Share Your Story <span aria-hidden="true">↗</span>
            </a>
        </section>
    </main>

    <!-- EXPERIENCE DETAILS MODAL POPUP -->
    <dialog id="experienceModal" class="experience-modal" closedby="any" aria-labelledby="modalExpTitle">
        <div class="modal-dialog-content">
            <button type="button" class="modal-close-btn" id="modalCloseBtn" aria-label="Close story dialog">&times;</button>
            <div class="modal-image-wrapper">
                <img id="modalExpImg" src="" alt="">
                <span class="modal-badge" id="modalTripType"></span>
            </div>
            <div class="modal-body-wrapper">
                <div class="modal-meta-row">
                    <span id="modalLocation"></span>
                    <span id="modalTripSub"></span>
                </div>
                <h2 id="modalExpTitle" class="modal-title"></h2>
                <div class="modal-review-text" id="modalExpDescription"></div>
                <div class="modal-footer">
                    <div class="modal-reviewer-info">
                        <span id="modalReviewer" class="modal-reviewer-name"></span>
                        <span class="modal-reviewer-sub">Verified Traveler</span>
                    </div>
                    <div class="modal-stars" id="modalStars"></div>
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

            // Fallback for browsers without 'closedBy' support (light-dismiss on backdrop click)
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
