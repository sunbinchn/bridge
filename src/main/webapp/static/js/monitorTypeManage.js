$(function () {
    init_event();

    function init_event() {
        $("#monitorTypeButton").addClass("color-info");

        $(".delete-monitorType").click(function () {
            var id = $($(this).parents('tr')[0]).attr('data-id');
            $.ajax({
                url: "/bridge/monitorType/delete?id="+id,
                type: "get",
                success: function (result) {
                    if (result.success) {
                        location.reload();
                    } else {
                        alert(result.message);
                    }
                }
            });
            return false;
        });
        $(".update-monitorType").click(function () {
            $('#addMonitorTypeLi').click();
            var $tr = $($(this).parents('tr')[0]);
            $("#monitorName").val($tr.children('td:eq(1)').text());
            $("#hial").val($tr.children('td:eq(2)').text());
            $("#loal").val($tr.children('td:eq(3)').text());
            $("#monitorPoint").val($tr.attr('monitor-point-id'));
            $("#addMonitorTypeForm").attr('data-id',$tr.attr('data-id'));

            $("#addMonitorTypeA").text('更新');
            $("#addMonitorTypeButton").text('更新');
            return false;
        });
        $("#addMonitorTypeLi").click(function () {
            $("#addMonitorTypeForm").attr('data-id','');
            $('#viewMonitorTypeLi').removeClass("active");
            $('#addMonitorTypeLi').addClass("active");
            $('#addMonitorTypeForm').css('display','block');
            $('#monitorType-view-div').css('display','none');
            $("#addMonitorTypeA").text('添加');
            $("#addMonitorTypeButton").text('添加');
            return false;
        });
        $("#addMonitorTypeButton").click(function () {
            var monitorType = {};
            monitorType.id = $(this).parents('form').attr('data-id');
            monitorType.monitorName = $("#monitorName").val();
            monitorType.hial = $("#hial").val();
            monitorType.loal = $("#loal").val();
            monitorType.monitorPointId = $("#monitorPoint").val() == -1 ? null : $("#monitorPoint").val();
            if (_.isEmpty(monitorType.monitorName)) {
                $("#error-msg-label").text('监测名称不能为空');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            if (_.isEmpty(monitorType.monitorPointId)) {
                $("#error-msg-label").text('监测点不能为空');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            $("#error-msg-div").prop('hidden', true);
            $.ajax({
                url: "/bridge/monitorType/save",
                type: "post",
                contentType: 'application/json;charset=utf-8',
                data: JSON.stringify(monitorType),
                success: function (result) {
                    if (result.success) {
                        if (result.message === 'save') {
                            $("#monitorName").val('');
                            $("#hial").val('');
                            $("#loal").val('');
                            $("#monitorPoint").val(-1);
                            $("#addMonitorTypeSuccessDiv strong").text('添加成功!');
                            $("#addMonitorTypeSuccessDiv").css('display','block');
                        } else {
                            $("#addMonitorTypeSuccessDiv strong").text('更新成功!');
                            $("#addMonitorTypeSuccessDiv").css('display','block');
                        }
                    } else {
                        $("#error-msg-label").text(result.message);
                        $("#error-msg-div").prop('hidden', false);
                    }
                }
            });
            return false;
        });
    }
});