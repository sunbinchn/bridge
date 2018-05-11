// document.getElementById("name").focus();
$(function () {
    $("#submit").click(function(){
        var username = $("#username").val();
        var password = $("#password").val();
        if (!(username && password)){ //用户名或密码为空
            $('.form-signin-heading').text('用户名或密码不能为空');
            return;
        }
        var data = 'userName=' + username + '&' + 'password=' + password;
        $.ajax({
            url: "/bridge/login/signin",
            type: "post",
            data: data,
            success: function (result) {
                if (result.success) {
                    window.location.href = '/bridge/monitorInfoData/getAll'
                } else {
                    $('.form-signin-heading').text(result.message);
                }
            }
        });
        return false;
    })
});