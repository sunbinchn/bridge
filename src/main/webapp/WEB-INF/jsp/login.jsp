<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    //The path starts with a "/" character but does not end with a "/"
    pageContext.setAttribute("PATH", request.getContextPath() + "/");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>桥梁监测系统-登录页</title>
    <script type="text/javascript" src="${PATH}static/js/jquery-2.0.3.min.js"></script>
    <link href="${PATH}static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${PATH}static/css/signin.css" rel="stylesheet">
    <script src="${PATH}static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script src="${PATH}static/js/login/login.js"></script>
</head>
<body style="background:url(${PATH}static/images/bg_1.jpg) top center no-repeat; background-size:cover;">
<div class="container" style="margin-top: 300px;">
    <form class="form-signin" method="post" onsubmit="return;">
        <h1>桥梁监测系统</h1>
        <h5 class="form-signin-heading" style="color: red;"></h5>
        <input type="text" id="username" class="form-control" placeholder="用户名" required autofocus>
        <input type="password" id="password" class="form-control" placeholder="密码" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit" id="submit">登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</button>
    </form>

</div>

</body>
</html>
