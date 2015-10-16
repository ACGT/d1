<%@ page contentType="text/html; charset=UTF-8"%><%
session.setAttribute("kfadmin",null);
session.setAttribute("kfshopcode",null);
response.sendRedirect("/admin/kfmng/login.jsp");
return;
%>