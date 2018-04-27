<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- fa fa-user: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel 菜单用户信息 -->
		<!-- search form -->
		<!-- /.search form -->
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu">
			<li class="header">系统菜单</li>
			<li class="treeview">
				<a href="${path}/home"> <i class="glyphicon glyphicon-home"></i><span>主页</span></a>
			</li>
			<li class="treeview">
				<a href="${path}/calendar"> <i class="glyphicon glyphicon-calendar"></i><span>写作日历</span></a>
			</li>
			<li class="treeview">
				<a href="${path}/diary"> <i class="glyphicon glyphicon-book"></i><span>日记管理</span></a>
			</li>
			<li class="treeview">
				<a href="${path}/mood"> <i class="glyphicon glyphicon-heart"></i><span>心情管理</span></a>
			</li>
			<%-- <security:authorize access="hasRole('ROLE_0') || hasRole('ROLE_1')"> --%>
			<security:authorize access="hasRole('ROLE_0')">
				<li class="treeview">
					<a href="${path}/user"> <i class="glyphicon glyphicon-user"></i><span>用户管理</span></a>
				</li>
			</security:authorize>
			<li class="treeview">
				<a href="${path}/exception/exception_record"> <i class="glyphicon glyphicon-list-alt"></i><span>异常记录管理</span></a>
			</li>
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>