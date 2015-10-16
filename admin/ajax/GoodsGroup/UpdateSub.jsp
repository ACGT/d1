<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String id = request.getParameter("id");
if(Tools.isNull(id)){
	out.print("{\"succ\":false,message:\"参数不正确！\"}");
    return;
}
String value = request.getParameter("val");
if(Tools.isNull(value)){
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
	gg.setGdsgrpdtl_stdvalue(value);
		if(Tools.getManager(GoodsGroupDetail.class).update(gg,true))
		{
			out.print("{\"succ\":true,message:\"更新成功！\"}");
		    return;
		}
		else
		{
			out.print("{\"succ\":false,message:\"更新出错，请稍后重试！\"}");
		    return;
		}
	}
	catch(Exception e){
		out.print("{\"succ\":false,message:\"更新出错，请稍后重试！\"}");
	    return;
	}

%>