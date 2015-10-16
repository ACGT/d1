<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %>
<%
    String id="";
    if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
    {
    	id=request.getParameter("id");
    	AYPrize nd=(AYPrize)Tools.getManager(AYPrize.class).get(id);
    	if(id!=null)
    	{
    		if(Tools.getManager(AYPrize.class).delete(nd))
    		{
    			out.print("删除成功");
    		}
    		else
    		{
    			out.print("删除失败");
    		}
    	}
    	else
    	{
    		out.print("记录不存在");
    	}
    }
    else
    {
       out.print("参数不正确");
    }

%>