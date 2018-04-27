<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sp" uri="http://www.springframework.org/tags"%>

<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="${path}/res/bootstrap/css/bootstrap.min.css">
<%-- <link rel="stylesheet" href="${path}/res/bootstrap/css/theme/bootstrap-theme0.min.css"> --%>
<!-- Theme style -->
<link rel="stylesheet" href="${path}/res/dist/css/AdminLTE.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="${path}/res/dist/css/skins/_all-skins.min.css">

<!-- iCheck：美化表单 -->
<link rel="stylesheet" href="${path}/res/plugins/iCheck/square/blue.css">
<!-- DataTables -->
<link rel="stylesheet" href="${path}/res/plugins/datatables/dataTables.bootstrap.css">
<!-- Font Awesome：各种小图标 -->
<link rel="stylesheet" href="${path}/res/plugins/fontawesome/css/font-awesome.min.css">
<!-- Ionicons：各种小图标 -->
<link rel="stylesheet" href="${path}/res/plugins/ionicons/css/ionicons.min.css">
<!-- toastr：提示框 -->
<link rel="stylesheet" href="${path}/res/toastr/toastr.min.css">
<!-- sweetalert：弹出提示框插件 -->
<link rel="stylesheet" href="${path}/res/sweetalert/sweetalert.css">
<!-- custom-->
<link rel="stylesheet" href="${path}/res/sy.css">
<!-- 双日历插件 -->
<link rel="stylesheet" href="${path}/res/plugins/daterangepicker/daterangepicker.css">
<link rel="stylesheet" href="${path}/res/plugins/select2/css/select2.min.css">
<%--<link rel="stylesheet" href="${path}/res/plugins/select2/select2.min.css">--%>

<!-- jQuery 2.2.3 -->
<script src="${path}/res/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- 实现拖拽功能 -->
<script src="${path}/res/jquery-ui.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${path}/res/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="${path}/res/plugins/iCheck/icheck.min.js"></script>

<!-- DataTables -->
<script src="${path}/res/plugins/datatables/jquery.dataTables.js"></script>
<script src="${path}/res/plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="${path}/res/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- custom-->
<script src="${path}/res/sy.js"></script>
<!-- toastr -->
<script src="${path}/res/toastr/toastr.min.js"></script>
<!-- sweetalert -->
<script src="${path}/res/sweetalert/sweetalert.min.js"></script>

<script src="${path}/js/main/json2.min.js"></script>

<script src="${path}/js/main/main2.js"></script>
<!-- ueditor -->
<script src="${path}/res/ueditor/ueditor.config.js"></script>
<script src="${path}/res/ueditor/ueditor.all.min.js"></script>
<!-- 双日历插件 -->
<script src="${path}/res/plugins/daterangepicker/moment.min.js"></script>
<script src="${path}/res/plugins/daterangepicker/daterangepicker.js"></script>
<script src="${path}/res/plugins/select2/js/select2.js"></script>
<%--<script src="${path}/res/plugins/select2/select2.js"></script>--%>
<script src="${path}/js/commonFunc.js"></script>

<link rel="icon" href="${path}/img/front/index/favicon.ico">

<script type="text/javascript">
jQuery.nowTime = '${nowTime}';
window.path = '${path}';	// 定义全局变量
window.imagePath = '${fileServer}/';
window.sessionId='${pageContext.session.id}';

var currUser = {};
currUser.id='${currUser.id}';
currUser.type='${currUser.type}';
currUser.username='${currUser.username}';

$(function(){
	
});
</script>
<!-- 用于js文件中获取上下文 -->
<input type="hidden" value="${path}" name="path">

<script type="text/javascript">
	toastr.options = {  
        closeButton: false,  
        debug: false,  
        progressBar: true,  
        positionClass: "toast-top-center",  
        onclick: null,  
        showDuration: "300",  
        hideDuration: "1000",  
        timeOut: "2000",  
        extendedTimeOut: "1000",  
        showEasing: "swing",  
        hideEasing: "linear",  
        showMethod: "fadeIn",  
        hideMethod: "fadeOut"  
    };

	// 右键禁用
    /*document.onmousedown = function () {
        if (event.button == 2) {
            alert("放弃吧...");
            return false;
        }
    }*/
    // F12 禁用
    /*document.onkeydown = function () {
        if (window.event && window.event.keyCode == 123) {
            alert("放弃吧...");
            window.event.returnValue = false;
        }
    }*/
</script>

<!-- custom-->