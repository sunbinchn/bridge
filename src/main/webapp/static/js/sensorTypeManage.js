$(function () {
    init_event();


    function init_event() {
        $("#sensorTypeManage").addClass("color-info");
        $("#add-button").click(function() {
            $(".modal-title").text('添加传感器类型');
            $(".sensorType-modal").modal('show');
            $("#model-sensorTypeName").val('');
            $("#model-description").val('');
            $("#model-algorithm").val('');
            $("#model-algorithmDescription").val('');
            $("#model-remark").val('');
            $(".sensorType-modal").attr("data-id", '');
            return false;
        });
        $(".update-sensor-type").click(function() {
            var $tr = $($(this).parents('tr')[0]);
            $(".modal-title").text('修改传感器类型');
            $(".sensorType-modal").modal('show');
            $("#model-sensorTypeName").val($tr.children('td:eq(1)').text());
            $("#model-description").val($tr.children('td:eq(2)').text());
            $("#model-algorithm").val($tr.children('td:eq(3)').text());
            $("#model-algorithmDescription").val($tr.children('td:eq(4)').text());
            $("#model-remark").val($tr.children('td:eq(5)').text());
            $(".sensorType-modal").attr("data-id", $tr.attr("data-id"));
            return false;
        });
        $("#updateOrCreateButton").click(function() {
            var sensorTypeId = $(".sensorType-modal").attr("data-id");
            var sensorType  = {};
            if (!_.isEmpty(sensorTypeId)) {
                sensorType.id = sensorTypeId;
            }
            sensorType.sensorTypeName = $("#model-sensorTypeName").val();
            if (_.isEmpty(sensorType.sensorTypeName)) {
                $("#error-msg-label").text('传感器类型不能为空！');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            sensorType.description = $("#model-description").val();
            sensorType.algorithm = $("#model-algorithm").val();
            sensorType.algorithmDescription = $("#model-algorithmDescription").val();
            sensorType.remark = $("#model-remark").val();
            $.ajax({
                url: "/bridge/sensorTypeManage/updateOrCreate" ,
                type: "post",
                contentType : 'application/json;charset=utf-8',
                data: JSON.stringify(sensorType),
                success: function (result) {
                    if (result.success) {
                        location.reload();
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