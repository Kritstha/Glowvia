package com.glowvia.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.glowvia.model.User;
import com.glowvia.utils.DBConfig;

public class UserDAO {

    public void insertUser(String firstName, String lastName, String username,
                           String email, String password, String image) throws Exception {
        Connection con = DBConfig.getConnection();

        String sql = "INSERT INTO users (first_name, last_name, username, email, password, image) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
    }

    public User getUserByUsername(String username) throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT * FROM users WHERE username = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, username);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            User user = new User();
            user.setFirstName(rs.getString("full_name"));
            user.setUserName(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            return user;
        }

        rs.close();
        pst.close();
        con.close();
        return null;
    }
}