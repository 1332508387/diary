<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/include/taglib.jsp"%>
<%@ include file="/WEB-INF/pages/include/common.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<!--title-->
       	<%@ include file="/WEB-INF/pages/include/title.jsp" %>
       	
		<link rel="stylesheet" href="${path}/res/plugins/validator/bootstrapValidator.min.css">
		<script src="${path}/res/plugins/validator/bootstrapValidator.min.js"></script>	 
		<script src="${path}/res/plugins/validator/language/zh_CN.js"></script> 
		<script src="${path}/js/user/loginValidate.js"></script>

		<style>
			/*html,body{
				height:100%;
				width:100%;
				background: url(/img/user/login/login-background.jpg) no-repeat center center;
				background-size:1920px 1000px;
				perspective:500px;
			}*/
			@keyframes cc{
				0%{opacity: 0.4;transform: scale(0.1) ;top: -500px;}
				50%{opacity: 0.4;transform: scale(0.1) rotateX(90deg);top: -50px;}
				100%{opacity: 1;transform: scale(1) rotateX(0deg);top: 0;}
			}
			#loginDiv{
				animation: cc 1.5s ease-in-out ;
			}
		</style>
	</head>
	
	<body class="hold-transition login-page" >
		<div class="login-box" id="loginDiv">
			<div class="login-logo">
				<b style="color: white;">用户登陆</b>
			</div>
			<!-- /.login-logo -->
			<div class="login-box-body">
				  <p class="login-box-msg">用户登陆</p> 
					<!--<sp:message code="user.login"/>-->
	
				<form id="loginForm1" autocomplete="off" action="/user/doLogin" method="post">
					<div class="row" style="text-align: center;">
						<span id="loginMessage" style="color: red;"><%-- ${session.SPRING_SECURITY_LAST_EXCEPTION.message} --%>${session.SPRING_SECURITY_LAST_EXCEPTION.message}${error}</span>
					</div>
					<div class="form-group has-feedback">
						<input type="text" class="form-control" name="username" placeholder="用户名" value="${requestScope.username}">
					</div>
					<div class="form-group has-feedback">
						<input type="password" class="form-control" name="password" placeholder="密码">
					</div>
					<div class="form-group has-feedback row">
						<div class='col-sm-5'>
							<input type="text" class="form-control" style="height: 40px;" name="verifyCode" id="verifyCode" placeholder="验证码">
						</div>
						<div class='col-sm-7' style="padding-left: 0px;">
							<img id="verify" width="110" height="40" src="/code/captchaImage" />
							<a href="javascript:void(0)" id="verify_a" style="margin-left: 10px;">换一张</a>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-8">
							<div class="checkbox icheck">
								<label> <input type="checkbox"> 记住密码 </label>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="${path}/admin/register.jsp" style="margin-left: 10px;">忘记密码</a>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<button class="btn btn-success btn-block" id="login1">登录</button>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col-xs-12">
						<a href="${path}/register" class="btn btn-default btn-block"> 用户注册 </a>
					</div>
				</div>
			</div>
			<!-- /.login-box-body -->
		</div>
		<!-- /.login-box -->
	</body>
	<script type="text/javascript">
		$(function(){
            $('input').iCheck({
                checkboxClass : 'icheckbox_square-blue',
                radioClass : 'iradio_square-blue',
                increaseArea : '20%' // optional
            });

		    $('#verify_a').click(function(){
		        var date = new Date();
		        $('#verify').attr('src', '/code/captchaImage?t=' + date.getMilliseconds());
		        $('#verifyCode').val('');
			})
		})
	</script>
</html>