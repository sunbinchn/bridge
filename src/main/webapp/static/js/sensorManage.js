$(function () {
    init_event();

    function init_event() {
        $("#sensorButton").addClass("color-info");

        $(".delete-sensor").click(function () {
            var id = $($(this).parents('tr')[0]).attr('data-id');
            $.ajax({
                url: "/bridge/sensor/delete?id="+id,
                type: "get",
                success: function (result) {
                    if (result.success) {
                        location.reload();
                    }
                }
            });
            return false;
        });
        $("#addSensorButton").click(function () {
           return false;
        });
        $(".update-sensor").click(function () {
            $('#addSensorLi').click();
            var $tr = $($(this).parents('tr')[0]);
            $("#sensorName").val($tr.children('td:eq(1)').text());
            $("#sensorType").val($tr.attr('sensor-type-id'));
            $("#monitorType").val($tr.attr('monitor-type-id'));
            $("#addSensorForm").attr('data-id',$tr.attr('data-id'));

            $("#addSensorA").text('更新');
            $("#addSensorButton").text('更新');
            return false;
        });
        $("#addSensorLi").click(function () {
            $('#viewSensorLi').removeClass("active");
            $('#addSensorLi').addClass("active");
            $('#addSensorForm').css('display','block');
            $('#sensor-view-div').css('display','none');
            $("#sensorPointA").text('添加');
            $("#sensorPointButton").text('添加');
            return false;
        });
        $("#addSensorButton").click(function () {
            var sensor = {};
            sensor.id = $(this).parents('form').attr('data-id');
            sensor.name = $("#sensorName").val();
            sensor.sensorTypeId = $("#sensorType").val() == -1 ? null : $("#sensorType").val();
            sensor.monitorTypeId = $("#monitorType").val() == -1 ? null : $("#monitorType").val();
            if (_.isEmpty(sensor.name)) {
                $("#error-msg-label").text('传感器名称不能为空');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            if (_.isEmpty(sensor.sensorTypeId)) {
                $("#error-msg-label").text('传感器类型不能为空');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            if (_.isEmpty(sensor.monitorTypeId)) {
                $("#error-msg-label").text('监测类型不能为空');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            $("#error-msg-div").prop('hidden', true);
            $.ajax({
                url: "/bridge/sensor/save",
                type: "post",
                contentType: 'application/json;charset=utf-8',
                data: JSON.stringify(sensor),
                success: function (result) {
                    if (result.success) {
                        if (result.message === 'save') {
                            $("#sensorName").val('');
                            $("#sensorType").val(-1);
                            $("#monitorType").val(-1);
                            $("#addSensorSuccessDiv strong").text('添加成功!');
                            $("#addSensorSuccessDiv").css('display','block');
                        } else {
                            $("#addSensorSuccessDiv strong").text('更新成功!');
                            $("#addSensorSuccessDiv").css('display','block');
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