$(function () {
    init_event();

    function init_event() {
        $("#monitorPointButton").addClass("color-info");
        $(".delete-point").click(function () {
            var id = $($(this).parents('tr')[0]).attr('data-id');
            $.ajax({
                url: "/bridge/monitorPoint/delete?id="+id,
                type: "get",
                success: function (result) {
                    if (result.success) {
                        location.reload();
                    }
                }
            });
            return false;
        });
        $(".update-point").click(function () {
            $('#addPointLi').click();
            var $tr = $($(this).parents('tr')[0]);
            $("#pointName").val($tr.children('td:eq(1)').text());
            var locationIds = $tr.attr('location-ids');
            var areaId = locationIds.split(',')[0];
            var cityId = locationIds.split(',')[1];
            var provinceId = locationIds.split(',')[2];
            if (!_.isEmpty(areaId)) {
                $('#select-province').val(provinceId);
                $.ajax({
                    url: "/bridge/location/getCitiesByProvinceId?provinceId=" + provinceId,
                    type: "get",
                    success: function (result) {
                        clearCity();
                        clearArea();
                        _.each(result, function (city) {
                            $('#select-city').append('<option value="' + city.cityid + '">' + city.city + '</option>')
                        });
                        $('#select-city').val(cityId);
                        $.ajax({
                            url: "/bridge/location/getAreasByCityId?cityId=" + cityId,
                            type: "get",
                            success: function (result) {
                                clearArea();
                                _.each(result, function (area) {
                                    $('#select-area').append('<option value="' + area.areaid + '">' + area.area + '</option>')
                                });
                                $('#select-area').val(areaId);
                            }
                        });
                    }
                });
            }
            // $("#model-sensorTypeName").val($tr.children('td:eq(2)').text());
            $("#longitude").val($tr.children('td:eq(3)').text());
            $("#latitude").val($tr.children('td:eq(4)').text());
            $("#remark").val($tr.children('td:eq(5)').text());
            $("#addPointForm").attr('data-id',$tr.attr('data-id'));
            $("#addPointA").text('更新');
            $("#addPointButton").text('更新');
            return false;
        });

        $("#addPointLi").click(function () {
            $("#addPointForm").attr('data-id','');
            $('#viewPointLi').removeClass("active");
            $('#addPointLi').addClass("active");
            $('#addPointForm').css('display','block');
            $('#point-view-div').css('display','none');
            $("#addPointA").text('添加');
            $("#addPointButton").text('添加');
            return false;
        });
        $("#viewPointLi").click(function () {
            window.location.href = '/bridge/monitorPoint/index';
            return false;
        });
        $("#addPointButton").click(function () {
            var monitorPoint = {};
            monitorPoint.name = $("#pointName").val();
            monitorPoint.provinceId = $("#select-province").val() == -1 ? null : $("#select-province").val();
            monitorPoint.cityId = $("#select-city").val() == -1 ? null : $("#select-city").val();
            monitorPoint.areaId = $("#select-area").val() == -1 ? null : $("#select-area").val();
            monitorPoint.userId = $("#select-user").val(); //todo update不让更新userId
            monitorPoint.longitude = $("#longitude").val();
            monitorPoint.latitude = $("#latitude").val();
            monitorPoint.remark = $("#remark").val();
            monitorPoint.id = $(this).parents('form').attr('data-id');

            if (_.isEmpty(monitorPoint.name)) {
                $("#error-msg-label").text('监测点名称不能为空');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            //如果省份或者市不为空，则必须选到县
            if ((!_.isEmpty(monitorPoint.provinceId) || !_.isEmpty(monitorPoint.provinceId)) && _.isEmpty(monitorPoint.areaId)) {
                $("#error-msg-label").text('城市必须选到区域哦！');
                $("#error-msg-div").prop('hidden', false);
                return false;
            }
            $("#error-msg-div").prop('hidden', true);
            $.ajax({
                url: "/bridge/monitorPoint/save",
                type: "post",
                contentType: 'application/json;charset=utf-8',
                data: JSON.stringify(monitorPoint),
                success: function (result) {
                    if (result.success) {
                        if (result.message === 'save') {
                            $("#pointName").val('');
                            $("#select-province").val(-1);
                            $("#select-city").val(-1);
                            $("#select-area").val(-1);
                            $("#longitude").val('');
                            $("#latitude").val('');
                            $("#remark").val('');
                            $("#addPointSuccessDiv strong").text('添加成功!');
                            $("#addPointSuccessDiv").css('display','block');
                        } else {
                            $("#addPointSuccessDiv strong").text('更新成功!');
                            $("#addPointSuccessDiv").css('display','block');
                        }
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