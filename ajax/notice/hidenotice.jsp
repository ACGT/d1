<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
   if(request.getParameter("u")!=null&&request.getParameter("u").length()>0&&request.getParameter("u").equals("update"))
   {
	    String noticeid="";
	    if(request.getParameter("noticeid")!=null&&request.getParameter("noticeid").length()>0)
	    {
	    	noticeid=request.getParameter("noticeid");
		    String Type=request.getParameter("type")==null?"0":request.getParameter("type");
		    String title=request.getParameter("title")==null?"":request.getParameter("title");
		    String flag=request.getParameter("flag")==null?"0":request.getParameter("flag");
		    String ggcolor=request.getParameter("color")==null?"":request.getParameter("color");
		    String ggimg=request.getParameter("img")==null?"":request.getParameter("img");
		    String content=request.getParameter("content")==null?"":request.getParameter("content");
		    String ggorder=request.getParameter("order")==null?"0":request.getParameter("order");
		    
		    if(!Type.equals("0")&&title.length()>0&&flag.length()>0)
		    {
		    	ArrayList<Notice> list=new ArrayList<Notice>();
		    	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		    	clist.add(Restrictions.eq("dirId", Type));
		    	List<BaseEntity> b_list = Tools.getManager(Notice.class).getList(clist, null, 0, 1000);
		    	if(b_list!=null)
		    	{
		    		for(BaseEntity b:b_list)
		    		{
		    			list.add((Notice)b);
		    		}
		    	}
		    	int fla=0;
		    	if(list!=null)
		    	{
		    		for(Notice nd:list)
		    		{
		    			if(nd.getTitle().equals(title))
		    			{
		    				fla++;
		    			}
		    		}
		    	}
		    	if(fla>0)
		    	{
		    		out.print("该文章标题已经存在不能更新！");
		    	}
		    	else
		    	{
			    	Notice nd=(Notice)Tools.getManager(Notice.class).get(noticeid);
			    	nd.setContent(content);
			    	nd.setDirId(Type);
			    	nd.setFlag(Tools.parseLong(flag));
			    	String contents="";
			    	if(ggcolor.length()>0)
			    	{
			    		contents="<font color='"+ggcolor+"'>"+title+"</font>";
			    	}
			    	else
			    	{
			    		contents=title;
			    	}
			    	if(ggimg.length()>0)
			    	{
			    		contents=contents+"<img src=\""+ggimg+"\"/>";
			    	}
			    	nd.setTitle(contents);
			    	nd.setTitle(title);
			    	nd.setPriority(Tools.parseInt(ggorder));
			    	
			    	if(Tools.getManager(Notice.class).update(nd,false))
			    	{
			    		 out.print("更新公告成功！");
			    	}
			    	else
			    	{
			    		out.print("更新公告失败！");
			    	}
		    	}
		    }
		    else
		    {
		    	out.print("参数错误！");
		    }
	    }
	    else
	    {
	    	out.print("参数错误！");
	    }
   }
   else
   {
	   String noticeid="";
	   int flag=0;
	   if(request.getParameter("noticeid")!=null&&request.getParameter("noticeid").length()>0&&request.getParameter("flag")!=null&&
			   (Tools.parseInt(request.getParameter("flag"))==0||Tools.parseInt(request.getParameter("flag"))==1))
	   {
		   noticeid=request.getParameter("noticeid");
		   Notice nd=(Notice)Tools.getManager(Notice.class).get(noticeid);
		   
		   nd.setFlag(Tools.parseLong(request.getParameter("flag")));
		   if(Tools.getManager(Notice.class).update(nd, false))
		   {
			   out.print("文章隐藏成功！");
		   }
		   else
		   {
			   out.print("文章隐藏失败！");
		   }
	   }
	   else
	   {
		   out.print("参数传递不正确！");
	   }
   }
%>