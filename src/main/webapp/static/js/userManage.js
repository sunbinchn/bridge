$(function () {
    init_event();


    function init_event() {
        $("#userManageButton").addClass("color-info");
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
            });
            return false;
        });
        $(".update-user").click(function () {
            var $tr = $($(this).parents("tr")[0]);
            $(".userInfo-modal").modal('show');
            $("#userNameLabel").text($tr.children('td:eq(2)').text());
            $("#inputPhone").val($tr.children('td:eq(3)').text());
            $("#inputEmail").val($tr.children('td:eq(4)').text());
            $(".userInfo-modal").attr("data-id", $tr.attr("data-id"));
            var selectRole = $tr.children('td:eq(5)').text();
            if (selectRole == '管理员') {
                $("#selectRole").val(1);
            } else {
                $("#selectRole").val(0);
            }
            $("#inputRemark").val($tr.children('td:eq(6)').text());
            return false;
        });
        $("#update-user-button").click(function () {
            var updateUser = {};
            updateUser.phone = $("#inputPhone").val();
            updateUser.email = $("#inputEmail").val();
            updateUser.role = $("#selectRole").val();
            updateUser.remark = $("#inputRemark").val();
            updateUser.userId = $(".userInfo-modal").attr("data-id");
            $.ajax({
                url: "/bridge/userManage/update" ,
                type: "post",
                contentType : 'application/json;charset=utf-8',
                data: JSON.stringify(updateUser),
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
        $("#batch-delete").click(function () {
            var deleteUserIdList = [];
            $('table input:gt(0)').each(function(){
                if($(this).prop('checked')) {
                    var userId = $($(this).parents("tr")[0]).attr("data-id");
                    deleteUserIdList.push(userId);
                }
            });
            if (!_.isEmpty(deleteUserIdList)) {
                $.ajax({
                    url: "/bridge/userManage/batchDelete" ,
                    type: "post",
                    contentType : 'application/json;charset=utf-8',
                    data: JSON.stringify(deleteUserIdList),
                    success: function (result) {
                        if (result.success) {
                            location.reload();
                        } else {
                        }
                    }
                })
            } else {
                //todo warning
            }
        });
    }


});