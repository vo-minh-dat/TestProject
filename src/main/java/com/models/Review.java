/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import java.sql.Date;

/**
 *
 * @author PhucPhan
 */
public class Review {
     int id;
    String roll_number;
    int book_id;
    String comment;
    int vote_star;
    Date date;

    public Review() {
    }

    public Review(int id, String roll_number, int book_id, String comment, int vote_star, Date date) {
        this.id = id;
        this.roll_number = roll_number;
        this.book_id = book_id;
        this.comment = comment;
        this.vote_star = vote_star;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoll_number() {
        return roll_number;
    }

    public void setRoll_number(String roll_number) {
        this.roll_number = roll_number;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getVote_star() {
        return vote_star;
    }

    public void setVote_star(int vote_star) {
        this.vote_star = vote_star;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    
    
    
}
