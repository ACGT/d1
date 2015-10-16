<%@ page contentType="text/html; charset=UTF-8" %><%@include file="/html/header.jsp" %><%
String yzcode="/ImageCode?r="+new Random().nextInt(10);
///System.out.print("{\"code\":\""+yzcode+"\"}");
out.print("{\"code\":\""+yzcode+"\"}");
%>
