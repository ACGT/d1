<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>酷夏的快乐密码 加1元多1件-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
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
function jhcard(obj){
	var cardno=$('#cardno').val();
	$.ajax({
		type: "get",
		dataType: "json",
		url: 'jhcard.jsp',
		cache: false,
		data: {cardno:cardno},
		error: function(XmlHttpRequest){
			$.alert("激活台历出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			$.alert(json.message);
		},beforeSend: function(){
		},complete: function(){
		}
	});
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
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_01-1.jpg" width="980" height="362" alt=""></td>
	</tr>
	<tr>
		<td height="125" colspan="3" valign="top" background="http://images.d1.com.cn/zt2013/20130702qytl/qytl_02-2.jpg"><table width="979" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="187" height="34">&nbsp;</td>
            <td width="129">&nbsp;</td>
            <td width="113">&nbsp;</td>
            <td width="550">&nbsp;</td>
          </tr>
          <tr>
            <td height="28">&nbsp;</td>
            <td><input name="cardno" id="cardno" type="text" size="20" style="height:22px;" /></td>
            <td><input type="image" name="imageField" onClick="jhcard(this);" src="http://images.d1.com.cn/zt2013/20130702qytl/ann.png" /></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_03.jpg" width="980" height="26" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01414170" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_04.jpg" alt="" width="330" height="327" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01416654" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_05.jpg" alt="" width="318" height="327" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01416653" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_06.jpg" alt="" width="332" height="327" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#" attr="01414170" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_07.jpg" width="330" height="71" alt="" border="0"></a></td>
		<td>
			<a href="#" attr="01416654" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_08.jpg" width="318" height="71" alt="" border="0"></a></td>
		<td>
			<a href="#" attr="01416653" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_09.jpg" width="332" height="71" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/03000521" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_10.jpg" alt="" width="330" height="329" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01517056" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_11.jpg" alt="" width="318" height="329" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01721329" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_12.jpg" alt="" width="332" height="329" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#" attr="03000521" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_13.jpg" width="330" height="69" alt="" border="0"></a></td>
		<td>
			<a href="#" attr="01517056" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_14.jpg" width="318" height="69" alt="" border="0"></a></td>
		<td>
			<a href="#" attr="01721329" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_15.jpg" width="332" height="69" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/product/01512603" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_16.jpg" alt="" width="330" height="332" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01714283" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_17.jpg" alt="" width="318" height="332" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/product/01721331" target="_blank"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_18.jpg" alt="" width="332" height="332" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<a href="#" attr="01512603" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_19.jpg" width="330" height="72" alt="" border="0"></a></td>
		<td>
			<a href="#" attr="01714283" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_20.jpg" width="318" height="72" alt="" border="0"></a></td>
		<td>
			<a href="#" attr="01721331" onClick="jginCart(this);"><img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_21.jpg" width="332" height="72" alt="" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/zt2013/20130702qytl/qytl_22.jpg" width="980" height="14" alt=""></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>