<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="include/common.jsp"%>

<!DOCTYPE html>
<html>
	<head>
       	<%@ include file="include/title.jsp" %>
       	<link href="${path}/res/plugins/datepicker/datepicker3.css" rel="stylesheet" />
       	<link href="${path}/res/plugins/validator/bootstrapValidator.min.css" rel="stylesheet" />
       	<link href="${path}/res/lobibox/lobibox.css" rel="stylesheet" />
       	<link href="${path}/css/mood/mood.css" rel="stylesheet"/>
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
					<a href="${path}/mood">日记管理</a>&nbsp;&nbsp;<small>日记列表</small>
				</section>
				<!-- Main content -->
				<section class="content">
					<!-- 查询、添加、批量删除、导出、刷新 -->
					<div class="row-fluid">
						<div class="pull-right">
							<div class="btn-group">
								<security:authorize access="hasRole('ROLE_0')">
									<button type="button" class="btn btn-primary btn-sm"  id="btn-add">
										<i class="fa fa-plus"></i> 添加
									</button>
								</security:authorize>
								<button type="button" class="btn btn-primary btn-sm" id="btn-re">
									<i class="fa fa-refresh"></i> 刷新
								</button>
							</div>
						</div>
						<div class="row">
							<form id="queryForm" method="post">
								<div class="col-xs-2">
									<select class="form-control input-sm" name="key">
										<option disabled selected>查询条件</option>
										<option value="all">全部</option>
										<option value="name">名称</option>
										<option value="type">类型</option>
									</select>
								</div>
								<div class="" name="valTarget">
								</div>
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
												<th>名称</th>
												<th>类型</th>
												<th>备注</th>
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
		<div class="window">
			<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<form class="form-horizontal" id="editForm" method="post">
						<div class="modal-content">
							<div class="modal-header" style="background-color: #307095;">
								<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">&times;</span><span class="sr-only"><sp:message code="sys.close" /></span>
								</button>
								<h4 class="modal-title" id="myModalLabel">心情管理-编辑</h4>
							</div>
							<div class="modal-body">
								<input type="hidden" name="id">
								<div class="form-group">
									<label for="inputName" class="col-sm-1 control-label">名称</label>
									<div class="col-sm-11">
										<input type="text" class="form-control" placeholder="输入名称" name="name">
									</div>
								</div>
								<div class="form-group ">
									<label for="inputName" class="col-sm-1 control-label">类型</label>
									<div class="col-sm-11">
										<select  class="form-control" name="type">
											<option disabled selected value="-1">请选择类型</option>
											<option value="0">积极</option>
											<option value="1">中性</option>
											<option value="2">消极</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="inputName" class="col-sm-1 control-label">备注</label>
									<div class="col-sm-11">
										<input type="text" class="form-control" placeholder="输入备注" name="remark">
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

		<!-- Sidebar toggle button 菜单收缩功能 -->
		<script src="${path}/res/dist/js/app.min.js" type="text/javascript"></script>
		<script src="${path}/res/laydate/laydate.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/validator/bootstrapValidator.min.js" type="text/javascript"></script>
		<script src="${path}/js/mood/editFormValidate.js" type="text/javascript"></script>
		<script src="${path}/js/mood/mood.js" type="text/javascript"></script>
		<script src="${path}/res/laydate/laydate.js" type="text/javascript"></script>
		<script src="${path}/js/site.js" type="text/javascript"></script>
		<script src="${path}/js/base64.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/kindeditor-all-min.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/lang/zh_CN.js" type="text/javascript"></script>
		<script src="${path}/res/lobibox/lobibox.js" type="text/javascript"></script>
		<security:authorize access="hasRole('ROLE_0')">
			<script type="text/javascript">
                $(function(){
                    tables.fnSetColumnVis(6, true);
                })
			</script>
		</security:authorize>
		<security:authorize access="not hasRole('ROLE_0')">
			<script type="text/javascript">
                $(function(){
                    tables.fnSetColumnVis(6, false);
                })
			</script>
		</security:authorize>
	</body>
</html>
