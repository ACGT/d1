<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>博能专业心率表，春季新品热销！！-D1优尚网</title>
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
    <td><a href="http://www.d1.com.cn/gdsinfo/01514669.asp" target="_blank"><img border="0" src="http://images.d1.com.cn/zt2011/0414bn/images/0414_01.jpg" width="980" height="344"/></a></td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2011/0414bn/images/0414_02.jpg" width="980" height="52"/></td>
  </tr>
</table>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="5" bgcolor="#d1eefc">
  <tr>
    <td align="center" bgcolor="#FFFFFF">
    <%request.setAttribute("code","6016");%>
		<jsp:include   page= "/sales/getgdsrcm1.jsp"   />
   </td>
  </tr>
</table>
</center>
<center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>