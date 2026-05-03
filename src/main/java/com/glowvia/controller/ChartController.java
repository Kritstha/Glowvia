package com.glowvia.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import java.io.IOException;

@WebServlet("/admin/chart/*")
public class ChartController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if ("/pie-chart".equals(pathInfo)) {
            generatePieChart(response);
        } else if ("/bar-chart".equals(pathInfo)) {
            generateBarChart(response);
        }
    }

    private void generatePieChart(HttpServletResponse response) throws IOException {

        DefaultPieDataset dataset = new DefaultPieDataset();
        dataset.setValue("Serums", 45);
        dataset.setValue("Cleansers", 28);
        dataset.setValue("Moisturizers", 32);
        dataset.setValue("Sunscreens", 18);

        JFreeChart chart = ChartFactory.createPieChart(
                "Category Distribution",
                dataset,
                true,
                true,
                false
        );

        response.setContentType("image/png");
        ChartUtils.writeChartAsPNG(response.getOutputStream(), chart, 400, 300);
    }

    private void generateBarChart(HttpServletResponse response) throws IOException {

        DefaultCategoryDataset dataset = new DefaultCategoryDataset();

        dataset.addValue(125000, "Sales", "Jan");
        dataset.addValue(142000, "Sales", "Feb");
        dataset.addValue(138000, "Sales", "Mar");
        dataset.addValue(165000, "Sales", "Apr");
        dataset.addValue(189000, "Sales", "May");
        dataset.addValue(210000, "Sales", "Jun");

        JFreeChart chart = ChartFactory.createBarChart(
                "Monthly Sales Trend",
                "Month",
                "Amount (Rs)",
                dataset
        );

        response.setContentType("image/png");
        ChartUtils.writeChartAsPNG(response.getOutputStream(), chart, 600, 400);
    }
}