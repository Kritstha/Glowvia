package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.glowvia.model.User;
import com.glowvia.service.LoginService;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        
        if (username == null || username.trim().isEmpty()) {
            // Not logged in - redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get user details from database
        LoginService loginService = new LoginService();
        User user = loginService.getUserByUsername(username);
        
        if (user == null) {
            // User not found in database - invalid session
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Set user attribute and forward to profile page
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
}