package com.glowvia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.glowvia.model.User;
import com.glowvia.utils.DBConfig;

public class UserDAO {

    public void insertUser(User user) throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "INSERT INTO users (full_name, username, dob, gender, phone, email, password, image_path, user_role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, user.getFullName());
        pst.setString(2, user.getUserName());
        pst.setString(3, user.getDob());
        pst.setString(4, user.getGender());
        pst.setString(5, user.getPhone());
        pst.setString(6, user.getEmail());
        pst.setString(7, user.getPassword());
        pst.setString(8, user.getImagePath());
        pst.setString(9, "user");
        pst.executeUpdate();
        pst.close();
        con.close();
    }

    public User getUserByUsername(String username) throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT * FROM users WHERE username = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, username);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            User user = new User();
            user.setUser_id(rs.getInt("user_id"));
            user.setFullName(rs.getString("full_name"));
            user.setUserName(rs.getString("username"));
            user.setDob(rs.getString("dob"));
            user.setGender(rs.getString("gender"));
            user.setPhone(rs.getString("phone"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setImagePath(rs.getString("image_path"));
            user.setUserRole(rs.getString("user_role"));
            return user;
        }

        rs.close();
        pst.close();
        con.close();
        return null;
    }
    
    public boolean isEmailExists(String email) throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT * FROM users WHERE email = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, email);
        ResultSet rs = pst.executeQuery();
        boolean exists = rs.next();
        rs.close();
        pst.close();
        con.close();
        return exists;
    }
    
    public boolean isUsernameExists(String username) throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT * FROM users WHERE username = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, username);
        ResultSet rs = pst.executeQuery();
        boolean exists = rs.next();
        rs.close();
        pst.close();
        con.close();
        return exists;
    }
}