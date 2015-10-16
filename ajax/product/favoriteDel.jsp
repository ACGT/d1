<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="../islogin.jsp" %><%
String id = request.getParameter("id");

Favorite fa = FavoriteHelper.getById(id);
if(fa!=null){
	if(!String.valueOf(fa.getGdswil_mbrid()).equals(lUser.getId())){
		out.print("{\"success\":false,\"message\":\"您没有权限进行此操作！\"}");
		return;
	}
	if(FavoriteHelper.manager.delete(fa)){
		out.print("{\"success\":true,\"message\":\"删除成功！\"}");
	}else{
		out.print("{\"success\":false,\"message\":\"删除失败，请重新再试！\"}");
	}
}else{
	String ids = request.getParameter("ids");
	if(Tools.isNull(ids)){
		out.print("{\"success\":false,\"message\":\"参数错误！\"}");
		return;
	}
	
	String[] pid = ids.split(",");
	if(pid==null||pid.length==0){
		out.print("{\"success\":false,\"message\":\"参数错误！\"}");
		return;
	}
	
	for(int i=0;i<pid.length;i++){
		Favorite fa123 = FavoriteHelper.getById(pid[i]);
		FavoriteHelper.manager.delete(fa123);
	}
	out.print("{\"success\":true,\"message\":\"删除成功！\"}");
}
%>