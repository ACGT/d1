<%@ page contentType="text/html; charset=UTF-8"%>
<% 	if(session.getAttribute("dfadmin")==null){
     response.sendRedirect("/admin/dfmng/Login.jsp");
     return;
}


%>
