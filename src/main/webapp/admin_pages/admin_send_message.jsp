<%-- 
    Document   : admin
    Created on : Nov 1, 2022, 2:57:36 AM
    Author     : PhucPhan
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.BookDAO"%>
<%@page import="com.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User admin = (User) request.getSession().getAttribute("user");
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

        <link rel="stylesheet" href="https://unpkg.com/font-awesome@4.7.0/css/font-awesome.min.css"/>

        <link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>




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

            .last_row{
                display: flex;
            }

            span.validate-tooltip {
                background: #EF5350;
                width: 100%;
                display: block;
                padding: 5px;
                color: #fff;
                box-sizing: border-box;
                font-size: 15px;
                margin-top: -40px;
                border-radius: 3px;

                transition: all 0.3s ease-in-out;
                -webkit-animation: tooltipanimation .3s 1;
                -moz-animation: tooltipanimation .3s 1;
                -o-animation: tooltipanimation .3s 1;
                animation: tooltipanimation .3s 1;
            }

            .input-group span.validate-tooltip {
                margin-top: 0;
            }
            @-webkit-keyframes tooltipanimation {
                from {
                    margin-top: -40px;
                }
                to {
                    margin-top: 0;
                }
            }
            @-moz-keyframes tooltipanimation {
                from {
                    margin-top: -40px;
                }
                to {
                    margin-top: 0;
                }
            }
            @-o-keyframes tooltipanimation {
                from {
                    margin-top: -40px;
                }
                to {
                    margin-top: 0;
                }
            }
            @keyframes tooltipanimation {
                from {
                    margin-top: -40px;
                }
                to {
                    margin-top: 0;
                }
            }
        </style>
        <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                // validetion
                $.validator.setDefaults({
                    errorElement: 'span',
                    errorClass: 'validate-tooltip'
                });

                $("#validationForm").validate({
                    rules: {
                        rollnumber: {
                            required: true,
                            maxlength: 8,
                            valid_rollnumber: true
                        },
                        subject: {
                            required: true

                        },
                        message: {
                            required: true

                        }
                    },
                    messages: {
                        rollnumber: {
                            required: "Please enter your rollnumber.",
                            maxlength: "Rollnumber max length is 8.",
                            valid_rollnumber: "Please enter valid rollnumber"

                        }
                    }
                });
            });

            $.validator.addMethod('valid_rollnumber', function (value) {
                var regex = /^[A-Za-z]{2}[0-9]{6}$/;
                return value.trim().match(regex);
            });



        </script>

    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- sidebar -->
                <div class="col-md-3 col-lg-2 px-0 position-fixed h-100 bg-white shadow-sm sidebar" id="sidebar">
                    <h1 class="text-primary d-flex my-4 justify-content-center">Admin</h1>
                    <div class="list-group rounded-0">
                        <a href="/admin" class="list-group-item list-group-item-action  border-0 d-flex align-items-center">
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
                        <div class="" id="message-collapse" data-parent="#sidebar">
                            <div class="list-group">
                                <a href="/admin/all_message" class="list-group-item list-group-item-action border-0 pl-5">User Message</a>
                                <a href="/admin/send_message" class="active list-group-item list-group-item-action border-0 pl-5">Send message</a>
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
                                <a class="dropdown-item" href="#">Logout</a>
                                <a class="dropdown-item" href="#">Settings</a>
                            </div>
                        </div>
                    </nav>
                    <!-- main content -->
                    <main class="container-fluid">
                        <form id="validationForm" method="post" action="/admin/send_message">
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="rollnumber" class="offset-8 col-form-label">To</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="rollnumber"
                                            name="rollnumber"
                                            placeholder="Roll number. Ex: CE171166"
                                            type="text"
                                            class="form-control"
                                            value="<%= request.getParameter("rollnumber") != null ? request.getParameter("rollnumber") : ""%>"
                                            />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="subject" class="offset-8 col-form-label">Subject</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="subject"
                                            name="subject"
                                            placeholder=""
                                            type="text"
                                            class="form-control"
                                            />
                                    </div>
                                </div>
                            </div>


                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="message" class="offset-8 col-form-label"
                                           >Message</label
                                    >
                                </div>
                                <div class="col-8">
                                    <textarea
                                        id="message"
                                        name="message"
                                        cols="40"
                                        rows="5"
                                        class="form-control feedback"
                                        ></textarea>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="offset-3 col-9">
                                    <button name="btnSend" type="submit" class="btn btn-primary">
                                        Send
                                    </button>
                                </div>
                            </div>
                        </form>
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

                $(document).ready(function () {
                    $('#tbBook').DataTable();
                });

            });
        </script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="	sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
