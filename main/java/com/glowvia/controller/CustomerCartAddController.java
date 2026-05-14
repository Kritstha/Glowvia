package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.glowvia.model.User;
import com.glowvia.service.CartService;
import com.glowvia.service.LoginService;

@WebServlet("/cart/add")
public class CustomerCartAddController extends HttpServlet {

    private CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdParam = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity");

        // Validate productId
        if (productIdParam == null || productIdParam.isEmpty()) {
            request.setAttribute("error_message", "Invalid product selection.");
            request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
            return;
        }

        int productId = Integer.parseInt(productIdParam);
        
        // Parse quantity (default to 1 if not provided or invalid)
        int quantity = 1;
        if (quantityParam != null && !quantityParam.isEmpty()) {
            try {
                quantity = Integer.parseInt(quantityParam);
                if (quantity <= 0) {
                    quantity = 1;
                }
            } catch (NumberFormatException e) {
                quantity = 1;
            }
        }

        // Check session
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            request.setAttribute("error_message", "Please login first.");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }

        String username = (String) session.getAttribute("username");
        
        LoginService loginService = new LoginService();
        User user = loginService.getUserByUsername(username);
        
        int userId = user.getUser_id();

        // Add to cart with quantity
        boolean result = cartService.addToCart(userId, productId, quantity);

        if (result) {
            session.setAttribute("message", "Added to Cart Successfully");
            session.setAttribute("cartCount", cartService.getCartCount(userId));
            response.sendRedirect(request.getHeader("Referer"));
        } else {
            request.setAttribute("error_message", "Failed to add product to cart.");
            request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
        }
    }
}