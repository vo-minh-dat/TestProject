<%-- 
    Document   : book_list
    Created on : Nov 2, 2022, 8:54:53 PM
    Author     : PhucPhan
--%>

<%@page import="com.daos.UserDAO"%>
<%@page import="com.daos.BorrowDAO"%>
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

    UserDAO uDAO = new UserDAO();
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

            .blog {
                font-size: 14px;
                font-weight: bold;
                text-align: center;
                position: absolute;
                bottom: 15px;
                left: 50%;
                transform: translateX(-50%);
                z-index: 1;
            }

            /* container */
            .container {
                width: 300px;
                height: auto;
                border-radius: 10px;
                background-color: white;
                box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                z-index: 1;
                overflow: hidden;
            }

            /* leaderboard */
            .leaderboard {
                background: linear-gradient(to bottom, #3a404d, #181c26);
            }

            /* head */
            .leaderboard .head {
                padding: 20px 16px;
                color: snow;
                font-size: 20px;
                text-align: center;
            }
            .leaderboard .head h1 {
                display: inline-block;
                margin-left: 4px;
            }

            /* body */
            .leaderboard .body {
                color: snow;
                font-size: 16px;
            }
            .leaderboard ol {
                counter-reset: number; /* 定義和初始化計數器 */
            }
            .leaderboard li {
                padding: 16px;
                display: flex;
            }
            .leaderboard li mark {
                flex-grow: 1;
                color: snow;
                background-color: transparent;
            }
            .leaderboard li:before {
                counter-increment: number; /* 遞增計數器 */
                content: counter(number) "."; /* 顯示計數器 */
                margin-right: 4px;
            }
            .leaderboard li:nth-child(1) {
                background: #fa6855;
            }
            .leaderboard li:nth-child(2) {
                background: #e0574f;
            }
            .leaderboard li:nth-child(3) {
                background: #d7514d;
            }
            .leaderboard li:nth-child(4) {
                background: #cd4b4b;
            }
            .leaderboard li:nth-child(5) {
                background: #c24448;
            }

        </style>

    </head>
    <body>
        <%@include file="/includes/header.jsp"%>
        <main> 
            <div class="container">
                <div class="leaderboard">
                    <div class="head">
                        <i class="fas fa-crown"></i>
                        <h3>Most active users</h3>
                    </div>
                    <div class="body">
                        <ol>
                            <%                                BorrowDAO brd = new BorrowDAO();
                                ResultSet rs = brd.getMostActiveUser();
                                while (rs.next()) {
                            %>
                            <li>
                                <mark>
                                    <%= uDAO.getUserByRollnumber(rs.getString("roll_number")).getFirst_name()%> 
                                    <%= uDAO.getUserByRollnumber(rs.getString("roll_number")).getLast_name()%> -
                                    <%= rs.getString("roll_number")%>
                                </mark>
                                <small>                                   
                                    <%= rs.getString("count")%> books
                                </small>
                            </li>
                            <%
                                }
                            %>


                        </ol>
                    </div>
                </div>
            </div>
        </main>

        <%@include file="includes/footer.jsp" %>

    </body>
</html>
