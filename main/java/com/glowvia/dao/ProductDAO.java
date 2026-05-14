package com.glowvia.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.glowvia.model.Product;
import com.glowvia.utils.DBConfig;

public class ProductDAO {

    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql =
                "SELECT p.product_id, p.name, p.brand_id, p.category, p.skin_type, " +
                "p.key_ingredients, p.price, p.stock_quantity, p.description, p.photo_path, " +
                "b.name AS brand_name " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "ORDER BY p.name ASC";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setBrandId(rs.getInt("brand_id"));
                product.setBrandName(rs.getString("brand_name"));
                product.setCategory(rs.getString("category"));
                product.setSkinType(rs.getString("skin_type"));
                product.setKeyIngredients(rs.getString("key_ingredients"));
                product.setPrice(rs.getDouble("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setDescription(rs.getString("description"));
                product.setPhotoPath(rs.getString("photo_path"));

                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public Product getProductById(int productId) {

        String sql =
                "SELECT p.product_id, p.name, p.brand_id, p.category, p.skin_type, " +
                "p.key_ingredients, p.price, p.stock_quantity, p.description, p.photo_path, " +
                "b.name AS brand_name " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.brand_id = b.brand_id " +
                "WHERE p.product_id = ?";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setBrandId(rs.getInt("brand_id"));
                product.setBrandName(rs.getString("brand_name"));
                product.setCategory(rs.getString("category"));
                product.setSkinType(rs.getString("skin_type"));
                product.setKeyIngredients(rs.getString("key_ingredients"));
                product.setPrice(rs.getDouble("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setDescription(rs.getString("description"));
                product.setPhotoPath(rs.getString("photo_path"));

                return product;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean productExists(String name, int brandId) {

        String sql =
                "SELECT COUNT(*) FROM products " +
                "WHERE name = ? AND brand_id = ?";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, name);
            stmt.setInt(2, brandId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean productExistsExcludingId(String name, int brandId, int excludeId) {

        String sql =
                "SELECT COUNT(*) FROM products " +
                "WHERE name = ? AND brand_id = ? AND product_id != ?";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, name);
            stmt.setInt(2, brandId);
            stmt.setInt(3, excludeId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean addProduct(Product product) {

        String sql =
                "INSERT INTO products " +
                "(name, brand_id, category, skin_type, key_ingredients, " +
                "price, stock_quantity, description, photo_path) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, product.getName());
            stmt.setInt(2, product.getBrandId());
            stmt.setString(3, product.getCategory());
            stmt.setString(4, product.getSkinType());
            stmt.setString(5, product.getKeyIngredients());
            stmt.setDouble(6, product.getPrice());
            stmt.setInt(7, product.getStockQuantity());
            stmt.setString(8, product.getDescription());
            stmt.setString(9, product.getPhotoPath());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateProduct(Product product) {

        String sql =
                "UPDATE products SET " +
                "name = ?, " +
                "brand_id = ?, " +
                "category = ?, " +
                "skin_type = ?, " +
                "key_ingredients = ?, " +
                "price = ?, " +
                "stock_quantity = ?, " +
                "description = ?, " +
                "photo_path = ? " +
                "WHERE product_id = ?";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, product.getName());
            stmt.setInt(2, product.getBrandId());
            stmt.setString(3, product.getCategory());
            stmt.setString(4, product.getSkinType());
            stmt.setString(5, product.getKeyIngredients());
            stmt.setDouble(6, product.getPrice());
            stmt.setInt(7, product.getStockQuantity());
            stmt.setString(8, product.getDescription());
            stmt.setString(9, product.getPhotoPath());
            stmt.setInt(10, product.getProductId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteProduct(int productId) {

        String sql = "DELETE FROM products WHERE product_id = ?";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, productId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}