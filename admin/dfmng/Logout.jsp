<%@ page contentType="text/html; charset=UTF-8"%><%
session.setAttribute("dfadmin",null);
session.setAttribute("dfshopcode",null);
response.sendRedirect("/admin/dfmng/login.jsp");
return;
%>