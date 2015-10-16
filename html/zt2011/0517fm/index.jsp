<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>夏装热销 狂降60</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<style type="text/css">
<!--
body {
	background-color: #FFF;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2"><img src="http://images.d1.com.cn/zt2011/0517fm/images/0517_01-1.jpg" width="980" height="198" border="0"></td>
  </tr>
  <tr>
    <td colspan="2"><a href="http://www.d1.com.cn/product/01715920" target="_blank"><img src="http://images.d1.com.cn/zt2011/0517fm/images/0517_02-1.jpg" width="980" height="256" border="0"></a></td>
  </tr>
  <tr>
    <td><a href="http://www.d1.com.cn/product/01715922" target="_blank"><img src="http://images.d1.com.cn/zt2011/0517fm/images/0517_03-1.jpg" width="470" height="578" border="0"></a></td>
    <td><a href="http://www.d1.com.cn/product/01715921" target="_blank"><img src="http://images.d1.com.cn/zt2011/0517fm/images/0517_04-1.jpg" width="510" height="578" border="0"></a></td>
  </tr>
</table>
<table background="http://images.d1.com.cn/zt2011/0512fm/images/0511_12.jpg" width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0512fm/images/0511_11.jpg" width="980" height="48"></td>
  </tr>
  <tr>
    <td align="center">
    <% request.setAttribute("code","6066");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
    </td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0512fm/images/0511_14.jpg" width="980" height="48"></td>
  </tr>
  <tr>
    <td align="center">
    <% request.setAttribute("code","6067");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
     </td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0512fm/images/0511_16.jpg" width="980" height="48"></td>
  </tr>
  <tr>
    <td align="center">
    <% request.setAttribute("code","6108");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
    </td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0512fm/images/0511_18.jpg" width="980" height="48"></td>
  </tr>
  <tr>
    <td align="center">
    <% request.setAttribute("code","6068");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
     </td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0512fm/images/0511_20.jpg" width="980" height="48"></td>
  </tr>
  <tr>
    <td align="center">
    <% request.setAttribute("code","6107");
		request.setAttribute("length","50");%>
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   />
     </td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0512fm/images/0511_22.jpg" width="980" height="2"></td>
  </tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>