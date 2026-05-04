package com.glowvia.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.glowvia.model.Product;
import com.glowvia.service.ProductService;

@WebServlet("/admin/products")
public class AdminProductListController extends HttpServlet {
    
    private ProductService productService = new ProductService();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Product> products = productService.getAllProducts();
        request.setAttribute("products", products);
        request.setAttribute("contentPage", "/pages/admin/products/list.jsp");
        request.getRequestDispatcher("/layouts/admin-layout.jsp").forward(request, response);
    }
}