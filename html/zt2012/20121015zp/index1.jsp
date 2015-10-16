<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>绽放秋日的温暖-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gblistCart.js")%>"></script>
<script type="text/javascript">
function gqinCart(obj){
 // $.alert('对不起，活动已结束！');
 <%
 if(lUser==null){
 %>
 $.close(); 	Login_Dialog();
		<%}else{%>
	$.close(); 
  $.inCart1(obj,{ajaxUrl:'zqInCart.jsp',width:400,align:'center'});
  <%}%>
}

</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->

<center>
<table id="__01" width="981" height="1301" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_01.jpg" width="980" height="242" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="242" alt=""></td>
	</tr>
	<tr>
		<td rowspan="3">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_02.jpg" width="436" height="287" alt=""></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_03.jpg" alt="" width="176" height="282" border="0" usemap="#Map"></td>
		<td rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_04.jpg" alt="" width="171" height="283" border="0" usemap="#Map2"></td>
		<td rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_05.jpg" alt="" width="197" height="283" border="0" usemap="#Map3"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="282" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="3">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_06.jpg" alt="" width="176" height="283" border="0" usemap="#Map4"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="1" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_07.jpg" alt="" width="171" height="282" border="0" usemap="#Map5"></td>
		<td rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_08.jpg" alt="" width="197" height="282" border="0" usemap="#Map6"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="4" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_09.jpg" width="436" height="278" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="278" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
		<a id="a1" name="a1"></a>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_10.jpg" alt="" width="497" height="259" border="0" usemap="#Map8"></td>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01517437" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_11.jpg" alt="" width="483" height="267" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="259" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm-_12.jpg" width="497" height="32" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="8" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<a href="http://www.d1.com.cn/product/01517437" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm_13-4.jpg" alt="" width="483" height="226" border="0" usemap="#Map7"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="24" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121015zp/sqsm_14-1.jpg" width="497" height="202" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="1" height="202" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="436" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="61" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="115" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="171" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121015zp/分隔符.gif" width="197" height="1" alt=""></td>
		<td></td>
	</tr>
</table>
<!-- End ImageReady Slices -->

<map name="Map"><area shape="rect" coords="12,8,168,166" href="http://www.d1.com.cn/product/02200096" target="_blank">
<area shape="rect" coords="13,213,158,268" href="#" attr="02200096" onClick="gqinCart(this);" >
</map>
<map name="Map2"><area shape="rect" coords="8,5,169,171" href="http://www.d1.com.cn/product/02200097" target="_blank">
<area shape="rect" coords="17,216,157,268" href="#" attr="02200097" onClick="gqinCart(this);" >
</map>
<map name="Map3"><area shape="rect" coords="11,9,161,161" href="http://www.d1.com.cn/product/02200095" target="_blank">
<area shape="rect" coords="11,210,153,266" href="#" attr="02200095" onClick="gqinCart(this);" >
</map>
<map name="Map4">
<area shape="rect" coords="17,10,170,146" href="http://www.d1.com.cn/product/02200094" target="_blank">
<area shape="rect" coords="15,198,163,245"  href="###" attr="02200094" onClick="gqinCart(this);" ></map>
<map name="Map5">
<area shape="rect" coords="5,12,168,142" href="http://www.d1.com.cn/product/03200050" target="_blank">
<area shape="rect" coords="16,198,153,245"  href="###" attr="03200050" onClick="gqinCart(this);" ></map>
<map name="Map6">
<area shape="rect" coords="12,12,161,146" href="http://www.d1.com.cn/product/03200049" target="_blank">
<area shape="rect" coords="15,195,158,247"  href="###" attr="03200049" onClick="gqinCart(this);" ></map>

<map name="Map8" id="Map8"><area shape="rect" coords="34,238,282,259" href="http://www.d1.com.cn/result.jsp?productsort=020004" target="_blank" />
</center>
<%@include file="/inc/foot.jsp"%>


</body>
</html>