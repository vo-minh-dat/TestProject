/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.daos.BookDAO;
import com.daos.BorrowDAO;
import com.daos.MessageDAO;
import com.daos.UserDAO;
import com.models.Book;
import com.models.Borrow;
import com.models.Message;
import com.models.User;
import static com.utils.Utils.getOverdueRemind;
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
public class AdminBorrowOverdueController extends HttpServlet {

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
            out.println("<title>Servlet AdminBorrowOverdueController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminBorrowOverdueController at " + request.getContextPath() + "</h1>");
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

        if (path.startsWith("/admin/borrow/overdue/return")) {
            BorrowDAO bd = new BorrowDAO();
            int id = -1;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e) {
                request.getRequestDispatcher("/admin_pages/admin_borrow_overdue.jsp").forward(request, response);
            }
            bd.changeCondition(id, 2);

        } else if (path.startsWith("/admin/borrow/overdue/message")) {
            BorrowDAO bd = new BorrowDAO();
            int id = -1;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e) {
                request.getRequestDispatcher("/admin_pages/admin_borrow_overdue.jsp").forward(request, response);
            }
            Borrow borrow = bd.getById(id);
            UserDAO udao = new UserDAO();
            User borrower = udao.getUserByRollnumber(borrow.getRoll_number());
            String fullname = borrower.getFirst_name() + " " + borrower.getLast_name();
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.getBookByID(borrow.getBook_id());

            MessageDAO md = new MessageDAO();
            bd.changeCondition(id, 3);
            md.addNew(new Message(1, borrow.getRoll_number(), "Remind: Borrow overdue", getOverdueRemind(fullname, borrow.getRoll_number(), book.getTitle(), book.getId(), borrow.getReturn_date()), 1, new Date(System.currentTimeMillis()), -1));
        }
        request.getRequestDispatcher("/admin_pages/admin_borrow_overdue.jsp").forward(request, response);
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
        String extendDate = request.getParameter("extendDate");
        int id = Integer.parseInt(request.getParameter("id"));
        BorrowDAO bd = new BorrowDAO();
        bd.extendReturnedDate(id, Date.valueOf(extendDate));
        bd.changeCondition(id, 1);

        response.sendRedirect("/admin/borrow/overdue?message=extend_success");
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
