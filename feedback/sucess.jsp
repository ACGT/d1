<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>用户反馈 - D1优尚</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/feedback.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

</head>
<body>
<center>
<%@include file="/inc/head2.jsp" %>
<%
if(request.getParameter("sucesstype")!=null){
	String type=request.getParameter("sucesstype");
	if(type.equals("yhfk")){
		%>
		<div class="yhfk_succ">
       <table width="760" >
	     <tr><td height="300"></td></tr>
		 <tr><td style=" text-align:center;"><a href="javascript:void(0);" onclick="window.close();"><img src="http://images.d1.com.cn/images2012/New/feedback/closepage.jpg" /></a></td></tr>
	   </table>
   	</div> 
	<%}else if(type.equals("ceo")){%>
		 <div class="ceo_succ">
       <table width="760" >
	     <tr><td height="280"></td></tr>
		 <tr><td style=" text-align:center;"><a href="javascript:window.close();"><img src="http://images.d1.com.cn/images2012/New/feedback/closepage.jpg" /></a></td></tr>
	   </table>
   </div> 
	<%}
}
%>
   <%@include file="/inc/foot.jsp" %>
   </center> 
</body>
</html>