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
            var userName = $($($(this).parents("tr")[0]).children()[2]).text();
            if (confirm('确认删除用户【'+ userName +'】吗？')) {
                $.ajax({
                    url: "/bridge/userManage/delete?userId=" + userId ,
                    type: "get",
                    success: function (result) {
                        if (result.success) {
                            location.reload();
                        } else {
                            alert(result.message);
                        }
                    }
                });
            }
            return false;
        });
        $(".update-user").click(function () {
            var $tr = $($(this).parents("tr")[0]);
            $(".userInfo-modal").modal('show');
            $("#userNameLabel").text($tr.children('td:eq(2)').text());
            $("#inputNickName").val($tr.children('td:eq(3)').text());
            $("#inputPhone").val($tr.children('td:eq(4)').text());
            $("#inputEmail").val($tr.children('td:eq(5)').text());
            $(".userInfo-modal").attr("data-id", $tr.attr("data-id"));
            var selectRole = $tr.children('td:eq(6)').text();
            if (selectRole == '管理员') {
                $("#selectRole").val(1);
            } else {
                $("#selectRole").val(0);
            }
            $("#inputRemark").val($tr.children('td:eq(7)').text());
            return false;
        });
        $("#update-user-button").click(function () {
            var updateUser = {};
            updateUser.nickName = $("#inputNickName").val();
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
        $("#insert-user-button").click(function () {
            var user = {};
            user.userName = $("#userNameInput2").val();
            user.password = $("#passwordInput2").val();
            user.nickName = $("#inputNickName2").val();
            user.phone = $("#inputPhone2").val();
            user.email = $("#inputEmail2").val();
            user.role = $("#selectRole2").val();
            user.remark = $("#inputRemark2").val();
            if (_.isEmpty(user.userName)) {
                $("#error-msg-label2").text('用户名不能为空');
                $("#error-msg-div2").prop('hidden', false);
                return false;
            }
            if (_.isEmpty(user.password)) {
                $("#error-msg-label2").text('密码不能为空');
                $("#error-msg-div2").prop('hidden', false);
                return false;
            }
            if (!_.isEmpty(user.email)) {
                if (!/^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g.test(user.email)) {
                    $("#error-msg-label2").text('邮箱格式不正确');
                    $("#error-msg-div2").prop('hidden', false);
                    return false;
                }
            }
            $("#error-msg-div2").prop('hidden', true);
            $.ajax({
                url: "/bridge/userManage/insert" ,
                type: "post",
                contentType : 'application/json;charset=utf-8',
                data: JSON.stringify(user),
                success: function (result) {
                    if (result.success) {
                        alert('添加成功！');
                        location.reload();
                    } else {
                        $("#error-msg-label2").text(result.message);
                        $("#error-msg-div2").prop('hidden', false);
                    }
                }
            });
            return false;
        });
        $("#add-button").click(function () {
            $("#error-msg-label2").text('');
            $("#error-msg-div2").prop('hidden', true);
            $(".addUserInfo-modal").modal('show');
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