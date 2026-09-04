<!-- ================= COMMON HEADER ================= -->

<header class="site-header">

    <div class="header-container">

        <!-- LOGO -->

        <a href="${pageContext.request.contextPath}/index.jsp"
           class="site-logo">

            Travel<span>Tourism</span>

        </a>


        <!-- NAVIGATION -->

        <nav class="main-navigation">

            <a href="${pageContext.request.contextPath}/index.jsp">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/destinations">
                Destinations
            </a><a href="${pageContext.request.contextPath}/customize">
                Customized Holidays
            </a>

            

            <a href="${pageContext.request.contextPath}/experiences">
                Experiences
            </a>

            <a href="${pageContext.request.contextPath}/about">
                About Us
            </a>

            <a href="${pageContext.request.contextPath}/contact">
                Contact Us
            </a>

        </nav>


        <!-- HEADER ACTIONS -->

        <div class="header-actions">

            <!-- HEADER SEARCH -->

            <form class="header-search"
                  action="${pageContext.request.contextPath}/search"
                  method="get">

                <input type="text"
                       name="query"
                       placeholder="Search destinations..."
                       aria-label="Search destinations">

            <button type="submit" aria-label="Search">
                &#128269;
            </button>

            </form>


            <!-- BOOK NOW -->

            <button type="button" class="book-button" data-booking-access-open>Book Now</button>

        </div>

    </div>

</header>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking-access.css?v=3">
<dialog class="booking-access-dialog" id="booking-access-dialog" aria-labelledby="booking-access-title">
<div class="booking-access-head"><p>BEFORE YOU CONTINUE</p><button type="button" data-dialog-close aria-label="Close booking options">×</button></div>
<h2 id="booking-access-title">How would you like to book?</h2>
<p class="booking-access-intro">An account will make it easier to revisit requests later. Account access is being prepared; guest booking remains fully available now.</p>
<div class="booking-access-options">
<button type="button" data-account-coming-soon><span>01</span><strong>Log in</strong><small>Returning traveller · Coming soon</small></button>
<button type="button" data-account-coming-soon><span>02</span><strong>Create an account</strong><small>New traveller · Coming soon</small></button>
<a data-guest-booking href="${pageContext.request.contextPath}/destinations"><span>03</span><strong>Continue as guest</strong><small>Choose a package without an account</small></a>
</div>
<p class="booking-access-note" tabindex="-1" hidden>Login and registration will be added in a future update. Please continue as a guest for now.</p>
</dialog>
<script src="${pageContext.request.contextPath}/js/booking-access.js" defer></script>