<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加评论主组</title>
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
	  if(cg_rackcode.length()!=6)
	  {
		  Tools.outJs(out, "请输入六位分类编号！", "back");
		  return;
	  }		  
	  CommentGroup cg=new CommentGroup();
	  cg.setCommentgroup_title(cg_title);
	  cg.setCommentgroup_rackcode(cg_rackcode);
	  cg.setCommentgroup_flag(new Long(cg_flag));
	  cg.setCommentgroup_content(cg_content);
	  cg.setCommentgroup_createtime(new Date());
	  cg=(CommentGroup)Tools.getManager(CommentGroup.class).create(cg);
	  if(cg!=null)
	  {
		   out.print("<script>alert('添加成功！');this.location.href='/admin/CommentGroup/addCommentGroup.jsp'; </script>");
	  }
	  else
	  {
		  Tools.outJs(out, "添加失败，稍后重试！", "back");
	  }
  }

%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">添加评论主组</h1>
   <a href="http://www.d1.com.cn/admin/CommentGroup/cgmanager.jsp" target="top">评论组管理</a><br/>
   <form id="comment" name="comment" method="post" action="addCommentGroup.jsp" >
   <table style=" margin:0px auto; font-size:14px;text-align:left;">       
        <tr><td>评论组主题：</td><td><input type="text" id="cg_title" name="cg_title" />&nbsp;&nbsp;<span id="cg_title_notice"></span></td></tr>
        <tr><td>评论组所属分类：</td><td><input type="text" id="cg_rackcode" name="cg_rackcode"/> <font style="color:#f00">请输入六位的分类号</font></td></tr>
        <tr><td>是否有效：</td><td><select id="cg_flag" name="cg_flag">
                                  <option value="0">无效</option>
                                  <option value="1">有效</option> 
                                  </select></td></tr>
        <tr><td>评论组描述：</td><td><input type="text" id="cg_content" name="cg_content" style="width:300px; height:200px;"/></td></tr>
        <tr><td colspan="2"><input type="button" value="添加" style="width:80px;" onclick="Check();"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
   </table>
     
   </form>
</div>
</body>
</html>





