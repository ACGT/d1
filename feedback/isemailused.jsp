<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
 if(request.getParameter("useremail")!=null){
	 ArrayList<User> user=UserHelper.getUidExist(request.getParameter("useremail").toString().trim());
	 if(user!=null){
		 out.print("1");
	 }else{
		 out.print("0");
	 }
 }

%>