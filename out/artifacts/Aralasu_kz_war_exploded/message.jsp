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
            <form action="/AddMessage" method="post">
            <div class="jumbotron text-center p-3 mt-3 border" style="background-color: white">
            <%
                ArrayList<Message> messages =(ArrayList<Message>) request.getAttribute("messages");
                    if(messages!=null){
                        for (Message m :messages){
            %>

                <div class="row">
                    <div class="col-md-3">
                        <div class="avatar mx-auto white mt-3"><img src="<%=m.getSender_user().getPicture_url()%>" alt="avatar mx-auto white " class="rounded-circle img-fluid"style="width: 100px;height: 70px">
                        </div>
                    </div>
                    <div class="col-md-7 text-md-left  mt-3">
                        <div class="d-flex justify-content-between">
                            <p class=" mr-3" style="font-size: 18px;font-weight: bold"><a href="/User?uid=<%=m.getSender_user().getId()%>" style="text-decoration: none;color: black"><%=m.getSender_user().getFull_name()%></a></p>
                            <p  style="font-size: 10px;"><%=m.getSent_date()%></p>
                        </div>
                        <p class="card-text"><a  style="text-decoration: none;color: black"><%=m.getMessage_text()%></a></p>
                    </div>
                </div>

                <input type="hidden" name="chatId" value="<%=m.getChat().getId()%>">

                <%if(m.getUser().getId()==userOnline.getId()){

                %>
                <input type="hidden" name="userId" value="<%=m.getSender_user().getId()%>">
                <%
                    }
                        else{
                %>
                <input type="hidden" name="userId" value="<%=m.getUser().getId()%>">
        <%
                        }
                    }
            }
    %>

            </div>
                <div class="jumbotron text-center p-3">

                    <div class="row">
                        <div class="col-md-9 text-md-left ml-2">
                            <!-- Search form -->
                            <input class="form-control" type="text" placeholder="Send Message" aria-label="Search" name="message">
                        </div>
                        <button class="btn btn-outline-success btn-rounded btn-sm my-0" type="submit"><i class="fas fa-plane" aria-hidden="true"></i>
                            Send</button>
                    </div>
                </div>
            </form>


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
