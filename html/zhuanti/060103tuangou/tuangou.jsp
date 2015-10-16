<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>团购批发专区--公司、集团礼品首选！新年礼物、春节送礼、年终奖品、中秋好礼、员工福利、馈赠礼品、会议礼品-D1优尚网</title>
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
			<img src="http://images.d1.com.cn/zt2011/20111226TuanGou/TuanGou_01.jpg" width="980" height="545" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226TuanGou/TuanGou_02.jpg" width="980" height="47" alt=""></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7228");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226TuanGou/TuanGou_04.jpg" width="980" height="47" alt=""></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7229");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226TuanGou/TuanGou_06.jpg" width="980" height="47" alt=""></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7230");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226TuanGou/TuanGou_08.jpg" width="980" height="47" alt=""></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7231");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111226TuanGou/TuanGou_10.jpg" width="980" height="47" alt=""></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7232");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>

</body>
</html>