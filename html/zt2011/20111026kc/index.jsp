<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>tic tac toe 井字游戏 新品牌入驻 买即赠-D1优尚网</title>
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
<table id="__01" width="980" height="419" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2011/20111026kc/kc_01.jpg" width="389" height="126" alt=""/></td>
		<td colspan="2" rowspan="2">
			<a href="/product/01516477" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111026kc/kc_02.jpg" alt="" width="591" height="203" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="/product/01516493" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111026kc/kc_03.jpg" alt="" width="389" height="77" border="0"/></a></td>
	</tr>
	<tr>
		<td>
			<a href="/product/01516477" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111026kc/kc_04-1.jpg" alt="" width="273" height="131" border="0"/></a></td>
		<td colspan="2">
			<a href="/product/01516493" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111026kc/kc_05.jpg" alt="" width="186" height="131" border="0"/></a></td>
		<td>
			<a href="/product/01516477" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111026kc/kc_06.jpg" alt="" width="521" height="131" border="0"/></a></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111026kc/kc_07.jpg" width="980" height="16" alt=""/></td>
	</tr>
	<tr>
		<td height="68" colspan="4"><%request.setAttribute("code","6982");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111026kc/分隔符.gif" width="273" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111026kc/分隔符.gif" width="116" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111026kc/分隔符.gif" width="70" height="1" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111026kc/分隔符.gif" width="521" height="1" alt=""/></td>
	</tr>
</table>
</center><center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>