<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%@include file="/admin/public.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改评论组详细记录</title>
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
  String id="";
  if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
  {
	  id=request.getParameter("id");
  }
  else
  {
	  out.print("对不起，参数不正确！");
	  return;
  }
  CommentGroupSub cgs=(CommentGroupSub)Tools.getManager(CommentGroupSub.class).get(id);
  if(cgs==null)
  {
	  Tools.outJs(out, "记录不存在！", "back");
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
	  
	  
	  cgs.setCommentgroupsub_gdsid(cgs_gdsid);
	  cgs.setCommentgroupsub_flag(new Long(cgs_flag));
	 
	  if(Tools.getManager(CommentGroupSub.class).update(cgs,false))
	  {
		  out.print("<script>alert('修改成功！');this.location.href='/admin/CommentGroup/updatecommentgroupsub.jsp?id="+id+"'; </script>");
	  }
	  else
	  {
		  Tools.outJs(out, "修改失败，稍后重试！", "back");
	  }
  }

%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">修改评论组详细记录</h1>
   <a href="/admin/CommentGroup/subcglist.jsp?cgid=<%=cgs.getCommentgroupsub_cgid() %>" target="bottom">评论组管理</a><br/>
   <form id="comment" name="comment" method="post" action="/admin/CommentGroup/updatecommentgroupsub.jsp?id=<%=cgs.getId() %>" >
   <table style=" margin:0px auto; font-size:14px;text-align:left;">       
        <tr><td>评论主组编号：</td><td><%=cgs.getCommentgroupsub_cgid()  %></td></tr>
        <tr><td>商品编号：</td><td><input type="text" id="cgs_gdsid" name="cgs_gdsid" value="<%= cgs.getCommentgroupsub_gdsid() %>"/> </td></tr>
        <tr><td>是否有效：</td><td><select id="cgs_flag" name="cgs_flag">
                                  <option value="0" <%= cgs.getCommentgroupsub_flag().longValue()==0?"selected":"" %>>无效</option>
                                  <option value="1" <%= cgs.getCommentgroupsub_flag().longValue()==1?"selected":"" %>>有效</option> 
                                  </select></td></tr>
        
        <tr><td colspan="2"><input type="button" value="修 改" style="width:80px;" onclick="Check();"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
   </table>
     
   </form>
</div>
</body>
</html>





