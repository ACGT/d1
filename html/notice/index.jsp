<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网---公告</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/index.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css" >
body{ font-size:12px; color:#444; background-color:#fff;}
.center{ margin:0px auto; padding-top:10px; width:980px;}
.clear{ float:none;}
.center .left{ width:200px; overflow:hidden; float:left; border-bottom:solid 1px #c2c2c2;}
.center .right{  width:733px; margin-left:15px; float:left; padding-bottom:30px;  padding-top:20px; border:solid 1px #c2c2c2; background-color:#f6f6f6; padding-left:15px;
margin-bottom:50px; padding-right:15px;}
.toggle{ width:200px; overflow:hidden;}
.left .toggle dl{ margin:0px;}
.left .toggle dl dd{ margin-top:10px; padding-bottom:10px; list-style:none; border:solid 1px #c2c2c2; width:198px;overflow:hidden; border-top:none;  border-bottom:none;}
.left .toggle dl dd{ margin:0px;}
.left .toggle dl dd ul{margin:0px; padding:0px; padding-left:10px; padding-right:8px; padding-bottom:8px; list-style:none;}
.left .toggle dl  dd ul li{ margin-top:10px; font-size:13px; color:#333333; line-height:17px;}
.toggle dl dt { background:#ebebeb url('http://images.d1.com.cn/Index/left-sj1.jpg') no-repeat scroll 10px 12px; cursor:pointer; margin-top:8px 0px; width:198px;height:30px; line-height:35px; color:#892c3e; font-size:14px; font-weight:bold; border-left:solid 1px #c2c2c2; border-right:solid 1px #c2c2c2;  }
.toggle dl dt.current { background: #ebebeb url('http://images.d1.com.cn/Index/left-sj.jpg') no-repeat scroll 10px 12px;  }
img{ vertical-align:bottom;}
.dd1 ul li img{ width:20px; height:20px;}

</style>
</head>
<body>
<%  ArrayList<Notice> nlist1=new ArrayList<Notice>(); %>

<!-- 头部 -->
<%@include file="../../inc/head.jsp" %>

<!-- 头部结束 -->

 <div class="center">
      <div class="left">
	        <div style=" width:200px; background:#ae4859; height:35px;">
			    <span style=" color:#fff; font-size:18px; font-weight:bold; line-height:37px; padding-left:4px; ">市场公告</span><span style=" color:#c85c6f; font-size:13px;  font-weight:bold; padding-left:1px; ">ANNUNC</span>
			</div>
			
			<%
			    ArrayList<NoticeDir> list=new ArrayList<NoticeDir>();
			    List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
			    clist.add(Restrictions.eq("parentId", "1"));
			    clist.add(Restrictions.eq("flag", new Long(1)));
			    List<Order> olist=new ArrayList<Order>();
			    olist.add(Order.asc("priority"));
			    olist.add(Order.asc("createdate"));
			    List<BaseEntity> b_list=Tools.getManager(NoticeDir.class).getList(clist, olist, 0, 100);
			    if(b_list!=null&&b_list.size()>0)
			    {
			    	for(BaseEntity be:b_list)
			    	{
			    		list.add((NoticeDir)be);
			    	}
			    }
			    
			    if(list!=null&&list.size()>0)
			    {%>
			       <div class="toggle">
		        	<dl>
			          <%
			              int i=0;
			              for(NoticeDir nd:list)
				          {%>
				        	<dt >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= nd.getTitle() %></dt>
				        	  <%  
				        	       ArrayList<Notice> nlist=new ArrayList<Notice>();
				        	       List<SimpleExpression> clist1=new ArrayList<SimpleExpression>();
					        	  	clist1.add(Restrictions.eq("dirId", nd.getId()));
					        	  	clist1.add(Restrictions.eq("flag",new Long(1)));
				        	       
					        	  	List<Order> olist1=new ArrayList<Order>();
				        	        olist1.add(Order.asc("priority"));
				        	       
				        	       List<BaseEntity> b_list1=Tools.getManager(Notice.class).getList(clist1, olist1, 0, 100);
				        	       if(b_list1!=null&&b_list1.size()>0)
				        	       {
				        	    	   for(BaseEntity bes:b_list1)
				        	    	   {
				        	    		   nlist.add((Notice)bes);
				        	    		   nlist1.add((Notice)bes);
				        	    	   }
				        	       }
				        	      
				        	       if(nlist!=null&&nlist.size()>0)
				        	       {%>
				        	    	   <dd class="dd1">
				        	    	   <ul>
				        	    	   <% 
				        	    	      
                                           for(Notice notice:nlist)
				        	    	       { i++;
				        	    	       %>
				        	    		    <li <% if(request.getParameter("ID")!=null&&request.getParameter("ID").length()>0)
				        	    		    { 
				        	    		    	if(notice.getId().equals(request.getParameter("ID").trim()))
				        	    		         	out.print("style=\" background-color:#ebebeb;\"");
				        	    		    }
				        	    		    else
				        	    		    {
				        	    		    	if(i==1)
				        	    		    	{
				        	    		    		out.print("style=\" background-color:#ebebeb;\"");
				        	    		    	}
				        	    		    }
				        	    		    	%> >■&nbsp;<a href="index.jsp?ID=<%=notice.getId() %>" target="_blank"><%= notice.getTitle() %></a></li>
				        				   
				        	    	       <%}
				        	    		
				        	    		   %>
				        			   </ul>
				        			</dd>
				        	      <% }
				        	       
				        	  %>
				          <%}  
			          %>
			       </dl>
			       </div>	
			    <%}
			    
			%>
			
			
			  <div style=" width:200px; background:#ae4859; height:35px;">
			    <span style=" color:#fff; font-size:18px; font-weight:bold; line-height:37px; padding-left:4px; ">服务公告</span><span style=" color:#c85c6f; font-size:13px;  font-weight:bold; padding-left:1px; ">ANNUNC</span>
			</div>
			
			<%
			    ArrayList<NoticeDir> list1=new ArrayList<NoticeDir>();
			    List<SimpleExpression> clist1=new ArrayList<SimpleExpression>();
			    clist1.add(Restrictions.eq("parentId", "2"));
			    clist1.add(Restrictions.eq("flag", new Long(1)));
			    List<Order> olist1=new ArrayList<Order>();
			    olist1.add(Order.asc("priority"));
			    olist1.add(Order.asc("createdate"));
			    List<BaseEntity> b_list1=Tools.getManager(NoticeDir.class).getList(clist1, olist1, 0, 100);
			    if(b_list1!=null&&b_list1.size()>0)
			    {
			    	for(BaseEntity be:b_list1)
			    	{
			    		list1.add((NoticeDir)be);
			    	}
			    }
			    
			    if(list1!=null&&list1.size()>0)
			    {%>
			       <div class="toggle">
		        	<dl>
			          <%
			              int i=0;
			              for(NoticeDir nd:list1)
				          {%>
				        	<dt >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= nd.getTitle() %></dt>
				        	  <%  
				        	       ArrayList<Notice> nlist=new ArrayList<Notice>();
				        	       List<SimpleExpression> clist1_1=new ArrayList<SimpleExpression>();
				        	       clist1_1.add(Restrictions.eq("dirId", nd.getId()));
				        	       clist1_1.add(Restrictions.eq("flag",new Long(1)));
				        	       
					        	  	List<Order> olist1_1=new ArrayList<Order>();
					        	  	olist1_1.add(Order.asc("priority"));
				        	       
				        	       List<BaseEntity> b_list1_1=Tools.getManager(Notice.class).getList(clist1_1, olist1_1, 0, 100);
				        	       if(b_list1_1!=null&&b_list1_1.size()>0)
				        	       {
				        	    	   for(BaseEntity bes:b_list1_1)
				        	    	   {
				        	    		   nlist.add((Notice)bes);
				        	    		   nlist1.add((Notice)bes);
				        	    	   }
				        	       }
				        	      
				        	       if(nlist!=null&&nlist.size()>0)
				        	       {%>
				        	    	   <dd class="dd1">
				        	    	   <ul>
				        	    	   <% 
				        	    	      
                                           for(Notice notice:nlist)
				        	    	       { i++;
				        	    	       %>
				        	    		    <li <% if(request.getParameter("ID")!=null&&request.getParameter("ID").length()>0)
				        	    		    { 
				        	    		    	if(notice.getId().equals(request.getParameter("ID").trim()))
				        	    		         	out.print("style=\" background-color:#ebebeb;\"");
				        	    		    }
				        	    		    else
				        	    		    {
				        	    		    	if(i==1&&nlist1.size()<nlist.size())
				        	    		    	{
				        	    		    		out.print("style=\" background-color:#ebebeb;\"");
				        	    		    	}
				        	    		    }
				        	    		    	%> >■&nbsp;<a href="index.jsp?ID=<%=notice.getId() %>" target="_blank"><%= notice.getTitle() %></a></li>
				        				   
				        	    	       <%}
				        	    		
				        	    		   %>
				        			   </ul>
				        			</dd>
				        	      <% }
				        	       
				        	  %>
				          <%}  
			          %>
			       </dl>
			       </div>	
			    <%}
			    
			%>
			
			
			<div style=" width:200px; background:#ae4859; height:35px;">
			    <span style=" color:#fff; font-size:18px; font-weight:bold; line-height:37px; padding-left:4px; ">网站功能公告</span><span style=" color:#c85c6f; font-size:13px;  font-weight:bold; padding-left:1px; ">ANNUNC</span>
			</div>
			
			<%
			    ArrayList<NoticeDir> wlist=new ArrayList<NoticeDir>();
			    List<SimpleExpression> clist1_2=new ArrayList<SimpleExpression>();
			    clist1_2.add(Restrictions.eq("parentId", "3"));
			    clist1_2.add(Restrictions.eq("flag", new Long(1)));
			    List<Order> olist1_2=new ArrayList<Order>();
			    olist1.add(Order.asc("priority"));
			    olist1.add(Order.asc("createdate"));
			    List<BaseEntity> b_list1_2=Tools.getManager(NoticeDir.class).getList(clist1_2, olist1_2, 0, 100);
			    if(b_list1_2!=null&&b_list1_2.size()>0)
			    {
			    	for(BaseEntity be:b_list1_2)
			    	{
			    		wlist.add((NoticeDir)be);
			    	}
			    }
			    
			    if(wlist!=null&&wlist.size()>0)
			    {%>
			       <div class="toggle">
		        	<dl>
			          <%
			              int i=0;
			              for(NoticeDir nd:wlist)
				          {%>
				        	<dt >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= nd.getTitle() %></dt>
				        	  <%  
				        	       ArrayList<Notice> nlist=new ArrayList<Notice>();
				        	       List<SimpleExpression> clist1_1=new ArrayList<SimpleExpression>();
				        	       clist1_1.add(Restrictions.eq("dirId", nd.getId()));
				        	       clist1_1.add(Restrictions.eq("flag",new Long(1)));
				        	       
					        	  	List<Order> olist1_1=new ArrayList<Order>();
					        	  	olist1_1.add(Order.asc("priority"));
				        	       
				        	       List<BaseEntity> b_list1_1=Tools.getManager(Notice.class).getList(clist1_1, olist1_1, 0, 100);
				        	       if(b_list1_1!=null&&b_list1_1.size()>0)
				        	       {
				        	    	   for(BaseEntity bes:b_list1_1)
				        	    	   {
				        	    		   nlist.add((Notice)bes);
				        	    		   nlist1.add((Notice)bes);
				        	    	   }
				        	       }
				        	      
				        	       if(nlist!=null&&nlist.size()>0)
				        	       {%>
				        	    	   <dd class="dd1">
				        	    	   <ul>
				        	    	   <% 
				        	    	      
                                           for(Notice notice:nlist)
				        	    	       { i++;
				        	    	       %>
				        	    		    <li <% if(request.getParameter("ID")!=null&&request.getParameter("ID").length()>0)
				        	    		    { 
				        	    		    	if(notice.getId().equals(request.getParameter("ID").trim()))
				        	    		         	out.print("style=\" background-color:#ebebeb;\"");
				        	    		    }
				        	    		    else
				        	    		    {
				        	    		    	if(i==1&&nlist1.size()<nlist.size())
				        	    		    	{
				        	    		    		out.print("style=\" background-color:#ebebeb;\"");
				        	    		    	}
				        	    		    }
				        	    		    	%> >■&nbsp;<a href="index.jsp?ID=<%=notice.getId() %>" target="_blank"><%= notice.getTitle() %></a></li>
				        				   
				        	    	       <%}
				        	    		
				        	    		   %>
				        			   </ul>
				        			</dd>
				        	      <% }
				        	       
				        	  %>
				          <%}  
			          %>
			       </dl>
			       </div>	
			    <%}
			    
			%>
			
		</div>
	  
	  <div class="right">
	  <%
		    String id="";
		    if(request.getParameter("ID")!=null&&request.getParameter("ID").length()>0)
		    {
		    	id=request.getParameter("ID");
		    	Notice nnn=(Notice)Tools.getManager(Notice.class).get(id);
		    	if(nnn!=null&&nnn.getFlag().longValue()!=0)
		    	{
		    		out.print(nnn.getContent());
		    	}
		    	else
		    	{
		    		out.print("该文章不存在或者该文章不可见");
		    	}
		    }
		    else
		    {   
		    	if(nlist1!=null&&nlist1.size()>0)
		    	{
		    		out.print(nlist1.get(0).getContent());
		    	}
		    	else
		    	{
		    		out.print("没有文章可提供");
		    	}
		    	
		    }

%>
	  
	  
	  
</div>
   </div>
   <div class="clear"></div>
   <!-- 尾部 -->
  <%@include file="../../inc/foot.jsp" %>
   <!-- 尾部结束 -->
</body>
</html>