<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>评论组管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
  input{ width:250px;}
  span{ color:#f00;}
</style>

</head>
<body style="padding-left:10px;">
<br/>
<br/>
<a href="/admin/CommentGroup/addCommentGroup.jsp" target="bottom">添加评论组</a>

<div  style="backgrond:#f00">
<form id="search" name="search" method="post" action="/admin/CommentGroup/resultlist.jsp?act=gdsid" target="top">
	请输入商品编号：<input type="text" id="gdsid" name="gdsid" style="width:80px;"/>
	<input type="submit" value="搜索" style="width:80px;">
</form>

<br/><br/>
<form id="searchs" name="searchs" method="post" action="/admin/CommentGroup/resultlist.jsp?act=id" target="top">
	请输入评论主组编号：<input type="text" id="id" name="id" style="width:80px;"/>
	<input type="submit" value="搜索" style="width:80px;">
</form>
<br/><br/>
<form id="search1" name="search1" method="post" action="/admin/CommentGroup/resultlist.jsp?act=code" target="top">
	请输入分类号：<input type="text" id="code" name="code" style="width:80px;"/>	<br/><br/>
	请输入商品号：<input type="text" id="cgdsid" name="cgdsid" style="width:80px;"/><br/><br/>
	是否有效：<select id="flag" name="flag">
	    <option value="">全部</option>
	    <option value="0">无效</option>
	    <option value="1">有效</option>
	</select><br/>
	<input type="submit"  value="搜索" style="width:80px;">
</form>

</div>


</div>
</body>
</html>




