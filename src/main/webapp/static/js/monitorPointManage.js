$(function(){
    init_event();

    function init_event() {
        $("#monitorPointButton").addClass("colo r-info");
        $("#select-province").change(function() {
            var provinceId = $(this).val();
            if (provinceId == -1) {
                clearCity();
                clearArea();
                return false;
            }
            $.ajax({
                url: "/bridge/location/getCitiesByProvinceId?provinceId=" + provinceId ,
                type: "get",
                success: function (result) {
                    clearCity();
                    clearArea();
                    _.each(result, function(city) {
                        $('#select-city').append('<option value="' + city.cityid + '">'+ city.city +'</option>')
                    });
                }
            });
        });
        $("#select-city").change(function() {
            var cityId = $(this).val();
            if (cityId == -1) {
                clearArea();
                return false;
            }
            $.ajax({
                url: "/bridge/location/getAreasByCityId?cityId=" + cityId ,
                type: "get",
                success: function (result) {
                    clearArea();
                    _.each(result, function(area) {
                        $('#select-area').append('<option value="' + area.areaid + '">'+ area.area +'</option>')
                    });
                }
            });
        });
        function clearCity() {
            $('#select-city').empty();
            $('#select-city').append('<option value="-1">请选择地级市</option>');

        };
        function clearArea() {
            $('#select-area').empty();
            $('#select-area').append('<option value="-1">请选择区域</option>');
        };
    }
});