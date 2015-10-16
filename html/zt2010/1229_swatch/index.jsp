<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<html >
<head>
<title>2011斯沃琪新年特惠，全场239元起！</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
</head>

<body bgcolor="#F7FFDB">
<!-- 头部开始 -->
<center>
<%@include file="/inc/head.jsp"%>

<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2010/1229_swatch/images/20101229_01_01.jpg" width="980" height="66"></td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2010/1229_swatch/images/20101229_01_02.jpg" width="980" height="66"></td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2010/1229_swatch/images/20101229_swatch_03.jpg" width="980" height="160"></td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2010/1229_swatch/images/20101229_swatch_04.jpg" width="980" height="151"></td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2010/1229_swatch/images/20101229_swatch_05.jpg" width="980" height="57"></td>
  </tr>
  <tr>
    <td><table bgcolor="#999999" width="980" border="0" align="center" cellpadding="0" cellspacing="10">
      <tr>
        <td align="center" bgcolor="#FFFFFF">
        <%
		   request.setAttribute("code", "5378");
	  %>
			<jsp:include page="/sales/getgdsrcm1.jsp" flush="true" /> 
        
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2010/1229_swatch/images/20101229_swatch_07.jpg" width="980" height="57"></td>
  </tr>
  <tr>
    <td><table bgcolor="#999999" width="980" border="0" align="center" cellpadding="0" cellspacing="10">
      <tr>
        <td align="center" bgcolor="#FFFFFF">
           <%
		   request.setAttribute("code", "5379");
	  %>
			<jsp:include page="/sales/getgdsrcm1.jsp" flush="true" /> 
        
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img border="0" src="http://images.d1.com.cn/zt2010/1229_swatch/images/20101229_swatch_09.jpg" width="980" height="56"></td>
  </tr>
  <tr>
    <td><table bgcolor="#999999" width="980" border="0" align="center" cellpadding="0" cellspacing="10">
      <tr>
        <td align="center" bgcolor="#FFFFFF">
           <%
		   request.setAttribute("code", "5380");
	  %>
			<jsp:include page="/sales/getgdsrcm1.jsp" flush="true" /> 
        
        </td>
      </tr>
    </table></td>
  </tr>
</table>

<%@include file="/inc/foot.jsp"%>
</center>

</body>

</html>