<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<%
if((lUser!=null&&(int)(UserScoreHelper.getRealScore(lUser.getId())+0.5)<200)&&(session.getAttribute("d1lianmengsubad") ==null 
	|| (!"201203jfcx".equals(session.getAttribute("d1lianmengsubad"))
	&&!"201203smsjfcx".equals(session.getAttribute("d1lianmengsubad"))
	))){
	response.sendRedirect("http://www.d1.com.cn");
	return;
}
%>
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
<table id="__01" width="920" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/images2012/znjf/znjf_01.jpg" width="920" height="76" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/images2012/znjf/znjf_02.jpg" width="920" height="105" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="http://www.d1.com.cn/help/helpnew.jsp?code=0104" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/znjf_03.jpg" width="920" height="94" alt=""></a></td>
	</tr>
	<tr>
		<td colspan="3">
		<table id="__01" width="920" height="630" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<a href="#"  attr="985" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/jfdh1203_01.jpg" width="318" height="312" alt="" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01720622" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/jfdh1203_02.jpg" alt="" width="602" height="312" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="984" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/jfdh1203_03.jpg" width="318" height="318" alt="" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01720623" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/jfdh1203_04.jpg" alt="" width="602" height="318" border="0"></a></td>
	</tr>
</table>
       </td>
      </tr>
	<tr>
		<td>
			<a href="#"  attr="978" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/znjf_04.jpg" alt="" width="318" height="309" border="0" ></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01720159" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/znjf_05.jpg" alt="" width="602" height="309" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="974" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/znjf_06.jpg" alt="" width="318" height="315" border="0" ></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01516824" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/znjf_07.jpg" alt="" width="602" height="315" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="975" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/znjf_08.jpg" alt="" width="318" height="319" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01720194" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/znjf_09.jpg" alt="" width="602" height="319" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="939" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/znjf_10.jpg" alt="" width="318" height="317" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01718807" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/znjf_11.jpg" alt="" width="602" height="317" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="976" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/znjf_12.jpg" alt="" width="318" height="314" border="0"></a></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/product/01719626" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/znjf_13.jpg" alt="" width="602" height="314" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="977" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/znjf_14.jpg" alt="" width="318" height="314" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01713233" target="_blank"><img src="http://images.d1.com.cn/images2012/znjf/znjf_15.jpg" alt="" width="601" height="314" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/images2012/znjf/znjf_16.jpg" width="1" height="314" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="36" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/znjf_17.jpg" alt="" width="318" height="323" border="0"></a></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/images2012/znjf/znjf_18.jpg" width="602" height="323" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="#"  attr="294" onclick="addCart(this);"><img src="http://images.d1.com.cn/images2012/znjf/znjf_19.jpg" alt="" width="318" height="318" border="0"></a></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/images2012/znjf/znjf_20.jpg" width="602" height="318" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
</center>
<%@include file="../inc/foot.jsp" %>
</body>
</html>