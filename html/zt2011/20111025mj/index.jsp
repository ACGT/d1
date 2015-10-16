<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>美即新品抢鲜恵 满99减10！-D1优尚网</title>
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
<table id="__01" width="980" height="1035" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111025mj/index_01-1.jpg" width="980" height="133" alt=""/></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111025mj/index_02.jpg" width="980" height="102" alt=""/></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111025mj/index_03.jpg" width="980" height="145" alt=""/></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111025mj/index_04.jpg" width="980" height="54" alt=""/></td>
	</tr>
	<tr>
		<td><a href="http://www.d1.com.cn/gdsinfo/01413930.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111025mj/index_05.jpg" alt="" width="245" height="323" border="0"/></a></td>
		<td><a href="http://www.d1.com.cn/gdsinfo/01413931.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111025mj/index_06.jpg" alt="" width="245" height="323" border="0"/></a></td>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01414790.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111025mj/index_07.jpg" alt="" width="245" height="323" border="0"/></a></td>
		<td>
			<a href="http://www.d1.com.cn/gdsinfo/01413798.asp" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111025mj/index_08.jpg" alt="" width="245" height="323" border="0"/></a></td>
	</tr>
	<tr>
		<td height="58" colspan="4"><%request.setAttribute("code","6975");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111025mj/index_10-1.jpg" width="980" height="54" alt=""/></td>
	</tr>
	<tr>
		<td height="60" colspan="4"><%request.setAttribute("code","6976");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111025mj/index_12.jpg" width="980" height="54" alt=""/></td>
	</tr>
	<tr>
		<td height="52" colspan="4"><%request.setAttribute("code","6977");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
</table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>