<%@ page import="db.User" %>

<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
      <section class=" pb-3">
        <!--Grid row-->
        <div class="row">
          <!--Grid column-->
          <div class="col-md-12">
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
                    <a class="list-group-item" href="/home"><i class="fa fa-home fa-fw" aria-hidden="true"></i>&nbsp; My profile</a>
                    <a class="list-group-item" href="#"><i class="fa fa-cog fa-fw" aria-hidden="true"></i>&nbsp; Settings</a>
                    <a class="list-group-item" style="color: #a71d2a" href="/logout"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp; Logout</a>
                  </div>
                  <hr>

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
      <% String alert = (String)request.getParameter("error");
        String success = (String) request.getParameter("success");
        String newPassword = (String) request.getParameter("IncorrectnewPassword");
        String  oldPasword = (String) request.getParameter("Incorrectoldpassword");

        if(alert!=null){
      %>

      <div class="alert alert-danger alert-dismissible fade show" role="alert">
          Error!
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <%}
      if(success!=null){

      %>
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        Success!!!
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <%}if(newPassword!=null){

      %>
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Incorrect new password!
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <%}if(oldPasword!=null){

      %>
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        Incorrect old password!
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <%}%>


      <div >
        <h1>
          Edit Profile
        </h1>
      </div>
      <form action="/edit" method="post">
        <div class="form-group mt-4">
          <label >Email address</label>
          <input type="email" class="form-control" placeholder="email@gmail.com" name="email" value="<%=userOnline.getEmail()%>" readonly>
        </div>

        <div class="form-group mt-4">
          <label >Full Name</label>
          <input type="text" class="form-control"  name="full_name" value="<%=userOnline.getFull_name()%>">
        </div>

        <div class="form-group mt-4 mb-4">
          <label >Birthdate</label>
          <input type="date" class="form-control"   name="birth_date" value="<%=userOnline.getBirth_date()%>">
        </div>
        <button type="submit" class="btn"style="background-color: #180B7A;color: white" name="editProfile">Update Profile</button>
      </form>

      <div class="mt-5 ">
        <h1>
          Edit Picture
        </h1>
        <form action="/edit" method="post">
          <div class="form-group mt-4 mb-4">
            <label >Picture URL:</label>
            <input type="text" class="form-control"   name="picture_url"  value="<%=userOnline.getPicture_url()%>">
          </div>
          <button type="submit" class="btn"style="background-color: #180B7A;color: white"name="editPicture">Update Picture</button>
        </form>
      </div>

      <div class="mt-5 ">
        <h1>
          Update Password
        </h1>
        <form action="/edit" method="post">
          <div class="form-group mt-4">
            <label >Old Password</label>
            <input type="password" class="form-control"  name="OldPassword">
          </div>

          <div class="form-group mt-4">
            <label >New Password</label>
            <input type="password" class="form-control"   name="NewPassword">
          </div>

          <div class="form-group mt-4">
            <label >Re-New Password</label>
            <input type="password" class="form-control"   name="ReNewPassword">
          </div>
          <button type="submit" class="btn"style="background-color: #180B7A;color: white"name="editPassword">Update Password</button>
        </form>

      </div>

    </div>

    <div class="col-md-3">
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
