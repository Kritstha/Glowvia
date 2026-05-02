package com.glowvia.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/home")
public class AuthenticationFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest   = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("username") != null);

        if (loggedIn) {
            // User is logged in → let them through
            chain.doFilter(request, response);
        } else {
            // Not logged in → send back to login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}