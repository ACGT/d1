<%@ page contentType="text/html; charset=UTF-8"%>
<% 	if(session.getAttribute("kfadmin")==null){
     response.sendRedirect("/admin/kfmng/Login.jsp");
     return;
}


%>
