package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.glowvia.model.User;
import com.glowvia.service.LoginService;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User();
        user.setUserName(username);
        user.setPassword(password);

        LoginService service = new LoginService();
        Boolean result = service.loginUser(user);

        if (result != null && result) {
            request.getSession().setAttribute("username", username);
            request.getSession().setAttribute("message", "Welcome, Admin");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.getSession().setAttribute("error_message", "Invalid username or password");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
}