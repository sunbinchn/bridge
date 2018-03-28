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
            <button type="button" class="btn btn-danger btn-sm" id="batch-delete" style="margin-top: 5px;">删除</button>
            <table class="table table-bordered table-hover" id="emp_table_id" style="margin-top: 5px; margin-bottom: 0px;">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>用户名</th>
                        <th>真实姓名</th>
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
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${userItem.userName}</td>
                                    <td>${userItem.nickName}</td>
                                    <td>${userItem.phone}</td>
                                    <td>${userItem.email}</td>
                                    <c:choose>
                                        <c:when test="${userItem.role eq 2}">
                                            <td>超级管理员</td>
                                        </c:when>
                                        <c:when test="${userItem.role eq 1}">
                                            <td>管理员</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>普通用户</td>
                                        </c:otherwise>
                                    </c:choose>
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
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${userItem.userName}</td>
                                    <td>${userItem.nickName}</td>
                                    <td>${userItem.phone}</td>
                                    <td>${userItem.email}</td>
                                    <c:choose>
                                        <c:when test="${userItem.role eq 2}">
                                            <td>超级管理员</td>
                                        </c:when>
                                        <c:when test="${userItem.role eq 1}">
                                            <td>管理员</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>普通用户</td>
                                        </c:otherwise>
                                    </c:choose>
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
            <!-- 分页 -->
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
            </div> <!-- 分页结束 -->
            <!-- 修改用户信息模态框 -->
            <div class="modal fade userInfo-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h3 class="modal-title">修改用户信息</h3>
                        </div>
                        <div class="modal-body">
                            <div class="form-group" hidden="true" id="error-msg-div" >
                                <label class="control-label" id="error-msg-label" style="color:red;"></label>
                            </div>
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">用户名</label>
                                    <div class="col-sm-10">
                                        <label class="control-label" id="userNameLabel"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputNickName" class="col-sm-2 control-label">真实姓名</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="inputNickName">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPhone" class="col-sm-2 control-label">电话</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="inputPhone">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">邮箱</label>
                                    <div class="col-sm-8">
                                        <input type="email" class="form-control" id="inputEmail">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="selectRole" class="col-sm-2 control-label">角色</label>
                                    <div class="col-sm-8">
                                        <select id="selectRole" name="selectRole"
                                                class="selectpicker show-tick form-control" data-live-search="false">
                                            <option value="0">普通用户</option>
                                            <option value="1">管理员</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputRemark" class="col-sm-2 control-label">备注</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="inputRemark">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-4 col-sm-6">
                                        <button type="submit" class="btn btn-primary" style="width: 120px" id="update-user-button">更新</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">

                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal-end -->
    </div>
</div>
</body>
</html>