<%-- 
    Document   : login
    Created on : Sep 14, 2026, 1:16:28 PM
    Author     : Dell
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Login | Travel & Tourism</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/login.css">
    </head>

    <body>

        <div class="login-page">

            <div class="login-card">

                <!-- Heading -->
                <div class="login-header">
                    <h1>Welcome Back</h1>
                    <p>Login to continue your journey</p>
                </div>


                <!-- TOP LOGIN TABS -->
                <div class="login-tabs">

                    <a href="javascript:void(0);"
                       id="userTab"
                       class="login-tab active"
                       onclick="showUserLogin()">
                        User Login
                    </a>

                    <a href="javascript:void(0);"
                       id="adminTab"
                       class="login-tab"
                       onclick="showAdminLogin()">
                        Admin Login
                    </a>

                </div>


                <!-- SLIDING CONTENT AREA -->
                <div class="login-window">
                    <% if (request.getAttribute("error") != null) {%>

                    <div class="login-error">
                        <%= request.getAttribute("error")%>
                    </div>

                    <% }%>

                    <div class="login-slider" id="loginSlider">


                        <!-- ================= USER LOGIN ================= -->

                        <div class="login-form user-form">

                            <h2>User Login</h2>

                            <p class="form-subtitle">
                                Login to access your account
                            </p>

                            <form action="${pageContext.request.contextPath}/user-login" method="post">
                                <input type="hidden"
                                       name="redirect"
                                       value="<%= request.getParameter("redirect") != null
                                               ? request.getParameter("redirect")
                                               : ""%>">

                                <div class="input-group">
                                    <label for="userEmail">
                                        Email Address
                                    </label>

                                    <input type="email"
                                           id="userEmail"
                                           name="email"
                                           placeholder="Enter your email"
                                           required>
                                </div>


                                <div class="input-group">
                                    <label for="userPassword">
                                        Password
                                    </label>

                                    <input type="password"
                                           id="userPassword"
                                           name="password"
                                           placeholder="Enter your password"
                                           required>
                                </div>


                                <button type="submit"
                                        class="login-button">
                                    Login
                                </button>

                            </form>


                            <div class="register-link">

                                <span>Don't have an account?</span>

                                <a href="${pageContext.request.contextPath}/register.jsp">
                                    Create New Account
                                </a>

                            </div>

                        </div>



                        <!-- ================= ADMIN LOGIN ================= -->

                        <div class="login-form admin-form">

                            <h2>Admin Login</h2>

                            <p class="form-subtitle">
                                Login to access the administration panel
                            </p>

                            <form action="${pageContext.request.contextPath}/admin-login" method="post">

                                <div class="input-group">

                                    <label for="adminUsername">
                                        Username
                                    </label>

                                    <input type="text"
                                           id="adminUsername"
                                           name="username"
                                           placeholder="Enter admin username"
                                           required>

                                </div>


                                <div class="input-group">

                                    <label for="adminPassword">
                                        Password
                                    </label>

                                    <input type="password"
                                           id="adminPassword"
                                           name="password"
                                           placeholder="Enter admin password"
                                           required>

                                </div>


                                <button type="submit"
                                        class="login-button admin-button">
                                    Admin Login
                                </button>

                            </form>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- SLIDING LOGIN SCRIPT -->

        <script>

            function showUserLogin() {

                const slider = document.getElementById("loginSlider");

                const userTab = document.getElementById("userTab");
                const adminTab = document.getElementById("adminTab");

                slider.style.transform = "translateX(0%)";

                userTab.classList.add("active");
                adminTab.classList.remove("active");
            }


            function showAdminLogin() {

                const slider = document.getElementById("loginSlider");

                const userTab = document.getElementById("userTab");
                const adminTab = document.getElementById("adminTab");

                slider.style.transform = "translateX(-50%)";

                userTab.classList.remove("active");
                adminTab.classList.add("active");
            }

        </script>

    </body>
</html>