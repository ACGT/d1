<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/CommentGroup/public.jsp" %>
<%@include file="/admin/chkrgt.jsp"%>
<%
     String gdsid="";
     if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0&&Tools.isNumber(request.getParameter("gdsid")))
     {
    	 gdsid=request.getParameter("gdsid");
     }
     String cid="";
     if(request.getParameter("cid")!=null&&request.getParameter("cid").length()>0&&Tools.isNumber(request.getParameter("cid")))
     {
    	 cid=request.getParameter("cid");
     }
     Product p=ProductHelper.getById(gdsid);
     if(p==null)
     {
    	 out.print("{\"succ\":false,\"message\":\"商品不存在！\"}");
    	 return;
     }
     CommentGroup cg=(CommentGroup)Tools.getManager(CommentGroup.class).findByProperty("id", cid);
     int flag=0;//是否已存在评论组中
     if(cg!=null)
     {
    	 ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cid);
    	 if(cgslist!=null&&cgslist.size()>0)
    	 {
    		 for(CommentGroupSub cgs:cgslist)
    		 {
    			 if(cgs!=null&&cgs.getCommentgroupsub_gdsid()!=null)
    			 {
    				 if(cgs.getCommentgroupsub_gdsid().equals(gdsid))
    				 {
    					 flag=1;
    					 break;
    				 }
    			 }
    		 }
    	 }
    	 if(flag==1)
    	 {
    		 out.print("{\"succ\":false,\"message\":\"该评论组中已存在该商品！\"}");
        	 return;
    	 }
    	 else
    	 {
    		 CommentGroupSub news=new CommentGroupSub();
    		 news.setCommentgroupsub_cgid(new Long(cid));
    		 news.setCommentgroupsub_createtime(new Date());
    		 news.setCommentgroupsub_flag(new Long(1));
    		 news.setCommentgroupsub_gdsid(gdsid);
    		 news=(CommentGroupSub)Tools.getManager(CommentGroupSub.class).create(news);
    		 if(news!=null)
    		 {
    			 out.print("{\"succ\":true,\"message\":\"添加成功！\"}");
    	    	 return;
    		 }
    		 else
    		 {
    			 out.print("{\"succ\":false,\"message\":\"添加失败！\"}");
    	    	 return;
    		 }
    	 }
     }
     else
     {
    	 out.print("{\"succ\":false,\"message\":\"评论组不存在！\"}");
    	 return;
     }
     
%>