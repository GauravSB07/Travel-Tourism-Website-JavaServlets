<%-- 
    Document   : header
    Created on : Aug 8, 2026, 3:08:37 PM
    Author     : Dell
--%>
<!-- ================= COMMON HEADER ================= -->

<header class="site-header">

    <div class="header-container">

        <!-- LOGO -->

        <a href="${pageContext.request.contextPath}/home"
           class="site-logo">

            Travel<span>Tourism</span>

        </a>


        <!-- NAVIGATION -->

        <nav class="main-navigation">

            <a href="${pageContext.request.contextPath}/home">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/destinations">
                Destinations
            </a>

            <a href="${pageContext.request.contextPath}/experiences">
                Experiences
            </a>

            <a href="${pageContext.request.contextPath}/customize">
                Customized Holidays
            </a>

            <a href="${pageContext.request.contextPath}/about">
                About Us
            </a>

            <a href="${pageContext.request.contextPath}/contact">
                Contact Us
            </a>

        </nav>


        <div class="header-actions">

            <!-- HEADER SEARCH -->

            <form class="header-search"
                action="${pageContext.request.contextPath}/search"
                method="get">

                <input type="text"
                    name="query"
                    placeholder="Search destinations..."
                    aria-label="Search destinations">

                <button type="submit"
                        aria-label="Search">

                    🔍

                </button>

            </form>


            <!-- BOOK NOW -->

            <a href="${pageContext.request.contextPath}/booking"
               class="book-button">

                Book Now

            </a>

        </div>
    </div>

</header>
