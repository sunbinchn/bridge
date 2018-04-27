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
            <c:if test="${role > 0}">
                <button type="button" class="btn btn-success btn-sm" id="add-button" style="margin-top: 5px;">添加</button>
            </c:if>

            <table class="table table-bordered table-hover" id="emp_table_id" style="margin-top: 5px; margin-bottom: 0px;">
                <thead>
                <tr>
                    <th>#</th>
                    <th style="min-width: 100px;">传感器类型</th>
                    <th style="min-width: 100px;">传感器描述</th>
                    <th style="min-width: 100px;">算法说明</th>
                    <th style="min-width: 100px;">值说明</th>
                    <th style="min-width: 100px;">备注</th>
                    <c:if test="${role > 0}">
                         <th style="min-width: 100px;">操作</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="sensorType" items="${pageInfo.list}" varStatus="status">
                    <c:choose>
                        <c:when test="${status.count%2 eq 1}">
                            <tr class="info" data-id="${sensorType.id}">
                                <td>${status.count + (pageInfo.pageNum-1) * pageInfo.pageSize}</td>
                                <td>${sensorType.sensorTypeName}</td>
                                <td>${sensorType.description}</td>
                                <td>${sensorType.algorithm}</td>
                                <td>${sensorType.algorithmDescription}</td>
                                <td>${sensorType.remark}</td>
                                <c:if test="${role > 0}">
                                    <td>
                                        <a class="update-sensor-type" href="">修改</a>
                                    </td>
                                </c:if>
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
                                <c:if test="${role > 0}">
                                    <td>
                                        <a class="update-sensor-type" href="">修改</a>
                                    </td>
                                </c:if>
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
            </c:if>
            <!-- 传感器类型信息模态框 -->
            <div class="modal fade sensorType-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h3 class="modal-title"></h3>
                        </div>
                        <div class="modal-body">
                            <div class="form-group" hidden="true" id="error-msg-div" >
                                <label class="control-label" id="error-msg-label" style="color:red;"></label>
                            </div>
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-4 col-sm-offset-2" style="color: red" id="error-panel"></label>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="model-sensorTypeName">传感器类型：</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="model-sensorTypeName" name="model-sensorTypeName" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="model-description">传感器描述：</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="model-description" name="model-description" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="model-algorithm">算法说明：</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="model-algorithm" name="model-algorithm" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="model-algorithmDescription">算法值说明：</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="model-algorithmDescription" name="model-algorithmDescription" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label" for="model-remark">备注：</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="model-remark" name="model-remark" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="col-sm-offset-5 btn btn-primary" style="width: 100px;"
                                            id="updateOrCreateButton">确认
                                    </button>
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
</div>
</body>
</html>