<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String id = request.getParameter("id");
if(Tools.isNull(id)){
	out.print("{\"succ\":false,message:\"参数不正确！\"}");
    return;
}
GoodsGroupDetail gg=(GoodsGroupDetail)Tools.getManager(GoodsGroupDetail.class).get(id);
if(gg==null)
{
	out.print("{\"succ\":false,message:\"记录不存在！\"}");
    return;
}
try{
	Tools.getManager(GoodsGroupDetail.class).delete(gg);    	
	}
	catch(Exception e){
		out.print("{\"succ\":false,message:\"删除出错，请稍后重试！\"}");
	    return;
	}
out.print("{\"succ\":true,message:\"删除成功！\"}");
%>