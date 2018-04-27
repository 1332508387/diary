<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/include/taglib.jsp"%>
<%@ include file="/WEB-INF/pages/include/common.jsp"%>
<html>
<head>
    <title>登录</title>

    <link rel="stylesheet" href="${path}/res/plugins/validator/bootstrapValidator.min.css">
    <link rel="stylesheet" href="${path}/css/user/register/register.css">
    <script src="${path}/res/plugins/validator/bootstrapValidator.min.js"></script>
    <script src="${path}/res/plugins/validator/language/zh_CN.js"></script>
    <script src="${path}/js/user/registerValidate.js"></script>
</head>
<body>
    <div style="height:1px;"></div>
    <div class="login">
        <header>
            <h1>注册</h1>
        </header>
        <div class="sr">
            <form id="registerFrom">
                <div class="row" style="text-align: center;">
                    <span id="regMessage" style="color: red;"></span>
                </div>
                <div class="name form-group">
                    <label>
                        <i class="sublist-icon glyphicon glyphicon-user"></i>
                    </label>
                    <input type="text"  placeholder="用户名" class="name_inp form-control" id="username" name="username">
                </div>
                <div class="name form-group">
                    <label>
                        <i class="sublist-icon glyphicon glyphicon-pencil"></i>
                    </label>
                    <input type="text"  placeholder="密码" class="name_inp form-control" id="password" name="password">
                </div>
                <div class="name form-group">
                    <label>
                        <i class="sublist-icon glyphicon glyphicon-pencil"></i>
                    </label>
                    <input type="text"  placeholder="确认密码" class="name_inp form-control" id="password2" name="password">
                </div>
                <div class="form-group has-feedback row">
                    <div class='col-sm-6'>
                        <input type="text" class="form-control" style="height: 40px;" name="verifyCode" id="verifyCode" placeholder="验证码">
                    </div>
                    <div class='col-sm-6' style="padding-left: 0px;">
                        <img id="verify" width="110" height="40" src="/code/captchaImage" style="cursor:hand;"/>
                        <%--<a href="javascript:void(0)" id="verify_a" style="margin-left: 10px;">换一张</a>--%>
                    </div>
                </div>
                <button class="dl" id="reg">注册</button>
                <span style="float: right;"><span style="color: #000000">已注册，去</span><a href="${path}/login2.html">登录</a></span>
            </form>
        </div>
    </div>
</body>
<script>
    $(function(){
        $('#verify').click(function(){
            var date = new Date();
            $('#verify').attr('src', '/code/captchaImage?t=' + date.getMilliseconds());
            $('#verifyCode').val('');
        })
    });
</script>
</html>
