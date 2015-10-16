<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%
User u = UserHelper.getById("1772396");
out.println(u.getMbrmst_uid());
boolean ret = Tools.getManager(User.class).delete(u); 
out.println(ret);
%>