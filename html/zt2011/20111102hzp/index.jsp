<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>冬季来袭 抵御干燥!12.9元起-D1优尚网</title>
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
<table id="__01" width="980" height="819" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111102hzp/index_01.jpg" width="980" height="136" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111102hzp/index_02.jpg" width="980" height="162" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111102hzp/index_03.jpg" width="980" height="124" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111102hzp/index_04.jpg" width="980" height="55" alt=""></td>
	</tr>
	<tr>
		<td height="66">
		<%request.setAttribute("code","7017");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
		</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111102hzp/index_06.jpg" width="980" height="53" alt=""></td>
	</tr>
	<tr>
		<td height="73">
		<%request.setAttribute("code","7033");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
		</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111102hzp/index_08.jpg" width="980" height="54" alt=""></td>
	</tr>
	<tr>
		<td height="96">
		<%request.setAttribute("code","7019");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
		</td>
	</tr>
</table>
</center><center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>