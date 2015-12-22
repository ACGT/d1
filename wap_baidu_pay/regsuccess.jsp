<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—邮箱注册成功页面</title>
<style type="text/css">
body {
	line-height: 25px;
	padding-left: 5px;
}

img {
	border: none;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="/wap/inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<font color='#f00'>恭喜您，您已经完成注册！</font><br /> 欢迎来到D1优尚网<br /> <b>请牢记以下信息：</b><br />
		邮箱账号：<%= lUser.getMbrmst_uid() %><br /> 您可以在电脑上完成对邮箱的验证，便于您找回密码。 <br />
		<a href="/wap/user">马上进入我的优尚</a><br /> <a href="/mindex.jsp">返回首页</a>&nbsp;&nbsp;<a
			href="/wap/html/help.jsp">帮助</a> <br /> 切换到<a
			href="http://www.d1.com.cn">电脑版</a> <br />京ICP证030072号

	</div>

</body>
</html>
