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
public class Message {
    private int id;
    private String roll_number;
    private String subject;
    private String message;
    private int sender;
    private Date date;
    private Integer reply_to;

    public Message() {
    }

    public Message(int id, String roll_number, String subject, String message, int sender, Date date, Integer reply_to) {
        this.id = id;
        this.roll_number = roll_number;
        this.subject = subject;
        this.message = message;
        this.sender = sender;
        this.date = date;
        this.reply_to = reply_to;
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

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getSender() {
        return sender;
    }

    public void setSender(int sender) {
        this.sender = sender;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getReply_to() {
        return reply_to;
    }

    public void setReply_to(Integer reply_to) {
        this.reply_to = reply_to;
    }
    
    
}
