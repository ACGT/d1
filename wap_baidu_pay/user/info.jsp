<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—删除收货人地址</title>
<style type="text/css">
body {
	line-height: 18px;
	background: #fff;
	padding-left: 4px;
	font-size: 16px;
	color: #333
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

img {
	border: none;
}
</style>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<% if(request.getParameter("flag")!=null&&request.getParameter("flag").length()>0)
	{ %>
		删除成功！<br />您可以返回<a href="/wap/user/address.jsp">我的地址簿</a>或<a
			href="/mindex.jsp">返回首页</a>
		<%}
else
{%>
		删除失败！<br />您可以返回<a href="/wap/user/address.jsp">我的地址簿</a>或<a
			href="/mindex.jsp">返回首页</a>
		<%}%>

	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>
