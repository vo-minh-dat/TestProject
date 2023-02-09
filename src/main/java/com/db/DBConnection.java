/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;

/**
 *
 * @author PhucPhan
 */
public class DBConnection {

    // initialize connection
    private static Connection conn = null;

    /**
     * Get connection
     *
     * @return connection
     */
    public static Connection getConnection() {
        if (conn == null) {
            try {
//                Class.forName("com.mysql.jdbc.Driver");
//                String url = "jdbc:mysql://localhost/my_first_database";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String url = "jdbc:sqlserver://DESKTOP-VQM9QT0:1433;databaseName=LibraryManagementFinal;user=sa;password=admin;encrypt=true;trustServerCertificate=true";
//                conn = DriverManager.getConnection(url, "root", "");
                conn = DriverManager.getConnection(url);
            } catch (ClassNotFoundException ex) {
                java.util.logging.Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                java.util.logging.Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return conn;
    }

    /**
     * Close connection
     */
    public void closeConnection() {
        try {
            if (conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
