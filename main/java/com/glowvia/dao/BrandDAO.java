package com.glowvia.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.glowvia.model.Brand;
import com.glowvia.utils.DBConfig;

public class BrandDAO {

    public List<Brand> getAllBrands() {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT id, name, contact FROM brands ORDER BY name ASC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Brand brand = new Brand();
                brand.setId(rs.getInt("id"));
                brand.setName(rs.getString("name"));
                brand.setContact(rs.getString("contact"));
                brands.add(brand);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    public Brand getBrandById(int id) {
        String sql = "SELECT id, name, contact FROM brands WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Brand brand = new Brand();
                brand.setId(rs.getInt("id"));
                brand.setName(rs.getString("name"));
                brand.setContact(rs.getString("contact"));
                return brand;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean brandExists(String name) {
        String sql = "SELECT COUNT(*) FROM brands WHERE name = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean brandExistsExcludingId(String name, int excludeId) {
        String sql = "SELECT COUNT(*) FROM brands WHERE name = ? AND id != ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setInt(2, excludeId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addBrand(Brand brand) {
        String sql = "INSERT INTO brands (name, contact) VALUES (?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, brand.getName());
            stmt.setString(2, brand.getContact());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateBrand(Brand brand) {
        String sql = "UPDATE brands SET name = ?, contact = ? WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, brand.getName());
            stmt.setString(2, brand.getContact());
            stmt.setInt(3, brand.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBrand(int id) {
        String sql = "DELETE FROM brands WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}