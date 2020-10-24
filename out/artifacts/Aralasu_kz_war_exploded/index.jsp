<%@ page import="db.User" %>
<%@ page import="db.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 04.10.2020
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
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
    LocalDate date = LocalDate.parse(userOnline.getBirth_date());
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
                    <a class="list-group-item" href="#"><i class="fas fa-blog fa-fw" aria-hidden="true"></i>  My posts</a>
                    <a class="list-group-item" href="/edit"><i class="fa fa-cog fa-fw" aria-hidden="true"></i>&nbsp; Settings</a>
                    <a class="list-group-item" href="/logout"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp; Logout</a>
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
    <div class="col-md-7">
      <!-- Button trigger modal -->
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addpost">
        + Add New
      </button>



      <% if(posts!=null){
        for(Post p :posts){
      %>
      <!-- News jumbotron -->
      <div class="jumbotron text-center p-4">
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
      <!-- News jumbotron -->


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
              <button type="submit" class="btn btn-primary btn-sm">Save changes</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Central Modal Small -->


      <%}
      }%>


      <!-- Central Modal Small -->
      <form action="addpost" method="post">
        <div class="modal fade" id="addpost" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">

          <!-- Change class .modal-sm to change the size of the modal -->
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h4 class="modal-title w-100" id="myModalLabel">Add post</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="form-group">
                  <label>Title</label>
                  <input type="text" class="form-control" name="title">
                </div>
                <div class="form-group">
                  <label>Short content</label>
                  <textarea name="short_content"></textarea>
                </div>
                <div class="form-group">
                  <label>Content</label>
                  <textarea name="content"></textarea>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary btn-sm">Save changes</button>
              </div>
            </div>
          </div>
        </div>
      </form>
      <!-- Central Modal Small -->





    </div>

    <div class="col-md-2">sdfsfdsfds</div>
  </div>

</div>
</body>
</html>
