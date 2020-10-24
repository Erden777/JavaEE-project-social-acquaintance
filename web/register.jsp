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
    <%@include file="vender/includes/head.jsp"%>
    <title>Title</title>
</head>
<body>
<%@include file="vender/includes/navbar.jsp"%>
<div class="container mt-lg-4">
    <% String alert = (String)request.getParameter("error");


    if(alert!=null){
    %>

    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Please enter correct password!
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <%}%>

    <!-- Default form register -->
    <form class="text-center border border-light p-5" action="/register" method="post">

        <p class="h4 mb-4">Sign up</p>

        <div class="form-row mb-4">
                <!-- Email address -->
                <input type="email" name="email" class="form-control mb-4" placeholder="E-mail">
            <!-- Password -->
            <input type="password" name="password" class="form-control" placeholder="Password" aria-describedby="defaultRegisterFormPasswordHelpBlock">
            <small id="defaultRegisterFormPasswordHelpBlock" class="form-text text-muted mb-4">
                At least 8 characters and 1 digit
            </small>

            <!-- Password -->
            <input type="password" name="repassword" class="form-control" placeholder="Password" aria-describedby="defaultRegisterFormPasswordHelpBlock">
            <small id="RedefaultRegisterFormPasswordHelpBlock" class="form-text text-muted mb-4">
                At least 8 characters and 1 digit
            </small>

                <!-- Full name -->
                <input type="text" name="fullname" class="form-control" placeholder="Full name">
            <small  class="form-text text-muted mb-4">
               Input yout own name
            </small>


        <!-- birthdate -->
        <input type="date" name="date" class="form-control" placeholder="Phone number" aria-describedby="defaultRegisterFormPhoneHelpBlock">
        <small id="defaultRegisterFormPhoneHelpBlock" class="form-text text-muted mb-4">
           Input your birthdate
        </small>
        </div>
        <!-- Sign up button -->
        <button class="btn btn-info my-4 btn-block" type="submit">Sign in</button>

        <!-- Social register -->
        <p>or sign up with:</p>

        <a href="#" class="mx-2" role="button"><i class="fab fa-facebook-f light-blue-text"></i></a>
        <a href="#" class="mx-2" role="button"><i class="fab fa-twitter light-blue-text"></i></a>
        <a href="#" class="mx-2" role="button"><i class="fab fa-linkedin-in light-blue-text"></i></a>
        <a href="#" class="mx-2" role="button"><i class="fab fa-github light-blue-text"></i></a>

        <hr>

        <!-- Terms of service -->
        <p>By clicking
            <em>Sign up</em> you agree to our
            <a href="" target="_blank">terms of service</a>
    </form>
    <!-- Default form register -->
</div>
</body>
</html>
