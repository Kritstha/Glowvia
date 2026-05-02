package com.glowvia.utils;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;

public class SessionUtil {

    // Save username to session after login
    public static void setSession(HttpServletRequest request, String username) {
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
    }

    // Get username from session
    public static String getSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute("username");
        }
        return null;
    }

    // Clear session on logout
    public static void clearSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}