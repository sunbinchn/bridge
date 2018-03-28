<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-传感器类型</title>
    <%@ include file="common.jsp" %>
    <script src="${PATH}static/js/sensorTypeManage.js"></script>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <!-- 右侧内容栏 -->
        <div class="col-md-10">
            <!-- 传感器显示table -->
            <table class="table table-bordered table-hover" id="emp_table_id" style="margin-top: 5px; margin-bottom: 0px;">
                <thead>
                <tr>
                    <th>#</th>
                    <th style="min-width: 100px;">传感器类型</th>
                    <th style="min-width: 100px;">传感器描述</th>
                    <th style="min-width: 100px;">算法说明</th>
                    <th style="min-width: 100px;">值说明</th>
                    <th style="min-width: 100px;">备注</th>
                    <th style="min-width: 100px;">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="sensorType" items="${pageInfo.list}" varStatus="status">
                    <c:choose>
                        <c:when test="${status.count%2 eq 1}">
                            <tr class="info" data-id="${userItem.userId}">
                                <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                <td>${sensorType.sensorTypeName}</td>
                                <td>${sensorType.description}</td>
                                <td>${sensorType.algorithm}</td>
                                <td>${sensorType.algorithmDescription}</td>
                                <td>${sensorType.remark}</td>
                                <td>
                                    <a class="update-sensor-type">修改</a>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr data-id="${userItem.userId}">
                                <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                <td>${sensorType.sensorTypeName}</td>
                                <td>${sensorType.description}</td>
                                <td>${sensorType.algorithm}</td>
                                <td>${sensorType.algorithmDescription}</td>
                                <td>${sensorType.remark}</td>
                                <td>
                                    <a id="update-sensor-type">修改</a>
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
                                <a href="${PATH}sensorTypeManage/getAll?pn=${pageInfo.pageNum-1}" aria-label="Previous">
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
                                    <li><a href="${PATH}sensorTypeManage/getAll?pn=${curNum}">${curNum}</a></li>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${PATH}sensorTypeManage/getAll?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div> <!-- 分页结束 -->
            <!-- 传感器form -->
            <form method="post" onsubmit="return;" class="form-horizontal" role="form" id="sensorTypeForm">
                <fieldset>
                    <div class="form-group">
                        <div id="sensorTypeCloseSuccess" class="alert  alert-success col-sm-offset-2 col-sm-4 alert-dismissible" role="alert" style="margin-bottom: 0px;display: none">
                            <button id="sensorTypeCloseSuccessClose" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>添加成功!</strong>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 col-sm-offset-2" style="color: red" id="error-panel"></label>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="model-sensorTypeName">传感器类型：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="model-sensorTypeName" name="model-sensorTypeName" type="text"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="model-description">传感器描述：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="model-description" name="model-description" type="text"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="model-algorithm">算法说明：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="model-algorithm" name="model-algorithm" type="password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="model-algorithmDescription">算法值说明：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="model-algorithmDescription" name="model-algorithmDescription" type="password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="model-remark">备注：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="model-remark" name="model-remark" type="password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="col-sm-offset-3 btn btn-primary" style="width: 100px;"
                                id="passwordSubmitButton">添加
                        </button>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>
</body>
</html>