<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%><%
	String input = request.getParameter("q");
	out.println(HotKeywordsUtil.getTopJsonHotKeyWords(input,10));
%>