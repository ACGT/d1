<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
if(!Tools.isNull(request.getParameter("zpid"))){
	Cart c=CartHelper.getById(request.getParameter("zpid"));
	if(c!=null){
		if(Tools.getManager(Cart.class).delete(c)){
			out.print("1");
		}else{
			out.print("0");
		}
		return;
	}
}
%>