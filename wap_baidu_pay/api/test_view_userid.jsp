<%@ page contentType="text/html; charset=UTF-8"%><%@page
	import="com.d1.Const"%>
<%
out.print(session.getAttribute(Const.LOGIN_USER_ID_PREFIX));
%>