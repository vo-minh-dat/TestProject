/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;

/**
 *
 * @author PhucPhan
 */
public class Utils {

    /**
     * Get MD5 hash (using for password protector)
     *
     * @param input password that need to be hashed
     * @return hashed password
     */
    public static String getMd5(String input) {
        try {

            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());

            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);

            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    
    public static String getImagesFolderPath() {
        return "C:/Users/PhucPhan/Documents/NetBeansProjects/Final_LibraryManagement_Gr1/src/main/webapp/book_images/";
    }
    
    public static String getOverdueRemind(String name, String rollnumber, String book_title, int book_id, Date return_date) {
        String message = "Dear " + name + "\n";
        message += "This is a message from library administrator. You have borrowed the book " + book_title + " with the id " + book_id + "."
                + " Your returned date is " + return_date + " so the book is overdued. Please come to the library to return the book.\n";
        message += "Regardless.";
        return message;
    }
}
