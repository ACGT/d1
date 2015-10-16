<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="../islogin.jsp" %><%
String id = request.getParameter("id");
UserAddress address = UserAddressHelper.getById(id);
if(address == null){
	out.print("{\"success\":false,\"message\":\"找不到收货人！\"}");
	return;
}
if(!lUser.getId().equals(String.valueOf(address.getMbrcst_mbrid()))){//不是一个人
	out.print("{\"success\":false,\"message\":\"您没有权限进行操作！\"}");
	return;
}
if(UserAddressHelper.manager.delete(address)){
	out.print("{\"success\":true,\"message\":\"删除成功！\"}");
	return;
}else{
	out.print("{\"success\":false,\"message\":\"删除收货人失败！\"}");
	return;
}
%>