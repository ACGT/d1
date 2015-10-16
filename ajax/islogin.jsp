<%@ page contentType="text/html; charset=UTF-8" import="com.d1.helper.UserHelper" %><%
//必须放在header.jsp的后面。
if(UserHelper.getById(UserHelper.getLoginUserId(request,response)) == null){
	response.setHeader("_d1-Ajax","0");
	return;
}
%>