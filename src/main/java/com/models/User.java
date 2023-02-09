/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import java.sql.Date;
import java.util.List;

/**
 *
 * @author PhucPhan
 */
public class User {
    private String roll_number;
    private String email;
    private String password;
    private Role role;
    private String first_name;
    private String last_name;
    private String main_class;
    private Date date_of_birth;
    private String gender;
    
    private List<Book> book_list;
    
    private String admin_message;
    private String curriculum_code;
            
    
    public User() {
    }

    public User(String roll_number, String email, String password, Role role, String first_name, String last_name, String main_class, Date date_of_birth, String gender, List<Book> book_list, String admin_message, String curriculum_code) {
        this.roll_number = roll_number;
        this.email = email;
        this.password = password;
        this.role = role;
        this.first_name = first_name;
        this.last_name = last_name;
        this.main_class = main_class;
        this.date_of_birth = date_of_birth;
        this.gender = gender;
        this.book_list = book_list;
        this.admin_message = admin_message;
        this.curriculum_code = curriculum_code;
    }

    public String getRoll_number() {
        return roll_number;
    }

    public void setRoll_number(String roll_number) {
        this.roll_number = roll_number;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getMain_class() {
        return main_class;
    }

    public void setMain_class(String main_class) {
        this.main_class = main_class;
    }

    public Date getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public List<Book> getBook_list() {
        return book_list;
    }

    public void setBook_list(List<Book> book_list) {
        this.book_list = book_list;
    }

    public String getAdmin_message() {
        return admin_message;
    }

    public void setAdmin_message(String admin_message) {
        this.admin_message = admin_message;
    }

    public String getCurriculum_code() {
        return curriculum_code;
    }

    public void setCurriculum_code(String curriculum_code) {
        this.curriculum_code = curriculum_code;
    }

  

}
