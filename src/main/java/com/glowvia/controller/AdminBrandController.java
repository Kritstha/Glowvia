package com.glowvia.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import com.glowvia.model.Brand;
import com.glowvia.service.BrandService;

@WebServlet("/admin/brands")
public class AdminBrandController extends HttpServlet {

    private BrandService brandService = new BrandService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Brand> brands = brandService.getAllBrands();
        request.setAttribute("brands", brands);

        request.setAttribute("contentPage", "/pages/admin/brands.jsp");
        request.getRequestDispatcher("/layouts/admin-layout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addBrand(request, response);
                break;
            case "update":
                updateBrand(request, response);
                break;
            case "delete":
                deleteBrand(request, response);
                break;
            default:
                response.sendRedirect("brands?error=Invalid action");
        }
    }

    private void addBrand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("brandName");
        String contact = request.getParameter("contactInfo");

        Brand brand = new Brand();
        brand.setName(name);
        brand.setContact(contact);

        boolean success = brandService.addBrand(brand);

        if (success) {
            response.sendRedirect("brands?message=Brand added");
        } else {
            response.sendRedirect("brands?error=Failed or duplicate brand");
        }
    }

    private void updateBrand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("brandId"));
        String name = request.getParameter("brandName");
        String contact = request.getParameter("contactInfo");

        Brand brand = new Brand();
        brand.setId(id);
        brand.setName(name);
        brand.setContact(contact);

        boolean success = brandService.updateBrand(brand);

        if (success) {
            response.sendRedirect("brands?message=Brand updated");
        } else {
            response.sendRedirect("brands?error=Update failed");
        }
    }

    private void deleteBrand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("brandId"));

        boolean success = brandService.deleteBrand(id);

        if (success) {
            response.sendRedirect("brands?message=Brand deleted");
        } else {
            response.sendRedirect("brands?error=Delete failed");
        }
    }
}