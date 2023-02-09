/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
import com.models.Role;
import com.models.User;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PhucPhan
 */
public class UserDAO {

    private Connection conn = null;

    public UserDAO() {
        conn = DBConnection.getConnection();
    }

    public int getNumberOfNewUserToday() {
        ResultSet rs = null;
        int count = 0;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from [User]\n"
                    + "where registration_date = CAST(CURRENT_TIMESTAMP AS DATE)");
            while (rs.next()) {
                count++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public User getUserByEmail(String email) {
        User user = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("Select * from [User] where email=?");
            pst.setString(1, email);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setRoll_number(rs.getString("roll_number"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getInt("role") == 1 ? Role.ADMIN : Role.USER);
                user.setFirst_name(rs.getString("first_name"));
                user.setLast_name(rs.getString("last_name"));
                user.setMain_class(rs.getString("main_class"));
                user.setDate_of_birth(rs.getDate("date_of_birth"));
                user.setGender(rs.getString("gender"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public User getUserByRollnumber(String rollnumber) {
        User user = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("Select * from [User] where roll_number=?");
            pst.setString(1, rollnumber);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setRoll_number(rs.getString("roll_number"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getInt("role") == 1 ? Role.ADMIN : Role.USER);
                user.setFirst_name(rs.getString("first_name"));
                user.setLast_name(rs.getString("last_name"));
                user.setMain_class(rs.getString("main_class"));
                user.setDate_of_birth(rs.getDate("date_of_birth"));
                user.setGender(rs.getString("gender"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public int addNew(User user) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into [User] values(?,?,?,?,?,?,?,?,?, NULL, NULL, NULL, NULL, ?, ?)");
            pst.setString(1, user.getRoll_number());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPassword());
            pst.setInt(4, user.getRole() == Role.ADMIN ? 1 : 0);
            pst.setString(5, user.getFirst_name());
            pst.setString(6, user.getLast_name());
            pst.setString(7, user.getMain_class().equalsIgnoreCase("none") ? null : user.getMain_class());
            pst.setDate(8, user.getDate_of_birth());
            pst.setString(9, user.getGender());
            pst.setString(10, user.getCurriculum_code().equalsIgnoreCase("none") ? null : user.getCurriculum_code());
            pst.setDate(11, new Date(System.currentTimeMillis()));
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("Select * from [User]");
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAllExceptAdmin(String rollnumber) {
        PreparedStatement pst;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement("Select * from [User] where roll_number !=?");
            pst.setString(1, rollnumber);

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public int update(User user) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("update [User] set "
                    + "[password]=?,\n"
                    + "first_name=?,\n"
                    + "last_name=?,\n"
                    + "main_class=?,\n"
                    + "date_of_birth=?,\n"
                    + "gender=?,\n"
                    + "curriculum_code=?,\n"
                    + "[role]=?\n"
                    + "Where roll_number=?");
            pst.setString(1, user.getPassword());
            pst.setString(2, user.getFirst_name());
            pst.setString(3, user.getLast_name());
            pst.setString(4, user.getMain_class().equalsIgnoreCase("none") ? null : user.getMain_class());
            pst.setDate(5, user.getDate_of_birth());
            pst.setString(6, user.getGender());
            pst.setString(7, user.getCurriculum_code().equalsIgnoreCase("none") ? null : user.getCurriculum_code());
            pst.setInt(8, user.getRole() == Role.ADMIN ? 1 : 0);
            pst.setString(9, user.getRoll_number());

            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int delete(String roll_number) {

        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from [User] where roll_number=?");
            pst.setString(1, roll_number);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
}
