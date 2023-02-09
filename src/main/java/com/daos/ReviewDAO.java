/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
import com.models.Review;
import com.models.ReviewWithUsername;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PhucPhan
 */
public class ReviewDAO {

    private Connection conn = null;

    public ReviewDAO() {
        conn = DBConnection.getConnection();
    }

    public int addNew(Review comment) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into Review values(?,?,?,?,?)");
            pst.setString(1, comment.getRoll_number());
            pst.setInt(2, comment.getBook_id());
            pst.setString(3, comment.getComment());
            pst.setInt(4, comment.getVote_star());
            pst.setDate(5, comment.getDate());

            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int update(Review review) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("update Review set comment=?,vote_star=?,date=? Where roll_number=? and book_id=?");
            pst.setString(1, review.getComment());
            pst.setInt(2, review.getVote_star());
            pst.setDate(3, review.getDate());
            pst.setString(4, review.getRoll_number());
            pst.setInt(5, review.getBook_id());
            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public boolean checkReview(String roll_number, int book_id) {
        PreparedStatement pst;
        try {

            pst = conn.prepareStatement("Select * from Review where roll_number=? and book_id= ?");
            pst.setString(1, roll_number);
            pst.setInt(2, book_id);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
public int getNumberOfReviewToday() {
        ResultSet rs = null;
        int count = 0;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from [Review]\n"
                    + "where date = CAST(CURRENT_TIMESTAMP AS DATE)");
            while (rs.next()) {
                count++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BorrowDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public List<ReviewWithUsername> getBookReview(int book_id) {
        List<ReviewWithUsername> reviews = new ArrayList<ReviewWithUsername>();
        ResultSet rs = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("select id, [User].roll_number, book_id, comment, vote_star, [date], CONCAT([User].first_name,' ', [User].last_name) as [username]  from [Review] \n"
                    + "join [User]\n"
                    + "on [Review].roll_number = [User].roll_number\n"
                    + "where [Review].book_id=?");
            pst.setInt(1, book_id);
            rs = pst.executeQuery();
            while (rs.next()) {
                ReviewWithUsername review = new ReviewWithUsername(rs.getInt("id"),
                        rs.getString("roll_number"),
                        rs.getInt("book_id"),
                        rs.getString("comment"),
                        rs.getInt("vote_star"),
                        rs.getDate("date"),
                        rs.getString("username")
                );
                reviews.add(review);

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reviews;
    }
}
