<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.MessageDAO"%>
<%@page import="com.models.Role"%>
<%@page import="com.models.Curriculum"%>
<%@page import="com.daos.CurriculumDAO"%>
<%@page import="com.models.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.daos.CategoryDAO"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer"
      />

<%

    CategoryDAO cateDAO = new CategoryDAO();
    List<Category> ctgires = cateDAO.getAllCategory();

    CurriculumDAO curd = new CurriculumDAO();
    List<Curriculum> currs = curd.getListCurriculum();

%>
<div class="sidebar">
    <div class="hdn-head">
        <h2>Hello, <%= (user != null) ? user.getFirst_name() : "Guest"%></h2>
    </div>
    <div class="hdn-content">
        <h3>Book for majors</h3>
        <ul>
            <%
                for (Curriculum curr : currs) {
            %>
            <a href="/curriculum?code=<%= curr.getCode()%>">
                <div>
                    <li>
                        <%= curr.getName()%>

                    </li>
                </div>
            </a>

            <%
                }
            %>


        </ul>
        <div class="line"></div>
    </div>
    <div class="hdn-content">
        <h3>Read by Category</h3>
        <ul>
            <%
                for (Category category : ctgires) {
            %>
            <a href="/category?id=<%= category.getId()%>">
                <div>
                    <li>
                        <%= category.getName()%>

                    </li>
                </div>
            </a>

            <%
                }
            %>


        </ul>
        <div class="line"></div>
    </div>

</div>
<i class="fa-solid fa-xmark"></i>
<div class="triangle"></div>
<div class="hdn-sign">
    <div class="hdn-auth" style="display: <%= (user == null) ? "flex" : "none"%>;">
        <a href="/login">
            <button>Sign In</button>
        </a>
        <div>
            <span>New user?</span>
            <a href="/sign-up">Start now.</a>
        </div>
    </div>

    <div class="hdn-auth" style="display: <%= (user != null) ? "flex" : "none"%>;">
        <a href="/user-logout" >
            <button >Log out</button>
        </a>

    </div>
    <div class="hdn-table">
        <div>
            <h3>Your account</h3>
<!--            <ul>
                <li>Favorite</li>
                <li>Change information</li>

            </ul>-->
        </div>
        <div class="hdn-line"></div>
        <div>
            <h3>Help Center</h3>
            <%
                MessageDAO msdao = new MessageDAO();
                int count = 0;
                ResultSet rss = null;
                if (user != null) {
                    rss = msdao.getAllForUser(user.getRoll_number());
                    while (rss.next()) {
                        count++;
                    }
                }

            %>
            <ul>
                <a href="/admin_message"><li>Admin message(<%= count%>)</li></a>
                <a href="/send_message"><li>Send message to admin</li></a>

            </ul>
        </div>
    </div>
</div>
<div class="black"></div>
<header class="navbar">
    <div class="first">
        <div class="flex logo">
            <a href="/"> <img src="https://cdn.haitrieu.com/wp-content/uploads/2021/10/Logo-Dai-hoc-FPT.png"
                              alt=""></a>
                <%
                    if (user != null) {
                        if (user.getRole() == Role.ADMIN) {
                %>
            <a href="/admin">
                <div class="map flex">
                    <i class="fas fa-user-circle "></i>
                    <div>
                        <span>Admin</span>
                        <span>Manage</span>
                    </div>
                </div>
            </a>
            <%
                    }
                }
            %>


        </div>
        <div class="flex input">

            <input id="search" style="padding-left: 20px;" type="text">
            <i class="fas fa-search"></i>

        </div>
        <div class="flex right">

            <div class="sign">
                <span>Hello, <%= (user != null) ? user.getFirst_name() : "Guest"%></span>
                <div class="flex ac">
                    <span>Account & Lists</span>
                    <i class="fas fa-caret-down"></i>
                </div>
            </div>
            <a href="/borrow-history/request">
                <div class="sign">
                    <span>Returns</span>
                    <span>& Borrow</span>
                </div>
            </a>

            <a href="/book-list">
                <div onclick="" class="flex cart">
                    <i class="fas fa-list-ul"></i>
                    <span class="ca">&nbsp;List</span>
                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= book_list == null ? 0 : book_list.size()%></p>
                </div>
            </a>

        </div>
    </div>
    <div class="second">
        <div class="second-1">
            <div>
                <i class="fas fa-bars"></i>
                <span>All</span>
            </div>
        </div>
        <div class="second-2">
            <ul>
                <a style="color:white;" href="/leaderboard"><li>Leaderboard</li></a>  
            </ul>
        </div>

    </div>
</header>
<script>
    let search = document.querySelector("#search");

    search.addEventListener("keydown", function (event) {
        if (event.keyCode == '13') {
            window.location = "/?search=" + this.value;
        }
    });



    function getSearchValue() {
        return document.querySelector("#search").value()
    }
    const sidebtn = document.querySelector(".second-1");
    const hdnelmnt = document.querySelector(".hdn-elmnt");
    const cross = document.querySelector(".fa-xmark");
    const sidebar = document.querySelector(".sidebar");
    const black = document.querySelector(".black");
    const sign = document.querySelector(".ac");
    const tri = document.querySelector(".triangle");
    const signin = document.querySelector(".hdn-sign");


    sidebtn.addEventListener("click", () => {
        console.log("dadsds")
        sidebar.classList.add("active");
        cross.classList.add("active");
        black.classList.add("active");
        document.body.classList.add("stop-scroll");

    });

    cross.addEventListener("click", () => {
        sidebar.classList.remove("active");
        cross.classList.remove("active");
        black.classList.remove("active");
        document.body.classList.remove("stop-scroll");
    })

    sign.addEventListener("mouseover", () => {
        black.classList.toggle("active-1");
        signin.classList.toggle("active");
        tri.classList.toggle("active");
        document.body.classList.toggle("stop-scroll");
    })
</script>