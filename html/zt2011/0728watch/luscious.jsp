<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Luscious girls韩国时尚潮流品牌腕表，体现完全不同的你！</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0728watch/images/0727_01.jpg" width="980" height="218"></td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0728watch/images/0727_02.jpg" width="980" height="212"></td>
  </tr>
  <tr>
    <td align="center"><%request.setAttribute("code","6568");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "../20111104hzp/gdsrcm0305.jsp"   /></td>
  </tr>
  </table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>