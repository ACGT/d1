<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品兑换-D1优尚网</title>
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
    $.inCart(obj,{ajaxUrl:'/ajax/flow/gjdhInCard.jsp',width:400,align:'center'});
}
</script>
<style type="text/css">
<!--
.cardnocs {
	border: 1px solid #CCCCCC;
	height: 36px;
	width: 240px;
	line-height:36px;
	font-size:18px;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<table id="__01" width="980" height="501" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01720373" target="_blank"><img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_01.jpg" alt="" width="313" height="311" border="0"></a></td>
		<td colspan="5">
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01720373" target="_blank"><img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_02.jpg" alt="" width="321" height="311" border="0"></a></td>
		<td>
			<a href="http://www.d1.com.cn/html/gdsshow.asp?gdsid=01720373" target="_blank"><img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_03.jpg" alt="" width="346" height="311" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_04.jpg" width="980" height="59" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_05.jpg" width="354" height="59" alt=""></td>
		<td colspan="3" background="http://images.d1.com.cn/market/1202/ganji/gjtgdh_06.jpg"><input type="text" name="gdsdh_code" id=gdsdh_code class="cardnocs"></td>
		<td colspan="2">
			<img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_07.jpg" width="368" height="59" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_08.jpg" width="369" height="44" alt=""></td>
		<td>
		<input type="image" name="imageField" id=imageField onclick="CheckForm(this);" src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_09.jpg">	
			</td>
		<td colspan="3">
			<img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_10.jpg" width="420" height="44" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="http://images.d1.com.cn/market/1202/ganji/gjtgdh_11.jpg" width="980" height="27" alt=""></td>
	</tr>
	<tr>
	  <td colspan="7"><table width="80%" border="0" cellspacing="0" cellpadding="0">
	
	<tr>
		<td colspan="5">
			<img src="http://images.d1.com.cn/market/1202/wangyidh/wydh12023_09.jpg" width="980" height="56" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01720270" target="_blank"><img src="http://images.d1.com.cn/market/1202/wangyidh/wydh12023_10.jpg" alt="" width="980" height="104" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01720270" target="_blank"><img src="http://images.d1.com.cn/market/1202/wangyidh/wydh12023_11.jpg" alt="" width="980" height="76" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01720270" target="_blank"><img src="http://images.d1.com.cn/market/1202/wangyidh/wydh12023_12.jpg" alt="" width="980" height="124" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="http://www.d1.com.cn/product/01720270" target="_blank"><img src="http://images.d1.com.cn/market/1202/wangyidh/wydh12023_13.jpg" alt="" width="980" height="76" border="0"></a></td>
	</tr>
</table></td>
  </tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1202/ganji/分隔符.gif" width="313" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/ganji/分隔符.gif" width="41" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/ganji/分隔符.gif" width="15" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/ganji/分隔符.gif" width="191" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/ganji/分隔符.gif" width="52" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/ganji/分隔符.gif" width="22" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/market/1202/ganji/分隔符.gif" width="346" height="1" alt=""></td>
	</tr>
</table>
<%@include file="/inc/foot.jsp" %>
</body>
</html>