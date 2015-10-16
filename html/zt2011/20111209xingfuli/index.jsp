<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>甜美圣诞 让爱在这个冬季升温-D1优尚网</title>
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
		<td>
			<img src="images/XingFuLi_01.jpg" width="980"  alt=""/></td>
	</tr>
	<tr>
		<td>
			<img src="images/XingFuLi_02.jpg" alt="" width="980" height="437" border="0" usemap="#Map"/></td>
	</tr>
	<tr>
		<td>
			<img src="images/XingFuLi_03.jpg" alt="" width="980" height="366" border="0" usemap="#Map2"/></td>
	</tr>
	<tr>
		<td>
			<img src="images/XingFuLi_04.jpg" width="980" height="60" alt=""/></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7175");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
</table>
<!-- End ImageReady Slices -->

<map name="Map"><area shape="rect" coords="23,135,356,424" href="/product/01719740" target="_blank">
<area shape="rect" coords="365,55,649,431" href="/product/01719737" target="_blank">
<area shape="rect" coords="657,55,975,321" href="/product/01719746" target="_blank">
</map>
<map name="Map2">
<area shape="poly" coords="11,313,13,194,62,88,97,30,164,4,241,12,334,74,344,117,195,248,193,347" href="/product/01719646" target="_blank">
<area shape="poly" coords="236,244,303,187,337,155,361,108,426,59,508,57,557,134,650,157,645,205,594,308,510,355,317,348,281,348" href="/product/01719647" target="_blank">
<area shape="poly" coords="644,232,673,184,673,85,691,51,859,51,954,85,968,134,965,254,923,355,740,362,688,342" href="/product/01719346" target="_blank">
</map>
<map name="Map3"><area shape="poly" coords="485,59" href="#"></map>
</center>
<%@include file="/inc/foot.jsp"%>

</body>
</html>