<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
   if(request.getParameter("u")!=null&&request.getParameter("u").length()>0&&request.getParameter("u").equals("update"))
   {
	    String noticedirid="";
	    if(request.getParameter("noticedirid")!=null&&request.getParameter("noticedirid").length()>0)
	    {
	    	noticedirid=request.getParameter("noticedirid");
		    String ggType=request.getParameter("ggtype")==null?"0":request.getParameter("ggtype");
		    String ggtitle=request.getParameter("gg_title")==null?"":request.getParameter("gg_title");
		    String ggflag=request.getParameter("gg_flag")==null?"0":request.getParameter("gg_flag");
		    String order=request.getParameter("orders")==null?"0":request.getParameter("orders");
		    
		    if(!ggType.equals("0")&&ggtitle.length()>0&&ggflag.length()>0)
		    {
			    	NoticeDir nd=(NoticeDir)Tools.getManager(NoticeDir.class).get(noticedirid);
			    	nd.setParentId(ggType);
			    	nd.setTitle(ggtitle);

			    	nd.setPriority(Tools.parseLong(order));
			    	nd.setFlag(Tools.parseLong(ggflag));

			    	Tools.getManager(NoticeDir.class).clearListCache(nd);
			    	if(Tools.getManager(NoticeDir.class).update(nd,true))
			    	{
			    		 out.print("更新公告成功！");
			    	}
			    	else
			    	{
			    		out.print("更新公告失败！");
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
	   String noticedirid="";
	   int flag=0;
	   if(request.getParameter("noticedirid")!=null&&request.getParameter("noticedirid").length()>0&&request.getParameter("flag")!=null&&
			   (Tools.parseInt(request.getParameter("flag"))==0||Tools.parseInt(request.getParameter("flag"))==1))
	   {
		   noticedirid=request.getParameter("noticedirid");
		   NoticeDir nd=(NoticeDir)Tools.getManager(NoticeDir.class).get(noticedirid);
		   
		   nd.setFlag(Tools.parseLong(request.getParameter("flag")));
		   if(Tools.getManager(NoticeDir.class).update(nd, false))
		   {
			   out.print("公告隐藏成功！");
		   }
		   else
		   {
			   out.print("公告隐藏失败！");
		   }
	   }
	   else
	   {
		   out.print("参数传递不正确！");
	   }
   }
%>