<%-- 
    Document   : book_list
    Created on : Nov 2, 2022, 8:54:53 PM
    Author     : PhucPhan
--%>

<%@page import="java.sql.ResultSet"%>
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

            }
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0px;
                font-family: 'segoe ui';
            }

            .nav {
                height: 50px;
                width: 100%;
                background-color: #4d4d4d;
                position: relative;
            }

            .nav > .nav-header {
                display: inline;
            }

            .nav > .nav-header > .nav-title {
                display: inline-block;
                font-size: 22px;
                color: #fff;
                padding: 10px 10px 10px 10px;
            }

            .nav > .nav-btn {
                display: none;
            }

            .nav > .nav-links {
                display: inline;
                float: right;
                font-size: 18px;
            }

            .nav > .nav-links > a {
                display: inline-block;
                padding: 13px 10px 13px 10px;
                text-decoration: none;
                color: #efefef;
            }

            .nav > .nav-links > a:hover {
                background-color: rgba(0, 0, 0, 0.3);
            }

            .nav > #nav-check {
                display: none;
            }

            @media (max-width:600px) {
                .nav > .nav-btn {
                    display: inline-block;
                    position: absolute;
                    right: 0px;
                    top: 0px;
                }
                .nav > .nav-btn > label {
                    display: inline-block;
                    width: 50px;
                    height: 50px;
                    padding: 13px;
                }
                .nav > .nav-btn > label:hover,.nav  #nav-check:checked ~ .nav-btn > label {
                    background-color: rgba(0, 0, 0, 0.3);
                }
                .nav > .nav-btn > label > span {
                    display: block;
                    width: 25px;
                    height: 10px;
                    border-top: 2px solid #eee;
                }
                .nav > .nav-links {
                    position: absolute;
                    display: block;
                    width: 100%;
                    background-color: #333;
                    height: 0px;
                    transition: all 0.3s ease-in;
                    overflow-y: hidden;
                    top: 50px;
                    left: 0px;
                }
                .nav > .nav-links > a {
                    display: block;
                    width: 100%;
                }
                .nav > #nav-check:not(:checked) ~ .nav-links {
                    height: 0px;
                }
                .nav > #nav-check:checked ~ .nav-links {
                    height: calc(100vh - 50px);
                    overflow-y: auto;
                }
            }
            :root {
                --primary-color: white;
                --secondary-color: rgb(61, 68, 73);
                --highlight-color: #3282b8;

                --dt-status-available-color: greenyellow;
                --dt-status-away-color: lightsalmon;
                --dt-status-offline-color: lightgray;

                --dt-padding: 12px;
                --dt-padding-s: 6px;
                --dt-padding-xs: 2px;

                --dt-border-radius: 3px;

                --dt-background-color-container: #2a3338;
                --dt-border-color: var(--secondary-color);
                --dt-bg-color: var(--highlight-color);
                --dt-text-color: var(--primary-color);
                --dt-bg-active-button: var(--highlight-color);
                --dt-text-color-button: var(--primary-color);
                --dt-text-color-active-button: var(--primary-color);
                --dt-hover-cell-color: var(--highlight-color);
                --dt-even-row-color: var(--secondary-color);
                --dt-focus-color: var(--highlight-color);
                --dt-input-background-color: var(--secondary-color);
                --dt-input-color: var(--primary-color);
            }

            .material-icons {
                font-size: 16px;
            }

            .datatable-container {
                font-family: sans-serif;
                background-color: var(--dt-background-color-container);
                border-radius: var(--dt-border-radius);
                color: var(--dt-text-color);
                max-width: 1140px;
                min-width: 950px;
                margin: 0 auto;
                font-size: 12px;
            }

            .datatable-container .header-tools {
                border-bottom: solid 1px var(--dt-border-color);
                padding: var(--dt-padding);
                padding-left: 0;
                display: flex;
                align-items: baseline;
            }

            .datatable-container .header-tools .search {
                width: 30%;
            }

            .datatable-container .header-tools .search .search-input {
                width: 100%;
                height: calc(1.5em + 0.75rem + 2px);
                padding: 0.375rem 0.75rem;
                background-color: var(--dt-input-background-color);
                display: block;
                box-sizing: border-box;
                border-radius: var(--dt-border-radius);
                border: solid 1px var(--dt-border-color);
                color: var(--dt-input-color);
            }

            .datatable-container .header-tools .tools {
                width: 70%;
            }

            .datatable-container .header-tools .tools ul {
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: start;
                align-items: baseline;
            }

            .datatable-container .header-tools .tools ul li {
                display: inline-block;
                margin: 0 var(--dt-padding-xs);
                align-items: baseline;
            }

            .datatable-container .footer-tools {
                padding: var(--dt-padding);
                display: flex;
                align-items: baseline;
            }

            .datatable-container .footer-tools .list-items {
                width: 50%;
            }

            .datatable-container .footer-tools .pages {
                margin-left: auto;
                margin-right: 0;
                width: 50%;
            }

            .datatable-container .footer-tools .pages ul {
                margin: 0;
                padding: 0;
                display: flex;
                align-items: baseline;
                justify-content: flex-end;
            }

            .datatable-container .footer-tools .pages ul li {
                display: inline-block;
                margin: 0 var(--dt-padding-xs);
            }

            .datatable-container .footer-tools .pages ul li button,
            .datatable-container .header-tools .tools ul li button {
                color: var(--dt-text-color-button);
                width: 100%;
                box-sizing: border-box;
                border: 0;
                border-radius: var(--dt-border-radius);
                background: transparent;
                cursor: pointer;
            }

            .datatable-container .footer-tools .pages ul li button:hover,
            .datatable-container .header-tools .tools ul li button:hover {
                background: var(--dt-bg-active-button);
                color: var(--dt-text-color-active-button);
            }

            .datatable-container .footer-tools .pages ul li span.active {
                background-color: var(--dt-bg-color);
                border-radius: var(--dt-border-radius);
            }

            .datatable-container .footer-tools .pages ul li button,
            .datatable-container .footer-tools .pages ul li span,
            .datatable-container .header-tools .tools ul li button {
                padding: var(--dt-padding-s) var(--dt-padding);
            }

            .datatable-container .datatable {
                border-collapse: collapse;
                width: 100%;
            }

            .datatable-container .datatable,
            .datatable-container .datatable th,
            .datatable-container .datatable td {
                padding: var(--dt-padding) var(--dt-padding);
            }

            .datatable-container .datatable th {
                font-weight: bolder;
                text-align: left;
                border-bottom: solid 1px var(--dt-border-color);
            }

            .datatable-container .datatable td {
                border-bottom: solid 1px var(--dt-border-color);
            }

            .datatable-container .datatable tbody tr:nth-child(even) {
                background-color: var(--dt-even-row-color);
            }

            .datatable-container .datatable tbody tr:hover {
                background-color: var(--dt-hover-cell-color);
            }

            .datatable-container .datatable tbody tr .available::after,
            .datatable-container .datatable tbody tr .away::after,
            .datatable-container .datatable tbody tr .offline::after {
                display: inline-block;
                vertical-align: middle;
            }

            .datatable-container .datatable tbody tr .available::after {
                content: "Online";
                color: var(--dt-status-available-color);
            }

            .datatable-container .datatable tbody tr .away::after {
                content: "Away";
                color: var(--dt-status-away-color);
            }

            .datatable-container .datatable tbody tr .offline::after {
                content: "Offline";
                color: var(--dt-status-offline-color);
            }

            .datatable-container .datatable tbody tr .available::before,
            .datatable-container .datatable tbody tr .away::before,
            .datatable-container .datatable tbody tr .offline::before {
                content: "";
                display: inline-block;
                width: 10px;
                height: 10px;
                margin-right: 10px;
                border-radius: 50%;
                vertical-align: middle;
            }

            .datatable-container .datatable tbody tr .available::before {
                background-color: var(--dt-status-available-color);
            }

            .datatable-container .datatable tbody tr .away::before {
                background-color: var(--dt-status-away-color);
            }

            .datatable-container .datatable tbody tr .offline::before {
                background-color: var(--dt-status-offline-color);
            }

            main {
                background-color: #4d4d4d;

            }
        </style>

    </head>
    <body>
        <%@include file="/includes/header.jsp"%>
        <main> 
            <div class="nav">
                <input type="checkbox" id="nav-check">
                <div class="nav-header">
                    <div class="nav-title">
                    </div>
                </div>
                <div class="nav-btn">
                    <label for="nav-check">
                        <span></span>
                        <span></span>
                        <span></span>
                    </label>
                </div>

                <div class="nav-links">
                    <a href="/borrow-history/request" >Request</a>
                    <a href="/borrow-history/borrowing" >Borrowing</a>
                    <a href="/borrow-history/returned" >Returned</a>
                    <a href="/borrow-history/overdue" >Overdue</a>

                </div>
            </div>
        </nav>
        <div class="datatable-container">
            <!-- ======= Header tools ======= -->


            <!-- ======= Table ======= -->
            <table class="datatable">
                <thead>
                    <tr>

                        <th>ID</th>
                        <th>Book ID</th>
                        <th>Book Title</th>
                        <th>Borrow Date</th>
                        <th>Return Date</th>
                    </tr>
                </thead>

                <tbody>
                    <%                        //get all user accounts from database for display fullname to display on table
                        BorrowDAO dao = new BorrowDAO();
                        ResultSet rs = dao.getOverdue();
                        while (rs.next()) {


                    %>
                    <tr>
                        <td><%= rs.getInt("id")%></td>
                        <td><%= rs.getInt("book_id")%></td>
                        <td><%= bd.getBookByID(rs.getInt("book_id")).getTitle()%></td>
                        <td><%= rs.getDate("borrow_date")%></td>
                        <td><%= rs.getDate("return_date")%></td>

                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <!-- ======= Footer tools ======= -->
            <div class="footer-tools">
                <div class="list-items">
                    Show
                    <select name="n-entries" id="n-entries" class="n-entries">
                        <option value="5">5</option>
                        <option value="10" selected>10</option>
                        <option value="15">15</option>
                    </select>
                    entries
                </div>

                <div class="pages">
                    <ul>
                        <li><span class="active">1</span></li>

                    </ul>
                </div>
            </div>
        </div>


    </main>
    <%@include file="includes/borrow_datepicker_script.jsp" %>

    <%@include file="includes/footer.jsp" %>

</body>
</html>
