<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>三大品牌联合特卖，低至２折，超值抢购-D1优尚网</title>
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
<table id="__01" width="980" height="520" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111129zara/zara_01.jpg" alt="" width="980" height="427" border="0" usemap="#Map"></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111129zara/zara_02.jpg" width="980" height="47" alt=""></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7145");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
</table>
<!-- End ImageReady Slices -->

<map name="Map">
<area shape="poly" coords="175,339" href="#"><area shape="poly" coords="177,348,171,309,186,265,174,209,188,162,267,128,296,136,309,175,332,203,351,228,388,240,389,275,372,298,385,325,385,371,369,411,144,420,140,361,158,349" href="http://www.d1.com.cn/gdsinfo/01719319.asp" target="_blank">
<area shape="poly" coords="381,227,344,206,347,166,367,128,396,81,424,42,444,20,480,19,499,25,518,38,538,80,549,109,567,139,587,165,597,194,597,223,534,244,540,250,544,263,541,292,541,325,410,330,400,323" href="http://www.d1.com.cn/gdsinfo/01718175.asp" target="_blank">
<area shape="poly" coords="637,419,590,386,566,356,566,311,553,274,574,248,606,230,624,198,634,159,665,133,716,119,749,134,775,165,778,203,774,249,768,297,786,325,793,347,792,392,792,416,804,420" href="http://www.d1.com.cn/gdsinfo/01719373.asp" target="_blank">
</map></center>

<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>