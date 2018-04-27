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
<link rel="stylesheet" href="${path}/res/plugins/fullcalendar/fullcalendar.min.css">

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
<script src="${path}/res/plugins/fullcalendar/fullcalendar.min.js"></script>
<script src="${path}/res/plugins/fullcalendar/fullcalendar.min.js"></script>
<script src="${path}/res/plugins/fullcalendar/fullcalendar.print.css"></script>
<style type="text/css">
	.h{
		height: 50px
	}
</style>
</head>
<body>
	<div class="container">
		<div id="calendar"></div> 
	</div>

	<script type="text/javascript">
		$(function(){
			//var dates = getAllDate('2017-02-01','2017-03-1')
			var format2 = "yyyy-MM-dd";
			 $('#calendar').fullCalendar({
			        weekMode: {fixed: 5},
			        header: {left: '', center: 'title', right: 'prev,today,next'},
			        titleFormat: "YYYY年MM月",
			        handleWindowResize: false,
			        eventLimit: true, // allow "more" link when too many events  monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
			        monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
			        dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
			        firstDay: 1,
			        buttonText: {
			            today: '今天',
			            prev: '上一月',
			            next: '下一月'  },
			        firstDay: 1,
			        editable: false,
			        events: function (start, end, timezone, callback) {
			            $.ajax({
			                type: "GET",
			                url: '/statistics/diary/writeDate/list2',
			                dataType: 'json',
			                data: {startDate: new Date(start).formatDate(format2), endDate: new Date().formatDate(format2), filter: $("#hid").val()},
			                success: function (dates) { 
			                	var events = []; 
			                	if(dates == []){
			                		return;
			                	}
			                	/* $.each(dates, function(index, date){
			                		events.push({
										title: date,
			                        	start: date,
			                            backgroundColor: '#E0FFFF',
			                            textColor: '#000000',
			                            borderColor: '#E0FFFF',
			                        });
			                	}) */
			                	var currDay = new Date().formatDate(format2);
			                	var startDay = new Date(start).formatDate(format2);
			                	var currMonthDays = getAllDate(startDay, currDay);
			                	//alert(currDay)
			                	//alert(currMonthDays)
			                	// 遍历 start 和 end 之间所有的日期，并判断这段时间内所写的日记日期是否包含该日期
			                	$.each(currMonthDays, function(index, date){
			                		var thisDay = $.inArray(date, dates);
			                		if(thisDay != -1){	// 包含该日期，日记已写
			                			if(date == dates[0]){
			                				events.push({	// 开些日期
												id: '2',			                				
												title: date,
					                        	start: date,
					                            backgroundColor: '#98FB98',
					                            textColor: '#000000',
					                            borderColor: '#98FB98'
					                        });
			                				return;
			                			}
			                			events.push({
											id: '1',			                				
											title: date,
				                        	start: date,
				                            backgroundColor: '#5CACEE',
				                            textColor: '#000000',
				                            borderColor: '#5CACEE'
				                        });
			                		} 
			                		if(thisDay == -1 && date > dates[0]){	// 不包含该日期
			                			events.push({
			                				id: '-1',
											title: date,
				                        	start: date,
				                            backgroundColor: '#FF6347',
				                            textColor: '#000000',
				                            borderColor: '#FF6347'
				                        });
			                		}
			                	});
			                    callback(events);
			                }
			            });
			        },
			        eventClick: function(event, jsEvent, view) {
			        	if(event.id == -1){
			        		alert("click")
			        	}
			        },
			        eventMouseover: function(event, jsEvent, view){
			        	if(event.id == -1){
				        	$(this).children('div').attr('title', '点击补写日记');
			        	}
			        },
			        loading: function (isLoading, view) { if (isLoading == false) {
			                $(".fc-more").parent("div").css("text-align", "center");
			            }
			        },
			       /*  dayClick:function(){
			        	alert('click')
			        }, */
			        eventRender: function (calEvent, element, view) {
			            element.attr("id", calEvent.id);
			            element.attr("tabindex", "0");
			            element.attr("role", "button");
			            element.attr("data-toggle", "popover");
			            element.attr("data-trigger", "focus");
			            element.attr("data-content", calEvent.content); if (calEvent.key == "meeting") {
			                element.attr("data-original-title", calEvent.title);
			                element.find("div").prepend('<i class="fa fa-stop font-red-haze"></i>');
			            } if (calEvent.key == "outgoing") {
			                element.attr("data-original-title", calEvent.title); if (calEvent.typeId == 10) {//请假  element.find("div").prepend('<i class="fa fa-stop font-yellow-crusta"></i>');
			                } else {
			                    element.find("div").prepend('<i class="fa fa-stop font-blue-steel"></i>');
			                }
			            }
			        },
			        selectable: true  });
		})
		// 将毫毫秒转化为日期
		function millisecondToDate(ms, format){
			if(ms == null){
				return '';
			}
			var date = new Date(parseInt(ms));
			return date.format(format);
		}
		
		// 格式化时间
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
	
		Date.prototype.formatDate=function (fmt){
		   /*  var s='';
		    s+=this.getFullYear()+'-';          // 获取年份。
		    s+=(this.getMonth()+1)+"-";         // 获取月份。
		    s+= this.getDate();                 // 获取日。
		    return(s);   */                        // 返回日期。
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
		};
		
		// 获取两个日期间的所有日期
		function getAllDate(begin,end){
		    var ab = begin.split("-");
		    var ae = end.split("-");
		    var db = new Date();
		    db.setUTCFullYear(ab[0], ab[1]-1, ab[2] - 1);
		    var de = new Date();
		    de.setUTCFullYear(ae[0], ae[1]-1, ae[2] - 1);
		    var unixDb=db.getTime();
		    var unixDe=de.getTime();
		    var dates = new Array();
		    for(var k=unixDb;k<=unixDe;){
			    //console.log((new Date(parseInt(k))).formatDate());
			    k=k+24*60*60*1000;
			    dates.push((new Date(parseInt(k))).formatDate("yyyy-MM-dd"));
		    }
		    return dates;
		}
		
		/* --------------------------------------我是优雅的分割线--------------------------------------------- */
		
	</script>
</body>
</html>