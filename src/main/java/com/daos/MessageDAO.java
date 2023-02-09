/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
import com.models.Message;
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
public class MessageDAO {

    private Connection conn = null;

    public MessageDAO() {
        conn = DBConnection.getConnection();
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("Select * from Message where sender=0");
        } catch (SQLException ex) {
            Logger.getLogger(MessageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getAllForUser(String rollnumber) {
        ResultSet rs = null;

        try {
            PreparedStatement pst = conn.prepareStatement("Select * from Message where sender=1 and roll_number=?");
            pst.setString(1, rollnumber);

            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;

    }

    public int addNew(Message message) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into [Message] values(?,?,?,?,?,?)");
            pst.setString(1, message.getRoll_number());
            pst.setString(2, message.getSubject());
            pst.setString(3, message.getMessage());
            pst.setInt(4, message.getSender());
            pst.setDate(5, message.getDate());
            pst.setInt(6, message.getReply_to());

            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MessageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
}
