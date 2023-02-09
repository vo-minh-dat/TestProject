/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
import com.models.Borrow;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PhucPhan
 */
public class BorrowDAO {

    private Connection conn = null;

    public BorrowDAO() {
        conn = DBConnection.getConnection();
    }

    public ResultSet getByCondition(int condition) {
        PreparedStatement pst;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement("Select * from [Borrow] where condition=?");
            pst.setInt(1, condition);

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getByCondition(int condition, String rollnumber) {
        PreparedStatement pst;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement("Select * from [Borrow] where condition=? and roll_number=?");
            pst.setInt(1, condition);
            pst.setString(2, rollnumber);

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Borrow getById(int id) {
        Borrow borrow = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("Select * from [Borrow] where id=?");
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                borrow = new Borrow(rs.getInt("id"),
                        rs.getString("roll_number"),
                        rs.getInt("book_id"),
                        rs.getDate("borrow_date"),
                        rs.getDate("return_date"),
                        rs.getInt("condition")
                );

            }
        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return borrow;
    }

    public ResultSet getMostActiveUser() {
        PreparedStatement pst;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement("select count(roll_number) as COUNT, roll_number from borrow \n"
                    + "where condition = 2\n"
                    + "group by roll_number");

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getBorrowing() {
        PreparedStatement pst;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement("Select * from [Borrow] where condition=1\n"
                    + "and return_date >= CAST(CURRENT_TIMESTAMP AS DATE)");

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getBorrowing(String rollnumber) {
        PreparedStatement pst;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement("Select * from [Borrow] where condition=1\n"
                    + "and return_date >= CAST(CURRENT_TIMESTAMP AS DATE)"
                    + "and roll_number=?");
            pst.setString(1, rollnumber);

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getOverdue() {
        PreparedStatement pst;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement("Select * from [Borrow] where condition in (1,3)\n"
                    + "and return_date < CAST(CURRENT_TIMESTAMP AS DATE)");

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getOverdue(String rollnumber) {
        PreparedStatement pst;
        ResultSet rs = null;

        try {
            pst = conn.prepareStatement("Select * from [Borrow] where condition in (1,3)\n"
                    + "and return_date < CAST(CURRENT_TIMESTAMP AS DATE)"
                    + "and roll_number=?");
            pst.setString(1, rollnumber);

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public int addNew(Borrow borrow) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into Borrow values(?,?,?,?,?)");
            pst.setString(1, borrow.getRoll_number());
            pst.setInt(2, borrow.getBook_id());
            pst.setDate(3, borrow.getBorrow_date());
            pst.setDate(4, borrow.getReturn_date());
            pst.setInt(5, borrow.getCondition());

            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int checkCondition(String roll_number, int book_id) {
        int condition = -1;
        PreparedStatement pst;
        try {

            pst = conn.prepareStatement("Select * from Borrow where roll_number=? and book_id= ?");
            pst.setString(1, roll_number);
            pst.setInt(2, book_id);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                condition = rs.getInt("condition");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return condition;
    }

    public int changeCondition(int id, int condition) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("update [Borrow] set condition=? where id=?");

            pst.setInt(1, condition);
            pst.setInt(2, id);
            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int extendReturnedDate(int id, Date date) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("update [Borrow] set return_date=? where id=?");

            pst.setDate(1, date);
            pst.setInt(2, id);
            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int reject(int id) {

        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from [Borrow] where id=?");
            pst.setInt(1, id);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
}
