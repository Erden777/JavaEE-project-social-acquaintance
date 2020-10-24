<%@include file="user.jsp"%>
<nav class="mb-1 navbar navbar-expand-md navbar-dark info-color fixed-top">
    <a class="navbar-brand" href="/home">Aralasu.kz </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-4"
            aria-controls="navbarSupportedContent-4" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent-4">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">
                    <i class="fab fa-facebook-f"></i> Facebook
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fab fa-instagram"></i> Instagram</a>
            </li>
            <%if(ONLINE){
            %>
            <%if
            (newMessage==0){
            %>
            <li class="nav-item">
                <a class="nav-link" href="/message">
                    <i class="fab fa-telegram-plane text-white">  </i>Messages</a>
            </li>
            <%
                }else{
            %>
            <li class="nav-item">
                <a class="nav-link" href="/message">
                    <i class="fab fa-telegram-plane text-white">  </i>Messages(<%=newMessage%>)</a>
            </li>
            <%
                }
            %>
            <li class="nav-item">
                <a class="nav-link" href="/Myfriend">
                    <i class="fas fa-user-friends" aria-hidden="true"></i> My friends</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="/mypost">
                    <i class="fas fa-blog fa-fw" aria-hidden="true"></i>  My posts</a>
            </li>


            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-4" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-user"></i> Profile </a>
                <div class="dropdown-menu dropdown-menu-right  dropdown-info" aria-labelledby="navbarDropdownMenuLink-4">
                    <a class="dropdown-item" href="/home">Wellcome <%=userOnline.getFull_name()%></a>
                    <a class="dropdown-item" href="/logout">Log out</a>
                </div>
            </li>
            <%}%>

        </ul>
    </div>
</nav>
<!--/.Navbar -->