<%@ page contentType="text/html; charset=UTF-8"%><%@include file="inc/header.jsp"%>
<%
response.setStatus(301);
response.setHeader( "Location", "http://www.d1.com.cn/product/"+request.getParameter("id"));
response.setHeader( "Connection", "close" );
%>  
