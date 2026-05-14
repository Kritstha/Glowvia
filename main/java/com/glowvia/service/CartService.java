package com.glowvia.service;

import com.glowvia.dao.CartDAO;

public class CartService {

    private CartDAO dao = new CartDAO();

    // Original method for backward compatibility (default quantity = 1)
    public boolean addToCart(int userId, int productId) {
        return addToCart(userId, productId, 1);
    }

    // New method with quantity parameter
    public boolean addToCart(int userId, int productId, int quantity) {

        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        // Get existing cart
        int cartId = dao.getCartIdByUserId(userId);

        // Create new cart if not exists
        if (cartId == -1) {
            cartId = dao.createCart(userId);
        }

        if (cartId == -1) {
            return false;
        }

        // Product already in cart
        if (dao.cartProductExists(cartId, productId)) {
            return dao.increaseQuantity(cartId, productId, quantity);
        }

        // Add new product with specified quantity
        return dao.addCartProduct(cartId, productId, quantity);
    }

    // Get total cart count
    public int getCartCount(int userId) {

        if (userId <= 0) {
            return 0;
        }

        // Get existing cart
        int cartId = dao.getCartIdByUserId(userId);

        // If no cart exists, count is 0
        if (cartId == -1) {
            return 0;
        }

        // Get total quantity from cart
        return dao.getCartTotalQuantity(cartId);
    }
}