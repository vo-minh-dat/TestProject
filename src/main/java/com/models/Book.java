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
public class Book {

    private int id;
    private String title;
    private String author;
    private String img_path;
    private String publisher;
    private Date published_date;
    private String edition;
    private int quantity;
    private String description;
    private String server_img;

    public Book() {
    }

    public Book(int id, String title, String author, String img_path, String publisher, Date published_date, String edition, int quantity, String description, String server_img) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.img_path = img_path;
        this.publisher = publisher;
        this.published_date = published_date;
        this.edition = edition;
        this.quantity = quantity;
        this.description = description;
        this.server_img = server_img;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getImg_path() {
        return img_path;
    }

    public void setImg_path(String img_path) {
        this.img_path = img_path;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public Date getPublished_date() {
        return published_date;
    }

    public void setPublished_date(Date published_date) {
        this.published_date = published_date;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getServer_img() {
        return server_img;
    }

    public void setServer_img(String server_img) {
        this.server_img = server_img;
    }

   

}
