<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网易抽奖-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="http://mimg.127.net/xm/all/point_club/110622/css/style.css"		rel="stylesheet" type="text/css"/>
<link href="http://mimg.127.net/xm/all/point_club/progress/medaltalent/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>


</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--头部-->
<%@include file="/inc/head.jsp" %>
<!-- 头部结束-->
<center>
<div class="header">	
<div class="inner page">

	<div class="page">		
  <div class="g-contBox g-shadow g-contBox-noBdr">		
  <div class="g-contBox-title">&nbsp;</div>
  			<div class="g-contBox-content">			
  				<div class="g-contBox-contBgBot">	
  		  <jsp:include   page= "tj.jsp"   />		
  </div></div></div></div>	
</center>
</body>
</html>	