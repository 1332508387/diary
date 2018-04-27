<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="include/common.jsp"%>
<!DOCTYPE html>
<html>
	<head>
       	<%@ include file="include/title.jsp" %>
       	<link href="${path}/res/plugins/datepicker/datepicker3.css" rel="stylesheet"/>
       	<link href="${path}/res/plugins/validator/bootstrapValidator.min.css" rel="stylesheet"/>
       	<link href="${path}/res/lobibox/lobibox.css" rel="stylesheet"/>
		<link href="${path}/css/home/home.css" rel="stylesheet"/>
	</head>
	
	<!-- skin-blue 为 AdminLTE 的主题颜色 可选颜色主题：/res/dist/css/skins-->
	<!-- <body class="hold-transition skin-blue sidebar-mini"> -->
	<body class="hold-transition skin-green-light sidebar-mini">
		<div class="wrapper">
			<!--header-->
       		<%@ include file="include/header.jsp" %>
			<!--menu-->
       		<%@ include file="include/menu.jsp" %>
			<!-- Left side column. contains the logo and sidebar -->
			<!-- Content Wrapper. Contains page content -->
			<div class="content-wrapper">
				<%-- <section class="content-header">
					<!-- 路径导航 -->
					<a href="${path}/home"><i class="fa fa-home"></i> 主页</a> > 
				</section> --%>
				<!-- Main content -->
				<section class="content">
					<div class="row-fluid"></div>
					<div class="row">
						<div class="col-xs-12">
							<div class="box">
								<div class="box-body">
									<h2 id="startDate"></h2>
									<div id="main" style="width: 600px;height:400px;"></div>
								</div>
								<!-- /.box-body -->
							</div>
							<!-- /.box -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</section>
			</div>
			<!--footer-->
	       	<%@ include file="include/footer.jsp" %>
			<div class="control-sidebar-bg"></div>
		</div>

		<!-- Sidebar toggle button 菜单收缩功能 -->
		<script src="${path}/res/dist/js/app.min.js" type="text/javascript"></script>
		<script src="${path}/res/laydate/laydate.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datepicker.js"  type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datetimepicker.zh-CN.js"  type="text/javascript"></script>
		<script src="${path}/res/plugins/validator/bootstrapValidator.min.js"  type="text/javascript"></script>
		<script src="${path}/js/site.js" type="text/javascript"></script>
		<script src="${path}/js/base64.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/kindeditor-all-min.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/lang/zh_CN.js" type="text/javascript"></script>
		<script src="${path}/res/echarts.min.js" type="text/javascript"></script>
		<script src="${path}/js/home/home.js" type="text/javascript"></script>
	</body>
</html>
