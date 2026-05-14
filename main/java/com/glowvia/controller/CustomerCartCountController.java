package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.glowvia.model.User;
import com.glowvia.service.CartService;
import com.glowvia.service.LoginService;

@WebServlet("/cart/count")
public class CustomerCartCountController extends HttpServlet {

    private CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            // Return 0 if user is not logged in
            response.setContentType("application/json");
            response.getWriter().write("{\"count\": 0}");
            return;
        }

        String username = (String) session.getAttribute("username");
        
        LoginService loginService = new LoginService();
        User user = loginService.getUserByUsername(username);
        
        int userId = user.getUser_id();

        int cartCount = cartService.getCartCount(userId);

        response.setContentType("application/json");
        response.getWriter().write("{\"count\": " + cartCount + "}");
    }
}