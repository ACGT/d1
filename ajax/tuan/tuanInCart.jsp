<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
	//团购加入购物车的程序
	String id = request.getParameter("gdsid");
	
	Product product = ProductHelper.getById(id);
	
	if(product == null){
		out.print("{\"success\":false,\"message\":\"团购商品不存在！\"}");
		return;
	}
	
	//TODO ...
			
%>