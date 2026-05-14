package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.glowvia.model.User;
import com.glowvia.service.LoginService;
import com.glowvia.service.CartService;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate empty fields
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            HttpSession session = request.getSession();
            session.setAttribute("error_message", "Username and password are required");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Set input user
        User user = new User();
        user.setUserName(username);
        user.setPassword(password);

        // Call service (returns FULL DB user if login is correct)
        LoginService service = new LoginService();
        CartService cartService = new CartService();
        User dbUser = service.loginUser(user);

        if (dbUser != null) {

            HttpSession session = request.getSession();

            // Store correct DB values
            session.setAttribute("user_id", dbUser.getUser_id());
            session.setAttribute("username", dbUser.getUserName());
            session.setAttribute("userRole", dbUser.getUserRole());
            session.setAttribute("fullName", dbUser.getFullName());
            session.setAttribute("email", dbUser.getEmail());

            // Role-based redirect
            if ("admin".equals(dbUser.getUserRole())) {

                session.setAttribute("message", "Welcome, Admin");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");

            } else if ("user".equals(dbUser.getUserRole())) {
            	session.setAttribute("cartCount",cartService.getCartCount(dbUser.getUser_id()));
                session.setAttribute("message", "Welcome, " + dbUser.getUserName());
                response.sendRedirect(request.getContextPath() + "/home");

            } else {
                // fallback if role is unknown
                session.setAttribute("error_message", "Invalid user role");
                response.sendRedirect(request.getContextPath() + "/login");
            }

        } else {
            // Login failed
            HttpSession session = request.getSession();
            session.setAttribute("error_message", "Invalid username or password");
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}