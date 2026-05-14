package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.glowvia.model.Product;
import com.glowvia.service.ProductService;

@WebServlet("/products/details")
public class CustomerProductDetailController extends HttpServlet {
    
    private ProductService productService = new ProductService();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productIdParam = request.getParameter("productId");
        
        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdParam);
            Product product = productService.getProductById(productId);
            
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            
            // Get related products (same category)
            request.setAttribute("product", product);
            request.setAttribute("contentPage", "/pages/customer/product_detail.jsp");
            request.getRequestDispatcher("/layouts/customer-layout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}