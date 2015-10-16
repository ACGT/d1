<%@ page contentType="text/html; charset=UTF-8"%>
<% 	if(session.getAttribute("shopadmin")==null && session.getAttribute("type_flag")==null){
     response.sendRedirect("/admin/SHManage/Login.jsp");
     return;
}


%>
