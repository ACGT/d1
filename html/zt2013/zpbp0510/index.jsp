<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>美妆爆款秒杀-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>

<style type="text/css">
<!--
/*.gdslist{padding-left:10px;}*/
.gdslist li {font-size: 14px;margin-left:15px; width:465px; height:210px; float:left;position:relative;}
.gdsitemt{ font-size:14px; color:#fdc300; line-height:19px;}
.gdsitemc{ font-size:14px; color:#fff;line-height:19px;}
.gdsitemp1{
	font-size:14px;
	color:#8399ca;
	text-decoration: line-through;
}
.tablin {
	border: 1px solid #899eb3;
}
.gdsitembut{
	position:absolute;
	width:266px;
	height:57px;
	dislay:block;
	background:url('http://images.d1.com.cn/zt2013/0510hzp/jgbj.png');
	left:-12px;
	z-index:5000;
	bottom: 20px;
}
.gdsitembut dt{ font-size:36px; padding-left:15px; color:#374d7c;width:100px; float:left; font-weight:bold;}
.gdsitembut dd{ width:110px; float:left; padding-top:10px;}
.itemy{ font-size:14px;}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- ImageReady Slices (美妆爆品.psd) -->
<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/0510hzp/zpbp_01.jpg" width="980" height="142" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/0510hzp/zpbp_02.jpg" width="980" height="145" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/0510hzp/zpbp_03.jpg" width="980" height="120" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/0510hzp/zpbp_04.jpg" width="980" height="146" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2013/0510hzp/zpbp_05.jpg" width="980" height="95" alt=""></td>
	</tr>
	<tr>
	  <td bgcolor="#D5E0FF" style="padding-left:4px">
	  <div class="gdslist"><ul>
	  <%
	  ArrayList<PromotionProduct> plist =PromotionProductHelper.getPromotionProductByCode("8633",40);
		ArrayList<Award> list=new ArrayList<Award>();
		if(plist!=null && plist.size()>0){
		 for(PromotionProduct pp:plist){
			 Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
			 if(product==null){continue;}
			  if(product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=1 )continue;
		 %>
	  <li> 
	  <table width="450" height="207" border="0" cellpadding="0" cellspacing="0" background="http://images.d1.com.cn/zt2013/0510hzp/pbj.jpg">
  <tr>
    <td width="21" class="gdsitemt"></td>
    <td width="210" height="35" class="gdsitemt"><%=pp.getSpgdsrcm_gdsname() %></td>
    <td width="12" class="gdsitemt"></td>
    <td width="205" rowspan="4" valign="middle">
	<div style="padding-top:3px;">
	<a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank"><img src="http://images.d1.com.cn/<%=product.getGdsmst_imgurl() %>"></a>
	</div>	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td height="60" class="gdsitemc"><%=pp.getSpgdsrcm_briefintrduce() %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td height="30"  class="gdsitemp1">市场价：<%=product.getGdsmst_saleprice() %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<div class="gdsitembut">
<dl>
<dt><span class="itemy">￥</span><%=product.getGdsmst_memberprice() %></dt>
<dd><a href="<%=ProductHelper.getProductUrl(product) %>" target="_blank"><img src="http://images.d1.com.cn/zt2013/0510hzp/but.png" width="74" height="28"></a></dd>
</dl>
</div>
	  </li>
	  <%}
		 }%>
	  
	  </ul></div>
	  </td>
  </tr>

</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>