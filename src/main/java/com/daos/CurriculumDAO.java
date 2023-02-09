/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
import com.models.Curriculum;
import java.sql.Connection;
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
public class CurriculumDAO {

    private Connection conn = null;

    public CurriculumDAO() {
        conn = DBConnection.getConnection();
    }

    public ResultSet getAllCurriculum() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Curriculum");
        } catch (SQLException ex) {
            Logger.getLogger(CurriculumDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
     public String getCurriculumName(String code) {
        String name = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("Select * from [Curriculum] where code=?");
            pst.setString(1, code);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");

            }
        } catch (SQLException ex) {
            Logger.getLogger(CurriculumDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return name;
    }
    
     public List<Curriculum> getListCurriculum() {
        List<Curriculum> curriculums = new ArrayList<Curriculum>();

        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("Select * from Curriculum");
            while (rs.next()) {
                curriculums.add(new Curriculum(rs.getString("code"), rs.getString("name")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CurriculumDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return curriculums;
    }
}
