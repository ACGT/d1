<%@ page contentType="text/html; charset=UTF-8" %><%
if(session.getAttribute("Weixinopenid")==null){
	out.print("{\"success\":false}");
}else{
	out.print("{\"success\":true}");
}
%>