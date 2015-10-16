<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>欧美三大品牌感恩回馈，满额赠围巾-D1优尚网</title>
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
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2011/20111123only/only_01.jpg" alt="" width="980" height="350" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111123only/only_02.jpg" alt="" width="502" height="479" border="0" usemap="#Map2"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111123only/only_03.jpg" alt="" width="478" height="479" border="0" usemap="#Map3"></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2011/20111123only/only_04.jpg" width="980" height="64" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">

       <% request.setAttribute("code","7065");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
		</td>
  </tr>
  
</table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>