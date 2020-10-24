<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.*" %>

<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 04.10.2020
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
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
            <%  ArrayList<Request> requests =(ArrayList<Request>) request.getAttribute("requests");
                ArrayList<Friend> friends = (ArrayList<Friend>) request.getAttribute("friends");
                long old;
                if(requests.size()>0){
            %>
            <nav class="navbar navbar-expand-lg navbar-light bg-light border mt-3">
                <div class="collapse navbar-collapse" >
                    <h4 class="h4" style="text-align: center">You have <%=requests.size()%> new requests</h4>
                </div>
            </nav>
            <div class="jumbotron text-center p-3">
                <% for(Request r : requests){
                    LocalDate dateUser = LocalDate.parse(r.getReq_sender_user().getBirth_date());
                    old = ChronoUnit.YEARS.between(dateUser, currentdate);
                %>
                <form method="post" action="/friends">
                <div class="row">
                    <div class="col-md-3 mt-3">
                        <div class="avatar mx-auto white"><img src="<%=r.getReq_sender_user().getPicture_url()%>"
                                                               alt="avatar mx-auto white" class="rounded-circle img-fluid">
                        </div>
                    </div>
                    <div class="col-md-8 text-md-left ml-3 mt-2">
                        <h4 class="h4"><a href="/User?uid=<%=r.getReq_sender_user().getId()%>"><strong><%=r.getReq_sender_user().getFull_name()%></strong></a></h4>
                        <p class="font-weight-normal"><%=old%> years</p>
                        <input type="hidden" name="request_id" value="<%=r.getId()%>">
                        <button name="confirm" value="<%=r.getReq_sender_user().getId()%>"><i class="fas fa-plus-circle"></i> Confirm</button>
                        <button name="reject" value="<%=r.getId()%>"><i class="fas fa-trash-alt"></i> Reject</button>
                    </div>
                </div>
                </form>
                <%}%>
            </div>


            <%}

                if(friends!=null){
                    for (Friend f : friends) {
                            LocalDate dateUser = LocalDate.parse(f.getFriend().getBirth_date());
                            old = ChronoUnit.YEARS.between(dateUser, currentdate);
            %>

            <div class="jumbotron text-center p-3">
                <div class="row">
                    <div class="col-md-3 mt-3">
                        <div class="avatar mx-auto white"><img src="<%=f.getFriend().getPicture_url()%>"
                                                               alt="avatar mx-auto white" class="rounded-circle img-fluid">
                        </div>
                    </div>
                    <div class="col-md-8 text-md-left ml-3 mt-2">
                        <h4 class="h4"><a href="/User?uid=<%=f.getFriend().getId()%>"><strong><%=f.getFriend().getFull_name()%></strong></a></h4>
                        <p class="font-weight-normal"><%=old%> years</p>
                        <form method="post" >
                            <input type="hidden" name="userid" value="<%=f.getFriend().getId()%>">
                            <button type="button" class="btn-white" data-toggle="modal" data-target="#centralModalSm<%=f.getFriend().getId()%>"><i class="fas fa-paper-plane" aria-hidden="true">  </i>
                                Send Message
                            </button>
                        </form>
                    </div>
                </div>
            </div>


            <!-- Central Modal Small -->
            <div class="modal fade" id="centralModalSm<%=f.getFriend().getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">


                <div class="modal-dialog modal-lg" role="document">

                    <form method="post" action="AddMessage">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title w-100 h4"  id="myModalLabel">Send Message to <%=f.getFriend().getFull_name()%></h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <textarea  class="form-control" rows="6" name="message"></textarea>
                                <input type="hidden" name="userId" value="<%=f.getFriend().getId()%>">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-success btn-sm">Send</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
            <%}
            }
            %>
        </div>

<!--
        <div class="jumbotron text-center p-3">
            <div class="row">
                <div class="col-md-3 mt-3">
                    <div class="avatar mx-auto white"><img src="u.getPicture_url()%>"
                                                           alt="avatar mx-auto white" class="rounded-circle img-fluid">
                    </div>
                </div>
                <div class="col-md-8 text-md-left ml-3 mt-2">
                    <h4 class="h4">u.getFull_name()%></h4>
                    <p class="font-weight-normal">old%> years</p>
                    <button type="button" class="btn-white" ><i class="fas fa-paper-plane" aria-hidden="true">  </i>
                        Send Message
                    </button>
                </div>
            </div>
        </div>
        -->


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
