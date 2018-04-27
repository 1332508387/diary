<%@ page language="java" pageEncoding="UTF-8"%>
<header class="main-header">
	<!-- Logo -->
	<a href="${path}/home" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
		<span class="logo-mini">DIARY</span> <!-- logo for regular state and mobile devices -->
		<span class="logo-lg"><b>我的日记</b></span> 
	</a>
	<!-- Header Navbar: style can be found in header.less -->
	<nav class="navbar navbar-static-top">
		<!-- Sidebar toggle button 菜单收缩按钮 -->
		<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button"> 
			<span class="sr-only">Toggle navigation</span> 
		</a>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<li class="dropdown user user-menu">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
						<!-- <img src="${path}/res/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">  -->
						<span class="hidden-xs">${currUser.username}</span>, 欢迎你！
					</a>
					<ul class="dropdown-menu">
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-right">
								<a href="javascript:void(0)" id="logout" class="btn btn-default btn-flat">注销</a>
							</div>
						</li>
						
					</ul>
				</li>
				<!-- Control Sidebar Toggle Button -->
			</ul>
		</div>
	</nav>
</header>
<div class="modal fade" id="mymodal">  
    <div class="modal-dialog" style="width:400px;">  
        <div class="modal-content">  
            <div class="modal-header">  
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>  
                <h4 class="modal-title">提示</h4>  
            </div>  
            <div class="modal-body">  
                <p>确认注销？</p>  
            </div>  
            <div class="modal-footer">  
                <a class="btn btn-primary" href="javascript:void(0)" id="comLogout">是</a>  
                <a class="btn btn-default" data-dismiss="modal">否</a>  
            </div>  
        </div><!-- /.modal-content -->  
    </div><!-- /.modal-dialog -->  
</div><!-- /.modal --> 
<script type="text/javascript">
	$(function(){
		$("#logout").click(function(){
			//$("#mymodal").modal("toggle");
			swal({
				  title: "确认注销当前用户?",
				  text: "",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "注销",
				  cancelButtonText: "放弃",
				  closeOnConfirm: true
				},
				function(){
					/* $.ajax({
						url: "${path}/user/logout",
						type: "GET",
						success: function(result){
							if(result.status == 200) location.href = "${path}/login";
						}
					}) */
					location.href = path + "/user/logout";
				});
		});
		/* $("#comLogout").click(function(){
			$.ajax({
				url: "${path}/user/logout",
				type: "GET",
				success: function(result){
					if(result.status == 200) location.href = "${path}/login";
				}
			})
		}); */
	});
</script>
