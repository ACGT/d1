<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="/inc/header.jsp" %>
<%
if("post".equals(request.getMethod().toLowerCase())||session.getAttribute("wydhorderpwd")!=null)
{
	String wydhpwd=request.getParameter("wydhpwd");
	if ((wydhpwd!=null&&wydhpwd.equals("wydhodr0326"))||session.getAttribute("wydhorderpwd")!=null){
		session.setAttribute("wydhorderpwd", "mqwy1208nktxa");
	}
}	
%>		
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网易兑换后台</title>
	
	 
 <%
      if(session.getAttribute("wydhorderpwd")==null){ %>
       <body>
		<div style="height:100px;">&nbsp;</div>
		<form id="wydhorder" method="post" action="adminwydh.jsp">
		<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cccccc" style="line-height:28px;">
		  <tr>
		    <td width="27%" bgcolor="#FFFFFF">密码：</td>
		    <td width="73%" bgcolor="#FFFFFF"><input type="password"  id="wydhpwd" name="wydhpwd"></td>
		  </tr>
		  
		  <tr>
		    <td bgcolor="#FFFFFF">&nbsp;</td>
		    <td bgcolor="#FFFFFF"><input type="submit" value="登陆"/>&nbsp;</td>
		  </tr>
		</table>
		</form>
		 </body>
<%}
 else{%>
	 <frameset cols="250,*" >
	  <frame name="left" src="/intf/wydhlist.jsp" noresize>
	  <frame name="right" src="">	
	  <noframes>
	  </noframes>
	</frameset>
 <%}%>
	  
	  
</html>