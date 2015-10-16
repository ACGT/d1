<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%
	String rack = request.getParameter("code");
    String l = request.getParameter("levels");
	ArrayList<Directory> dirlist=new ArrayList<Directory>();
	dirlist=DirectoryHelper.getByParentcode(rack);
	if(dirlist!=null&&dirlist.size()>0)
	{
		%>
		<%
		for(Directory dir : dirlist){
			if(dir!=null)
			{%>
			<option value="<%= dir.getId().trim() %>" ><%= dir.getRakmst_rackname()%></option>   
            				
			<%}
		}
		%>
	<%
	}
	else
	{%>
	
		
	<%}
%>