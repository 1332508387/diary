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
		<script src="${path}/js/user/registerValidate.js"></script>

		<style>
			@keyframes cc{
				0%{opacity: 0.4;transform: scale(0.1) ;top: -500px;}
				50%{opacity: 0.4;transform: scale(0.1) rotateX(90deg);top: -50px;}
				100%{opacity: 1;transform: scale(1) rotateX(0deg);top: 0;}
			}
			#registerDiv{
				animation: cc 1.5s ease-in-out ;
			}
		</style>
	</head>
	
	<body class="hold-transition login-page" >
		<div class="login-box" id="registerDiv">
			<div class="login-logo">
				<b style="color: white;">用户注册</b>
			</div>
			<!-- /.login-logo -->
			<div class="login-box-body">
				  <p class="login-box-msg">用户注册</p> 
					<!--<sp:message code="user.login"/>-->
	
				<form id="registerFrom">
					<div class="row" style="text-align: center;">
						<span id="regMessage" style="color: red;"></span>
					</div>
					<!-- <div class="form-group">
					    <label class="control-label">Full name</label>
					    <div class="">
					        <input type="text" class="form-control" name="firstName"
					            placeholder="First name"  data-bv-notempty
					            data-bv-notempty-message="firstName不能为空(提示语)" 
					            />
					</div> -->
					<div class="form-group has-feedback">
						<input type="text" class="form-control" name="username" id="username" placeholder="用户名">
					</div>
					<div class="form-group has-feedback">
						<input type="password" class="form-control" name="password" placeholder="密码">
					</div>
					<div class="form-group has-feedback">
						<input type="password" class="form-control" name="password2" placeholder="确认密码">
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
						<div class="col-xs-12">
							<button type="button" class="btn btn-success btn-block" id="reg">立即注册</button>
						</div>
					</div>
				</form>
				<div class="row">
					<div class="col-xs-12">
						<a href="${path}/login.html" class="btn btn-default btn-block"> 登陆 </a>
					</div>
				</div>
			</div>
			<!-- /.login-box-body -->
		</div>
		<!-- /.login-box -->
		<script>
			$(function(){
			    $('#verify_a').click(function(){
                    setVerify();
				});
			})
			function setVerify(){
                var date = new Date();
                $('#verify').attr('src', '/code/captchaImage?t=' + date.getMilliseconds());
                $('#verifyCode').val('');
			}
		</script>
	</body>
</html>