package com.traveltourism.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/user-dashboard", "/edit-profile", "/change-password"})
public class UserAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        if (session == null || !Boolean.TRUE.equals(session.getAttribute("userLoggedIn"))) {
            String path = httpRequest.getRequestURI()
                    .substring(httpRequest.getContextPath().length());

            httpResponse.sendRedirect(
                    httpRequest.getContextPath()
                    + "/login.jsp?redirect=" + path
            );
            return;
        }

        chain.doFilter(request, response);
    }
}
