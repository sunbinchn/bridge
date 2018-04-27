<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <%--<img src="/bridge/static/images/logo.png" alt="logo">--%>
            <a class="navbar-brand" href="/bridge/monitorInfoData/getAll" style="color: mediumseagreen;font-family: cursive;">桥梁监测系统</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">${userName} <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/bridge/userInfo/index">个人信息</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="/bridge/login/logOut">退出登录</a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
