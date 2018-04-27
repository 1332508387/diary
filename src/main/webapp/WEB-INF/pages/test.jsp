<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/res/bootstrap/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/res/plugins/validator/bootstrapValidator.min.css"/>
<link rel="stylesheet" href="/res/plugins/datepicker/datepicker3.css">

<script type="text/javascript" src="/res/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="/js/base64.js"></script>
<script type="text/javascript" src="/js/security.js"></script>
<script type="text/javascript" src="/res/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/res/plugins/validator/bootstrapValidator.min.js"></script>
<script src="/res/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/res/plugins/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
<body>
<textarea rows="10" cols="50" id="content"></textarea><br>
<textarea rows="10" cols="50" id="show"></textarea><br>
<button id="en">编码</button>
<button id="de">解码</button>
<button id="desen">加密</button>
<button id="desde">解密</button>
<div id="baidu_geo"></div>
<h1>表单验证</h1>
<form action="" id="edit">
 <div class="form-group has-feedback">
	<input type="text" class="form-control" name="username" placeholder="用户名"  
		data-bv-notempty data-bv-notempty-message="firstName不能为空(提示语)" >
</div>
    <button name="sub" type="submit" class="btn btn-primary">Submit</button>
</form>
<h1>hibernate后台验证</h1>
<form action="" id="hibernateForm">
	<input type="text" name="username"/>
	<input type="text" name="password"/>
	<button type="button" id="hibernateBut" class="btn btn-primary">验证</button>
</form>

<h1>时间控件</h1>
<div class="input-append form_datetime">
	<input size="16" type="text" id="datetimeStart" readonly class="form_datetime" class="date">
	--
	<input size="16" type="text" id="datetimeEnd" readonly class="form_datetime">
	<input size="16" type="text" id="datetime" readonly class="form_datetime">
</div>
<div style="margin-bottom: 100px;"></div>
<h1>日历标记</h1>
<div id="dateFlag" style="width: 80%; algin:center"></div>

<script type="text/javascript">
	$(function(){
		$("#datetimeStart").datepicker({
	        format: 'yyyy-mm-dd',
	        minView:'month',
	        language: 'zh-CN',
	        autoclose:true,
	        startDate:new Date()
	    }).on("click",function(){
	        $("#datetimeStart").datepicker("setEndDate",$("#datetimeEnd").val())
	    });
		$("#datetimeEnd").datepicker({
	        format: 'yyyy-mm-dd',
	        minView:'month',
	        language: 'zh-CN',
	        autoclose:true,
	        startDate:new Date()
	    }).on("click",function(){
	        $("#datetimeEnd").datepicker("setStartDate",$("#datetimeStart".val()))
	    });
		
	    $("#datetime").datepicker({
	        format: 'yyyy-mm-dd',
	        minView:'hour',
	        language: 'zh-CN',
	        autoclose:true,
	        //startDate:new Date(), // 显示从本月往后
	        todayHighlight: true,	// 高亮显示今天
	        todayBtn: "linked", //如果此值为true 或 "linked"，则在日期时间选择器组件的底部显示一个 "Today" 按钮用以选择当前日期。如果是true的话，"Today" 按钮仅仅将视图转到当天的日期，如果是"linked"，当天日期将会被选中。
	        pickerPosition: "bottom-left"
	    });
	    
		// hibernate验证测试
		$("#hibernateBut").on("click", function(){
			$.ajax({
				url: "/validate/test",
				data: $("#hibernateForm").serialize(),
				success: function(result){
					if(result.status == 200) alert("用过验证");
					if(result.status == 201) alert("错误")
				}
			});
		})
		
		var revers;
		// 编码
		$("#en").click(function(){
			var content = $("#content").val();
			var base64Content = BASE64.encoder(content);
			$("#show").val(base64Content);
		});
		$("#de").click(function(){
			var base64Content = $("#show").val();
			var unicode= BASE64.decoder(base64Content); // 返回会解码后的unicode码数组
			// 将 Unicode 编码转化为字符串
			var content = '';
			for(var i = 0 , len =  unicode.length ; i < len ;++i){
				content += String.fromCharCode(unicode[i]);
			}
			$("#show").val(content);
		});
		// des
		var key = "12345678";
		$("#desen").click(function(){
			var content = $("#content").val();
			var desContent = strEnc(content,key);
			$("#show").val(desContent);
		});
		$("#desde").click(function(){
			var desContent = $("#show").val();
			var content = strDec(desContent, key);
			$("#show").val(content);
		});
		
		/* form 验证 */
		/*$('#edit').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                user: {
                    message: '用户名验证失败',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 18,
                            message: '用户名长度必须在6到18位之间'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名只能包含大写、小写、数字和下划线'
                        }
                    }
                },
                email: {
                    validators: {
                        notEmpty: {
                            message: '邮箱不能为空'
                        },
                        emailAddress: {
                            message: '邮箱地址格式有误'
                        }
                    }
                }
            }
        });
		*/
		$('#edit').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            }})
		/* $("button[name=sub]").click(function(){
			var bootstrapValidator = $("#edit").data('bootstrapValidator');
		   bootstrapValidator.validate();
		   if(bootstrapValidator.isValid()) alert("ok");
		}) */
	
         /*----------------日历标记---------------------*/
        $("[data-toggle='tooltip']").tooltip()
   		var writeDateList = getWriteDate();
   		$("#dateFlag").datepicker({
   	        format: 'yyyy-mm-dd',
   	        minView:'hour',
   	        language: 'zh-CN',
   	        //autoclose:true,
   	        //startDate:new Date(), // 显示从本月往后
   	        endDate:new Date(), // 显示从本月往后
   	        todayHighlight: true,	// 高亮显示今天
   	        //todayBtn: "linked", //如果此值为true 或 "linked"，则在日期时间选择器组件的底部显示一个 "Today" 按钮用以选择当前日期。如果是true的话，"Today" 按钮仅仅将视图转到当天的日期，如果是"linked"，当天日期将会被选中。
   	        pickerPosition: "bottom-left",
   	        //clearBtn: true
   	    });
   		var prev = $("#dateFlag .datepicker th.prev");
   		var prev = $("#dateFlag .datepicker th.next");
   		prev.text('')
   	 	prev.attr('class', '');
   		next.text('');
   		next.attr('class', '');
   		setFlag(writeDateList);
   		// changeMonth/changeYear/changeDate
   		$('#dateFlag').datepicker().on('changeDate', function(ev){ 　//日期改变事件
   			setFlag(writeDateList);
   	        //var dmonth=ev.date　　　　　　　　　　　　　　　　　　　//当前选中日期
   	        //alert(dmonth)
   		});
   		
   		/*-----------------日历标记-----------------------*/
	})
	
function setFlag(writeDateList){
	//var writeDateList = getWriteDate();
	//var datepickerDate = getDatepickerDate();
	
	var ym = $("#dateFlag .datepicker th.datepicker-switch:first").text();
	var d = $("#dateFlag .datepicker .datepicker-days table tr td:not(.old):not(.new)");
	var yms = ym.split(' ')
	var month = transfromMonth(yms[0].substring(0, 1));
	var year = yms[1];
	d.each(function(index){
		var day = $(this).text();
		if(day.split('').length == 1) day = '0' + day;
		var date = year + '-' + month + '-' + day;
		if($.inArray(date, writeDateList) != -1){
			// 设置开始写的日期的颜色
			if(date == writeDateList[0]){
				$(this).css('background', '#98FB98');
			}else{// 设置已写日期的颜色
				$(this).css('background', '#5CACEE');
			}		
		}
		// 设置漏写日期的颜色
		if($.inArray(date, writeDateList) == -1){
			if(date >= writeDateList[0] && date < new Date().format('yyyy-MM-dd')){
				$(this).css('background', '#FF6347');
				$(this).attr('data-toggle', 'tooltip');
				$(this).attr('data-placement', 'top');
				$(this).attr('title', '点击补写');
				$(this).click(function(){
					alert("补写")
				});
			}
		}
	});
}
	
// 获取当前用户所有的写作日期
function getWriteDate(){
	var writeDateList;
	$.ajax({
		url: '/statistics/diary/writeDate/list',
		async: false,
		success: function(data){
			writeDateList = data;
		}
	});		
	return writeDateList;
}
	
// 获取当前日历所有日期组成的数组：yyyy-mm-dd
function getDatepickerDate(){
	var ym = $("#dateFlag .datepicker th.datepicker-switch:first").text();
	var d = $("#dateFlag .datepicker .datepicker-days table tr td:not(.old):not(.new)");
	
	var yms = ym.split(' ')
	var month = transfromMonth(yms[0].substring(0, 1));
	var year = yms[1];
	
	var date = [];
	d.each(function(index){
		var day = $(this).text();
		if(day.split('').length == 1) day = '0' + day;
		date[index] = year + '-' + month + '-' + day;
	});
	
	return date;
}

function transfromMonth(m){
	switch(m){
		case '一': return '01';
		case '二': return '02';
		case '三': return '03';
		case '四': return '04';
		case '五': return '05';
		case '六': return '06';
		case '七': return '07';
		case '八': return '08';
		case '九': return '09';
		case '十': return '10';
		case '十一': return '11';
		case '十二': return '12';
	}
}

//格式化时间
Date.prototype.format = function(fmt) { 
     var o = { 
        "M+" : this.getMonth()+1,                 // 月份
        "d+" : this.getDate(),                    // 日
        "h+" : this.getHours(),                   // 小时
        "m+" : this.getMinutes(),                 // 分
        "s+" : this.getSeconds(),                 // 秒
        "q+" : Math.floor((this.getMonth()+3)/3), // 季度
        "S"  : this.getMilliseconds()             // 毫秒
    }; 
    if(/(y+)/.test(fmt)) {
            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
    }
     for(var k in o) {
        if(new RegExp("("+ k +")").test(fmt)){
             fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
         }
     }
    return fmt; 
}
</script>
</body>
</html>