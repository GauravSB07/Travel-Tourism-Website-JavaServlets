<!-- ================= COMMON HEADER ================= -->

<header class="site-header">

    <div class="header-container">

        <!-- LOGO -->

        <a href="${pageContext.request.contextPath}/index.jsp"
           class="site-logo">
            Travel<span>Tourism</span>
        </a>


        <!-- MAIN NAVIGATION -->

        <nav class="main-navigation">

            <a href="${pageContext.request.contextPath}/index.jsp">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/destinations">
                Destinations
            </a>

            <a href="${pageContext.request.contextPath}/customize">
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


        <!-- ================= HEADER ACTIONS ================= -->

        <div class="header-actions">


            <!-- SEARCH -->

            <div class="header-search-wrapper">

                <button type="button"
                        class="header-search-icon"
                        id="headerSearchIcon"
                        aria-label="Search">

                    <svg width="22"
                         height="22"
                         viewBox="0 0 24 24"
                         aria-hidden="true">

                    <circle cx="11"
                            cy="11"
                            r="7">
                    </circle>

                    <line x1="16.5"
                          y1="16.5"
                          x2="21"
                          y2="21">
                    </line>

                    </svg>

                </button>


                <!-- SEARCH FORM -->

                <form class="header-search-form"
                      id="headerSearchForm"
                      action="${pageContext.request.contextPath}/search"
                      method="get">

                    <input type="text"
                           name="query"
                           placeholder="Search destinations..."
                           aria-label="Search destinations"
                           autocomplete="off">

                    <button type="submit"
                            aria-label="Submit search">

                        <svg width="18"
                             height="18"
                             viewBox="0 0 24 24"
                             aria-hidden="true">

                        <circle cx="11"
                                cy="11"
                                r="7">
                        </circle>

                        <line x1="16.5"
                              y1="16.5"
                              x2="21"
                              y2="21">
                        </line>

                        </svg>

                    </button>

                </form>

            </div>

            <!-- ================= BOOK NOW ================= -->

            <%
                Boolean userLoggedIn
                        = (Boolean) session.getAttribute("userLoggedIn");

                if (Boolean.TRUE.equals(userLoggedIn)) {
            %>

            <!-- USER IS ALREADY LOGGED IN -->

            <a href="${pageContext.request.contextPath}/destinations"
               class="book-button"
               id="bookNowButton">

                Book Now

            </a>

            <%
            } else {
            %>

            <!-- USER IS NOT LOGGED IN -->

            <a href="${pageContext.request.contextPath}/login.jsp?redirect=/destinations"
               class="book-button"
               id="bookNowButton">

                Book Now

            </a>

            <%
                }
            %>


            <!-- ================= USER / LOGIN ================= -->

            <%
                String loggedInUserName
                        = (String) session.getAttribute("userName");

                if (Boolean.TRUE.equals(userLoggedIn)
                        && loggedInUserName != null
                        && !loggedInUserName.isBlank()) {
            %>

            <!-- LOGGED-IN USER -->

            <div class="user-menu">

                <button type="button"
                        class="user-menu-link"
                        id="userMenuLink"
                        aria-expanded="false">

                    <span class="user-name">
                        <%= loggedInUserName%>
                    </span>

                    <span class="user-arrow"
                          aria-hidden="true">
                        &#9662;
                    </span>

                </button>

                <div class="user-dropdown"
                     id="userDropdown">

                    <a href="${pageContext.request.contextPath}/user-dashboard">
                        My Dashboard
                    </a>

                    <a href="${pageContext.request.contextPath}/user-bookings">
                        My Bookings
                    </a>

                    <a href="${pageContext.request.contextPath}/logout"
                       class="logout-link">
                        Logout
                    </a>

                </div>

            </div>

            <%
            } else {
            %>

            <!-- NOT LOGGED IN -->

            <a href="${pageContext.request.contextPath}/login.jsp"
               class="header-login-button">

                Login

            </a>

            <%
                }
            %>

        </div>

    </div>

</header>

<!-- ================= OLD BOOKING DIALOG REMOVED ================= -->

<!--
     The old "How would you like to book?" dialog is intentionally
     removed because Book Now should no longer open that popup.
-->


<!-- ================= HEADER JAVASCRIPT ================= -->

<script src="${pageContext.request.contextPath}/js/header.js"
        defer>
</script>