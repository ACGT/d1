<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>冬季必备妆备-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/gdsscene.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
.newlist {width:980px;overflow:hidden; margin:0px auto; background-color:#fff; }
.newlist ul {width:980px;padding:0 0 0px; padding-left:20px;  padding-top:15px; padding-bottom:15px;}
.newlist li {float:left; margin-right:20px;overflow:hidden; width:220px; overflow:hidden; margin-bottom:20px;  }
.newlist p {text-align:left; }
.retime a{text-decoration:none; }
.lf{ padding:10px; background-color:#d6bdbb ; over-flow:hidden; }

</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table width="980" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/20121115hzp/1114cos_01.jpg" width="980" height="235" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/20121115hzp/1114cos_02.jpg" width="980" height="219" /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/20121115hzp/1114cos_03.jpg" width="980" height="57" /></td>
  </tr>
  <tr>
    <td>	<%request.setAttribute("code", "8233");%>
		<jsp:include   page= "gdsscr.jsp"   /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/20121115hzp/1114cos_05.jpg" width="980" height="57" /></td>
  </tr>
  <tr>
    
    <td>	<%request.setAttribute("code", "8234");%>
		<jsp:include   page= "gdsscr.jsp"   /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/20121115hzp/1114cos_07.jpg" width="980" height="57" /></td>
  </tr>
  <tr>
    
    <td>	<%request.setAttribute("code", "8235");%>
		<jsp:include   page= "gdsscr.jsp"   /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/20121115hzp/1114cos_09.jpg" width="980" height="57" /></td>
  </tr>
  <tr>
   
    <td>	<%request.setAttribute("code", "8236");%>
		<jsp:include   page= "gdsscr.jsp"   /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/20121115hzp/1114cos_11.jpg" width="980" height="57" /></td>
  </tr>
  <tr>
   
    <td>	<%request.setAttribute("code", "8237");%>
		<jsp:include   page= "gdsscr.jsp"   /></td>
  </tr>
  <tr>
    <td><img src="http://images.d1.com.cn/zt2012/20121115hzp/1114cos_13.jpg" width="980" height="57" /></td>
  </tr>
  <tr>
   
    <td>	<%request.setAttribute("code", "8238");%>
		<jsp:include   page= "gdsscr.jsp"   /></td>
  </tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</body>
</html>