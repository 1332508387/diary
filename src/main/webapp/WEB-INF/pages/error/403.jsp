<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>错误</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="${path}/css/error/error.css">
<script src="${path}/res/plugins/jQuery/jquery-2.2.3.min.js"></script>
</head>
<body class="error">
<div id="doc_main">
	<section class="bd clearfix">
		<div class="module-error">
			<div class="error-main clearfix">
				<div class="label"></div>
				<div class="info">
					<h3 class="title">403！</h3>
					<h3 class="title">放弃吧，你无权访问</h3>
					<div class="reason">
						<!-- <p>可能的原因：</p>
						<p>1.手抖打错了。</p>
						<p>2.链接过了保质期。</p> -->
					</div>
					<div class="oper">
						<p><a href="javascript:history.go(-1);">返回上一级页面&gt;</a></p>
						<p><a href="/home.html">回到网站首页&gt;</a></p>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script type="text/javascript">
	/* window.setTimeout(home,3000);
	function home(){
		location.href = "/home.html";
	} */
</script>
</body>
</html>