$(function () {
    init_event();

    function init_event() {
        $("#monitorPointButton").addClass("color-info");
        $("#addPointButton").click(function () {
            var monitorPoint = {};
            monitorPoint.name = $("#pointName").val();
            monitorPoint.provinceId = $("#select-province").val();
            monitorPoint.cityId = $("#select-city").val();
            monitorPoint.areaId = $("#select-area").val();
            monitorPoint.userId = $("#select-user").val();
            monitorPoint.longitude = $("#longitude").val();
            monitorPoint.latitude = $("#latitude").val();
            monitorPoint.remark = $("#remark").val();

            if (_.isEmpty(monitorPoint.name)) {
                $("#error-msg-label").text('监测点名称不能为空');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            $.ajax({
                url: "/bridge/monitorPoint/save",
                type: "post",
                contentType: 'application/json;charset=utf-8',
                data: JSON.stringify(monitorPoint),
                success: function (result) {
                    if (result.success) {
                        $("#pointName").val('');
                        $("#select-province").val(-1);
                        $("#select-city").val(-1);
                        $("#select-area").val(-1);
                        $("#longitude").val('');
                        $("#latitude").val('');
                        $("#remark").val('');
                        $("#addPointSuccessDiv").css('display','block');
                    } else {
                        $("#error-msg-label").text(result.message);
                        $("#error-msg-div").prop('hidden', false);
                    }
                }
            });
            return false;
        });
        $("#select-province").change(function () {
            var provinceId = $(this).val();
            if (provinceId == -1) {
                clearCity();
                clearArea();
                return false;
            }
            $.ajax({
                url: "/bridge/location/getCitiesByProvinceId?provinceId=" + provinceId,
                type: "get",
                success: function (result) {
                    clearCity();
                    clearArea();
                    _.each(result, function (city) {
                        $('#select-city').append('<option value="' + city.cityid + '">' + city.city + '</option>')
                    });
                }
            });
        });
        $("#select-city").change(function () {
            var cityId = $(this).val();
            if (cityId == -1) {
                clearArea();
                return false;
            }
            $.ajax({
                url: "/bridge/location/getAreasByCityId?cityId=" + cityId,
                type: "get",
                success: function (result) {
                    clearArea();
                    _.each(result, function (area) {
                        $('#select-area').append('<option value="' + area.areaid + '">' + area.area + '</option>')
                    });
                }
            });
        });
        $("#addPointSuccessClose").click(function(){
            $('#addPointSuccessDiv').css('display','none');
            return false;
        });
        function clearCity() {
            $('#select-city').empty();
            $('#select-city').append('<option value="-1">---地级市---</option>');

        }

        function clearArea() {
            $('#select-area').empty();
            $('#select-area').append('<option value="-1">---区域---</option>');
        }

    }
});