<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/CommentGroup/public.jsp" %>
<%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加评论组详细记录</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
  input{ width:250px;}
  span{ color:#f00;}
</style>
<script type="text/javascript" language="javascript">
   function Check()
   {	   
	   var gdsid=$('#cgs_gdsid').val();
	   if(gdsid.length<=0)
	   {
		   $.alert('对不起，商品编号不能为空！');
		   return;
		}
	  
	   document.comment.submit();
   }
   
   function cancle()
   {
	   $("#cgs_gdsid").val('');
	   $("#cgs_flag").val('0');
	   
	 
   }
</script>

</head>
<body>
<%
String cgid="";
if(request.getParameter("cgid")!=null&&request.getParameter("cgid").length()>0)
{
	  cgid=request.getParameter("cgid");
}
else
{
	  out.print("对不起，参数不正确！");
	  return;
}

  if("post".equals(request.getMethod().toLowerCase()))
  {
	  String cgs_gdsid="";
	  String cgs_flag="";
	  
	  if(request.getParameter("cgs_gdsid")!=null&&request.getParameter("cgs_gdsid").length()>0){
		  cgs_gdsid=request.getParameter("cgs_gdsid");
	  }
	  
	  if(request.getParameter("cgs_flag")!=null&&request.getParameter("cgs_flag").length()>0){
		  cgs_flag=request.getParameter("cgs_flag");
	  }
	 
	  if(cgs_gdsid.length()<=0)
	  {
		  Tools.outJs(out, "请输入商品编号！", "back");
		  return;
	  }
	   Product p=ProductHelper.getById(cgs_gdsid);
	   if(p==null)
	   {
		   Tools.outJs(out, "商品编号不正确！", "back");
			  return;
	   }
	   ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cgid);
	   CommentGroup cg=(CommentGroup)Tools.getManager(CommentGroup.class).findByProperty("id", cgid);
	     int flag=0;//是否已存在评论组中
	     if(cg!=null)
	     {
	    	 ArrayList<CommentGroupSub> cgslist1=getCommentGroupSubList(cgid);
	    	 if(cgslist1!=null&&cgslist1.size()>0)
	    	 {
	    		 for(CommentGroupSub cgs:cgslist1)
	    		 {
	    			 if(cgs!=null&&cgs.getCommentgroupsub_gdsid()!=null)
	    			 {
	    				 if(cgs.getCommentgroupsub_gdsid().equals(cgs_gdsid))
	    				 {
	    					 flag=1;
	    					 break;
	    				 }
	    			 }
	    		 }
	    	 }
	    	 if(flag==1)
	    	 {
	    		 Tools.outJs(out, "该评论组中已存在该商品！", "back");
	        	 return;
	    	 }
	    	 else
	    	 {
				  CommentGroupSub cgs=new CommentGroupSub();
				  cgs.setCommentgroupsub_cgid(new Long(cgid));
				  cgs.setCommentgroupsub_gdsid(cgs_gdsid);
				  cgs.setCommentgroupsub_flag(new Long(cgs_flag));
				  cgs.setCommentgroupsub_createtime(new Date());
				  cgs=(CommentGroupSub)Tools.getManager(CommentGroupSub.class).create(cgs);
				  if(cgs!=null)
				  {
					  out.print("<script>alert('添加成功！');this.location.href='/admin/CommentGroup/addCommentGroupSub.jsp?cgid="+cgid+"'; </script>");
						
				  }
				  else
				  {
					  Tools.outJs(out, "添加失败，稍后重试！", "back");
				  }
	    	 }
	     }
  }

%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">添加评论组详细记录</h1>
   <a href="/admin/CommentGroup/subcglist.jsp?cgid=<%=cgid %>" target="bottom">评论组管理</a><br/>
   <form id="comment" name="comment" method="post" action="addCommentGroupSub.jsp?cgid=<%= cgid %>" >
   <table style=" margin:0px auto; font-size:14px;text-align:left;">       
        <tr><td>评论主组编号：</td><td><%= cgid %></td></tr>
        <tr><td>商品编号：</td><td><input type="text" id="cgs_gdsid" name="cgs_gdsid"/> </td></tr>
        <tr><td>是否有效：</td><td><select id="cgs_flag" name="cgs_flag">
                                  <option value="0">无效</option>
                                  <option value="1">有效</option> 
                                  </select></td></tr>
        
        <tr><td colspan="2"><input type="button" value="添 加" style="width:80px;" onclick="Check();"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
   </table>
     
   </form>
</div>
</body>
</html>





