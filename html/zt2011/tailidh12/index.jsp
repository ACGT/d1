<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<% Tools.setCookie(response,"rcmdusr_rcmid","102",(int)(Tools.DAY_MILLIS/1000*1));%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>台历券兑换 </title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript">
function CheckForm(obj){
	var code=$('#gdsdh_code').val();
	  if (code == ""){
			$.alert('请填写兑换码!');
	        return;
	    }
    $('#imageField').attr('attr',code);
    $.inCart(obj,{ajaxUrl:'/ajax/flow/tldhInCard.jsp',width:400,align:'center'});
}
</script>
<style type="text/css">
<!--
.cardnocs {
	border: 1px solid #CCCCCC;
	height: 36px;
	width: 136px;
	line-height:36px;
	font-size:14px;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td height="51" colspan="4">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_01.jpg" width="980" height="51" alt=""></td>
	</tr>
	<tr>
		<td height="117" colspan="4">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_02.jpg" width="980" height="117" alt=""></td>
	</tr>
	<tr>
		<td height="73" colspan="4">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_03.jpg" width="980" height="73" alt=""></td>
	</tr>
	<tr>
		<td height="136" colspan="4">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_04.jpg" width="980" height="136" alt=""></td>
	</tr>
	<tr>
		<td height="109" colspan="4">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_05.jpg" width="980" height="109" alt=""></td>
	</tr>
	<tr>
		<td height="154" colspan="4">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_06.jpg" width="980" height="154" alt=""></td>
	</tr>
	<tr>
		<td width="680" height="42">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_07.jpg" width="680" height="42" alt=""></td>
		<td width="160"><input type="text" name="gdsdh_code" id=gdsdh_code class="cardnocs">
               <INPUT TYPE="hidden" NAME="act" value="jy"></td>
		<td width="126">
		<input type="image" onclick="CheckForm(this);" id=imageField name="imageField" src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_09.jpg">
</td>
		<td width="14">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_10.jpg" width="14" height="42" alt=""></td>
	</tr>
	<tr>
		<td height="80" colspan="4">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_11.jpg" width="980" height="80" alt=""></td>
	</tr>
	<tr>
		<td colspan="4"><%
		request.setAttribute("reccode","7134");
		request.setAttribute("dxcode","102");
		request.setAttribute("length","30");


		%><jsp:include   page= "../../gdsrecdx.jsp"   /></td>
	</tr>
	<tr>
		<td height="55" colspan="4">
			<img src="http://images.d1.com.cn/zt2011/tailidh12/sdlw_13.jpg" width="980" height="55" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
<%request.setAttribute("code","7135");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
</td>
	</tr>
</table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>