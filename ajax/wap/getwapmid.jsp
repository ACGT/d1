<%@ page contentType="text/html; charset=UTF-8" %><%@include file="/inc/header.jsp"%>


<%

Map<String, String> ret =null;
if(lUser!=null) {
	out.print("{\"flag\":\"0\",\"mid\":\""+lUser.getId()+"\"}");
	return;
}else{
out.print("{\"flag\":\"1\",\"mid\":\"\"}");
return;
}
%>