package com.glowvia.service;

import com.glowvia.dao.UserDAO;
import com.glowvia.model.User;
import com.glowvia.utils.PasswordUtil;

public class LoginService {

    public Boolean loginUser(User user) {
        try {
            UserDAO dao = new UserDAO();
            User dbUser = dao.getUserByUsername(user.getUserName());

            if (dbUser != null) {
                return PasswordUtil.checkPassword(user.getPassword(), dbUser.getPassword());
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return false;
    }
}