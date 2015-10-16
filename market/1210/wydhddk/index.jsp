<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网易兑换-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style type="text/css">
.newlist {width:980px;overflow:hidden; margin:0px auto; background-color:#f0f0f0; }
.newlist ul {width:980px;padding:0 0 0px; padding-left:4px;  padding-top:15px; padding-bottom:15px;}
.newlist li {float:left; margin-right:4px;overflow:hidden; width:240px; overflow:hidden; margin-bottom:20px;  }
.newlist p {text-align:left; }
.retime a{text-decoration:none; }
.lf{ padding-top:7px; background-color:#f0f0f0; over-flow:hidden; }

</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>

		
<table width="980"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
		<a href="index2.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/market/wangyi/wydh1211.jpg" border="0"/></a>
			</td>
	</tr>
	
	
</table>
<table id="__01" width="980" height="1500" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121113flcx/yrf/flcx-yrf_01.jpg" width="980" height="127" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/result.jsp?productsort=030007002,020007002&order=2" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121113flcx/yrf/flcx-yrf_02-1.jpg" alt="" width="980" height="430" border="0" usemap="#Map"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121113flcx/yrf/flcx-yrf_03.jpg" width="980" height="252" alt=""></td>
	</tr>
	
	<tr>
		<td><a name="m1" id="m1"></a>
			<img src="http://images.d1.com.cn/zt2012/20121113flcx/yrf/flcx-yrf_06.jpg" alt="" width="980" height="45" border="0" usemap="#Map3"></td>
	</tr>
	<tr>
		<td>
				<%
		request.setAttribute("code", "8282");
		%>
		<jsp:include   page= "/html/20121113zc.jsp"   /></td>
	</tr>
<tr>
		<td><a name="w1" id="w1"></a>
			<img src="http://images.d1.com.cn/zt2012/20121113flcx/yrf/flcx-yrf_04.jpg" alt="" width="980" height="45" border="0" usemap="#Map2"></td>
	</tr>
	<tr>
		<td>
				<%
		request.setAttribute("code", "8281");
		%>
		<jsp:include   page= "/html/20121113zc.jsp"   /></td>
	</tr>
</table>
<!-- End ImageReady Slices -->

<map name="Map"><area shape="rect" coords="717,5,975,424" href="http://www.d1.com.cn/product/02000876" target="_blank">
<area shape="rect" coords="10,8,698,413" href="http://www.d1.com.cn/result.jsp?productsort=030007002,020007002&order=2" target="_blank">
</map>
<map name="Map2"><area shape="rect" coords="426,5,745,43" href="#m1"></map>
<map name="Map3"><area shape="rect" coords="386,9,759,43" href="#w1">
</map>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>