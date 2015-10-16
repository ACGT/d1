<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<% Tools.setCookie(response,"rcmdusr_rcmid","85",(int)(Tools.DAY_MILLIS/1000*1));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>3大温暖潮搭 告别冬日臃肿-D1优尚</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" height="1500" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_01.jpg" width="980" height="97" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_02.jpg" width="980" height="113" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_03.jpg" width="980" height="122" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_04_2.jpg" width="980" height="153" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_05_3.jpg" width="980" height="100" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_06.jpg" width="980" height="61" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/help/helpnew.asp?code=0105" target="_blank"><img src="http://images.d1.com.cn/market/1110/wysr_07.jpg" alt="" width="980" height="23" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_08.jpg" width="980" height="68" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_09.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td><%
		request.setAttribute("reccode","6932");
		request.setAttribute("dxcode","85");
		request.setAttribute("length","30");


		%>
		
		<jsp:include   page= "/html/gdsrecdx.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_11.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td height="27"><%
		request.setAttribute("code","6925");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "/html/gdsrec.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_13.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td height="29"><%
		request.setAttribute("code","6926");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "/html/gdsrec.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_15.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td height="36"><%
		request.setAttribute("code","6933");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "/html/gdsrec.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_17.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td height="37"><%
		request.setAttribute("code","6928");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "/html/gdsrec.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_19.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td height="37"><%
		request.setAttribute("code","6929");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "/html/gdsrec.jsp"   /></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/market/1110/wysr_21.jpg" width="980" height="58" alt=""></td>
	</tr>
	<tr>
		<td height="179"><%
		request.setAttribute("code","6930");
		request.setAttribute("length","50");%>
		
		<jsp:include   page= "/html/gdsrec.jsp"   /></td>
	</tr>
</table>
</center>
<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>