<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Integer registeredCustomers = (Integer) request.getAttribute("registeredCustomers");
    Integer pendingOrders = (Integer) request.getAttribute("pendingOrders");
    
    List<Map<String, Object>> products = (List<Map<String, Object>>) request.getAttribute("products");
    Integer lowStockCount = (Integer) request.getAttribute("lowStockCount");
    String mostSoldCategory = (String) request.getAttribute("mostSoldCategory");
    Double avgOrderValue = (Double) request.getAttribute("avgOrderValue");
    Integer outOfStockCount = (Integer) request.getAttribute("outOfStockCount");
    
    List<Map<String, Object>> recentOrders = (List<Map<String, Object>>) request.getAttribute("recentOrders");
    Map<String, Integer> categoryDistribution = (Map<String, Integer>) request.getAttribute("categoryDistribution");
    
    String pieChartUrl = (String) request.getAttribute("pieChartUrl");
    String barChartUrl = (String) request.getAttribute("barChartUrl");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin_dashboard.css">

<div class="kpi-grid">
    <div class="kpi-card">
        <div class="kpi-value">Rs <%= String.format("%,.0f", totalRevenue) %></div>
        <div class="kpi-label">Total Revenue</div>
    </div>
    <div class="kpi-card">
        <div class="kpi-value"><%= totalOrders %></div>
        <div class="kpi-label">Total Orders</div>
    </div>
    <div class="kpi-card">
        <div class="kpi-value"><%= registeredCustomers %></div>
        <div class="kpi-label">Registered Customers</div>
    </div>
    <div class="kpi-card">
        <div class="kpi-value"><%= pendingOrders %></div>
        <div class="kpi-label">Pending Orders</div>
    </div>
</div>


<div class="grid-2">
   
    <div class="card">
        <div class="card-title">Product Inventory</div>
        
        <table>
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                </td>
            </thead>
            <tbody>
                <% for (Map<String, Object> product : products) { %>
                    <tr>
                        <td><%= product.get("name") %></td>
                        <td><%= product.get("category") %></td>
                        <td>Rs <%= product.get("price") %></td>
                        <td>
                            <span class="badge <%= "low".equals(product.get("stockStatus")) ? "low-stock" : "ok-stock" %>">
                                <%= product.get("stock") %>
                            </span>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>


    <div class="card">
        <div class="card-title">Quick Insights</div>
        
        <div class="list">
            <div class="list-item">
                <span>Low stock products</span>
                <span class="muted"><%= lowStockCount %> items</span>
            </div>
            <div class="list-item">
                <span>Most sold category</span>
                <span class="muted"><%= mostSoldCategory %></span>
            </div>
            <div class="list-item">
                <span>Average order value</span>
                <span class="muted">Rs <%= String.format("%,.0f", avgOrderValue) %></span>
            </div>
            <div class="list-item">
                <span>Out of Stock</span>
                <span class="muted"><%= outOfStockCount %></span>
            </div>
        </div>
        

        <div class="chart-container">
            <div style="font-size: 12px; color: #666; margin-bottom: 8px;">Sales Trend (Last 6 Months)</div>
            <img src="<%= barChartUrl %>" alt="Sales Trend Chart" class="chart-image" />
        </div>
    </div>
</div>


<div class="grid-2">

    <div class="card">
        <div class="card-title">Recent Orders</div>
        
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Status</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, Object> order : recentOrders) { %>
                    <tr>
                        <td><%= order.get("id") %></td>
                        <td><%= order.get("customer") %></td>
                        <td><span class="badge"><%= order.get("status") %></span></td>
                        <td>Rs <%= order.get("total") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>


    <div class="card">
        <div class="card-title">Category Distribution</div>
        
        <div class="list">
            <% for (Map.Entry<String, Integer> entry : categoryDistribution.entrySet()) { %>
                <div class="list-item">
                    <span><%= entry.getKey() %></span>
                    <span class="muted"><%= entry.getValue() %> products</span>
                </div>
            <% } %>
        </div>
        

        <div class="chart-container">
            <img src="<%= pieChartUrl %>" alt="Category Distribution Chart" class="chart-image" />
        </div>
    </div>
</div>