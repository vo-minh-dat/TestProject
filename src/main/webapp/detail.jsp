<%-- 
    Document   : detail
    Created on : Nov 3, 2022, 1:06:46 AM
    Author     : PhucPhan
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="com.models.ReviewWithUsername"%>
<%@page import="com.models.Review"%>
<%@page import="com.daos.ReviewDAO"%>
<%@page import="com.models.Category"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.daos.CategoryDAO"%>
<%@page import="com.models.Book"%>
<%@page import="com.daos.BookDAO"%>
<%@page import="com.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) request.getSession().getAttribute("user");

    BookDAO bd = new BookDAO();
    List<Book> books = bd.getAllBook();

    CategoryDAO cd = new CategoryDAO();
    List<Category> categories = cd.getAllCategory();

    ArrayList<Book> book_list = (ArrayList<Book>) session.getAttribute("book-list");
    if (book_list != null) {
        request.setAttribute("book_list", book_list);
    }

    Book book = bd.getBookByID(Integer.parseInt(request.getParameter("id")));

    ReviewDAO rd = new ReviewDAO();
    List<ReviewWithUsername> reviews = null;
    reviews = rd.getBookReview(book.getId());

    DecimalFormat df = new DecimalFormat("#.#");
    float rating = 0;
    int n = reviews.size();
    for (int i = 0; i < n; i++) {
        rating += reviews.get(i).getVote_star();
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="includes/head.jsp" %>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->

        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
        <style>
            .pd-wrap {
                padding: 40px 0;
                font-family: 'Poppins', sans-serif;
            }
            .heading-section {
                text-align: center;
                margin-bottom: 20px;
            }
            .sub-heading {
                font-family: 'Poppins', sans-serif;
                font-size: 12px;
                display: block;
                font-weight: 600;
                color: #2e9ca1;
                text-transform: uppercase;
                letter-spacing: 2px;
            }
            .heading-section h2 {
                font-size: 32px;
                font-weight: 500;
                padding-top: 10px;
                padding-bottom: 15px;
                font-family: 'Poppins', sans-serif;
            }
            .user-img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                position: relative;
                min-width: 80px;
                background-size: 100%;
            }
            .carousel-testimonial .item {
                padding: 30px 10px;
            }
            .quote {
                position: absolute;
                top: -23px;
                color: #2e9da1;
                font-size: 27px;
            }
            .name {
                margin-bottom: 0;
                line-height: 14px;
                font-size: 17px;
                font-weight: 500;
            }
            .position {
                color: #adadad;
                font-size: 14px;
            }
            .owl-nav button {
                position: absolute;
                top: 50%;
                transform: translate(0, -50%);
                outline: none;
                height: 25px;
            }
            .owl-nav button svg {
                width: 25px;
                height: 25px;
            }
            .owl-nav button.owl-prev {
                left: 25px;
            }
            .owl-nav button.owl-next {
                right: 25px;
            }
            .owl-nav button span {
                font-size: 45px;
            }
            .product-thumb .item img {
                height: 100px;
            }
            .product-name {
                font-size: 22px;
                font-weight: 500;
                line-height: 22px;
                margin-bottom: 4px;
            }
            .product-price-discount {
                font-size: 22px;
                font-weight: 400;
                padding: 10px 0;
                clear: both;
            }
            .product-price-discount span.line-through {
                text-decoration: line-through;
                margin-left: 10px;
                font-size: 14px;
                vertical-align: middle;
                color: #a5a5a5;
            }
            .display-flex {
                display: flex;
            }
            .align-center {
                align-items: center;
            }
            .product-info {
                width: 100%;
            }
            .reviews-counter {
                font-size: 13px;
            }
            .reviews-counter span {
                vertical-align: -2px;
            }
            .rate {
                float: left;
                padding: 0 10px 0 0;
            }
            .rate:not(:checked) > input {
                position:absolute;
                top:-9999px;
            }
            .rate:not(:checked) > label {
                float: right;
                width: 15px;
                overflow: hidden;
                white-space: nowrap;
                cursor: pointer;
                font-size: 21px;
                color:#ccc;
                margin-bottom: 0;
                line-height: 21px;
            }
            .rate:not(:checked) > label:before {
                content: '\2605';
            }
            .rate > input:checked ~ label {
                color: #ffc700;
            }
            .rate:not(:checked) > label:hover,
            .rate:not(:checked) > label:hover ~ label {
                color: #deb217;
            }
            .rate > input:checked + label:hover,
            .rate > input:checked + label:hover ~ label,
            .rate > input:checked ~ label:hover,
            .rate > input:checked ~ label:hover ~ label,
            .rate > label:hover ~ input:checked ~ label {
                color: #c59b08;
            }
            .product-dtl p {
                font-size: 14px;
                line-height: 24px;
                color: #7a7a7a;
            }
            .product-dtl .form-control {
                font-size: 15px;
            }
            .product-dtl label {
                line-height: 16px;
                font-size: 15px;
            }
            .form-control:focus {
                outline: none;
                box-shadow: none;
            }
            .product-count {
                margin-top: 15px;
            }
            .product-count .qtyminus,
            .product-count .qtyplus {
                width: 34px;
                height: 34px;
                background: #212529;
                text-align: center;
                font-size: 19px;
                line-height: 36px;
                color: #fff;
                cursor: pointer;
            }
            .product-count .qtyminus {
                border-radius: 3px 0 0 3px;
            }
            .product-count .qtyplus {
                border-radius: 0 3px 3px 0;
            }
            .product-count .qty {
                width: 60px;
                text-align: center;
            }
            .round-black-btn {
                border-radius: 4px;
                background: #212529;
                color: #fff;
                padding: 7px 45px;
                display: inline-block;
                margin-top: 20px;
                border: solid 2px #212529;
                transition: all 0.5s ease-in-out 0s;
            }
            .round-black-btn:hover,
            .round-black-btn:focus {
                background: transparent;
                color: #212529;
                text-decoration: none;
            }

            .product-info-tabs {
                margin-top: 25px;
            }
            .product-info-tabs .nav-tabs {
                border-bottom: 2px solid #d8d8d8;
            }
            .product-info-tabs .nav-tabs .nav-item {
                margin-bottom: 0;
            }
            .product-info-tabs .nav-tabs .nav-link {
                border: none;
                border-bottom: 2px solid transparent;
                color: #323232;
            }
            .product-info-tabs .nav-tabs .nav-item .nav-link:hover {
                border: none;
            }
            .product-info-tabs .nav-tabs .nav-item.show .nav-link,
            .product-info-tabs .nav-tabs .nav-link.active,
            .product-info-tabs .nav-tabs .nav-link.active:hover {
                border: none;
                border-bottom: 2px solid #d8d8d8;
                font-weight: bold;
            }
            .product-info-tabs .tab-content .tab-pane {
                padding: 30px 20px;
                font-size: 15px;
                line-height: 24px;
                color: #7a7a7a;
            }
            .review-form .form-group {
                clear: both;
            }
            .mb-20 {
                margin-bottom: 20px;
            }

            .review-form .rate {
                float: none;
                display: inline-block;
            }
            .review-heading {
                font-size: 24px;
                font-weight: 600;
                line-height: 24px;
                margin-bottom: 6px;
                text-transform: uppercase;
                color: #000;
            }
            .review-form .form-control {
                font-size: 14px;
            }
            .review-form input.form-control {
                height: 40px;
            }
            .review-form textarea.form-control {
                resize: none;
            }
            .review-form .round-black-btn {
                text-transform: uppercase;
                cursor: pointer;
            }

            .navbar {
                padding: 0;
            }

            .second-2 ul {
                margin: 0;
            }

            .img-fluid {

            }

            .rating-stars {
                display: block;
                width: 25vmin;
                padding: 0.875vmin 5vmin 1vmin 1.5vmin;
                background: linear-gradient(90deg, #ffffff90 40vmin, #fff0 40vmin 100%);
                border-radius: 5vmin;
                position: relative;
            }

            .rating-counter {
                font-size: 2.25vmin;
                font-family: Arial, Helvetica, serif;
                color: gold;
                width: 5vmin;
                text-align: center;
                background: #0006;
                position: absolute;
                top: 0;
                right: 0;
                height: 100%;
                border-radius: 0 2.5vmin 2.5vmin 0;
                line-height: 5vmin;
            }

            .rating-counter:before {
                content: "0";
                transition: all 0.25s ease 0s;
            }



            .input_star {
                display: none;
            }

            .star_label {
                width: 2.5vmin;
                height: 2.5vmin;
                background: #000b;
                display: inline-flex;
                cursor: pointer;
                margin: 0.25vmin 0.325vmin;
                transition: all 1s ease 0s;
                clip-path: polygon(50% 0%, 66% 32%, 100% 38%, 78% 64%, 83% 100%, 50% 83%, 17% 100%, 22% 64%, 0 38%, 34% 32%);
            }

            .star_label[for=rs0] {
                display: none;
            }

            .star_label:before {
                width: 90%;
                height: 90%;
                content: "";
                background: orange;
                z-index: -1;
                display: block;
                margin-left: 5%;
                margin-top: 5%;
                clip-path: polygon(50% 0%, 66% 32%, 100% 38%, 78% 64%, 83% 100%, 50% 83%, 17% 100%, 22% 64%, 0 38%, 34% 32%);
                background: linear-gradient(90deg, yellow, orange 30% 50%, #184580 50%, 70%, #173a75 100%);
                background-size: 205% 100%;
                background-position: 0 0;
            }

            .star_label:hover:before {
                transition: all 0.25s ease 0s;
            }

            .input_star:checked + label ~ label:before {
                background-position: 100% 0;
                transition: all 0.25s ease 0s;
            }

            .input_star:checked + label ~ label:hover:before {
                background-position: 0% 0
            }





            #rs1:checked ~ .rating-counter:before {
                content: "1";
            }

            #rs2:checked ~ .rating-counter:before {
                content: "2";
            }

            #rs3:checked ~ .rating-counter:before {
                content: "3";
            }

            #rs4:checked ~ .rating-counter:before {
                content: "4";
            }

            #rs5:checked ~ .rating-counter:before {
                content: "5";
            }

            .star_label + .input_star:checked ~ .rating-counter:before {
                color: #ffab00 !important;
                transition: all 0.25s ease 0s;
            }





            .star_label:hover ~ .rating-counter:before {
                color: gold !important;
                transition: all 0.5s ease 0s;
                animation: pulse 1s ease 0s infinite;
            }

            @keyframes pulse {
                50% {
                    font-size: 3.125vmin;
                }
            }

            .star_label[for=rs1]:hover ~ .rating-counter:before {
                content: "1" !important;
            }

            .star_label[for=rs2]:hover ~ .rating-counter:before {
                content: "2" !important;
            }

            .star_label[for=rs3]:hover ~ .rating-counter:before {
                content: "3" !important;
            }

            .star_label[for=rs4]:hover ~ .rating-counter:before {
                content: "4" !important;
            }

            .star_label[for=rs5]:hover ~ .rating-counter:before {
                content: "5" !important;
            }


            .input_star:checked:hover ~ .rating-counter:before {
                animation: none !important;
                color: #ffab00 !important ;
            }








            /*** INITIAL ANIMATION - Not Necessary ***/
            /*** I want to make a loop here ***/
            /*
            label + input + label:before {
                animation: start 0.5s ease 0s 1;
            }
            
            .rating-stars:hover label + input + label:before {
                animation: none;
            }
            
            label[for=rs2]:before {
                    animation-delay: 0.1s;
            }
            
            label[for=rs3]:before {
                    animation-delay: 0.2s;
            }
            
            label[for=rs4]:before {
                    animation-delay: 0.3s;
            }
            
            label[for=rs5]:before {
                    animation-delay: 0.4s;
            }
            
            @keyframes start {
                    10%, 90% { background-position: 0% 0; }
            }
            
            */

            .userReview{
                padding: 10px;
                border-radius: 5px;
                box-shadow: 7px 0px 40px 0px rgba(0,0,0,0.12);
                -webkit-box-shadow: 7px 0px 40px 0px rgba(0,0,0,0.12);
                -moz-box-shadow: 7px 0px 40px 0px rgba(0,0,0,0.12);
                margin-bottom: 20px;
            }

            .userReview__username {
                font-weight: bold;
                color: black;
                font-size: 18px;
            }
            .userReview__date {
                font-style: italic;
                font-size: 12px;
            }
            .userReview__comment {
                margin-left: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="/includes/header.jsp"%>
        <main>

            <div class="pd-wrap">
                <div class="container">

                    <div class="row">
                        <div class="col-md-4">

                            <img class="img-fluid" src=<%= book.getImg_path()%> />

                        </div>
                        <div class="col-md-8">
                            <div class="product-dtl">
                                <div class="product-info">
                                    <h2> <%= book.getTitle()%> </h2>

                                    <div class="product-name"> -- <%= book.getAuthor()%></div>
                                    <div class="reviews-counter">
                                        <div class="rate">
                                            <div class="rate_value"><span>⭐️</span><%= n == 0 ? 0 : df.format(rating / n)%> / 5.0</div>
                                        </div>
                                        <span><%= reviews.size()%> Reviews</span>
                                    </div>
                                </div>
                                <div><span>Edition: </span><%= book.getEdition()%> </div>
                                <div><span>Publisher: </span><%= book.getPublisher()%> </div>
                                <div><span>Published Date: </span><%= book.getPublished_date()%> </div>

                                <p><%= book.getDescription()%></p>

                                <div class="product-count">                                   
                                    <a href="/add-to-list?book_id=<%= book.getId()%>&from=detail&id=<%= book.getId()%>" class="round-black-btn">Add to Borrow List</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-info-tabs">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="description-tab" data-toggle="tab" href="#description" role="tab" aria-controls="description" aria-selected="true">Description</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">Reviews (<%= reviews.size()%>)</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
                                <%= book.getDescription()%>
                            </div>
                            <div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
                                <div class="review-heading">REVIEWS</div>

                                <% if (reviews == null || reviews.size() == 0) {
                                %>
                                <p class="mb-20">There are no reviews yet.</p>
                                <%
                                } else {
                                    for (ReviewWithUsername review : reviews) {
                                %> 
                                <div class="userReview">
                                    <div>
                                        <span class="userReview__username"><%= review.getUsername()%></span> 
                                        <span class="userReview__date"><%= review.getDate()%></span> 
                                    </div>
                                    <p  class="userReview__comment"><%= review.getComment()%></p>
                                </div>


                                <%
                                        }
                                    }
                                %>
                                <hr>
                                <form action="/submit-review" method="get" class="review-form">
                                    <input type="hidden" name="id" value=<%= book.getId()%> />


                                    <div class="form-group">
                                        <label>Your rating</label>
                                        <div class="rating-stars">
                                            <input class="input_star" value=0 type="radio" name="rating" id="rs0" checked><label class="star_label" for="rs0"></label>
                                            <input class="input_star"  value=1 type="radio" name="rating" id="rs1"><label class="star_label" for="rs1"></label>
                                            <input class="input_star"  value=2 type="radio" name="rating" id="rs2"><label class="star_label" for="rs2"></label>
                                            <input class="input_star"  value=3 type="radio" name="rating" id="rs3"><label class="star_label" for="rs3"></label>
                                            <input class="input_star"  value=4 type="radio" name="rating" id="rs4"><label class="star_label" for="rs4"></label>
                                            <input class="input_star"  value=5 type="radio" name="rating" id="rs5"><label class="star_label" for="rs5"></label>
                                            <span class="rating-counter" ></span>
                                        </div>


                                    </div>
                                    <div class="form-group">
                                        <label>Your message</label>
                                        <textarea class="form-control" rows="10" name="comment"></textarea>
                                    </div>

                                    <button class="round-black-btn"><%= user == null ? "Sign in to review" : rd.checkReview(user.getRoll_number(), book.getId()) == false ? "Submit Review" : "Resubmit review"%></button>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="	sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        </main>        
        <%@include file="includes/footer.jsp" %>

    </body>
</html>
