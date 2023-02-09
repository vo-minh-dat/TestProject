<%-- 
    Document   : admin
    Created on : Nov 1, 2022, 2:57:36 AM
    Author     : PhucPhan
--%>

<%@page import="com.daos.ClassDAO"%>
<%@page import="com.daos.CurriculumDAO"%>
<%@page import="java.sql.ResultSet"%>
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
                        firstname: {
                            required: true,
                            valid_name: true
                        },
                        lastname: {
                            required: true,
                            valid_name: true
                        },
                        email: {
                            required: true,
                            minlength: 6,
                            maxlength: 50
                        },
                        password: {
                            required: true,
                            minlength: 6,
                            maxlength: 50

                        },
                        repassword: {
                            required: true,
                            minlength: 6,
                            maxlength: 50,
                            valid_repassword: true
                        },
                        birthdate: {
                            required: true,
                            valid_birthdate: true
                        }
                    },
                    messages: {
                        rollnumber: {
                            required: "Please enter your rollnumber.",
                            maxlength: "Rollnumber max length is 8.",
                            valid_rollnumber: "Please enter valid rollnumber"

                        },
                        firstname: {
                            required: "Please enter your firstname.",
                            valid_name: "Please enter valid name"

                        },
                        lastname: {
                            required: "Please enter your lastname.",
                            valid_name: "Please enter valid name"

                        },
                        email: {
                            required: "Please enter your email.",
                            minlength: "Please provide valid email.",
                            maxlength: "email must be less than or equal 50 letters."

                        },
                        password: {
                            required: "Enter your password to login.",
                            minlength: "Incorrect login or password.",
                            maxlength: "Password must be less than or equal 50 letters."
                        },
                        repassword: {
                            required: "Re-enter your password to login.",
                            minlength: "Incorrect re-enter password",
                            maxlength: "Incorrect re-enter password",
                            valid_repassword: "Incorrect re-enter password"
                        },
                        birthdate: {
                            required: "You must choose your birthdate",
                            valid_birthdate: "Your age must above 17."
                        }
                    }
                });
            });

            $.validator.addMethod('valid_rollnumber', function (value) {
                var regex = /^[A-Za-z]{2}[0-9]{6}$/;
                return value.trim().match(regex);
            });

            $.validator.addMethod('valid_name', function (value) {
                var regex = /^[A-Za-z]{1,10}$/;
                return value.trim().match(regex);
            });
            $.validator.addMethod('valid_repassword', function (value) {
                var password = $("#password").val();
                return password === value;
            });

            $.validator.addMethod('valid_repassword', function (value) {
                var password = $("#password").val();
                return password === value;
            });

            $.validator.addMethod('valid_birthdate', function (value) {
                var birthday = value;
                var date = new Date();

                var d1 = new Date(); //"now"
                var d2 = new Date(birthday);  // some date
                var diff = Math.abs(d1 - d2) / 31536000000;  // difference in milliseconds                        

                if (diff >= 17) {
                    return true;

                }
                return false;

            });

        </script>

    </head>
    <body>
        <%
            // initialize content display
            String errorDisplay = "none";
            String errorContent = "";

            // check if there is an error message from request
            if (request.getParameter("error") != null) {
                // display error
                errorDisplay = "block";
                String errorType = request.getParameter("error");
                if (errorType.equals("id_exist")) {
                    errorContent = "This ID is already exists.";
                } else {
                    errorContent = "Something wrong happened :(((";
                }
            }
        %>
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

                        <a href="/admin/user" class="active list-group-item list-group-item-action border-0 align-items-center">
                            <span class="bi-person-circle"></span>
                            <span class="ml-2">Admin & User</span>
                        </a>

                        <a href="/admin/book" class="list-group-item lactiveist-group-item-action border-0 align-items-center">
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
                    <div style="display:<%= errorDisplay%>; margin-top: 20px;" id="usernotfound-alert" class="alert alert-danger col-sm-12"><%= errorContent%></div>

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
                        <form id="validationForm" method="post" action="/admin/user/insert">
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="rollnumber" class="offset-8 col-form-label">Roll number</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="rollnumber"
                                            name="rollnumber"
                                            placeholder="Please enter roll number here"
                                            type="text"
                                            class="form-control"
                                            />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="email" class="offset-8 col-form-label">Email</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="email"
                                            name="email"
                                            placeholder="Please enter email here"
                                            type="email"
                                            class="form-control"
                                            />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="password" class="offset-8 col-form-label">Password</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="password"
                                            name="password"
                                            placeholder="Please enter password here"
                                            type="password"
                                            class="form-control"
                                            />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="repassword" class="offset-8 col-form-label">Re-enter password</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="repassword"
                                            name="repassword"
                                            placeholder="Please re-enter password here"
                                            type="password"
                                            class="form-control"
                                            />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="firstname" class="offset-8 col-form-label">First name</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="firstname"
                                            name="firstname"
                                            placeholder="Please enter first name here"
                                            type="text"
                                            class="form-control"
                                            />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="lastname" class="offset-8 col-form-label">Last name</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="lastname"
                                            name="lastname"
                                            placeholder="Please enter last name here"
                                            type="text"
                                            class="form-control"
                                            />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="role" class="offset-8 col-form-label"
                                           >Role</label
                                    >
                                </div>
                                <div class="col-8">
                                    <select id="role" name="role" class="custom-select">
                                        <option value="admin">Admin</option>
                                        <option value="user">User</option>

                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="birthdate" class="offset-8 col-form-label">Birth Date</label>
                                </div>
                                <div class="col-8">
                                    <div class="input-group">
                                        <input
                                            id="birthdate"
                                            name="birthdate"
                                            type="date"
                                            class="form-control"
                                            />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="gender" class="offset-8 col-form-label"
                                           >Gender</label
                                    >
                                </div>
                                <div class="col-8">
                                    <select id="gender" name="gender" class="custom-select">
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>

                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="curriculum" class="offset-8 col-form-label"
                                           >Curriculum</label
                                    >
                                </div>
                                <div class="col-8">
                                    <select id="curriculum" name="curriculum" class="custom-select">
                                        <option value="none">None</option>

                                        <%
                                            CurriculumDAO daoc = new CurriculumDAO();
                                            ResultSet rsc = daoc.getAllCurriculum();
                                            while (rsc.next()) {
                                        %>
                                        <option value=<%= rsc.getString("code")%> <%= request.getParameter("major") != null ? (request.getParameter("major").equals(rsc.getString("code")) ? "selected" : "") : ""%>><a href=""><%= rsc.getString("name")%></a></option>
                                        <%
                                            }
                                        %>
                                    </select>


                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-3">
                                    <label for="class" class="offset-8 col-form-label"
                                           >Class</label
                                    >
                                </div>
                                <div class="col-8">
                                    <select id="mainclass" name="mainclass" class="custom-select" required="required">
                                        <option value="none">None</option>
                                        <%
                                            ClassDAO dao = new ClassDAO();
                                            ResultSet rs = dao.getClassByCurriculum(request.getParameter("major") != null ? request.getParameter("major") : "");
                                            while (rs.next()) {
                                        %>
                                        <option value="<%= rs.getString("name")%>"><%= rs.getString("name")%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="offset-3 col-9">
                                    <button name="btnInsert" type="submit" class="btn btn-primary">
                                        Add
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

                $("#curriculum").click(function () {
                    var open = $(this).data("isopen");
                    if (open) {
                        window.location.href = "/admin/user/insert?major=" + $(this).val()
                    }
                    //set isopen to opposite so next time when use clicked select box
                    //it wont trigger this event
                    $(this).data("isopen", !open);
                });

            });
        </script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="	sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
