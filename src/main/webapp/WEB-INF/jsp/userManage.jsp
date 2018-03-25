<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-用户管理</title>
    <%@ include file="common.jsp" %>
    <script src="${PATH}static/js/userManage.js"></script>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <!-- 右侧内容栏 -->
        <div class="col-md-10">
            <table class="table table-bordered table-hover" id="emp_table_id" style="margin-top: 5px; margin-bottom: 0px;">
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
                        <th>备注</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="userItem" items="${pageInfo.list}" varStatus="status">
                        <c:choose>
                            <c:when test="${status.count%2 eq 1}">
                                <tr class="info" data-id="${userItem.userId}">
                                    <td><input type="checkbox"/></td>
                                    <td>${status.count}</td>
                                    <td>${userItem.userName}</td>
                                    <td>${userItem.phone}</td>
                                    <td>${userItem.email}</td>
                                    <td>${userItem.role}</td>
                                    <td>${userItem.remark}</td>
                                    <td>
                                        <a href="" class="update-user">修改</a>
                                        <a href="" class="delete-user">删除</a>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr data-id="${userItem.userId}">
                                    <td><input type="checkbox"/></td>
                                    <td>${status.count}</td>
                                    <td>${userItem.userName}</td>
                                    <td>${userItem.phone}</td>
                                    <td>${userItem.email}</td>
                                    <td>${userItem.role}</td>
                                    <td>${userItem.remark}</td>
                                    <td>
                                        <a class="update-user">修改</a>
                                        <a class="delete-user">删除</a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </tbody>
            </table>
            <div style="float:right">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${PATH}userManage/getAll?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="curNum">
                            <c:choose>
                                <c:when test="${pageInfo.pageNum eq curNum}" >
                                    <li class="active"><span>${curNum}</span></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="${PATH}userManage/getAll?pn=${curNum}">${curNum}</a></li>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${PATH}userManage/getAll?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>


        </div>
    </div>
</div>
</body>
</html>