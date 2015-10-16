<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%
String gdsid=request.getParameter("gdsid");
response.sendRedirect("http://www.d1.com.cn/product/"+gdsid);
%>
