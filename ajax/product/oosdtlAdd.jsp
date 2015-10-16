<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
String id = request.getParameter("id");
Product product = ProductHelper.getById(id);
if(product == null || !ProductHelper.isShow(product)){
	out.print("{\"success\":false,\"message\":\"找不到商品信息，可能商品已经下架！\"}");
	return;
}
String email = request.getParameter("email");
if(!Tools.isEmail(email)){
	out.print("{\"success\":false,\"message\":\"邮箱错误，请重新填写！\"}");
	return;
}
OosDtl os = OosDtlHelper.createOosDtl(id,email);
if(os != null){
	out.print("{\"success\":true,\"message\":\"订阅成功！\"}");
	return;
}else{
	out.print("{\"success\":false,\"message\":\"订阅失败，请重新再试！\"}");
	return;
}
%>