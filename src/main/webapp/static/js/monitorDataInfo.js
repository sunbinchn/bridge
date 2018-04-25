$(function () {
    Datetime();
    init_event();
    init_UI();
    function init_event() {
        $("#monitorDataButton").addClass("color-info");
        $("#search-button").click(function () {
           var fromDate = $("#from-date").val();
           var toDate = $("#to-date").val();
           if (!_.isEmpty(fromDate) && !_.isEmpty(toDate)) {
               if (new Date(toDate).getTime() - new Date(fromDate).getTime() <= 0) {
                   //todo
                   debugger;
                   return false;
               }
           }
           window.location.href = "/bridge/monitorInfoData/getAll?dateRange=" + fromDate + "_" + toDate;
           return false;
        });
    }
    function init_UI() {
        var dateRange = $("#dateRangeInput").val();
        if (!_.isEmpty(dateRange)) {
            document.getElementById("from-date").value = dateRange.split('_')[0];
            document.getElementById("to-date").value = dateRange.split('_')[1];
        }
    }

    function Datetime() {
        $('#datetimepicker1').datetimepicker({
            language: 'zh-CN',//显示中文
            format: 'yyyy-mm-dd',//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),
            autoclose: true,//选中自动关闭
            todayBtn: true,//显示今日按钮
            locale: moment.locale('zh-cn')
        });
        $('#datetimepicker2').datetimepicker({
            language: 'zh-CN',//显示中文
            format: 'yyyy-mm-dd',//显示格式yyyy-mm-dd hh:ii
            minView: "month",//设置只显示到月份
            initialDate: new Date(),
            autoclose: true,//选中自动关闭
            todayBtn: true,//显示今日按钮
            locale: moment.locale('zh-cn')
        });
        // //默认获取当前日期
        // var today = new Date();
        // var nowdate = (today.getFullYear()) + "-" + (today.getMonth() + 1) + "-" + today.getDate();
        // //对日期格式进行处理
        // var date = new Date(nowdate);
        // var mon = date.getMonth() + 1;
        // var day = date.getDate();
        // var mydate = date.getFullYear() + "-" + (mon < 10 ? "0" + mon : mon) + "-" + (day < 10 ? "0" + day : day);
        // document.getElementById("from-date").value = mydate;
    }
});