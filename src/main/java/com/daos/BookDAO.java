/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
import com.models.Book;
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
public class BookDAO {

    private Connection conn = null;

    public BookDAO() {
        conn = DBConnection.getConnection();
    }

    public List<Book> getBookByCurrciculum(String code) {
        List<Book> books = new ArrayList<Book>();
        ResultSet rs = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("select Book.id, Book.title, Book.author, Book.img_path, Book.publisher, Book.published_date, Book.edition, Book.quantity, Book.[description], Book.server_img from Curriculum, Subject_Curriculum, [Subject],Book_Subject,[Book]\n"
                    + "where Curriculum.code = Subject_Curriculum.curriculum_code\n"
                    + "and Subject_Curriculum.subject_code = [Subject].code\n"
                    + "and [Subject].code = Book_Subject.subject_code\n"
                    + "and Book_Subject.book_id = Book.id\n"
                    + "and Curriculum.code= ?");
            pst.setString(1, code);
            rs = pst.executeQuery();
            while (rs.next()) {
                Book book = new Book(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("img_path"),
                        rs.getString("publisher"),
                        rs.getDate("published_date"),
                        rs.getString("edition"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("server_img")
                );
                books.add(book);

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return books;
    }

    public List<Book> getRecommendedBook(String rollnumber) {
        List<Book> books = new ArrayList<Book>();
        ResultSet rs = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("Select Book.id, Book.title, Book.author, Book.img_path, Book.publisher, Book.published_date, Book.edition, Book.quantity, Book.[description], Book.server_img from [User], Class, [Subject], Book_Subject, Book\n"
                    + "where [User].main_class = Class.[name]\n"
                    + "and Class.semester = [Subject].semester\n"
                    + "and [Subject].code = Book_Subject.subject_code\n"
                    + "and Book_Subject.book_id = book.id\n"
                    + "and [User].roll_number = 'CE171166'");
//            pst.setString(1, rollnumber);
            rs = pst.executeQuery();
            while (rs.next()) {
                Book book = new Book(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("img_path"),
                        rs.getString("publisher"),
                        rs.getDate("published_date"),
                        rs.getString("edition"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("server_img")
                );
                books.add(book);

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return books;
    }

    public List<Book> getBookByCategory(int category) {
        List<Book> books = new ArrayList<Book>();
        ResultSet rs = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("select * from Book \n"
                    + "join Category_Book\n"
                    + "on Book.id = Category_Book.book_id\n"
                    + "join Category \n"
                    + "on Category.id = Category_Book.category_id\n"
                    + "where Category.id = ?");
            pst.setInt(1, category);
            rs = pst.executeQuery();
            while (rs.next()) {
                Book book = new Book(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("img_path"),
                        rs.getString("publisher"),
                        rs.getDate("published_date"),
                        rs.getString("edition"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("server_img")
                );
                books.add(book);

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return books;
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("Select * from Book");
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public List<Book> getAllBook() {
        List<Book> books = new ArrayList<Book>();
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("Select * from Book");
            while (rs.next()) {
                Book book = new Book(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("img_path"),
                        rs.getString("publisher"),
                        rs.getDate("published_date"),
                        rs.getString("edition"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("server_img")
                );
                books.add(book);

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return books;
    }

    public List<Book> getMostReadBook() {
        List<Book> books = new ArrayList<Book>();
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("WITH TB AS (select count(book_id) as [Count], book_id  from borrow\n"
                    + "group by book_id\n"
                    + ")\n"
                    + "Select * from TB \n"
                    + "join Book on TB.book_id = Book.id\n"
                    + "order by [Count] desc");
            while (rs.next()) {
                Book book = new Book(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("img_path"),
                        rs.getString("publisher"),
                        rs.getDate("published_date"),
                        rs.getString("edition"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("server_img")
                );
                books.add(book);

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return books;
    }

    public List<Book> getMostReviewBook() {
        List<Book> books = new ArrayList<Book>();
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("WITH TB AS (select count(book_id) as [Count], book_id  from review\n"
                    + "group by book_id\n"
                    + ")\n"
                    + "Select * from TB \n"
                    + "join Book on TB.book_id = Book.id\n"
                    + "order by [Count] desc");
            while (rs.next()) {
                Book book = new Book(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("img_path"),
                        rs.getString("publisher"),
                        rs.getDate("published_date"),
                        rs.getString("edition"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("server_img")
                );
                books.add(book);

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return books;
    }

    public List<Book> search(String searchContent) {
        List<Book> books = new ArrayList<Book>();
        PreparedStatement pst;

        ResultSet rs = null;
        try {
            pst = conn.prepareStatement("select * from [Book]\n"
                    + "where title LIKE '%" + searchContent + "%'\n"
                    + "or author LIKE '%" + searchContent + "%'\n"
                    + "or publisher LIKE '%" + searchContent + "%'\n"
                    + "or edition LIKE '%" + searchContent + "%'\n"
                    + "or [description] LIKE '%" + searchContent + "%'");

            rs = pst.executeQuery();
            while (rs.next()) {
                Book book = new Book(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("img_path"),
                        rs.getString("publisher"),
                        rs.getDate("published_date"),
                        rs.getString("edition"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("server_img")
                );
                books.add(book);

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return books;
    }

    public Book getBookByID(int id) {
        Book book = null;
        PreparedStatement pst;

        try {
            pst = conn.prepareStatement("Select * from [Book] where id=?");
            pst.setString(1, id + "");

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                book = new Book(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("img_path"),
                        rs.getString("publisher"),
                        rs.getDate("published_date"),
                        rs.getString("edition"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("server_img")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return book;
    }

    public int addNew(Book book) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into Book values(?,?,?, ?, ?,?,?,?,?,?)");
            pst.setInt(1, book.getId());
            pst.setString(2, book.getTitle());
            pst.setString(3, book.getAuthor());
            pst.setString(4, book.getImg_path());
            pst.setString(5, book.getPublisher());
            pst.setDate(6, book.getPublished_date());
            pst.setString(7, book.getEdition());
            pst.setInt(8, book.getQuantity());
            pst.setString(9, book.getDescription());
            pst.setString(10, book.getServer_img());

            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int update(Book book) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("update Book set title=?,author=?, img_path=?, publisher=?,published_date=?,edition=?,quantity=?,description=?,server_img=? Where id=?");
            pst.setString(1, book.getTitle());
            pst.setString(2, book.getAuthor());
            pst.setString(3, book.getImg_path());
            pst.setString(4, book.getPublisher());
            pst.setDate(5, book.getPublished_date());
            pst.setString(6, book.getEdition());
            pst.setInt(7, book.getQuantity());
            pst.setString(8, book.getDescription());
            pst.setString(9, book.getServer_img());
            pst.setInt(10, book.getId());

            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int delete(int id) {

        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from book where id=?");
            pst.setInt(1, id);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

}
