<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
    String id="";
    if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
    {
    	id=request.getParameter("id");
    	NoticeDir nd=(NoticeDir)Tools.getManager(NoticeDir.class).get(id);
    	if(id!=null)
    	{
    		if(Tools.getManager(NoticeDir.class).delete(nd))
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