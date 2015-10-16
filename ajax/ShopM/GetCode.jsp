<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%
		String rack = request.getParameter("c");
		ArrayList<Directory> dirlist=new ArrayList<Directory>();
		dirlist=DirectoryHelper.getByParentcode(rack);
        if(dirlist!=null&&dirlist.size()>0)
        {
        	out.print("{\"success\":false,message:\"不是最后一级分类！\"}");
        	return;
        	
        }
        else
        {
        	out.print("{\"success\":true,message:\"是最后一级分类！\"}");
        	return;
        }
%>