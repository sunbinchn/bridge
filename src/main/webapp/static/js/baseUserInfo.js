$(function () {
    init_event();


    function init_event() {
        $("#userInfoButton").addClass("color-info");
        $("#baseInfoLi").click(function () {
            $('#passwordLi').removeClass("active");//todo 一直点会出错
            $('#baseInfoLi').addClass("active");
            $('#updateUserInfoForm').css('display','block');
            $('#updateUserPasswordForm').css('display','none');
            return false;
        });
        $("#passwordLi").click(function () {
            $('#passwordLi').addClass("active");
            $('#baseInfoLi').removeClass("active");
            $('#updateUserInfoForm').css('display','none');
            $('#updateUserPasswordForm').css('display','block');
            return false;
        });
        $('#baseInfoSubmitButton').click(function () {
            $('#updateUserPasswordForm').serializeArray();
            var updateUser = {};
            updateUser.nickName = $("#nickName").val();
            updateUser.phone = $("#phone").val();
            updateUser.email = $("#email").val();
            updateUser.remark = $("#remark").val();
            $.ajax({
                url: "/bridge/userInfo/update" ,
                type: "post",
                contentType : 'application/json;charset=utf-8',
                data: JSON.stringify(updateUser),
                success: function (result) {
                    if (result.success) {
                        $('#userInfoUpdateSuccess').css('display','block');
                    } else {
                        // $("#error-msg-label").text(result.message);
                        // $("#error-msg-div").prop('hidden', false);
                    }
                }
            });
            return false;
        });
        $("#userInfoUpdateSuccessClose").click(function(){
            $('#userInfoUpdateSuccess').css('display','none');
            return false;
        });
        $("#userPasswordUpdateSuccessClose").click(function(){
            $('#userPasswordUpdateSuccess').css('display','none');
            return false;
        });

        $('#passwordSubmitButton').click(function () {
            var newPassword1 = $("#newPassword1").val();
            var newPassword2 = $("#newPassword2").val();
            if (newPassword1 != newPassword2) {
                //todo 两次密码不一致
                return false;
            }
            var updateUser = {};
            updateUser.oldPassword = $("#oldPassword").val();
            updateUser.newPassword = newPassword1;
            $.ajax({
                url: "/bridge/userInfo/updatePass" ,
                type: "post",
                contentType : 'application/json;charset=utf-8',
                data: JSON.stringify(updateUser),
                success: function (result) {
                    if (result.success) {
                        $('#userPasswordUpdateSuccess').css('display','block');
                    } else {
                        // $("#error-msg-label").text(result.message);
                        // $("#error-msg-div").prop('hidden', false);
                    }
                }
            });
            return false;
        })
    }
});