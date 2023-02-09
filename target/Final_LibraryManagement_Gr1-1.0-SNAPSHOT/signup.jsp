<%-- 
    Document   : login.jsp
    Created on : Nov 1, 2022, 1:25:46 AM
    Author     : PhucPhan
--%>

<%@page import="com.daos.CurriculumDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.ClassDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registration</title>
        <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>


        <script>
            $(document).ready(function () {


                $('.palceholder').click(function () {
                    $(this).siblings('input').focus();
                });

                $('.form-control').focus(function () {
                    $(this).parent().addClass("focused");
                });

                $('.form-control').blur(function () {
                    var $this = $(this);
                    if ($this.val().length == 0)
                        $(this).parent().removeClass("focused");
                });
                $('.form-control').blur();

                // validetion
                $.validator.setDefaults({
                    errorElement: 'span',
                    errorClass: 'validate-tooltip'
                });



                $("#formvalidate").validate({
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

            });
        </script>
        <style>
            body {
                background: #f2f2f2;
                overflow: hidden;
            }
            .animate {
                transition: all 0.3s linear;
            }
            .text-center {
                text-align: center;
            }
            .pull-left {
                float: left;
            }
            .pull-right {
                float: right;
            }
            .clearfix:after {
                visibility: hidden;
                display: block;
                font-size: 0;
                content: " ";
                clear: both;
                height: 0;
            }
            .clearfix {
                display: inline-block;
            }
            * html .clearfix {
                height: 1%;
            }
            .clearfix {
                display: block;
            }
            a {
                color: #00A885;
            }
            a:hover, a:focus {
                color: #00755d;
                transition: all 0.3s linear;
            }
            .text-primary {
                color: #00A885;
            }
            input:-webkit-autofill {
                -webkit-box-shadow: 0 0 0 1000px white inset !important;
            }
            .logo h1 {
                color: #00A885;
                margin-bottom: -12px;
            }
            input[type="checkbox"] {
                width: auto;
            }
            button {
                cursor: pointer;
                background: #00A885;
                width: 100%;
                border: 0;
                padding: 10px 15px;
                color: #fff;
                font-size: 20px;
                -webkit-transition: .3s linear;
                transition: .3s linear;
            }
            span.validate-tooltip {
                background: #EF5350;
                width: 100%;
                display: block;
                padding: 5px;
                color: #fff;
                box-sizing: border-box;
                font-size: 14px;
                margin-top: -28px;
                transition: all 0.3s ease-in-out;
                -webkit-animation: tooltipanimation .3s 1;
                -moz-animation: tooltipanimation .3s 1;
                -o-animation: tooltipanimation .3s 1;
                animation: tooltipanimation .3s 1;
            }
            .input-group {
                position: relative;
                margin-bottom: 20px;
            }
            .input-group label {
                position: absolute;
                top: 9px;
                left: 10px;
                font-size: 16px;
                color: #cdcdcd;
                font-weight: normal;
                padding: 2px 5px;
                z-index: 5;
                transition: all 0.3s linear;
            }
            .input-group input {
                outline: none;
                display: block;
                width: 100%;
                height: 40px;
                position: relative;
                z-index: 3;
                border: 1px solid #d9d9d9;
                padding: 10px 10px;
                background: #ffffff;
                box-sizing: border-box;
                font-wieght: 400;
                -moz-transition: 0.3s ease;
                -webkit-transition: 0.3s ease;
                -o-transition: 0.3s ease;
                transition: 0.3s ease;
            }
            .input-group .lighting {
                background: #00A885;
                width: 0;
                height: 2px;
                display: inline-block;
                position: absolute;
                top: 40px;
                left: 0;
                transition: all 0.3s linear;
            }
            .input-group.focused .lighting {
                width: 100%;
            }
            .input-group.focused label {
                background: #fff;
                font-size: 12px;
                top: -8px;
                left: 5px;
                color: #00A885;
            }
            .input-group span.validate-tooltip {
                margin-top: 0;
            }
            .wrapper {
                width: 320px;
                background: #fff;
                margin: 20px auto;
                min-height: 200px;
                border: 1px solid #f3f3f3;
            }
            .wrapper .inner-warpper {
                padding: 30px 30px 30px;
                box-shadow: 1px 1.732px 10px 0px rgba(0,0,0,0.063);
            }
            .wrapper .title {
                margin-top: 0;
            }
            .wrapper .supporter {
                margin-top: 10px;
                font-size: 14px;
                color: #8E8E8E;
                cursor: pointer;
            }
            .wrapper .remember-me {
                cursor: pointer;
            }
            .wrapper input[type="checkbox"] {
                float: left;
                margin-right: 5px;
                margin-top: 2px;
                cursor: pointer;
            }
            .wrapper label[for="rememberMe"] {
                cursor: pointer;
            }
            .wrapper .signup-wrapper {
                padding: 10px;
                font-size: 14px;
                background: #EBEAEA;
            }
            .wrapper .signup-wrapper a {
                text-decoration: none;
                color: #7F7F7F;
            }
            .wrapper .signup-wrapper a:hover {
                text-decoration: underline;
            }
            @-webkit-keyframes tooltipanimation {
                from {
                    margin-top: -28px;
                }
                to {
                    margin-top: 0;
                }
            }
            @-moz-keyframes tooltipanimation {
                from {
                    margin-top: -28px;
                }
                to {
                    margin-top: 0;
                }
            }
            @-o-keyframes tooltipanimation {
                from {
                    margin-top: -28px;
                }
                to {
                    margin-top: 0;
                }
            }
            @keyframes tooltipanimation {
                from {
                    margin-top: -28px;
                }
                to {
                    margin-top: 0;
                }
            }
            .direction {
                width: 200px;
                position: fixed;
                top: 120px;
                left: 20px;
                font-size: 14px;
                line-height: 1.2;
                text-align: center;
                background: #9365B8;
                padding: 10px;
                color: #fff;
            }
            @media (max-width: 480px) {
                .direction {
                    position: static;
                }
            }

            .login_form_container {
                font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            }

            .toast{
                position: absolute;
                top: 25px;
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
                right: 15px;
                padding: 5px;
                cursor: pointer;
                opacity: 0.7;
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



            .fullname-group {
                display: flex;

            }

            #firstname, #lastname {
                width: 90%;
            }

            #firstname-error, #lastname-error {
                width: 90%;
            }

            .gender_container {
                display: flex;
                flex-direction: row;
                justify-content: center;
                align-items: center;
                margin-top: -15px;
            }
            label{
                user-select: none;
            }
            input[type="radio"] {
                display: none;
            }

            input[type="radio"] + label {
                z-index: 10;
                margin: 0 10px 10px 0;
                position: relative;
                color: #ced4da;
                text-shadow: 0 1px 0 rgba(255, 255, 255, 0.1);
                font-weight: bold;
                background-color: #ffffff;
                border: 2px solid #ced4da;
                cursor: pointer;
                transition: all 200ms ease;
            }

            input[type="radio"]:checked + label {
                color: #495057;
                background-color: #ced4da;
            }

            input[type="radio"] + label {
                padding: 5px 20px;
                border-radius: 10px;
            }

            #mainclass, #major {
                outline: none;
                display: block;
                width: 100%;
                height: 40px;
                position: relative;
                z-index: 3;
                border: 1px solid #d9d9d9;
                padding: 10px 10px;
                background: #ffffff;
                box-sizing: border-box;
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
                    if (errorType.equals("rollnumber")) {
                        errorContent = "This roll number is already a user.";
                    } else if (errorType.equals("email")) {
                        errorContent = "This email is already a user.";
                    } else {
                        errorContent = "Opps... Something wrong happened :(((";
                    }
                }

            %>
        </script>
    </head>
    <body>


        <div class="login_form_container">
            <div class="toast">
                <div class="toast-content">
                    <i class="fas fa-solid fa-times check"></i>

                    <div class="message">
                        <span class="text text-1">Failed</span>
                        <span class="text text-2"><%= errorContent%></span>
                    </div>
                </div>
                <i class="fa-solid fa-xmark close"></i>

                <div class="progress"></div>
            </div>
            <div class="logo text-center">
                <h1>Create account</h1>
            </div>
            <div class="wrapper">
                <div class="inner-warpper text-center">
                    <form action="/sign-up" id="formvalidate" method="post">
                        <select name="major" id='major' class="input-group">

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
                        <div class="input-group">
                            <label class="palceholder" for="rollnumber">Roll number</label>
                            <input class="form-control" name="rollnumber" id="rollnumber" type="text" placeholder="" />
                            <span class="lighting"></span>
                        </div>
                        <div class="fullname-group">
                            <div class="input-group">
                                <label class="palceholder" for="firstname">First name</label>
                                <input class="form-control" name="firstname" id="firstname" type="text" placeholder="" />
                            </div>

                            <div class="input-group">
                                <label class="palceholder" for="lastname">Last name</label>
                                <input class="form-control" name="lastname" id="lastname" type="text" placeholder="" />
                            </div>

                        </div>
                        <div class="input-group">
                            <label class="palceholder" for="email">Email</label>
                            <input class="form-control" name="email" id="email" type="email" placeholder="" />
                            <span class="lighting"></span>
                        </div>
                        <div class="input-group">
                            <label class="palceholder" for="password">Password</label>
                            <input class="form-control" name="password" id="password" type="password" placeholder="" />
                            <span class="lighting"></span>
                        </div>
                        <div class="input-group">
                            <label class="palceholder" for="repassword">Re-enter password</label>
                            <input class="form-control" name="repassword" id="repassword" type="password" placeholder="" />
                            <span class="lighting"></span>
                        </div>

                        <div class="input-group gender_container">
                            <input type='radio' id='male' value="Male" checked='checked' name='gender'>
                            <label for='male'>Male</label>
                            <input type='radio' id='female' value="Female" name='gender'>
                            <label for='female'>Female</label>
                        </div>

                        <div class="input-group">
                            <input class="form-control" name="birthdate" id="birthdate" type="date"/>
                            <span class="lighting"></span>
                        </div>




                        <select id="mainclass" name="mainclass" class="input-group" required="required">
                            <%
                                ClassDAO dao = new ClassDAO();
                                ResultSet rs = dao.getClassByCurriculum(request.getParameter("major") != null ? request.getParameter("major") : "SE");
                                while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("name")%>"><%= rs.getString("name")%></option>
                            <%
                                }
                            %>
                        </select>

                        <button type="submit" id="login">Sign up</button>

                    </form>
                </div>
                <div class="signup-wrapper text-center">
                    <a href="/login">Already a user? <span class="text-primary">Log in</span></a>
                </div>
                <div class="signup-wrapper text-center">
                    <a href="/">Back to home screen</a>
                </div>
            </div>


        </div>
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
