<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="${PATH}static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<h3>登录成功，欢迎：<h1><%=request.getSession().getAttribute("userName")%></h1></h3>

</body>
</html>