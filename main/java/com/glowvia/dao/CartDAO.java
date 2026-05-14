package com.glowvia.dao;

import java.sql.*;

import com.glowvia.utils.DBConfig;

public class CartDAO {

    // Get cart by user id
    public int getCartIdByUserId(int userId) {

        String sql = "SELECT cart_id FROM carts WHERE user_id = ?";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("cart_id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    // Create cart
    public int createCart(int userId) {

        String sql = "INSERT INTO carts (user_id) VALUES (?)";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {

            stmt.setInt(1, userId);

            int rows = stmt.executeUpdate();

            if (rows > 0) {

                ResultSet rs = stmt.getGeneratedKeys();

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    // Check if product already exists
    public boolean cartProductExists(int cartId, int productId) {

        String sql = "SELECT COUNT(*) FROM cart_products WHERE cart_id = ? AND product_id = ?";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Check if sufficient stock is available
    public boolean hasSufficientStock(int productId, int requestedQuantity) {
        String sql = "SELECT stock_quantity FROM products WHERE product_id = ?";
        
        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                int availableStock = rs.getInt("stock_quantity");
                return availableStock >= requestedQuantity;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    // Decrease product stock
    private boolean decreaseStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE product_id = ? AND stock_quantity >= ?";
        
        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    // Increase stock (for rollbacks or returns)
    public boolean increaseStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock_quantity = stock_quantity + ? WHERE product_id = ?";
        
        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    // Increase quantity by a specific amount (with stock check)
    public boolean increaseQuantity(int cartId, int productId, int quantityToAdd) {
        
        // First check if sufficient stock is available
        if (!hasSufficientStock(productId, quantityToAdd)) {
            System.err.println("Insufficient stock for product ID: " + productId);
            return false;
        }
        
        // Decrease stock first (to prevent race conditions)
        if (!decreaseStock(productId, quantityToAdd)) {
            System.err.println("Failed to decrease stock for product ID: " + productId);
            return false;
        }
        
        // If stock decreased successfully, update cart quantity
        String sql = "UPDATE cart_products SET quantity = quantity + ? WHERE cart_id = ? AND product_id = ?";
        
        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, quantityToAdd);
            stmt.setInt(2, cartId);
            stmt.setInt(3, productId);
            
            boolean updated = stmt.executeUpdate() > 0;
            
            // If cart update fails, rollback the stock decrease
            if (!updated) {
                increaseStock(productId, quantityToAdd);
                System.err.println("Failed to update cart, stock has been restored for product ID: " + productId);
            }
            
            return updated;
            
        } catch (SQLException e) {
            // Rollback stock decrease on exception
            increaseStock(productId, quantityToAdd);
            e.printStackTrace();
        }
        
        return false;
    }

    // Overloaded method for backward compatibility (increase by 1)
    public boolean increaseQuantity(int cartId, int productId) {
        return increaseQuantity(cartId, productId, 1);
    }

    // Add product to cart with specific quantity (with stock check)
    public boolean addCartProduct(int cartId, int productId, int quantity) {
        
        // First check if sufficient stock is available
        if (!hasSufficientStock(productId, quantity)) {
            System.err.println("Insufficient stock for product ID: " + productId);
            return false;
        }
        
        // Decrease stock first (to prevent race conditions)
        if (!decreaseStock(productId, quantity)) {
            System.err.println("Failed to decrease stock for product ID: " + productId);
            return false;
        }
        
        // If stock decreased successfully, add product to cart
        String sql = "INSERT INTO cart_products (cart_id, product_id, quantity) VALUES (?, ?, ?)";
        
        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            
            boolean added = stmt.executeUpdate() > 0;
            
            // If cart update fails, rollback the stock decrease
            if (!added) {
                increaseStock(productId, quantity);
                System.err.println("Failed to add to cart, stock has been restored for product ID: " + productId);
            }
            
            return added;
            
        } catch (SQLException e) {
            // Rollback stock decrease on exception
            increaseStock(productId, quantity);
            e.printStackTrace();
        }
        
        return false;
    }

    // Overloaded method for backward compatibility (quantity = 1)
    public boolean addCartProduct(int cartId, int productId) {
        return addCartProduct(cartId, productId, 1);
    }

    // Get total quantity from cart
    public int getCartTotalQuantity(int cartId) {

        String sql = "SELECT SUM(quantity) as total_quantity FROM cart_products WHERE cart_id = ?";

        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, cartId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // SUM() returns null if no products, so handle that case
                int total = rs.getInt("total_quantity");
                return rs.wasNull() ? 0 : total;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    
    // Remove product from cart and restore stock
    public boolean removeCartProduct(int cartId, int productId) {
        // First get the quantity to restore stock
        String selectSql = "SELECT quantity FROM cart_products WHERE cart_id = ? AND product_id = ?";
        int quantity = 0;
        
        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(selectSql)
        ) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                quantity = rs.getInt("quantity");
            } else {
                System.err.println("Product not found in cart");
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        
        // Remove from cart
        String deleteSql = "DELETE FROM cart_products WHERE cart_id = ? AND product_id = ?";
        
        try (
                Connection conn = DBConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(deleteSql)
        ) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            
            boolean removed = stmt.executeUpdate() > 0;
            
            // If removed successfully, restore stock
            if (removed) {
                increaseStock(productId, quantity);
            }
            
            return removed;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}