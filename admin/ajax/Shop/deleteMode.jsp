<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String mid="";
if(request.getParameter("mid")!=null)
{
	mid=request.getParameter("mid");
}
if(mid.equals("")){
	out.print("{\"succ\":false,message:\"参数不正确！\"}");
    return;
}
ShopModel sm=(ShopModel)Tools.getManager(ShopModel.class).get(mid);
if(sm!=null&&sm.getId()!=null){
	try{
		if(Tools.getManager(ShopModel.class).delete(sm)){
			out.print("{\"succ\":true,message:\"删除模块成功！\"}");
		    return;
		}
		else
		{
			out.print("{\"succ\":false,message:\"删除模块失败！\"}");
		    return;
		}
	}
	catch(Exception e){
		out.print("{\"succ\":false,message:\"操作出错，请稍后重试！\"}");
	    return;
	}
	
}
else
{
	out.print("{\"succ\":false,message:\"删除的记录不存在！\"}");
    return;
}
%>