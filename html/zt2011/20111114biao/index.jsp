<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>优尚腕表时装周，全场4折起!-D1优尚</title>
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
<table id="__01" width="980" height="1800" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2011/20111114biao/index_01-1.jpg" width="980" height="194" alt=""/></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2011/20111114biao/index_02-1.jpg" width="980" height="209" alt=""/></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111114biao/index_03.jpg" width="517" height="381" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111114biao/index_04.jpg" width="463" height="381" alt=""/></td>
	</tr>
	<tr>
		<td height="75" colspan="2"><%request.setAttribute("code","7067");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111114biao/index_06.jpg" width="517" height="381" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111114biao/index_07.jpg" width="463" height="381" alt=""/></td>
	</tr>
	<tr>
		<td height="86" colspan="2"><%request.setAttribute("code","7068");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111114biao/index_09.jpg" width="517" height="381" alt=""/></td>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111114biao/index_10.jpg" width="463" height="381" alt=""/></td>
	</tr>
	<tr>
		<td height="93" colspan="2"><%request.setAttribute("code","7069");
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