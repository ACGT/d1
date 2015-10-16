<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
    String id="";
    if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
    {
    	id=request.getParameter("id");
    	FriendLink nd=(FriendLink)Tools.getManager(FriendLink.class).get(id);
    	if(id!=null)
    	{
    		if(Tools.getManager(FriendLink.class).delete(nd))
    		{
    			out.print("{\"success\":true,\"message\":\"删除成功！\"}");
    		}
    		else
    		{
    			out.print("{\"success\":false,\"message\":\"删除失败！\"}");
    		}
    	}
    	else
    	{
    		out.print("{\"success\":false,\"message\":\"记录不存在！\"}");
    	}
    }
    else
    {
    	out.print("{\"success\":false,\"message\":\"参数不正确！\"}");
    }

%>