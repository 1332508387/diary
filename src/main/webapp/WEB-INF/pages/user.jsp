<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="include/common.jsp"%>

<!DOCTYPE html>
<html>
	<head>
       	<%@ include file="include/title.jsp" %>
       	<link href="${path}/res/plugins/datepicker/datepicker3.css" rel="stylesheet">
       	<link href="${path}/res/plugins/validator/bootstrapValidator.min.css" rel="stylesheet"/>
		<link href="${path}/css/user/user.css" rel="stylesheet"/>
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
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<!-- 路径导航 -->
					<a href="${path}/home"><i class="fa fa-home"></i> 主页</a> > 
					<a href="${path}/user">用户管理</a>&nbsp;&nbsp;<small>用户列表</small>
				</section>
				<!-- Main content -->
				<section class="content">
					<!-- 查询、添加、批量删除、导出、刷新 -->
					<div class="row-fluid">
						<div class="pull-right">
							<div class="btn-group">
								<button type="button" class="btn btn-primary btn-sm"  id="btn-add">
									<i class="fa fa-plus"></i> 添加
								</button>
								<button type="button" class="btn btn-primary btn-sm" id="btn-re">
									<i class="fa fa-refresh"></i> 刷新
								</button>
							</div>
						</div>
						<div class="pull-left">
							<form id="queryForm" class="form-inline" method="post">
								<!-- <a id="clearDate">清除</a> -->
								<div class="form-group">
									<select class="form-control input-sm" name="key">
										<option disabled selected>请选择查询字段</option>
										<option value="all">全部</option>
										<option value="username">用户名</option>
										<option value="type">用户类型</option>
									</select>
								</div>
								<div class="form-group" id="searchValDiv"></div>
								<button type="button" class="btn btn-primary btn-sm" id="btn-query">
									<i class="fa fa-search"></i> 查询
								</button>
							</form>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<div class="box">
								<div class="box-body">
									<table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
										<thead>
											<tr class="info">
												<!-- <td><input type="checkbox" id="checkAll"></td> -->
												<th>序号</th>
												<th>用户名</th>
												<th>用户类型</th>
												<th>创建时间</th>
												<th>修改时间</th>
												<th>操作</th>
											</tr>
										</thead>
									</table>
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
		
		<!-- 独立窗口，点击触发 -->
		<!-- 添加、修改窗口 -->
		<div class="row">
			<div class="window col-xs-12">
				<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<!-- autocomplete="off" 禁止 input 缓存 -->
						<form class="form-horizontal" id="editForm" action="" method="post" autocomplete="off">
							<div class="modal-content">
								<div class="modal-header bg-green" style="background-color: #307095;">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times;</span><span class="sr-only"><sp:message code="sys.close" /></span>
									</button>
									<h4 class="modal-title cyrillic-ext" id="myModalLabel">用户管理-编辑</h4>
								</div>
								<div class="modal-body">
									<input type="hidden" name="id">
									<div class="form-group">
										<label for="inputName" class="col-xs-1 control-label">用户名</label>
										<div class="col-xs-11">
											<input type="text" class="form-control" placeholder="输入用户名" name="username">
										</div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-xs-1 control-label">类型</label>
										<div class="col-xs-11">
											<select class="form-control" name="type" id="sel1">
												<option selected value="0">管理员</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-xs-1 control-label">密码</label>
										<div class="col-xs-11">
											<input type="text" class="form-control" placeholder="输入密码" name="password">
										</div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-xs-1 control-label">确认密码</label>
										<div class="col-xs-11">
											<input type="text" class="form-control" placeholder="确认密码" name="password2">
										</div>
									</div>
								</div>
								<!-- modal-body END -->
								<div class="modal-footer">
									<button type="submit" name="submit" id="btn-submit" class="btn btn-primary">提交</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 锁定窗口  -->
		<div class="modal fade" id="lockModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header" style="background-color: #307095;">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only"><sp:message code="sys.close" /></span>
						</button>
						<h4 class="modal-title" id="myModalLabel">提示信息</h4>
					</div>
					<div class="modal-body" >
						<div class="form-group">
							<p class="text-danger"><span><strong>此日记已锁定，请输入口令再进行操作</strong></span></p>
							<div>
								<input type="password" class="form-control" placeholder="口令" name="pwd">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" name="lockSubmit" id="btn-submit" class="btn btn-primary">提交</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Sidebar toggle button 菜单收缩功能 -->
		<script src="${path}/res/dist/js/app.min.js"></script>
		<script src="${path}/res/laydate/laydate.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/validator/bootstrapValidator.min.js" type="text/javascript"></script>
		<script src="${path}/res/laydate/laydate.js" type="text/javascript"></script>
		<script src="${path}/js/site.js" type="text/javascript"></script>
		<script src="${path}/js/base64.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/kindeditor-all-min.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/lang/zh_CN.js" type="text/javascript"></script>
		<script src="${path}/js/user/user.js" type="text/javascript"></script>
	</body>
</html>
