<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="vender/css/style.css">
    <%@include file="vender/includes/head.jsp"%>
</head>
<body>
<%@include file="vender/includes/navbar.jsp"%>
<div class="container mt-5">

    <%
        LocalDate date = LocalDate.parse(userOnline.getBirth_date());
        LocalDate currentdate = LocalDate.now();
        long years = ChronoUnit.YEARS.between(date, currentdate);

    %>
    <div class="row">
        <div class="col-md-3">
            <!--Section: Group of personal cards-->
            <section class="pb-3 position-fixed">
                <!--Grid row-->
                <div class="row">
                    <!--Grid column-->
                    <div class="col-md-12 mt-lg-3">
                        <!--Card group-->
                        <div class="card-group">
                            <!--Card-->
                            <div class="card card-personal mb-4">
                                <!--Card image-->
                                <div class="view">
                                    <img class="card-img-top" src="<%=userOnline.getPicture_url()%>" alt="Card image cap">
                                    <a href="#!">
                                        <div class="mask rgba-white-slight"></div>
                                    </a>
                                </div>
                                <!--Card image-->

                                <!--Card content-->
                                <div class="card-body">
                                    <!--Title-->
                                    <a>
                                        <h5 class="card-title"><%=userOnline.getFull_name()%> ,<%=years%> years</h5>
                                    </a>
                                    <div class="list-group">
                                        <a class="list-group-item" href="#"><i class="fa fa-home fa-fw" aria-hidden="true"></i>&nbsp; My profile</a>
                                        <a class="list-group-item" href="/edit"><i class="fa fa-cog fa-fw" aria-hidden="true"></i>&nbsp; Settings</a>
                                        <a class="list-group-item" style="color: #a71d2a" href="/logout"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp; Logout</a>
                                    </div>
                                    <hr>
                                    <a class="card-meta"><span><i class="fas fa-user"></i>83 Friends</span></a>
                                    <p class="card-meta float-right">Joined in 2012</p>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </div>

        <div class="col-md-6 mt-4">

            <div class="jumbotron text-center p-3">
                <form method="get" action="friends">
                    <div class="row">

                        <div class="col-md-9 text-md-left ml-2">
                            <!-- Search form -->
                            <input class="form-control" type="text" placeholder="Search" aria-label="Search" name="search">
                        </div>
                        <button class="btn btn-outline-success btn-rounded btn-sm my-0" type="submit"><i class="fas fa-search" aria-hidden="true"></i>
                            Search</button>
                    </div>
                </form>
            </div>

            <%
                ArrayList<Chat> chats = (ArrayList<Chat>)request.getAttribute("chats");
                ArrayList<Message> newMessages = (ArrayList<Message>)request.getAttribute("newMessages");
                if(chats!=null){
                    for(Chat c:chats){
            %>
            <div class="card mb-3 mt-3" style="max-width: 100%;">
                <div class="row no-gutters">
                    <div class="col-md-3 pt-3 pl-4 pb-3">
                        <a href="/user_page?user_id=<%=c.getOpponent().getId()%>"><img src="<%=c.getOpponent().getPicture_url()%>" class="rounded-circle" alt="..." width="100" height="100"></a>
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <%
                                    boolean t= false;
                                    for(Message m : newMessages){
                                        if(c.getId()==m.getChat().getId()){
                                            t = true;
                                %>
                                <h5 class="card-title h3"><a href="/dialog?chatId=<%=c.getId()%>">**<%=c.getOpponent().getFull_name()%>**</a></h5>
                                <%
                                        break;
                                    }
                                    }
                                    if(!t){
                                %>
                                <h5 class="card-title"><a href="/dialog?chatId=<%=c.getId()%>"><%=c.getOpponent().getFull_name()%></a></h5>
                                <%
                                    }
                                %>
                                <p class="card-text"><small class="text-muted"><%=c.getLates_message_time()%></small></p>
                            </div>
                            <p class="card-text mt-3"><small class="text-muted"><%=c.getLatest_message_text()%></small></p>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>



        <div class="col-md-3 mt-3">
            <div class="col-md-3 position-fixed">
                <div class="card bg-light mb-3 " style="max-width: 18rem;">
                    <div class="card-header"style="background-color: #159BB1;color: white;font-weight: bold">Latest birthdays</div>
                    <div class="card-body">
                        <p class="card-text">Apple, tomorrow</p>
                        <p class="card-text">Toyota, 09 October</p>
                        <p class="card-text">BMW, 10 October</p>
                    </div>
                </div>
                <div class="card bg-light mb-3 " style="max-width: 18rem;">
                    <div class="card-header"style="background-color: #159BB1;color: white;font-weight: bold">My games</div>
                    <div class="card-body">
                        <p class="card-text"style="font-weight: bold;color: #180B7A">Basketball ONLINE</p>
                        <p class="card-text"style="font-weight: bold;color: #180B7A">Chess ONLINE</p>
                        <p class="card-text"style="font-weight: bold;color: #180B7A">Final ONLINE</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
