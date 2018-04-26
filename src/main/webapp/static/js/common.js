$(function(){
    $(".panel-heading").click(function(e){
        /*切换折叠指示图标*/
        $(this).find("span").toggleClass("glyphicon-chevron-down");
        $(this).find("span").toggleClass("glyphicon-chevron-up");
    });
    $("#monitorDataButton").click(function() {
        window.location.href = "/bridge/monitorInfoData/getAll";
    });
    $("#monitorDataOfIsEmailButton").click(function() {
        window.location.href = "/bridge/monitorInfoData/alert/getAll";
    });
    $("#chartInfoButton").click(function() {
        window.location.href = "/bridge/chartInfo/index";
    });
    $("#userManageButton").click(function() {
        window.location.href = "/bridge/userManage/getAll";
    });
    $("#userInfoButton").click(function() {
        window.location.href = "/bridge/userInfo/index";
    });
    $("#sensorTypeManage").click(function() {
        window.location.href = "/bridge/sensorTypeManage/getAll";
    });
    $("#monitorPointButton").click(function() {
        window.location.href = "/bridge/monitorPoint/index";
    });
    $("#sensorButton").click(function() {
        window.location.href = "/bridge/sensor/index";
    });
    $("#monitorTypeButton").click(function() {
        window.location.href = "/bridge/monitorType/index";
    });

});