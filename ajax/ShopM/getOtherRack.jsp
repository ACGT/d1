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
		<ul>
		<%
		for(Directory dir : dirlist){
			if(dir!=null)
			{%>
			<li attr="<%= dir.getId() %>" attr1="<%=dir.getRakmst_rackname() %>" onclick="levelClick('<%=l %>',this)"><span style="display:block; width:103px; float:left;"><%= dir.getRakmst_rackname()%></span><% if(!l.equals("4")){ %><span style="display:block; width:7px; float:left;margin-top:3px;"><img src="/admin/SHManage/images/jt.jpg"/></span><%} %><div class="clear"></div></li>   
            				
			<%}
		}
		%>
		</ul>
	<%
	}
	else
	{%>
	<br/>
		没有分类！
		
	<%}
%>