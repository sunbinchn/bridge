<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>桥梁监测系统-监测类型设置</title>
    <%@ include file="common.jsp" %>
    <script src="${PATH}static/js/monitorTypeManage.js"></script>
</head>
<body>
<div class="container">
    <%@ include file="head.jsp" %>
    <div class="row">
        <!-- 左侧导航栏-->
        <%@ include file="leftMeun.jsp" %>
        <div class="col-sm-10" style="margin-bottom: 30px">
            <ul class="nav nav-tabs">
                <li role="presentation" class="active" id="viewMonitorTypeLi"><a href="">查看</a></li>
                <li role="presentation" id="addMonitorTypeLi"><a href="" id="addMonitorTypeA">添加</a></li>
            </ul>
        </div>
        <div class="col-sm-10">
            <form method="post" onsubmit="return;" class="form-horizontal" role="form" id="addMonitorTypeForm" style="display: none">
                <div class="form-group">
                    <div id="addMonitorTypeSuccessDiv" class="alert  alert-success col-sm-offset-2 col-sm-4 alert-dismissible" role="alert" style="margin-bottom: 0px;display: none">
                        <button id="addMonitorTypeSuccessClose" type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <strong></strong>
                    </div>
                </div>
                <div class="form-group" hidden="true" id="error-msg-div" style="margin-left: 20px;">
                    <label class="control-label" id="error-msg-label" style="color:red;"></label>
                </div>
                <div class="form-group">
                    <label for="monitorName" class="col-sm-2 control-label">监测名称：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="monitorName" name="monitorName" type="text" required autofocus/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="hial" class="col-sm-2 control-label">高预警：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="hial" name="hial" type="number" required autofocus/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="loal" class="col-sm-2 control-label">低预警：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="loal" name="loal" type="number" required autofocus/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="monitorPoint" class="col-sm-2 control-label">监测点：</label>
                    <div class="col-sm-6">
                        <select id="monitorPoint" name="monitorPoint"
                                class="form-control selectpicker show-tick col-sm-3" data-live-search="false">
                            <option value="-1">---类型---</option>
                            <c:forEach items="${monitorPointList}" var="monitorPoint">
                                <option value="${monitorPoint.id}">${monitorPoint.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="col-sm-offset-3 btn btn-primary" style="width: 100px;"
                            id="addMonitorTypeButton">添加
                    </button>
                </div>
            </form><!-- 添加监测点form -->
            <div class="col-md-10" id="monitorType-view-div"> <!-- 监测点div -->
                <table class="table table-bordered table-hover" id="monitorType_table_id" style="margin-top: 5px; margin-bottom: 0px;">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>监测名称</th>
                        <th>超高预警</th>
                        <th>超低预警</th>
                        <th>监测点名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="sensorType" items="${pageInfo.list}" varStatus="status">
                        <c:choose>
                            <c:when test="${status.count%2 eq 1}">
                                <tr class="info" data-id="${sensorType.id}" monitor-point-id="${sensorType.monitorPoint.id}">
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${sensorType.monitorName}</td>
                                    <td><fmt:formatNumber value="${sensorType.hial}" pattern="#.#####"/></td>
                                    <td><fmt:formatNumber value="${sensorType.loal}" pattern="#.#####"/></td>
                                    <td>${sensorType.monitorPoint.name}</td>
                                    <td>
                                        <a href="" class="update-monitorType">修改</a>
                                        <a href="" class="delete-monitorType">删除</a>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr data-id="${sensorType.id}" monitor-point-id="${sensorType.monitorPoint.id}">
                                    <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                    <td>${sensorType.monitorName}</td>
                                    <td><fmt:formatNumber value="${sensorType.hial}" pattern="#.#####"/></td>
                                    <td><fmt:formatNumber value="${sensorType.loal}" pattern="#.#####"/></td>
                                    <td>${sensorType.monitorPoint.name}</td>
                                    <td>
                                        <a href="" class="update-monitorType">修改</a>
                                        <a href="" class="delete-monitorType">删除</a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- 分页 -->
                <c:if test="${pageInfo.pages gt 1}">
                    <div style="float:right">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${pageInfo.hasPreviousPage}">
                                    <li>
                                        <a href="${PATH}monitorType/index?pn=${pageInfo.pageNum-1}" aria-label="Previous">
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
                                            <li><a href="${PATH}monitorType/index?pn=${curNum}">${curNum}</a></li>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>
                                <c:if test="${pageInfo.hasNextPage}">
                                    <li>
                                        <a href="${PATH}monitorType/index?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div> <!-- 分页结束 -->
                </c:if>
        </div> <!-- 监测点table结束 -->

    </div>
</div>
</body>
</html>