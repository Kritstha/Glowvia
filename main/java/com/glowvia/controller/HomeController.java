package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.glowvia.model.Product;
import com.glowvia.service.ProductService;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    
    private ProductService productService = new ProductService();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        List<Product> products = productService.getAllProducts();
        
        // Set as request attribute
        request.setAttribute("productList", products);
        

        request.setAttribute("contentPage", "/pages/customer/home.jsp");
        request.getRequestDispatcher("/layouts/customer-layout.jsp").forward(request, response);
    }
}