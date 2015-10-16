<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Tag标签查询条件</title>
<style type="text/css">
  div{ font-size:14px; color:#aa44bb; line-height:25px;}
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  span{ color:#f00;}
  td{border-bottom:solid 1px #999999;border-right:solid 1px #999999; text-align:center;}
</style>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

</head>
<body style="padding-left:10px; background:#fff;">
<form id="form1" name="form1" method="post" action="TagManager.jsp" target="top">
<div >
<br/>
<br/>
       <br/>请输入编号：<br/>
       <input type="text" name="ids" id="ids"/><br/>
       <br/>
                  请输入标签名称：<br/>
       <input type="text" id="title" name="title" /> 
       <br/><br/>
       <input type="submit" id="btnsearch" value="查 询" /><br/><br/>
       
       <br/><br/>
       <a href="addTag.jsp" target="submit" style="color:#f00; font-size:16px;">添加标签</a>

   
</div>
</form>
</body>
</html>




