<%@page language="java" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="include/common.jsp"%>

<HTML>
<HEAD>
</HEAD>
<BODY >
<SCRIPT LANGUAGE="JavaScript">

	$(function(){
		var msg = "${msgView.msg}";
		swal({
			  title: "登陆超时，请重新登陆！",
			  text: msg,
			  timer: 3000,
			  showConfirmButton: true,
			  confirmButtonText: "登陆"
			},
			function (){
				top.window.location.href="${path}/login";
			}
		);
	    window.setTimeout("ok();",3000);
	
		function ok(){
			top.window.location.href="${path}/login";
	 	}
	}) 
		
</SCRIPT>
</BODY>
</HTML>