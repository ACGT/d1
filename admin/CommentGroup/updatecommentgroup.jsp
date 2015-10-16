<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改评论主组</title>
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
	   var title=$('#cg_title').val();
	   var rackcode=$('#cg_rackcode').val();
	   if(title.length<=0)
	   {
		   $.alert('对不起，标题不能为空！');
		   return;
		}
	   if(rackcode.length<=0)
	   {
		   $.alert('对不起，商品分类号不能为空');
		   return;
	   }
	   document.comment.submit();
   }
   
   function cancle()
   {
	   $("#cg_title").val('');
	   $("#cg_rackcode").val('');
	   $("#cg_flag").val('0');
	   $("#cg_content").val('');
	   
	 
   }
</script>

</head>
<body>
<%
   String id="";
   if(request.getParameter("id")!=null&&request.getParameter("id").length()>0&&Tools.isNumber(request.getParameter("id")))
   {
	   id=request.getParameter("id");
   }
   else
   {
	   out.print("参数不正确！");
	   return;
   }
   CommentGroup cg1=(CommentGroup)Tools.getManager(CommentGroup.class).get(id);
   if(cg1==null)
   {
	   out.print("记录不存在！");
	   return;
   }
  if("post".equals(request.getMethod().toLowerCase()))
  {
	  String cg_title="";
	  String cg_content="";
	  String cg_rackcode="";
	  String cg_flag="";
	  
	  if(request.getParameter("cg_title")!=null&&request.getParameter("cg_title").length()>0){
		  cg_title=request.getParameter("cg_title");
	  }
	  if(request.getParameter("cg_rackcode")!=null&&request.getParameter("cg_rackcode").length()>0){
		  cg_rackcode=request.getParameter("cg_rackcode");
	  }
	  if(request.getParameter("cg_flag")!=null&&request.getParameter("cg_flag").length()>0){
		  cg_flag=request.getParameter("cg_flag");
	  }
	  if(request.getParameter("cg_content")!=null&&request.getParameter("cg_content").length()>0){
		  cg_content=request.getParameter("cg_content");
	  }
	  if(cg_title==null&&cg_title.length()<=0)
	  {
		  Tools.outJs(out, "请输入评论组标题！", "back");
		  return;
	  }
	  if(cg_rackcode==null&&cg_rackcode.length()<=0)
	  {
		  Tools.outJs(out, "请输入分类编号！", "back");
		  return;
	  }
	 
	  cg1.setCommentgroup_title(cg_title);
	  cg1.setCommentgroup_rackcode(cg_rackcode);
	  cg1.setCommentgroup_flag(new Long(cg_flag));
	  cg1.setCommentgroup_content(cg_content);
	  cg1.setCommentgroup_createtime(new Date());
	  
	  if(Tools.getManager(CommentGroup.class).update(cg1,false))
	  {
		  out.print("<script>alert('修改成功！');this.location.href='/admin/CommentGroup/updatecommentgroup.jsp?id="+id+"'; </script>");
	  }
	  else
	  {
		  Tools.outJs(out, "修改失败，稍后重试！", "back");
	  }
  }

%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">修改评论主组</h1>
   <a href="http://www.d1.com.cn/admin/CommentGroup/cgmanager.jsp" target="top">评论组管理</a><br/>
   <form id="comment" name="comment" method="post" action="updatecommentgroup.jsp?id=<%=id %>" >
   <table style=" margin:0px auto; font-size:14px;text-align:left;">       
        <tr><td>评论组主题：</td><td><input type="text" id="cg_title" name="cg_title" value="<%= cg1.getCommentgroup_title() %>" /></td></tr>
        <tr><td>评论组所属分类：</td><td><input type="text" id="cg_rackcode" name="cg_rackcode" value="<%= cg1.getCommentgroup_rackcode() %>"/> </td></tr>
        <tr><td>是否有效：</td><td><select id="cg_flag" name="cg_flag">
                                  <option value="0" <%= cg1.getCommentgroup_flag().longValue()==0?"selected":"" %>>无效</option>
                                  <option value="1" <%= cg1.getCommentgroup_flag().longValue()==1?"selected":"" %>>有效</option> 
                                  </select></td></tr>
        <tr><td>评论组描述：</td><td><input type="text" id="cg_content" name="cg_content" style="width:300px; height:200px;" value=<%=cg1.getCommentgroup_content() %>/></td></tr>
        <tr><td colspan="2"><input type="button" value="修 改" style="width:80px;" onclick="Check();"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
   </table>
     
   </form>
</div>
</body>
</html>





