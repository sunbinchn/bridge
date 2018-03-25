<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>桥梁监测系统-首页</title>

    <%@ include file="common.jsp" %>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <!-- 右侧内容栏 -->
        <div class="col-md-10">
            <table class="table table-bordered table-hover" id="emp_table_id" style="margin-top: 5px;">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>用户名</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>角色</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="info">
                        <td><input type="checkbox"></td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>
                            <a href="#">修改</a>
                            <a href="#">删除</a>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>
                            <a href="#">修改</a>
                            <a href="#">删除</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>