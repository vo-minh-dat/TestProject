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
public class Borrow {

    private int id;
    private String roll_number;
    private int book_id;
    private Date borrow_date;
    private Date return_date;
    private int condition;
    //condition : 
    // 0 is not approved
    // 1 is approved
    // 2 is declined

    public Borrow() {
    }

    public Borrow(int id, String roll_number, int book_id, Date borrow_date, Date return_date, int condition) {
        this.id = id;
        this.roll_number = roll_number;
        this.book_id = book_id;
        this.borrow_date = borrow_date;
        this.return_date = return_date;
        this.condition = condition;
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

    public Date getBorrow_date() {
        return borrow_date;
    }

    public void setBorrow_date(Date borrow_date) {
        this.borrow_date = borrow_date;
    }

    public Date getReturn_date() {
        return return_date;
    }

    public void setReturn_date(Date return_date) {
        this.return_date = return_date;
    }

    public int getCondition() {
        return condition;
    }

    public void setCondition(int condition) {
        this.condition = condition;
    }

}
