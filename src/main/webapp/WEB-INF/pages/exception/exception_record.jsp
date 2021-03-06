<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../include/common.jsp"%>
<!DOCTYPE html>
<html>
	<head>
       	<%@ include file="../include/title.jsp" %>
       	<link href="${path}/res/plugins/datepicker/datepicker3.css" rel="stylesheet">
       	<link href="${path}/res/plugins/validator/bootstrapValidator.min.css" rel="stylesheet"/>
		<link href="${path}/css/exception/exception_record.css" rel="stylesheet"/>
	</head>

	<body class="hold-transition skin-green-light sidebar-mini">
		<div class="wrapper">
       		<%@ include file="../include/header.jsp" %>
       		<%@ include file="../include/menu.jsp" %>
			<div class="content-wrapper">
				<section class="content-header">
					<a href="${path}/home"><i class="fa fa-home"></i> 主页</a> >
					<a href="${path}/exception/exception_record">异常记录管理</a>&nbsp;&nbsp;<small>异常记录列表</small>
				</section>
				<section class="content">
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
								<input type="hidden" name="keywords"/>
								<div class="form-group" id="dateDiv">
									<%--<select class="form-control input-sm" style="width: 200px;" name="exceptionTypeId" id="keyword"></select>--%>
									<select  class="form-control" id="keyword" multiple="multiple" style="width: 200px;"></select>
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
												<th>序号</th>
												<th>异常信息</th>
												<th>类型</th>
												<th>备注</th>
												<th>创建日期</th>
												<th>修改日期</th>
												<th>操作</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
	       	<%@ include file="../include/footer.jsp" %>
			<div class="control-sidebar-bg"></div>
		</div>
		<div class="row">
			<div class="window col-xs-12">
				<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<form id="hiddenForm">
							<input type="hidden" name="id"/>
							<input type="hidden" name="exceptionTypeIds"/>
							<input type="hidden" name="remark"/>
							<input type="hidden" name="exceptionInfo"/>
							<input type="hidden" name="solution"/>
						</form>
						<form class="form-horizontal" id="editForm" action="" method="post" autocomplete="off">
							<div class="modal-content">
								<div class="modal-header bg-green" style="background-color: #307095;">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times;</span><span class="sr-only"><sp:message code="sys.close" /></span>
									</button>
									<h4 class="modal-title cyrillic-ext" id="myModalLabel">异常记录管理-编辑</h4>
								</div>
								<div class="modal-body">
									<input type="hidden" name="id">
									<div class="form-group " id="exceptionTypeDiv">
										<label for="inputName" class="col-xs-1 control-label">所属分类</label>
										<div class="col-xs-4">
											<select  class="form-control" name="exceptionTypeIds" id="exceptionTypeIds" multiple="multiple" style="width: 300px;"></select>
										</div>
										<div id="customForType"></div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-xs-1 control-label">异常信息</label>
										<div class="col-xs-11">
											<input type="text" class="form-control" placeholder="输入关异常信息" name="exceptionInfo">
										</div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-xs-1 control-label">备注</label>
										<div class="col-xs-11">
											<input type="text" class="form-control" placeholder="输入备注" name="remark">
										</div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-xs-1 control-label">解决方案</label>
										<div class="col-xs-11">
											<textarea style="width:828px;height:400px;visibility:hidden;" id="solution" name="solution"></textarea>
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
			<div class="window row">
				<div class="modal fade col-xs-12" id="contentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-green" style="background-color: #307095;">
								<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">&times;</span><span class="sr-only"><sp:message code="sys.close" /></span>
								</button>
								<h4 class="modal-title" id="myModalLabel"></h4>
							</div>
							<div class="modal-body" >
								<table border="0" width=100% id="showContentTab"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script src="${path}/res/dist/js/app.min.js"></script>
		<script src="${path}/res/laydate/laydate.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/validator/bootstrapValidator.min.js" type="text/javascript"></script>
		<script src="${path}/js/base64.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/kindeditor-all-min.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/lang/zh_CN.js" type="text/javascript"></script>
		<script src="${path}/js/exception/exception.js"></script>
	</body>
</html>
