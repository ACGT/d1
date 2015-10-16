<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>周末全场大放价　每周必惠-D1优尚网</title>
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
<table id="__01" width="980" height="500" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2011/20110920zmzp/x/zp_01.jpg" width="980" height="136" alt=""/></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20110920zmzp/x/zp_02.jpg" width="542" height="120" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20110920zmzp/x/zp_03-1.gif" width="133" height="120" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20110920zmzp/x/zp_04.jpg" width="305" height="120" alt=""/></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2011/20110920zmzp/x/zp_05.jpg" width="980" height="87" alt=""/></td>
	</tr>
	<tr>
		<td height="39" colspan="3"><img src="http://images.d1.com.cn/zt2011/20110920zmzp/x/zp_06-2.jpg" width="980" height="40" alt=""/></td>
	</tr>
	<tr>
	  <td height="39" colspan="3"><%request.setAttribute("code","6833");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../gdsrcm0306.jsp"   /></td>
    </tr>
	<tr>
	  <td height="39" colspan="3"><img src="http://images.d1.com.cn/zt2011/20110920zmzp/x/zp1_06.jpg" width="980" height="48" alt=""/></td>
    </tr>
	<tr>
	  <td height="40" colspan="3"><%request.setAttribute("code","6915");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../gdsrcm0306.jsp"   /></td>
    </tr>
</table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>