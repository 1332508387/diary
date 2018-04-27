<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/res/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/res/plugins/validator/bootstrapValidator.min.css" />
<link rel="stylesheet" href="/res/plugins/datepicker/datepicker3.css">
<link rel="stylesheet" href="/res/plugins/bootstrap-slider/slider.css">
<!-- 双日历插件 -->
<link rel="stylesheet" href="${path}/res/plugins/daterangepicker/daterangepicker.css">

<script type="text/javascript"
	src="/res/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="/js/base64.js"></script>
<script type="text/javascript" src="/js/security.js"></script>
<script type="text/javascript" src="/res/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="/res/plugins/validator/bootstrapValidator.min.js"></script>
<script src="/res/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/res/plugins/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="/res/plugins/bootstrap-slider/bootstrap-slider.js"></script>
<script src="/res/plugins/bootstrap-slider/bootstrap-slider.js"></script>
<script src="${path}/res/plugins/daterangepicker/moment.min.js"></script>
<script src="${path}/res/plugins/daterangepicker/daterangepicker.js"></script>
</head>
<body>
	<input id="btntext" type="button" value="添加文本组件" data-toggle="modal"
		data-target="#myModal" href="../SysManage/ZuJianManage.aspx" />
	<!-- Modal -->
	<div class="modal hide fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal">×</button>
			<h3 id="myModalLabel">Modal header</h3>
		</div>
		<div class="modal-body"></div>
		<div class="modal-footer">

			<a href="#" class="btn">关闭</a> <a href="#" class="btn btn-primary">保存</a>

		</div>
	</div>
	<h1>sweetalert 提示框测试</h1>
	<button id="sweetalert">点击我，有惊喜</button>
	<h1>文件</h1>
	<form action="/file" enctype="multipart/form-data">
		<input type="file" value="upload"> <input type="submit"
			value="submit">
	</form>

	<h1>UEditor</h1>
	<script id="container" name="content" type="text/plain"
		style="width:1024px;height:500px;">
            这里写你的初始化内容
       </script>

	<h1>滚动器</h1>
	<input id="ex1" data-slider-id='ex1Slider' type="text"
		data-slider-min="0" data-slider-max="20" data-slider-step="1"
		data-slider-value="14" />

	<h1>双日历插件</h1>
	<div class="input-group" style="width: 240px; margin-left: -5px;">
		<input type="text" class="form-control date-picker" id="dateTimeRange" value="" /> 
		<span class="input-group-addon"> <i class="fa fa-calendar bigger-110"></i></span> 
		<input type="hidden" name="beginTime" id="beginTime" value="" /> 
		<input type="hidden" name="endTime" id="endTime" value="" />
	</div>
	<a href="javascript:;" onclick="begin_end_time_clear();">清除</a>
	<script type="text/javascript">
	
	$(function() {
		alert($('#dateTimeRange'))
	    $('#dateTimeRange').daterangepicker({
	        applyClass : 'btn-sm btn-success',
	        cancelClass : 'btn-sm btn-default',
	        locale: {
	            applyLabel: '确认',
	            cancelLabel: '取消',
	            fromLabel : '起始时间',
	            toLabel : '结束时间',
	            customRangeLabel : '自定义',
	            firstDay : 1
	        },
	        ranges : {
	            //'最近1小时': [moment().subtract('hours',1), moment()],
	            '今日': [moment().startOf('day'), moment()],
	            '昨日': [moment().subtract('days', 1).startOf('day'), moment().subtract('days', 1).endOf('day')],
	            '最近7日': [moment().subtract('days', 6), moment()],
	            '最近30日': [moment().subtract('days', 29), moment()],
	            '本月': [moment().startOf("month"),moment().endOf("month")],
	            '上个月': [moment().subtract(1,"month").startOf("month"),moment().subtract(1,"month").endOf("month")]
	        },
	        opens : 'right',    // 日期选择框的弹出位置
	        separator : ' 至 ',
	        showWeekNumbers : true,     // 是否显示第几周
	 
	 
	        //timePicker: true,
	        //timePickerIncrement : 10, // 时间的增量，单位为分钟
	        //timePicker12Hour : false, // 是否使用12小时制来显示时间
	 
	         
	        //maxDate : moment(),           // 最大时间
	        format: 'YYYY-MM-DD'
	 
	    }, function(start, end, label) { // 格式化日期显示框
	        $('#startTime').val(start.format('YYYY-MM-DD'));
	        $('#endTime').val(end.format('YYYY-MM-DD'));
	    })
	    .next().on('click', function(){
	        $(this).prev().focus();
	    });
	});
	 
	/**
	 * 清除时间
	 */
	function begin_end_time_clear() {
	    $('#dateTimeRange').val('');
	    $('#beginTime').val('');
	    $('#endTime').val('');
	}
	
		// With JQuery
		$('#ex1').slider({
			formatter: function(value) {
				return 'Current value: ' + value;
			}
		});
	
		/* // Without JQuery
		var slider = new Slider('#ex1', {
			formatter: function(value) {
				return 'Current value: ' + value;
			}
		}); */
	
		<!-- 实例化编辑器 -->
		var ue = UE.getEditor('container');

	
		$('#sweetalert').click(function(){
			//swal("提示信息!", "It's pretty, isn't it?")
			//swal("Good job!", "You clicked the button!", "success")
			/* swal({
			  title: "确定删除?",
			  text: "删除后将无法恢复!",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#DD6B55",
			  cancelButtonText: "放弃",
			  confirmButtonText: "删除",
			  closeOnConfirm: false
			},
			function(isConfirm){
			  if (isConfirm) {
			    swal("Deleted!", "Your imaginary file has been deleted.", "success");
			  } else {
			    swal("Cancelled", "Your imaginary file is safe :)", "error");
			  }
			}); */
			/* swal({
				  title: "确定删除?",
				  text: "删除后将无法恢复!",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "删除",
				  cancelButtonText: "放弃",
				  closeOnConfirm: false,
				  //closeOnCancel: false
				},
				function(isConfirm){
				  if (isConfirm) {
				    swal("删除成功!", "", "success");
				  } else {
				    return;
				  }
			}); */
			/* swal({
				  title: "需要口令!",
				  text: "此日记已锁定，请输入口令再进行操作:",
				  type: "input",
				  showCancelButton: true,
				  closeOnConfirm: false,
				  animation: "slide-from-top",
				  inputPlaceholder: "口令"
				},
				function(inputValue){
				  if (inputValue === false) return false;
				  
				  if (inputValue === "") {
				    swal.showInputError("请输入口令!");
				    return false
				  }
				  
				  swal("Nice!", "You wrote: " + inputValue, "success");
				}); */
				
			swal({
				  title: "确认注销当前用户?",
				  text: "",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "Yes, delete it!",
				  closeOnConfirm: true
				},
				function(){
				  
				});
			
		})
	</script>
</body>
</html>