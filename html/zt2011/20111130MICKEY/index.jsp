<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>米奇限量抢购 全场109元起-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" height="550" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<a href="/product/01717540" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111130MICKEY/MICKEY_01.jpg" alt="" width="980" height="427" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111130MICKEY/MICKEY_02.jpg" width="980" height="47" alt=""></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7146");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
</table>
</center>

<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>