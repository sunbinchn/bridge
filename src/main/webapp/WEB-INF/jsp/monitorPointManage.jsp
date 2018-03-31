<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-监测点设置</title>
    <%@ include file="common.jsp" %>
    <script src="${PATH}static/js/monitorPointManage.js"></script>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <div class="col-sm-10" style="margin-bottom: 30px">
            <ul class="nav nav-tabs">
                <li role="presentation" class="active" id="addPointLi"><a href="">添加</a></li>
                <li role="presentation" id="viewPointLi"><a href="">查看</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <form method="post" onsubmit="return;" class="form-horizontal" role="form" id="updateUserInfoForm">
                <div class="form-group">
                    <div id="addPointSuccessDiv" class="alert  alert-success col-sm-offset-2 col-sm-4 alert-dismissible" role="alert" style="margin-bottom: 0px;display: none">
                        <button id="addPointSuccessClose" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <strong>添加成功!</strong>
                    </div>
                </div>
                <div class="form-group" hidden="true" id="error-msg-div" style="margin-left: 20px;">
                    <label class="control-label" id="error-msg-label" style="color:red;"></label>
                </div>
                <div class="form-group">
                    <label for="pointName" class="col-sm-2 control-label">监测点名称：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="pointName" name="pointName" type="text" required autofocus/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="select-province" class="col-sm-2 control-label">城市：</label>
                    <div class="col-sm-6">
                        <select id="select-province" name="select-province"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false" style="width: 33.333333333%;">
                            <option value="-1">---省份---</option>
                            <c:forEach items="${provinceList}" var="province">
                                <option value="${province.provinceid}">${province.province}</option>
                            </c:forEach>
                        </select>
                        <select id="select-city" name="select-city"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false" style="width: 33.333333333%;">
                            <option value="-1">---地级市---</option>
                        </select>
                        <select id="select-area" name="select-area"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false" style="width: 33.333333333%;">
                            <option value="-1">---区域---</option>
                        </select>
                    </div>
                </div>
                <c:if test="${not empty targetUserList}">
                    <div class="form-group"> <!-- 如果是管理员，需要填写监测点的目标用户 -->
                        <label for="select-user" class="col-sm-2 control-label">所属用户：</label>
                        <div class="col-sm-6">
                            <select id="select-user" name="select-user"
                                    class="form-control selectpicker">
                                <c:forEach items="${targetUserList}" var="targetUser">
                                    <option value="${targetUser.userId}">${targetUser.userName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </c:if>
                <div class="form-group">
                    <label for="longitude" class="col-sm-2 control-label">经度：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="longitude" name="longitude" type="number"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="latitude" class="col-sm-2 control-label">纬度：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="latitude" name="latitude" type="number"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remark" class="col-sm-2 control-label">备注：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="remark" name="remark" type="text"/>
                    </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="col-sm-offset-3 btn btn-primary" style="width: 100px;"
                            id="addPointButton">添加
                    </button>
                </div>
            </form><!-- 添加监测点form -->
        </div>

    </div>
</div>
</body>
</html>