<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="db.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="vender/tinymce/tinymce.min.js" referrerpolicy="origin"></script>
    <script>tinymce.init({selector:'textarea'});</script>
    <%@include file="vender/includes/head.jsp"%>
</head>
<body>
<%@include file="vender/includes/navbar.jsp"%>
<div class="container mt-5">

    <%
        ArrayList<Post> posts = (ArrayList<Post>)request.getAttribute("posts");
        ArrayList<Friend> friends = (ArrayList<Friend>)request.getAttribute("friends");
        ArrayList<Request> requests = (ArrayList<Request>)request.getAttribute("requests");
        User user = (User) request.getAttribute("user");
        LocalDate date = LocalDate.parse(user.getBirth_date());
        LocalDate currentdate = LocalDate.now();
        long years = ChronoUnit.YEARS.between(date, currentdate);

    %>

    <div class="row">
        <div class="col-md-3">
            <!--Section: Group of personal cards-->
            <section class=" pb-3">
                <!--Grid row-->
                <div class="row">
                    <!--Grid column-->
                    <div class="col-md-12 mt-lg-3">
                        <!--Card group-->
                        <div class="card-group hoverable">
                            <!--Card-->
                            <div class="card card-personal mb-4">
                                <!--Card image-->
                                <div class="view">
                                    <img class="card-img-top" src="<%=user.getPicture_url()%>" alt="Card image cap">
                                    <a href="#!">
                                        <div class="mask rgba-white-slight"></div>
                                    </a>
                                </div>
                                <!--Card image-->

                                <!--Card content-->
                                <div class="card-body">
                                    <!--Title-->
                                    <a>
                                        <h5 class="card-title"><%=user.getFull_name()%> ,<%=years%> years</h5>
                                    </a>
                                    <div class="list-group">
                                        <% if(friends!=null){
                                            boolean t = false;
                                            for (Friend f : friends) {
                                                if(f.getFriend().getId()==user.getId()){
                                                    t=true;

                                        %>
                                        <a style="color: #a71d2a;" class="list-group-item" href="/UserEdit?remove=<%=user.getId()%>"><i class="fas fa-minus-circle" aria-hidden="true"></i>&nbsp; Remove from friends</a>

                                        <%
                                                   }
                                                }
                                            if(!t){
                                                boolean k =false;
                                                for(Request r : requests){
                                                    if(user.getId()==r.getUser().getId()){
                                                        k=true;

                                        %>
                                        <a style="color: green" class="list-group-item" href="/UserEdit?request_id=<%=r.getId()%>&uid=<%=user.getId()%>"><i class="fas fa-check-circle" aria-hidden="true"></i>&nbsp; Request Sended</a>
                                        <%
                                                    }
                                                    else if(user.getId()==r.getReq_sender_user().getId()){
                                                        k=true;
                                        %>
                                        <a class="list-group-item" href="/UserEdit?confirm=<%=r.getReq_sender_user().getId()%>"><i class="fas fa-plus-circle" aria-hidden="true"></i>&nbsp; Confirm</a>
                                        <a style="color: #a71d2a;" class="list-group-item" href="/UserEdit?reject=<%=r.getId()%>&uid=<%=user.getId()%>"><i class="fas fa-plus-circle" aria-hidden="true"></i>&nbsp; Reject</a>
                                        <%
                                                }
                                            }
                                            if(!k){

                                        %>
                                        <a class="list-group-item" href="/UserEdit?addfriend=<%=user.getId()%>"><i class="fas fa-plus-circle" aria-hidden="true"></i>&nbsp; Add to friend</a>

                                        <%
                                            }
                                            }
                                        %>

                                        <button type="button" style="color: #00b0ff; padding: 12px 1px;" class="list-group-item" data-toggle="modal" data-target="#centralModalSm<%=user.getId()%>"><i class="fas fa-paper-plane" aria-hidden="true">  </i>
                                            Send Message
                                        </button>

                                        <!-- Central Modal Small -->
                                        <div class="modal fade" id="centralModalSm<%=user.getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                                             aria-hidden="true">


                                            <div class="modal-dialog modal-lg" role="document">

                                                <form method="post" action="AddMessage">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title w-100 h4"  id="myModalLabel">Send Message to <%=user.getFull_name()%></h4>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="form-group">
                                                                <textarea  class="form-control" rows="6" name="message"></textarea>
                                                                <input type="hidden" name="userId" value="<%=user.getId()%>">
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
                                        <%


                                            }
                                        %>
                                        <a class="list-group-item" style="color: #a71d2a" href="/logout"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp; Logout</a>
                                    </div>
                                    <hr>
                                    <!-- <a class="card-meta"><span><i class="fas fa-user"></i>83 Friends</span></a>
                                     <p class="card-meta float-right">Joined in 2012</p>
                                     -->
                                </div>
                            </div>
                            <!--Card content-->

                        </div>
                        <!--Card group-->

                    </div>
                    <!--Grid column-->

                </div>
                <!--Grid row-->

            </section>
            <!--Section: Group of personal cards-->

        </div>
        <div class="col-md-6">
            <% if(posts!=null){
                for(Post p :posts){
            %>
            <!-- News jumbotron -->
            <div class="jumbotron text-center hoverable p-4 mt-4">
                <div class="row">
                    <div class="col-md-12 text-md-left ml-3 mt-3">
                        <a href="#!" class="green-text">
                            <h6 class="h6 pb-1"><i class="fas fa-desktop pr-1"></i> Work</h6>
                        </a>
                        <h4 class="h4 mb-4"><%=p.getTitle()%></h4>
                        <p class="font-weight-normal"><%=p.getShort_content()%></p>
                        <p class="font-weight-normal">by <a><strong><%=p.getUser().getFull_name()%></strong></a>, <%=p.getPost_date()%></p>
                        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#viewpost<%=p.getId()%>">
                            Read more
                        </button>
                    </div>
                </div>
            </div>


            <!-- Central Modal Small -->
            <div class="modal fade" id="viewpost<%=p.getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1"
                 aria-hidden="true">
                <!-- Change class .modal-sm to change the size of the modal -->
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title w-100" id="myModalLabel1">View</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Title</label>
                                <input type="text" class="form-control" name="title" value="<%=p.getTitle()%>" readonly>
                            </div>
                            <div class="form-group">
                                <label><h3>Short content</h3></label>
                                <p><%=p.getShort_content()%></p>
                            </div>
                            <div class="form-group">
                                <label><h2>Content</h2></label>
                                <p><%=p.getContent()%></p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Central Modal Small -->


            <%}
            }%>

        </div>

        <div class="col-md-3 mt-3">
            <div class="card bg-light mb-3" style="max-width: 18rem;">
                <div class="card-header"style="background-color: #159BB1;color: white;font-weight: bold">Latest birthdays</div>
                <div class="card-body">
                    <p class="card-text">Apple, tomorrow</p>
                    <p class="card-text">Toyota, 09 October</p>
                    <p class="card-text">BMW, 10 October</p>
                </div>
            </div>
            <div class="card bg-light mb-3" style="max-width: 18rem;">
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
</body>
</html>
