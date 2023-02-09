<%-- 
    Document   : index.jsp
    Created on : Nov 1, 2022, 12:39:22 AM
    Author     : PhucPhan
--%>

<%@page import="com.models.Curriculum"%>
<%@page import="com.daos.CurriculumDAO"%>
<%@page import="com.models.Borrow"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.models.User"%>
<%@page import="com.models.Category"%>
<%@page import="com.daos.CategoryDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.models.Book"%>
<%@page import="com.daos.BookDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) request.getSession().getAttribute("user");

    BookDAO bd = new BookDAO();
    List<Book> books = bd.getBookByCategory(1);
    books.addAll(bd.getBookByCategory(2));

    ArrayList<Borrow> book_list = (ArrayList<Borrow>) session.getAttribute("book-list");
    if (book_list != null) {
        request.setAttribute("book_list", book_list);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Home Page</title>
        <%@include file="includes/head.jsp" %>
        <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>
        <style>
            body {
                overflow-x: hidden;
            }
            .button_add {
                display:block;
                position: relative;
                bottom: 0px;
                left: 0px;
                width:30px;
                height:30px;
                background:#148F77;
                margin: auto;
                margin-top: 30px;
                border-radius: 15px;
                transition-duration: 1s;
                z-index: 2;

            }

            .button_add:hover {
                cursor: pointer;
            }

            .cross_add {
                width: 18px;
                margin:auto;
                margin-top:0px;
                height:18px;
                background: linear-gradient(to bottom, transparent 40%,
                    white 40%,
                    white 60%,
                    transparent 60%),

                    linear-gradient(to right, transparent 40%,
                    white 40%,
                    white 60%,
                    transparent 60%);

                position: relative;
                top: 50%;
                transform: translateY(-50%);


            }

            aside {
                flex-basis: 380px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100%;
                background-color: rgba(0, 0, 0, .2);
                color: #fff;
                line-height: 1.5;
            }
            aside .title, aside .subtitle, aside .description {
                font-family: Georgia, Serif;
                font-style: italic;
                text-shadow: 1px 1px 5px rgba(0, 0, 0, .5);
            }
            aside .title {
                font-weight: bold;
                font-size: 2em;
            }
            aside .subtitle {
                font-size: 1.5em;
            }
            aside .description {
                margin-top: 24px;
                font-size: 1.2em;
            }
            main {
                /*                flex-grow: 1;
                                display: flex;
                                align-items: center;
                                justify-content: center;*/
            }
            .book-card {
                width: 200px;
                padding: 16px;
                border-radius: 5px;
                background-color: #fff;
                box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23);
            }
            .book-card .book-card__cover {
                position: relative;
                width: 168px;
                height: 270px;
                margin: 0 auto 8px auto;
                perspective: 1000px;
            }
            .book-card .book-card__book {
                width: 168px;

                height: 100%;
                transform-style: preserve-3d;
                transition: all 250ms ease;
            }
            .book-card .book-card__book-front {
                position: absolute;
                height: 100%;
                width: 168px;
            }
            .book-card .book-card__book-back {
                position: absolute;
                top: 0;
                height: 100%;
                width: 168px;
                transform: translateZ(-40px);
            }
            .book-card .book-card__book-side {
                position: absolute;
                top: 5px;
                bottom: 2px;
                right: -29px;
                width: 40px;
                background-size: 5px;
                background-color: #e1e1e1;
                background-image: linear-gradient(to right, #ccc 35%, #e1e1e1 35%);
                opacity: 0;
                transform: rotate3d(0, 1, 0, 90deg);
            }
            .book-card .book-card__img {
                width: 168px;
                height: 100%;
                background-color: #e1e1e1;
            }
            .book-card .book-card__title {
                font-size: 1.5em;
                margin-bottom: 8px;
            }
            .book-card .book-card__author {
                color: #757575;
                font-size: 1em;
            }
            .book-card:hover .book-card__book {
                transform: rotate3d(0, -1, 0, 30deg) translate(-15px, -30px);
            }
            .book-card:hover .book-card__book-back {
                box-shadow: 5px 10px 15px rgba(0, 0, 0, 0.35);
            }
            .book-card:hover .book-card__book-side {
                opacity: 1;
            }

            .card_container {
                width: 100%;
                display: grid;
                grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr;
                padding: 20px;
                grid-gap: 20px;
            }

            .book-card {
                border-radius: 20px;
                box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;


            }

            @media screen and (max-width: 1358px) {
                .card_container {
                    grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
                }
            }
            @media screen and (max-width: 1145px) {
                .card_container {
                    grid-template-columns: 1fr 1fr 1fr 1fr;
                }
            }

            @media screen and (max-width: 925px) {
                .card_container {
                    grid-template-columns: 1fr 1fr 1fr ;
                }
            }

            @media screen and (max-width: 700px) {
                .card_container {
                    grid-template-columns: 1fr 1fr  ;
                }
            }

            body {
                background: #EAEDED;

            }

            main {

                padding-left: 20px;
                padding-right: 20px;

            }

            section {
                padding-top: 20px;
                background-color: white;

            }

            .toast{
                position: absolute;
                top: 70px;
                right: 30px;
                border-radius: 12px;
                background: #fff;
                padding: 20px 35px 20px 25px;
                box-shadow:  0 5px 10px rgba(0, 0, 0, 0.1) ;
                border-left: 6px solid #EF5350;
                overflow: hidden;
                transform: translateX(calc(100% + 30px));
                transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.35);
            }

            .toast.active{
                transform: translateX(0%);

            }



            .toast .toast-content{
                display: flex;
                align-items: center;
            }

            .toast-content .check{
                display: flex;
                align-items: center;
                justify-content: center;
                height: 35px;
                width: 35px;
                background-color: #EF5350;
                color: #fff;
                font-size: 20px;
                border-radius: 50%;
            }

            .toast-content .message{
                display: flex;
                flex-direction: column;
                margin:  0 20px;
            }

            .message .text{
                font-size: 20px;
                font-weight: 600;
                color: #666666;
            }

            .message .text.text-1{
                font-weight: 600;
                color: #333;

            }

            .toast .close{
                position: absolute;
                top: 10px;
                right: 20px;
                padding: 5px;
                cursor: pointer;
                opacity: 0.7;
                color: black;
                font-size: 15px;
            }

            .toast .close:hover{
                opacity: 1;
            }

            .toast .progress{
                position: absolute;
                bottom: 0;
                left: 0;
                height: 3px;
                width: 100%;
                background: #ddd;
            }

            .toast .progress::before{
                content: '';
                position: absolute;
                bottom: 0;
                right: 0;
                height: 100%;
                width: 100%;
                background-color: #EF5350;
            }

            .progress.active:before{
                animation: progress 5s linear forwards;
            }

            @keyframes progress {
                100%{
                    right: 100%;
                }

            }
        </style>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <script>
            <%
                // initialize content display
                String errorContent = "";

                // check if there is an error message from request
                if (request.getParameter("error") != null) {
                    // display error

                    String errorType = request.getParameter("error");
                    if (errorType.equals("waiting_for_approved")) {
                        errorContent = "This book is waiting for approved.";
                    } else if (errorType.equals("already_exist_in_the_list")) {
                        errorContent = "This book is already exist in your list.";
                    } else if (errorType.equals("already_borrow")) {
                        errorContent = "You already borrow this book.";
                    } else {
                        errorContent = "Opps... Something wrong happened :(((";
                    }
                }

            %>
        </script>
    </head>
    <body>
        <div class="toast">
            <div class="toast-content">
                <i class="fas fa-solid fa-times check"></i>

                <div class="message">
                    <span class="text text-1">Failed</span>
                    <span class="text text-2"><%= errorContent%></span>
                </div>
            </div>
            <i class="fa-solid fa-minus close"></i>

            <div class="progress"></div>
        </div>
        <%@include file="/includes/header.jsp"%>
        <%            String search = request.getParameter("search");
            if (search != null) {
                books = bd.search(search);
        %>
        <main>

            <section style="margin-top: 20px;">
                <h1 style="margin-left: 30px;">Search result</h1>
                <div class="card_container">
                    <%                for (Book book : books) {
                    %>
                    <div class="book-card">
                        <a href="/detail?id=<%= book.getId()%>"> 
                            <div class="book-card__cover">
                                <div class="book-card__book">
                                    <div class="book-card__book-front">
                                        <img class="book-card__img" src="<%= book.getServer_img() != null ? book.getServer_img() : book.getImg_path()%>" />
                                    </div>
                                    <div class="book-card__book-back">
                                    </div>
                                    <div class="book-card__book-side">
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="book-card__title">
                                    <%= book.getTitle()%>
                                </div>
                                <div class="book-card__author">
                                    <%= book.getAuthor()%>
                                </div>
                            </div>
                        </a>

                        <div>
                            <a href="add-to-list?book_id=<%=book.getId()%>" class="button_add">
                                <div class="cross_add">  
                                </div>
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </section>
        </main>
        <%
        } else {
        %>
        <main>
            
           
            <%
                if (user != null) {
            %>

            <section style="margin-top: 20px;">
                <h1 style="margin-left: 30px;">Recommended book for your semester</h1>
                <div class="card_container">

                    <%
                        List<Book> recommendeds = bd.getRecommendedBook(user.getRoll_number());

                        for (Book book : recommendeds) {
                    %>
                    <div class="book-card">
                        <a href="/detail?id=<%= book.getId()%>"> 
                            <div class="book-card__cover">
                                <div class="book-card__book">
                                    <div class="book-card__book-front">
                                        <img class="book-card__img" src="<%= book.getServer_img() != null ? book.getServer_img() : book.getImg_path()%>" />
                                    </div>
                                    <div class="book-card__book-back">
                                    </div>
                                    <div class="book-card__book-side">
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="book-card__title">
                                    <%= book.getTitle()%>
                                </div>
                                <div class="book-card__author">
                                    <%= book.getAuthor()%>
                                </div>
                            </div>
                        </a>

                        <div>
                            <a href="add-to-list?book_id=<%=book.getId()%>" class="button_add">
                                <div class="cross_add">  
                                </div>
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </section>

            <%
                }
            %>

             <section style="margin-top: 20px;">
                <h1 style="margin-left: 30px;">Most read books</h1>
                <div class="card_container">

                    <%
                        List<Book> mostRead = bd.getMostReadBook();
                        for (Book book : mostRead) {
                    %>
                    <div class="book-card">
                        <a href="/detail?id=<%= book.getId()%>"> 
                            <div class="book-card__cover">
                                <div class="book-card__book">
                                    <div class="book-card__book-front">
                                        <img class="book-card__img" src="<%= book.getServer_img() != null ? book.getServer_img() : book.getImg_path()%>" />
                                    </div>
                                    <div class="book-card__book-back">
                                    </div>
                                    <div class="book-card__book-side">
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="book-card__title">
                                    <%= book.getTitle()%>
                                </div>
                                <div class="book-card__author">
                                    <%= book.getAuthor()%>
                                </div>
                            </div>
                        </a>

                        <div>
                            <a href="add-to-list?book_id=<%=book.getId()%>" class="button_add">
                                <div class="cross_add">  
                                </div>
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </section>
                
                 <section style="margin-top: 20px;">
                <h1 style="margin-left: 30px;">Most review books</h1>
                <div class="card_container">

                    <%
                        List<Book> mostReview = bd.getMostReviewBook();
                        for (Book book : mostReview) {
                    %>
                    <div class="book-card">
                        <a href="/detail?id=<%= book.getId()%>"> 
                            <div class="book-card__cover">
                                <div class="book-card__book">
                                    <div class="book-card__book-front">
                                        <img class="book-card__img" src="<%= book.getServer_img() != null ? book.getServer_img() : book.getImg_path()%>" />
                                    </div>
                                    <div class="book-card__book-back">
                                    </div>
                                    <div class="book-card__book-side">
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="book-card__title">
                                    <%= book.getTitle()%>
                                </div>
                                <div class="book-card__author">
                                    <%= book.getAuthor()%>
                                </div>
                            </div>
                        </a>

                        <div>
                            <a href="add-to-list?book_id=<%=book.getId()%>" class="button_add">
                                <div class="cross_add">  
                                </div>
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </section>
        </main>

        <%
            }
        %>

        <%@include file="includes/footer.jsp" %>
        <script>

            $("#major").click(function () {
                var open = $(this).data("isopen");
                if (open) {
                    window.location.href = "/sign-up?major=" + $(this).val()
                }
                //set isopen to opposite so next time when use clicked select box
                //it wont trigger this event
                $(this).data("isopen", !open);
            });

            toast = document.querySelector(".toast");
            closeIcon = document.querySelector(".close");
            progress = document.querySelector(".progress");

            function showError() {
                toast.classList.add("active");
                progress.classList.add("active");

                setTimeout(() => {
                    toast.classList.remove("active");
                }, 5000); //1s = 1000 milliseconds

                setTimeout(() => {
                    toast.classList.remove("active");
                }, 5300);
            }
            closeIcon.addEventListener("click", () => {
                toast.classList.remove("active");

                setTimeout(() => {
                    toast.classList.remove("active");
                }, 300);
            });


        </script>

        <%            // check if there is an error message from request
            if (request.getParameter("error") != null) {
                // display error
        %>
        <script>
            showError(); //No need to put java script code inside scriptlet
        </script>
        <%
            }

        %>
    </body>
</html>
