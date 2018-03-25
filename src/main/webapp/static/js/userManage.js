$(function () {
    init_event();


    function init_event() {
        $("#check_all").click(function(){
            if ($(this).prop('checked')) {
                $("#emp_table_id > tbody > tr > td > input").prop('checked', true);
            } else {
                $("#emp_table_id > tbody > tr > td > input").prop('checked', false);
            }
        });

        $(".update-user").click(function () {

            return false;
        });
        $(".delete-user").click(function () {
            var userId = parseInt($($(this).parents("tr")[0]).attr('data-id'));
            $.ajax({
                url: "/bridge/userManage/delete?userId=" + userId ,
                type: "get",
                success: function (result) {
                    if (result.success) { //todo waring如果为当前
                        location.reload();
                    } else { //todo waring
                        console.log(result.message);
                    }
                }
            })
            return false;
        });
    }


});