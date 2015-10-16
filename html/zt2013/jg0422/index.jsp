<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>0元免费领 限时7天-D1优尚网</title>
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
function jginCart(obj){
	 <%
	 if(lUser==null){
	 %>
	 $.close(); 	Login_Dialog();
			<%}else{%>
		$.close(); 
$.inCart(obj,{ajaxUrl:'jgincart.jsp',width:450,align:'center'});
		<%}%>
 
}

</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2013/04/jg0422/jg0418_01-1.jpg" width="980" height="117" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2013/04/jg0422/jg0418_02.jpg" width="980" height="125" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/04/jg0422/jg0418_03.jpg" alt="" width="248" height="358" border="0" usemap="#Map"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/04/jg0422/jg0418_04.jpg" alt="" width="241" height="358" border="0" usemap="#Map2"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/04/jg0422/jg0418_05.jpg" alt="" width="240" height="358" border="0" usemap="#Map3"></td>
		<td>
			<img src="http://images.d1.com.cn/zt2013/04/jg0422/jg0418_06.jpg" alt="" width="251" height="358" border="0" usemap="#Map4"></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2013/04/jg0422/jg0418_07.jpg" width="980" height="59" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/zt2013/04/jg0422/jg0418_08.jpg" width="980" height="79" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
<% request.setAttribute("code","8587");
                request.setAttribute("length","50");%>
        <jsp:include   page= "/zhuanti/20121116wfm/20121113zc.jsp"  />

</td>
	</tr>
</table>
<map name="Map"><area shape="rect" coords="11,5,241,262" href="http://www.d1.com.cn/product/01410254" target="_blank">
<area shape="rect" coords="12,263,241,313" href="#" attr="01410254" onClick="jginCart(this);"></map>
<map name="Map2"><area shape="rect" coords="6,2,237,262" href="http://www.d1.com.cn/product/02000793" target="_blank">
<area shape="rect" coords="7,262,238,313" href="#" attr="02000793" onClick="jginCart(this);"></map>
<map name="Map3">
<area shape="rect" coords="5,2,235,262" href="http://www.d1.com.cn/product/02001490" target="_blank">
<area shape="rect" coords="4,265,235,314" href="#" attr="02001490" onClick="jginCart(this);"></map>
<map name="Map4"><area shape="rect" coords="5,5,249,265" href="http://www.d1.com.cn/product/01517532" target="_blank">
<area shape="rect" coords="3,266,249,313" href="#" attr="01517532" onClick="jginCart(this);"></map>
<!-- End ImageReady Slices -->
</center>

<%@include file="/inc/foot.jsp"%>


</body>
</html>