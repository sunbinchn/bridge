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
        <div class="form-group">
            <label for="select-province" class="col-sm-1 control-label">城市：</label>
            <div class="col-sm-8">
                <select id="select-province" name="select-province"
                        class="selectpicker show-tick col-sm-2" data-live-search="false">
                    <option value="-1">请选择省份</option>
                    <c:forEach items="${provinceList}" var="province">
                        <option value="${province.provinceid}">${province.province}</option>
                    </c:forEach>
                </select>
                <select id="select-city" name="select-city"
                        class="selectpicker show-tick col-sm-2" data-live-search="false">
                    <option value="-1">请选择地级市</option>
                </select>
                <select id="select-area" name="select-area"
                        class="selectpicker show-tick col-sm-2" data-live-search="false">
                    <option value="-1">请选择区域</option>
                </select>
            </div>
        </div>
    </div>
</div>
</body>
</html>