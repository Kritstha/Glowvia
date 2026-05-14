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

        if (action == null) {
            setError(request, "Invalid action");
            response.sendRedirect("brands");
            return;
        }

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
                setError(request, "Invalid action");
                response.sendRedirect("brands");
        }
    }

    private void addBrand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("brandName");
        String contact = request.getParameter("contactInfo");

        Brand brand = new Brand();
        brand.setName(name);
        brand.setContact(contact);

        if (brandService.addBrand(brand)) {
            setSuccess(request, "Brand added successfully");
        } else {
            setError(request, "Failed or duplicate brand");
        }

        response.sendRedirect("brands");
    }

    private void updateBrand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int brand_id = Integer.parseInt(request.getParameter("brandId"));
        String name = request.getParameter("brandName");
        String contact = request.getParameter("contactInfo");

        Brand brand = new Brand();
        brand.setBrand_id(brand_id);
        brand.setName(name);
        brand.setContact(contact);

        if (brandService.updateBrand(brand)) {
            setSuccess(request, "Brand updated successfully");
        } else {
            setError(request, "Update failed");
        }

        response.sendRedirect("brands");
    }

    private void deleteBrand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int brand_id = Integer.parseInt(request.getParameter("brandId"));

        if (brandService.deleteBrand(brand_id)) {
            setSuccess(request, "Brand deleted successfully");
        } else {
            setError(request, "Delete failed");
        }

        response.sendRedirect("brands");
    }

    private void setSuccess(HttpServletRequest request, String msg) {
        HttpSession session = request.getSession();
        session.setAttribute("message", msg);
    }

    private void setError(HttpServletRequest request, String msg) {
        HttpSession session = request.getSession();
        session.setAttribute("error_message", msg);
    }
}