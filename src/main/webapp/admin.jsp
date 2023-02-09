<%-- 
    Document   : admin
    Created on : Nov 1, 2022, 2:57:36 AM
    Author     : PhucPhan
--%>

<%@page import="com.daos.ReviewDAO"%>
<%@page import="com.daos.UserDAO"%>
<%@page import="com.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User admin = (User) request.getSession().getAttribute("user");
    UserDAO uDAO = new UserDAO();
    ReviewDAO rDAO = new ReviewDAO();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" id="bootstrap-css">

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>


        <style>

            body{
                font-family: 'Barlow', sans-serif;
            }

            a:hover{
                text-decoration: none;
            }

            .border-left{
                border-left: 2px solid var(--primary) !important;
            }


            .sidebar{
                top: 0;
                left : 0;
                z-index : 100;
                overflow-y: auto;
            }

            .overlay{
                background-color: rgb(0 0 0 / 45%);
                z-index: 99;
            }

            /* sidebar for small screens */
            @media screen and (max-width: 767px){

                .sidebar{
                    max-width: 18rem;
                    transform : translateX(-100%);
                    transition : transform 0.4s ease-out;
                }

                .sidebar.active{
                    transform : translateX(0);
                }

            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- sidebar -->
                <div class="col-md-3 col-lg-2 px-0 position-fixed h-100 bg-white shadow-sm sidebar" id="sidebar">
                    <h1 class="text-primary d-flex my-4 justify-content-center">Admin</h1>
                    <div class="list-group rounded-0">
                        <a href="/admin" class="list-group-item list-group-item-action active border-0 d-flex align-items-center">
                            <span class="bi bi-border-all"></span>
                            <span class="ml-2">Dashboard</span>
                        </a>
                        <a href="/admin/borrow-request" class="list-group-item list-group-item-action border-0 align-items-center">
                            <span class="bi bi-pencil-square"></span>
                            <span class="ml-2">Borrow Request</span>
                        </a>

                        <a href="/admin/user" class="list-group-item list-group-item-action border-0 align-items-center">
                            <span class="bi-person-circle"></span>
                            <span class="ml-2">Admin & User</span>
                        </a>

                        <a href="/admin/book" class="list-group-item list-group-item-action border-0 align-items-center">
                            <span class="bi bi-journals"></span>
                            <span class="ml-2">Book</span>
                        </a>
                        <button class="list-group-item list-group-item-action border-0 d-flex justify-content-between align-items-center" data-toggle="collapse" data-target="#message-collapse">
                            <div>
                                <span class="bi bi-envelope"></span>
                                <span class="ml-2">Message</span>
                            </div>
                            <span class="bi bi-chevron-down small"></span>
                        </button>
                        <div class="collapse" id="message-collapse" data-parent="#sidebar">
                            <div class="list-group">
                                <a href="/admin/all_message" class="list-group-item list-group-item-action border-0 pl-5">User Message</a>
                                <a href="/admin/send_message" class="list-group-item list-group-item-action border-0 pl-5">Send message</a>
                            </div>
                        </div>

                        <button class="list-group-item list-group-item-action border-0 d-flex justify-content-between align-items-center" data-toggle="collapse" data-target="#purchase-collapse">
                            <div>
                                <span class="bi bi-box"></span>
                                <span class="ml-2">Borrow Conditions</span>
                            </div>
                            <span class="bi bi-chevron-down small"></span>
                        </button>
                        <div class="collapse" id="purchase-collapse" data-parent="#sidebar">
                            <div class="list-group">
                                <a href="/admin/borrow/returned" class="list-group-item list-group-item-action border-0 pl-5">Returned</a>
                                <a href="/admin/borrow/borrowing" class="list-group-item list-group-item-action border-0 pl-5">Borrowing</a>
                                <a href="/admin/borrow/overdue" class="list-group-item list-group-item-action border-0 pl-5">Overdue</a>

                            </div>
                        </div>

                    </div>
                </div>
                <!-- overlay to close sidebar on small screens -->
                <div class="w-100 vh-100 position-fixed overlay d-none" id="sidebar-overlay"></div>
                <!-- note: in the layout margin auto is the key as sidebar is fixed -->
                <div class="col-md-9 col-lg-10 ml-md-auto px-0">
                    <!-- top nav -->
                    <nav class="w-100 d-flex px-4 py-2 mb-4 shadow-sm">
                        <!-- close sidebar -->
                         <a class="navbar-brand" href="/">Webpage</a>
                        <button class="btn py-0 d-lg-none" id="open-sidebar">
                            <span class="bi bi-list text-primary h3"></span>
                        </button>
                        <div class="dropdown ml-auto">
                            <button class="btn py-0 d-flex align-items-center" id="logout-dropdown" data-toggle="dropdown" aria-expanded="false">
                                <span class="bi bi-person text-primary h4"></span>
                                <span class="bi bi-chevron-down ml-1 mb-2 small"></span>
                            </button>
                            <div class="dropdown-menu dropdown-menu-right border-0 shadow-sm" aria-labelledby="logout-dropdown">
                                <a class="dropdown-item" href="/admin/log-out">Logout</a>
                                <a class="dropdown-item" href="#">Settings</a>
                            </div>
                        </div>
                    </nav>
                    <!-- main content -->
                    <main class="container-fluid">
                        <section class="row">
                            <div class="col-md-6 col-lg-4">
                                <!-- card -->
                                <article class="p-4 rounded shadow-sm border-left
                                         mb-4">
                                    <a href="/admin/book" class="d-flex align-items-center">
                                        <span class="bi bi-box h5"></span>
                                        <h5 class="ml-2"><%= rDAO.getNumberOfReviewToday() %> book reviews today</h5>
                                    </a>
                                </article>
                            </div>

                            <div class="col-md-6 col-lg-4">
                                <article class="p-4 rounded shadow-sm border-left mb-4">
                                    <a href="/admin/user" class="d-flex align-items-center">
                                        <span class="bi bi-person-check h5"></span>
                                        <h5 class="ml-2"><%= uDAO.getNumberOfNewUserToday() %> new users today</h5>
                                    </a>
                                </article>
                            </div>
                        </section>

                        <div class="jumbotron jumbotron-fluid rounded bg-white border-0 shadow-sm border-left px-4">
                            <div class="container">
                                <h1 class="display-4 mb-2 text-primary">Welcome</h1>
                                <p class="lead text-muted"><%= admin.getFirst_name() + " " + admin.getLast_name()%></p>
                            </div>
                        </div>
                    </main>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(() => {

                $('#open-sidebar').click(() => {

                    // add class active on #sidebar
                    $('#sidebar').addClass('active');

                    // show sidebar overlay
                    $('#sidebar-overlay').removeClass('d-none');

                });


                $('#sidebar-overlay').click(function () {

                    // add class active on #sidebar
                    $('#sidebar').removeClass('active');

                    // show sidebar overlay
                    $(this).addClass('d-none');

                });

            });
        </script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="	sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
