<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>柏雅图 热卖季节 感恩回馈-D1优尚网</title>
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
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111124BoYaTu/BoYaTu_01.jpg" alt="" width="980" height="427" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111124BoYaTu/BoYaTu_02.jpg" width="980" height="60" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="/product/01717863" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111124BoYaTu/BoYaTu_03.jpg" alt="" width="245" height="394" border="0"></a></td>
		<td>
			<a href="/product/01719212" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111124BoYaTu/BoYaTu_04.jpg" alt="" width="244" height="394" border="0"></a></td>
		<td>
			<a href="/product/01716613" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111124BoYaTu/BoYaTu_05.jpg" alt="" width="244" height="394" border="0"></a></td>
		<td>
			<a href="/product/01719208" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111124BoYaTu/BoYaTu_06.jpg" alt="" width="247" height="394" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2011/20111124BoYaTu/BoYaTu_07.jpg" width="980" height="62" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<%request.setAttribute("code","7131");
		      request.setAttribute("length","100");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
</table>


<map name="Map"><area shape="rect" coords="81,106,585,425" href="/product/01719209" target="_blank">
<area shape="rect" coords="746,270,962,424" href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01719822" target="_blank">
</map></center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>