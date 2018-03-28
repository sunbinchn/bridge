<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-个人信息</title>
    <%@ include file="common.jsp" %>
    <script src="${PATH}static/js/baseUserInfo.js"></script>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <div class="col-sm-10">
            <ul class="nav nav-tabs">
                <li role="presentation" class="active" id="baseInfoLi"><a href="">基本信息</a></li>
                <li role="presentation" id="passwordLi"><a href="">密码</a></li>
            </ul>
        </div>
        <!-- 右侧内容栏 -->
        <div class="col-sm-10">
            <!-- 更改基本信息form -->
            <form method="post" onsubmit="return;" class="form-horizontal" role="form" id="updateUserInfoForm">
                <fieldset>
                    <div class="form-group">
                        <div id="userInfoUpdateSuccess" class="alert  alert-success col-sm-offset-2 col-sm-4 alert-dismissible" role="alert" style="margin-bottom: 0px;display: none">
                            <button id="userInfoUpdateSuccessClose" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>更新成功!</strong>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="userName">用户名：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="userName" name="userName" type="text"
                                   value="${user.userName}"
                                   disabled="disabled"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="nickName">真实姓名：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="nickName" name="nickName" type="text"
                                   value="${user.nickName}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="phone">电话：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="phone" name="phone" type="text" value="${user.phone}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="email">邮箱：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="email" name="email" type="email" value="${user.email}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="remark">备注：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="remark" name="remark" type="text" value="${user.remark}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="col-sm-offset-3 btn btn-primary" style="width: 100px;"
                                id="baseInfoSubmitButton">确认
                        </button>
                    </div>
                </fieldset>
            </form>
            <!-- 更改密码form -->
            <form method="post" onsubmit="return;" class="form-horizontal" role="form" style="display: none"
                  id="updateUserPasswordForm">
                <fieldset>
                    <div class="form-group">
                        <div id="userPasswordUpdateSuccess" class="alert  alert-success col-sm-offset-2 col-sm-4 alert-dismissible" role="alert" style="margin-bottom: 0px;display: none">
                            <button id="userPasswordUpdateSuccessClose" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>更新成功!</strong>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 col-sm-offset-2" style="color: red" id="error-update-password"></label>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="userName2">用户名：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="userName2" type="text" value="${user.userName}"
                                   disabled="disabled"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="oldPassword">原密码：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="oldPassword" name="oldPassword" type="password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="newPassword1">新密码：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="newPassword1" name="newPassword1" type="password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="newPassword2">确认新密码：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="newPassword2" name="newPassword2" type="password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="col-sm-offset-3 btn btn-primary" style="width: 100px;"
                                id="passwordSubmitButton">确认
                        </button>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</body>
</html>