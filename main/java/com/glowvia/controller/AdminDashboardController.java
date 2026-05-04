package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("totalRevenue", 128450.00);
        request.setAttribute("totalOrders", 342);
        request.setAttribute("registeredCustomers", 156);
        request.setAttribute("pendingOrders", 18);
        
        List<Map<String, Object>> products = new ArrayList<>();
        
        Map<String, Object> product1 = new HashMap<>();
        product1.put("name", "Niacinamide Serum");
        product1.put("category", "Serum");
        product1.put("price", 1800.00);
        product1.put("stock", 45);
        product1.put("stockStatus", "ok");
        products.add(product1);
        
        Map<String, Object> product2 = new HashMap<>();
        product2.put("name", "Hydrating Cleanser");
        product2.put("category", "Cleanser");
        product2.put("price", 2200.00);
        product2.put("stock", 8);
        product2.put("stockStatus", "low");
        products.add(product2);
        
        Map<String, Object> product3 = new HashMap<>();
        product3.put("name", "Moisturizing Cream");
        product3.put("category", "Moisturizer");
        product3.put("price", 1500.00);
        product3.put("stock", 5);
        product3.put("stockStatus", "low");
        products.add(product3);
        
        Map<String, Object> product4 = new HashMap<>();
        product4.put("name", "Sunscreen SPF 50");
        product4.put("category", "Sunscreen");
        product4.put("price", 2500.00);
        product4.put("stock", 32);
        product4.put("stockStatus", "ok");
        products.add(product4);
        
        request.setAttribute("products", products);
        
        request.setAttribute("lowStockCount", 12);
        request.setAttribute("mostSoldCategory", "Serums");
        request.setAttribute("avgOrderValue", 1850.00);
        request.setAttribute("outOfStockCount", 5);
        
        List<Map<String, Object>> recentOrders = new ArrayList<>();
        
        Map<String, Object> order1 = new HashMap<>();
        order1.put("id", "#1001");
        order1.put("customer", "Ram Sharma");
        order1.put("status", "Processing");
        order1.put("total", 2300.00);
        recentOrders.add(order1);
        
        Map<String, Object> order2 = new HashMap<>();
        order2.put("id", "#1002");
        order2.put("customer", "Sita Rai");
        order2.put("status", "Delivered");
        order2.put("total", 1800.00);
        recentOrders.add(order2);
        
        Map<String, Object> order3 = new HashMap<>();
        order3.put("id", "#1003");
        order3.put("customer", "Aarav KC");
        order3.put("status", "Pending");
        order3.put("total", 3400.00);
        recentOrders.add(order3);
        
        request.setAttribute("recentOrders", recentOrders);
        
        Map<String, Integer> categoryDistribution = new LinkedHashMap<>();
        categoryDistribution.put("Serums", 45);
        categoryDistribution.put("Cleansers", 28);
        categoryDistribution.put("Moisturizers", 32);
        categoryDistribution.put("Sunscreens", 18);
        
        request.setAttribute("categoryDistribution", categoryDistribution);
        
        request.setAttribute("pieChartUrl", request.getContextPath() + "/admin/chart/pie-chart");
        request.setAttribute("barChartUrl", request.getContextPath() + "/admin/chart/bar-chart");
        
        request.setAttribute("contentPage", "/pages/admin/dashboard.jsp");
        request.getRequestDispatcher("/layouts/admin-layout.jsp").forward(request, response);
    }
}