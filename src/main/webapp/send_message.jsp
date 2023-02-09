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
           

            body {
                background-color: #4d4d4d;
              
            }

            form {
                padding-left:25px;
                padding-right:25px;
                padding-top:60px;
                margin: 12px auto;
                border-radius: 20px;
                position:relative;
                z-index:1;
            }

            form > div{
                position:absolute;
                top:0;
                left:50%;
                padding:0 20px;
                transform:translate(-50%,-50%);
                background-color:black;
                border-radius: 20px;
                text-align:center;
            }

            form > div > img{
                filter:invert(1);
                width:100px;
            }

            form > input,
            form > textarea {
                padding: 12px;
                margin: 12px auto;
                color: #ddd;
                background-color: #222;
                border-radius: 4px;
                display: block;
                width: 70vw;
            }

            form > textarea{
                height:100px;
                resize:none;
            }

            form > input[type="submit"] {
                max-width: 20vw;
                padding-left: 1%;
                padding-right: 1%;
                cursor: pointer;
                transition: 0.35s;
            }

            form > input[type="submit"]:hover {
                background-color: #555;
            }

        </style>

    </head>
    <body>
        <%@include file="/includes/header.jsp"%>
        <main> 
            <form action="/send_message" method="post">
                <div>
                    <img src="https://cdn4.iconfinder.com/data/icons/basic-user-interface-elements/700/mail-letter-offer-256.png" alt="icon">
                </div>
                <input name="rollnumber" type="hidden" value=<%= user.getRoll_number() %>>
                <input name="subject" type="text" placeholder="Subject (required)" required>
                <textarea name="message" placeholder="Message (required)" required></textarea>
                <input type="submit" value="Send">
            </form>
        </main>

        <%@include file="includes/footer.jsp" %>

    </body>
</html>
