/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.daos.BookDAO;
import com.daos.BorrowDAO;
import com.models.Book;
import com.models.Borrow;
import com.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author PhucPhan
 */
public class AddToBookListController extends HttpServlet {

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
            out.println("<title>Servlet AddToBookListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToBookListController at " + request.getContextPath() + "</h1>");
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
        ArrayList<Borrow> bookList = new ArrayList<>();

        User user = (User) request.getSession().getAttribute("user");
        String roll_number = user.getRoll_number();

        int book_id = Integer.parseInt(request.getParameter("book_id"));
        BookDAO bd = new BookDAO();
        Book targetBook = bd.getBookByID(book_id);
        Borrow targetBorrow = new Borrow(1, roll_number, targetBook.getId(), new Date(System.currentTimeMillis()), new Date(System.currentTimeMillis()), 0);

        if (targetBook.getQuantity() == 0) {
            response.sendRedirect("/?error=no_book_left");
            return;
        }

        BorrowDAO brDAO = new BorrowDAO();
        int condition = brDAO.checkCondition(roll_number, book_id);

        switch (condition) {
            case 0:
                response.sendRedirect("/?error=waiting_for_approved");
                return;
            case 1:
                response.sendRedirect("/?error=already_borrow");
                return;
          
            default:
                break;
        }

        HttpSession session = request.getSession();
        ArrayList<Borrow> book_list = (ArrayList<Borrow>) session.getAttribute("book-list");
        if (book_list == null) {
            bookList.add(targetBorrow);
            session.setAttribute("book-list", bookList);
            String text = request.getHeader("Referer");
            String url = text.replaceAll("http://localhost:8080", "");
            response.sendRedirect(url);
//            response.sendRedirect("/detail?id=" + book_id);
        } else {
            bookList = book_list;
            boolean exist = false;

            for (Borrow b : book_list) {
                if (b.getBook_id() == book_id) {
                    exist = true;
                    String from = request.getParameter("from");
                    if (from == null) {
                        response.sendRedirect("/?error=already_exist_in_the_list");
                    } else if (from.equals("detail")) {
                        String id = request.getParameter("id");
                        response.sendRedirect("/detail?id=" + id + "&error=already_exist_in_the_list");

                    } else {
                        response.sendRedirect("/?error=already_exist_in_the_list");

                    }
                }
            }

            if (!exist) {
                bookList.add(targetBorrow);
                session.setAttribute("book-list", bookList);
                String text = request.getHeader("Referer");
                String url = text.replaceAll("http://localhost:8080", "");
                response.sendRedirect(url);
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
        processRequest(request, response);

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
