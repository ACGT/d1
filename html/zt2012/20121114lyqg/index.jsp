<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>大礼0元领取-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gblistCart.js")%>"></script>
<style type="text/css">
.newlist {width:980px;overflow:hidden; margin:0px auto; background-color:#f0f0f0; }
.newlist ul {width:980px;padding:0 0 0px; padding-left:4px;  padding-top:15px; padding-bottom:15px;}
.newlist li {float:left; margin-right:4px;overflow:hidden; width:240px; overflow:hidden; margin-bottom:20px;  }
.newlist p {text-align:left; }
.retime a{text-decoration:none; }
.lf{ padding-top:7px; background-color:#f0f0f0; over-flow:hidden; }

</style>
<script type="text/javascript">
function gqinCart(obj){
	$.alert("活动已结束");
//$.inCart(obj,{ajaxUrl:'/html/zt2012/20121114lyqg/zeroIncart.jsp',width:450,align:'center'});
 
}

</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<!-- ImageReady Slices (lylq.tif) -->
<table id="__01" width="981"  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/lylq_01-1.jpg" width="980" height="202" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/分隔符.gif" width="1" height="202" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01721296" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121114lylq/lylq_02.jpg" alt="" width="493" height="293" border="0"></a></td>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/02000798" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121114lylq/lylq_03.jpg" alt="" width="487" height="294" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/分隔符.gif" width="1" height="293" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<a href="http://www.d1.com.cn/product/01721296" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121114lylq/lylq_04.jpg" alt="" width="493" height="140" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/分隔符.gif" width="1" height="1" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/02000798" target="_blank"><img src="http://images.d1.com.cn/zt2012/20121114lylq/lylq_05.jpg" alt="" width="487" height="139" border="0"></a></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/分隔符.gif" width="1" height="139" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/lylq_06-1.jpg" width="493" height="50" alt="" border="0"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/lylq_07-1.jpg" width="487" height="50" alt="" border="0"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/分隔符.gif" width="1" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/lylq_08.jpg" width="980" height="50" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/分隔符.gif" width="1" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" width="980">
				<%request.setAttribute("code", "8241");%>
		<jsp:include   page= "20121114zp.jsp"   />
		</td>
		<td>
			<img src="http://images.d1.com.cn/zt2012/20121114lylq/分隔符.gif" width="1" height="365" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->
</center>

<%@include file="/inc/foot.jsp"%>


</body>
</html>