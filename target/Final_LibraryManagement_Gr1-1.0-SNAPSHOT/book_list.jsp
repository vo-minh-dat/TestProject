<%-- 
    Document   : book_list
    Created on : Nov 2, 2022, 8:54:53 PM
    Author     : PhucPhan
--%>

<%@page import="com.models.Borrow"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.models.Category"%>
<%@page import="com.models.Book"%>
<%@page import="java.util.List"%>
<%@page import="com.daos.CategoryDAO"%>
<%@page import="com.daos.BookDAO"%>
<%@page import="com.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) request.getSession().getAttribute("user");

    BookDAO bd = new BookDAO();
    List<Book> books = bd.getAllBook();

    CategoryDAO cd = new CategoryDAO();
    List<Category> categories = cd.getAllCategory();

    ArrayList<Borrow> book_list = (ArrayList<Borrow>) session.getAttribute("book-list");
    if (book_list != null) {
        request.setAttribute("book_list", book_list);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book List</title>

        <%@include file="includes/head.jsp" %>
        <%@include file="includes/borrow_datepicker_head.jsp" %>

        <style>
            .book_container {
                display: flex;
                flex-direction: column;
                padding: 20px;
                align-items: center;
                justify-content: center;
            }
            .bl_item {
                width: 90%;
                border-radius: 4px;
                overflow: hidden;
                box-shadow: 0 30px 80px 10px rgba(0, 0, 0, 0.2);

                display: flex;
                align-items: strtech;

                margin-bottom: 20px;
            }

            .book_image {
                flex: 0 0 20%;
                background-color: white;
            }

            .book__img {
                max-width: 90%;
                max-height: 300px;
                display: block;
            }

            .book__content {
                flex: 1;
                background: white;
                padding: 35px 30px;

                display: flex;
                flex-direction: column;
            }


            .book__title {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .book_author {
                font-size: 15px;
            }
            .book__heading {
                font-size: 20px;
                margin-right: auto;
            }

            .book__borrow {

                background: white;
            }
            .book__price {
                flex: 0 0 50px;
                background: linear-gradient(to bottom, #67b26f, #4ca2cd);
                writing-mode: vertical-rl;
                color: white;
                font-size: 18px;
                user-select:none;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .book__price a {
                display:block;
                height: 100%;
                text-align: center;
                color: white;
            }

            .book__price:hover{
                cursor: pointer;
            }
            .book__tag {
                font-size: 10px;
                text-transform: uppercase;
                color: white;
                padding: 2px 7px;
                border-radius: 100px;
                margin-left: 7px;
            }

            .book__tag--1 {
                background-color: #67b26f;
            }

            .book__tag--2 {
                background-color: #4ca2cd;
            }

            .book__description {
                font-size: 14px;
            }

            .book__details {
                display: flex;
                margin-top: auto;
            }

            .book__detail {
                font-size: 15px;
                text-transform: uppercase;
                margin-right: 20px;
                font-weight: 700;

                display: flex;
                align-items: center;
            }

            .emoji {
                font-size: 20px;
                margin-right: 3px;
            }

            .button-container {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: row;
                margin-bottom: 20px;

            }
            .button_all {
                margin: 0 15px;
                padding: 15px 0;
                min-width: 150px;
                border-radius: 30px;
                border: none;
                transition: all 0.3s linear;
                cursor: pointer;
                text-transform: uppercase;
                font-weight: 700;
                letter-spacing: 0.2em;
            }
            .button--accept {
                background-color: #9cd859;
            }
            .button--accept:hover {
                background-color: #77b82c;
            }
            .button--cancel {
                background-color: #ef825f;
            }
            .button--cancel:hover {
                background-color: #eb5e30;
            }

            main {
                flex-grow: 1;
                display: flex;
                align-items: center;
                justify-content: center;
            }

        </style>

    </head>
    <body>
        <%@include file="/includes/header.jsp"%>
        <main> 
            <%                if (book_list == null || book_list.size() == 0) {
            %>    
            <h1> There are no book in the list</h1>
            <%
            } else {
            %>

            <form class="book_container" action= "/borrow-all" method="POST">

                <div class="button-container">
                    <button type="submit" class="button_all button--accept">Borrow</button>
                    <a href="/clear-booklist">
                        <button type="button" class="button_all button--cancel">Clear</button>
                    </a>
                </div>
                <%            for (Borrow borrow : book_list) {
                        Book book = bd.getBookByID(borrow.getBook_id());
                %>
                <figure class="bl_item">
                    <div class="book_image">
                        <img src=<%= book.getImg_path()%> alt="Pizza" class="book__img">
                    </div>

                    <div class="book__content">
                        <div class="book__title">
                            <h1 class="book__heading"> <%= book.getTitle()%>
                                <span class="book_author"> -- <%= book.getAuthor()%></span></h1>

                            <div class="book__tag book__tag--1">#vegetarian</div>
                            <div class="book__tag book__tag--2">#italian</div>
                        </div>
                        <p class="book__description">
                            <%= book.getDescription() == null ? "" : book.getDescription()%>
                        </p>
                        <div class="book__details">
                            <p class="book__detail"><span class="emoji">✍</span><%= book.getPublisher()%></p>
                            <p class="book__detail"><span class="emoji">⏱</span><%= book.getPublished_date()%></p>
                            <p class="book__detail"><span class="emoji">✅</span><%= book.getEdition()%></p>

                        </div>

                    </div>

                    <div class="book__borrow">

                        <div class="header-booking"  role="form" aria-label="Make a Reservation">
                            <div class="booking" name="booking" method="POST" target="_blank" action="/borrow-submit?book_id=<%= book.getId()%>">
                                <h5>Borrow date:</h5>
                                <div class="booking-input date">
                                    <input type="date" class="arrival" name="borrowDate<%= book.getId()%>" aria-label="Arrival Date">
                                    <i class="fa-regular fa-calendar-days"></i>
                                </div>
                                <h5>Return date:</h5>
                                <div class="booking-input date">

                                    <input type="date" class="departure" name="returnDate<%= book.getId()%>" aria-label="Departure Date">
                                    <i class="fa-regular fa-calendar-days"></i>
                                </div>

                                <input type="hidden" name="checkInDate" value="">
                                <input type="hidden" name="checkOutDate" value="">
                                <input type="hidden" name="checkInMonthYear" value="">
                                <input type="hidden" name="checkOutMonthYear" value="">
                                <input type="hidden" name="path" value="rates">
                                <input type="hidden" name="brandCode" value="hi">
                                <input type="hidden" name="numberOfAdults" value="1">
                                <input type="hidden" name="numberOfChildren" value="0">
                                <input type="hidden" name="numberOfRooms" value="1">
                                <input type="hidden" name="rateCode" value="6CBARC">
                                <input type="hidden" name="hotelCode" value="dislb">
                                <input type="hidden" name="_PMID" value="99502222">
                                <div class="booking-input">
                                    <a class="borrow-submit"></a>
                                </div>
                                </a>
                            </div>
                        </div>


                    </div>
                    <div class="book__price">
                        <a href="/delete-from-list?id=<%= book.getId()%>">Delete</a>
                    </div>
                </figure>
                <%
                    }

                %>
                </div>
                <%                    }
                %>

        </main>
        <%@include file="includes/borrow_datepicker_script.jsp" %>

        <%@include file="includes/footer.jsp" %>

    </body>
</html>
