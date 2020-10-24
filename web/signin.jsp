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
<div class="container mt-5">
    <% String alert = (String)request.getParameter("error");
    String email = (String) request.getAttribute("email");
    String password = (String) request.getAttribute("password");
        if(alert!=null){
    %>

    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Please enter correct email or password!
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <%}%>

    <!-- Default form login -->
    <form class="text-center border border-light p-5" action="/signin" method="post">

        <p class="h4 mb-4">Sign in</p>
        <!-- Email -->
        <input type="email"  name = "email" class="form-control mb-4" placeholder="E-mail" value="<%=email%>">

        <!-- Password -->
        <input type="password" name="password" class="form-control mb-4" placeholder="Password" value="<%=password%>">

        <div class="d-flex justify-content-around">
            <div>
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="defaultLoginFormRemember" name="remember">
                    <label class="custom-control-label" for="defaultLoginFormRemember">Remember me</label>
                </div>
            </div>
        </div>


        <!-- Sign in button -->
        <button class="btn btn-info btn-block my-4" type="submit">Sign in</button>

        <!-- Register -->
        <p>Not a member?
            <a href="/register">Register</a>
        </p>

        <!-- Social login -->
        <p>or sign in with:</p>

        <a href="#" class="mx-2" role="button"><i class="fab fa-facebook-f light-blue-text"></i></a>
        <a href="#" class="mx-2" role="button"><i class="fab fa-twitter light-blue-text"></i></a>
        <a href="#" class="mx-2" role="button"><i class="fab fa-linkedin-in light-blue-text"></i></a>
        <a href="#" class="mx-2" role="button"><i class="fab fa-github light-blue-text"></i></a>

    </form>
    <!-- Default form login -->
</div>
</body>
</html>
