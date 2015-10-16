<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>淘宝生成索引文件</title>
<script language="javascript" type="text/javascript">
  function getSellCats(){
	  window.location.href="/intf/taobaoSellerCats.jsp";
  }
  function getFullIndex(){
	  window.location.href="/intf/taobaoFullIndex.jsp";
  }
  function getInIndex(){
	  window.location.href="/intf/taobaoIncrementIndex.jsp";
  }
</script>
</head>
<body>
<center>
<%
if(!Tools.isNull(request.getParameter("sellcats"))){
	if("1".equals(request.getParameter("sellcats").trim())){
		out.print("类目生成成功");
		//out.print("<script type=\"text/javascript\">alert('类目生成成功！');</script>");
	}
}
if(!Tools.isNull(request.getParameter("fullindex"))){
	if("1".equals(request.getParameter("fullindex").trim())){
		//out.print("<script type=\"text/javascript\">alert('全量索引生成成功！');</script>");
		out.print("全量索引生成成功");
	}else if("-1".equals(request.getParameter("fullindex").trim())){
		//out.print("<script type=\"text/javascript\">alert('全量索引子目录生成失败！');</script>");
		out.print("全量索引子目录生成失败");
	}else if("-2".equals(request.getParameter("fullindex").trim())){
		//out.print("<script type=\"text/javascript\">alert('全量索引主目录生成失败！');</script>");
		out.print("全量索引主目录生成失败");
	}
}
if(!Tools.isNull(request.getParameter("inindex"))){
	if("1".equals(request.getParameter("inindex").trim())){
		//out.print("<script type=\"text/javascript\">alert('增量索引生成成功！');</script>");
		out.print("增量索引生成成功");
	}else if("-1".equals(request.getParameter("fullindex").trim())){
		//out.print("<script type=\"text/javascript\">alert('增量索引子目录生成失败！');</script>");
		out.print("增量索引子目录生成失败");
	}else if("-2".equals(request.getParameter("fullindex").trim())){
		//out.print("<script type=\"text/javascript\">alert('增量索引主目录生成失败！');</script>");
		out.print("增量索引主目录生成失败");
	}
}
%>
   <input type="button" value="全量" onclick="getFullIndex()"></input><br/><br/>
  <input type="button" value="增量" onclick="getInIndex()"></input><br/><br/>
  <input type="button" value="类目" onclick="getSellCats()"></input><br/><br/>
 
   
</center>
</body>
</html>