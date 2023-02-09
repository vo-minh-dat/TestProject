/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.daos.BookDAO;
import com.models.Book;
import static com.utils.Utils.getImagesFolderPath;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Date;

/**
 *
 * @author PhucPhan
 */
@MultipartConfig
public class AdminBookController extends HttpServlet {

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
            out.println("<title>Servlet AdminBookController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminBookController at " + request.getContextPath() + "</h1>");
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

        if (path.endsWith("/admin/book")) {
            request.getRequestDispatcher("/admin_pages/admin_book.jsp").forward(request, response);
        } else {
            if (path.endsWith("/admin/book/insert")) {
                request.getRequestDispatcher("/admin_pages/admin_book_insert.jsp").forward(request, response);
            } else {
                if (path.startsWith("/admin/book/update")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    BookDAO dao = new BookDAO();
                    Book book = dao.getBookByID(id);
                    if (book == null) {
                        response.sendRedirect("/admin/book");
                    } else {
//                        HttpSession session = request.getSession();
//                        session.setAttribute("book", book);
                        request.getRequestDispatcher("/admin_pages/admin_book_update.jsp").forward(request, response);
                    }
                } else {
                    if (path.startsWith("/admin/book/delete")) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        BookDAO dao = new BookDAO();
                        dao.delete(id);
                        response.sendRedirect("/admin/book");
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

//            Part file = request.getPart("image");
//            String fileName = file.getSubmittedFileName();
            String urlImage = request.getParameter("image_url");
//            String uploadPath = getImagesFolderPath() + fileName;
//
//            try {
//                FileOutputStream fos = new FileOutputStream(uploadPath);
//                InputStream is = file.getInputStream();
//
//                byte[] data = new byte[is.available()];
//                is.read(data);
//                fos.write(data);
//                fos.close();
//
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
            Integer id = null;
            try {
                id = Integer.parseInt(request.getParameter("bookID"));
            } catch (Exception e) {
                response.sendRedirect("/admin/book/insert?error=wrong_id");
            }
            BookDAO dao = new BookDAO();
            Book checkBook = dao.getBookByID(id);
            if (checkBook != null) {
                response.sendRedirect("/admin/book/insert?error=id_exist");
                return;
            }

            String title = request.getParameter("title");
            String author = request.getParameter("author");

            String publisher = request.getParameter("publisher");

            String published_date = request.getParameter("publishedDate");
            String edition = request.getParameter("title");
            int quantity = Integer.parseInt(request.getParameter("quantity"));;
            String description = request.getParameter("description");

            Book book = new Book(id,
                    title,
                    author,
                    urlImage,
                    publisher,
                    Date.valueOf(published_date),
                    edition,
                    quantity,
                    description,
                    null
            );
            int count = dao.addNew(book);
            if (count > 0) {
                response.sendRedirect("/admin/book?message=add_success");
            } else {
                response.sendRedirect("/admin/book/insert?error=add_error");
            }
        }

        if (request.getParameter("btnUpdate") != null) {

//            Part file = request.getPart("image");
//            String fileName = file.getSubmittedFileName();

//            String uploadPath = getImagesFolderPath() + fileName;
            String urlImage = request.getParameter("image_url");

//            try {
//                FileOutputStream fos = new FileOutputStream(uploadPath);
//                InputStream is = file.getInputStream();
//
//                byte[] data = new byte[is.available()];
//                is.read(data);
//                fos.write(data);
//                fos.close();
//
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
            Integer id = null;
            try {
                id = Integer.parseInt(request.getParameter("bookID"));
            } catch (Exception e) {
                response.sendRedirect("/admin/book/update?id=" + id + "&error=wrong_id");
            }

            String title = request.getParameter("title");
            String author = request.getParameter("author");

            String publisher = request.getParameter("publisher");

            String published_date = request.getParameter("publishedDate");
            String edition = request.getParameter("title");
            int quantity = Integer.parseInt(request.getParameter("quantity"));;
            String description = request.getParameter("description");

            Book book = new Book(id,
                    title,
                    author,
                    urlImage,
                    publisher,
                    Date.valueOf(published_date),
                    edition,
                    quantity,
                    description,
                    ""
            );
            BookDAO dao = new BookDAO();
            int count = dao.update(book);
            if (count > 0) {
                response.sendRedirect("/admin/book?message=update_success");
            } else {
                response.sendRedirect("/admin/book/update?id=" + id + "&error=add_error");
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
