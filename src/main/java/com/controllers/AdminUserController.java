/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.daos.UserDAO;
import com.models.Role;
import com.models.User;
import static com.utils.Utils.getMd5;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;

/**
 *
 * @author PhucPhan
 */
public class AdminUserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminUserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUserController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();

        if (path.endsWith("/admin/user")) {
            request.getRequestDispatcher("/admin_pages/admin_user.jsp").forward(request, response);
        } else {
            if (path.endsWith("/admin/user/insert")) {
                request.getRequestDispatcher("/admin_pages/admin_user_insert.jsp").forward(request, response);
            } else {
                if (path.startsWith("/admin/user/update")) {

                    String roll_number = request.getParameter("rollnumber");
                    UserDAO dao = new UserDAO();
                    User user = dao.getUserByRollnumber(roll_number);
                    if (user == null) {
                        response.sendRedirect("/admin/user");
                    } else {

                        request.getRequestDispatcher("/admin_pages/admin_user_update.jsp").forward(request, response);
                    }
                } else {
                    if (path.startsWith("/admin/user/delete")) {
                        String roll_number = request.getParameter("rollnumber");
                        UserDAO dao = new UserDAO();
                        dao.delete(roll_number);
                        response.sendRedirect("/admin/user");
                    }
                }
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("btnInsert") != null) {

            String rollnumber = request.getParameter("rollnumber");

            UserDAO dao = new UserDAO();
            User usercheck = dao.getUserByRollnumber(rollnumber);
            if (usercheck != null) {
                response.sendRedirect("/admin/user/insert?error=id_exist");
                return;
            }

            String email = request.getParameter("email");

            usercheck = dao.getUserByEmail(email);
            if (usercheck != null) {
                response.sendRedirect("/admin/user/insert?error=email_exist");
                return;
            }
            String password = request.getParameter("password");
            String repassword = request.getParameter("repassword");
            if (!password.equals(repassword)) {
                response.sendRedirect("/admin/user/insert?error=repassword");
                return;
            }
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String role = request.getParameter("role");
            String gender = request.getParameter("gender");
            String birthdate = request.getParameter("birthdate");
            String mainclass = request.getParameter("mainclass");
            String curriculum_code = request.getParameter("curriculum");
            int count = dao.addNew(new User(rollnumber, email, getMd5(password), role.equals("admin") ? Role.ADMIN : Role.USER, firstname, lastname, mainclass, Date.valueOf(birthdate), gender, null, null, curriculum_code));
            if (count > 0) {
                response.sendRedirect("/admin/user?message=add_success");
            } else {
                response.sendRedirect("/admin/user/insert?error=add_error");
            }

        }

        if (request.getParameter("btnUpdate") != null) {

            String rollnumber = request.getParameter("rollnumber");

            UserDAO dao = new UserDAO();
            User usercheck = dao.getUserByRollnumber(rollnumber);

            String email = request.getParameter("email");
            String curriculum_code = request.getParameter("curriculum");

            String password = request.getParameter("password");
            if (password.equals("")) {
                password = usercheck.getPassword();
            } else {
                String repassword = request.getParameter("repassword");

                if (!password.equals(repassword)) {
                    response.sendRedirect("/admin/user/update?rollnumer=" + rollnumber + "&major=" + curriculum_code + "&?error=repassword");
                    return;
                } else {
                    password = getMd5(password);
                }
            }

            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String role = request.getParameter("role");
            String gender = request.getParameter("gender");
            String birthdate = request.getParameter("birthdate");
            String mainclass = request.getParameter("mainclass");
         

            int count = dao.update(new User(rollnumber, email, password, role.equals("admin") ? Role.ADMIN : Role.USER, firstname, lastname, mainclass, Date.valueOf(birthdate), gender, null, null, curriculum_code));
            if (count > 0) {
                response.sendRedirect("/admin/user?message=update_success");
            } else {
                response.sendRedirect("/admin/user/update?rollnumer=" + rollnumber + "&major=" + curriculum_code + "&error=add_error");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
