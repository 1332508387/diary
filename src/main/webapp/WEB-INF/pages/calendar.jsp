<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="include/common.jsp"%>
<!DOCTYPE html>
<html>
	<head>
       	<%@ include file="include/title.jsp" %>
       	<link href="${path}/res/plugins/datepicker/datepicker3.css" rel="stylesheet"/>
       	<link href="${path}/res/plugins/validator/bootstrapValidator.min.css" rel="stylesheet"/>
       	<link href="${path}/res/lobibox/lobibox.css" rel="stylesheet"/>
       	<link href="${path}/res/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet"/>
       	<link href="${path}/res/plugins/fullcalendar/fullcalendar2.css" rel="stylesheet"/>
		<link href="${path}/css/calendar/calendar.css" rel="stylesheet"/>
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
				<!-- Main content -->
				<section class="content">
					<div class="row">
						<div class="col-xs-12">
							<div class="box">
								<div class="box-body">
									<div id="desc">
										<table>
											<tr><td style="background: #98FB98; width: 50px; height: 5px"></td><td>&nbsp开写日期&nbsp&nbsp</td>
											<td style="background: #5CACEE; width: 50px; height: 5px"></td><td>&nbsp已写日期&nbsp&nbsp</td>
											<td style="background: #FF6347; width: 50px; height: 5px"></td><td>&nbsp漏写日期&nbsp&nbsp</td></tr>
										</table>
									</div>
									<div id="dateFlag"></div>
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
			<!-- 展示日记内容窗口 -->
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
								<table border="0" width=100% id="showContentTab">
									<!-- <tr>
                                        <td id="showContent"></td>
                                    </tr> -->
								</table>
							</div>
							<!-- modal-body END -->
						</div>
					</div>
				</div>
			</div>
			<div class="window">
				<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<form id="hiddenForm">
							<input type="hidden" name="id">
							<input type="hidden" name="writeDate">
							<input type="hidden" name="moodId">
							<input type="hidden" name="keyword">
							<input type="hidden" name="site">
							<input type="hidden" name="remark">
							<input type="hidden" name="content">
							<input type="hidden" name="isLock">
						</form>
						<!-- autocomplete="off" 禁止 input 缓存 -->
						<form class="form-horizontal" id="editForm" action="" method="post" autocomplete="off">
							<div class="modal-content">
								<div class="modal-header bg-green" style="background-color: #307095;">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times;</span><span class="sr-only"><sp:message code="sys.close" /></span>
									</button>
									<h4 class="modal-title" id="myModalLabel">日志管理-编辑</h4>
								</div>

								<div class="modal-body">
									<input type="hidden" name="id">
									<div class="form-group ">
										<label for="inputName" class="col-sm-1 control-label">日期</label>
										<div class="col-sm-11">
											<input type="text" class="form-control form_datetime" placeholder="输入日期" name="writeDate" id="write" readonly>
										</div>
									</div>
									<div class="form-group ">
										<label for="inputName" class="col-sm-1 control-label">心情</label>
										<div class="col-sm-11">
											<select  class="form-control" name="moodId" id="sel2">
												<option disabled selected value="0">请选择心情</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-sm-1 control-label">关键字</label>
										<div class="col-sm-11">
											<input type="text" class="form-control" placeholder="输入关键字" name="keyword">
										</div>
									</div>
									<div class="form-group">
										<a id="setSite" href="javascript:void(0)" style="cursor:pointer;">
											<label for="inputName" class="col-sm-1 control-label" data-toggle='tooltip' data-placement='right' title="点击获取当前位置，支持 IE/Edge，Chrome 需能访问 Google">地点</label>
										</a>
										<div class="col-sm-11">
											<input type="text" class="form-control" placeholder="输入地点" name="site">
										</div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-sm-1 control-label">备注</label>
										<div class="col-sm-11">
											<input type="text" class="form-control" placeholder="输入备注" name="remark">
										</div>
									</div>
									<div class="form-group" id="lock">
										<label for="inputName" class="col-xs-1 control-label">类型</label>
										<div class="col-xs-3">
											<label class="checkbox-inline">
												<!-- <input type="radio" name="status" id="status" value="0" checked> 普通 -->
											</label>
											<label class="checkbox-inline">
												<!-- <input type="radio" name="status" id="status2" value="2"> 锁定 -->
											</label>
										</div>
										<div id="pwd">
											<!-- <input type="text" class="form-control" placeholder="输入密码" name="pwd"> -->
										</div>
									</div>
									<div class="form-group">
										<label for="inputName" class="col-sm-1 control-label">内容</label>
										<div class="col-sm-11">
											<textarea style="width:828px;height:400px;visibility:hidden;" id="content" name="content" data-bv-notempty data-bv-notempty="not empt"></textarea>
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
			<!--footer-->
	       	<%@ include file="include/footer.jsp" %>
			<div class="control-sidebar-bg"></div>
		</div>

		<!-- Sidebar toggle button 菜单收缩功能 -->
		<script src="${path}/res/dist/js/app.min.js" type="text/javascript"></script>
		<script src="${path}/res/laydate/laydate.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/datepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
		<script src="${path}/res/plugins/validator/bootstrapValidator.min.js" type="text/javascript"></script>
		<script src="${path}/js/site.js" type="text/javascript"></script>
		<script src="${path}/js/base64.js" type="text/javascript"></script>
		<%-- 使用 Bootstrap 日历插件
			<script src="${path}/js/calendar/calendar.js" ></script> --%>
		<!-- 使用 Fullcalendar 日历插件 -->
		<script src="${path}/js/calendar/calendar2.js" type="text/javascript"></script>
		<script src="${path}/js/diary/lock.js" type="text/javascript"></script>
		<script src="${path}/js/diary/editFormValidate.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/kindeditor-all-min.js" type="text/javascript"></script>
		<script src="${path}/res/kindeditor-4.1.4/lang/zh_CN.js"type="text/javascript"></script>
		<script src="${path}/res/echarts.min.js" type="text/javascript"></script>
		<!-- 扩展添加了农历 -->
		<script src="${path}/res/plugins/fullcalendar/fullcalendar2.js" type="text/javascript"></script>
		<%-- <script src="${path}/res/plugins/fullcalendar/fullcalendar.js"></script> --%>
		<script src="${path}/res/plugins/fullcalendar/fullcalendar.print.css"></script>
		<script type="text/javascript">
            // 点击 <a>，获取位置，设置到 <input>
            $("#setSite").click(function(){
                setLocation();// 设置位置，IE可用，Chrome，Firefox需翻墙
            });
		</script>
	</body>
</html>
