<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网 - 积分兑换</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/jifen.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
<!--
function op(obj){
	if (window.confirm("确定要兑换此商品吗?一经兑换,不能恢复.")){
		addCart(obj);
	}
}
function addCart(obj){
	$.inCart(obj,{ajaxUrl:'/ajax/flow/listAwardInCart.jsp'});
}
//-->
</script>
</head>
<body  BGCOLOR=#FFFFFF >
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<%if (lUser!=null) {%>
<div align="center" style="padding:10px 0 10px 0;font-size:16px; color:#000; font-weight:800">您当前的积分是：<span style="color: #EC5658;font-size: 16px;"><%=(int)(UserScoreHelper.getRealScore(lUser.getId())+0.5) %></span></div>
<%} %>
<table id="__01" width="921" height="2171" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_01.jpg" width="920" height="122" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="122" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_02.jpg" width="920" height="156" alt="" usemap="#Map"></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="156" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="#"  attr="1006" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_03.jpg" alt="" width="317" height="308" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01720843" target="_blank"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_04.jpg" alt="" width="603" height="308" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="308" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="#"  attr="1007" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_05.jpg" width="317" height="313" alt=""></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01720068" target="_blank"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_06.jpg" alt="" width="603" height="313" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="313" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="974" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_07.jpg" width="316" height="313" alt=""></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01516824" target="_blank"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_08.jpg" alt="" width="604" height="313" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="313" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<a href="#"  attr="978" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_09.jpg" width="316" height="315" alt=""></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01720159" target="_blank"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_10.jpg" alt="" width="604" height="314" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="314" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_11.jpg" width="604" height="316" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="1" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="36" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_12.jpg" width="316" height="315" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="315" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<a href="#"  attr="294" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_13.jpg" width="317" height="328" alt=""></a></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/jfdh1204_14.jpg" width="603" height="328" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="328" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="316" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/jfdh04/分隔符.gif" width="603" height="1" alt=""></td>
		<td></td>
	</tr>
</table>
<map name="Map"><area shape="rect" coords="754,119,911,146" href="http://www.d1.com.cn/help/helpnew.jsp?code=0104" target="_blank">
</map>
<!-- End ImageReady Slices -->
</center>
<%@include file="../inc/foot.jsp" %>
</body>
</html>