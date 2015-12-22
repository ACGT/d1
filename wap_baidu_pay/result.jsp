<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.comp.*,com.d1.manager.*"%><%@include
	file="/inc/header.jsp"%>
<%
request.setCharacterEncoding("GBK");

String productsort = request.getParameter("productsort");
String parentId="000";
if(!Tools.isNull(productsort)){
	productsort = productsort.trim();
	productsort = Tools.simpleCharReplace(productsort);
	String ps123 = productsort;
	//如果传了多个分类，只取第一个，原来有传多个分类的链接
	if(ps123.indexOf(",")>-1){
		ps123 = ps123.substring(0,ps123.indexOf(","));
	}
	Directory dir = DirectoryHelper.getById(ps123);
	if(dir == null){
		response.sendRedirect("/mindex.jsp");
		return;
	}
	else
	{ if(ps123.length()!=3){
		parentId=dir.getRakmst_parentrackcode();
	    }else{
	    	parentId=ps123;
	    }
	 }
}else{
	response.sendRedirect("/mindex.jsp");
	return;
}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-分类列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, hr, pre, form,
	fieldset, input, textarea, p, label, blockquote, th, td, button, span {
	padding: 0;
	margin: 0;
}

body {
	background: #fff;
	font: 14px Arial, "微软雅黑";
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
	padding-left: 4px;
}

ol, ul {
	list-style: none;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

.clear {
	clear: both;
	font-size: 1px;
	line-height: 0;
	height: 0px;
	*zoom: 1;
}

img {
	border: none;
}

.top {
	margin-top: 3px;
}

.top ul li {
	float: left;
	border-bottom: solid 1px #000;
}

.top ul li a {
	color: #000;
}

.top ul li a:hover {
	color: #aa2e44;
}

.newli {
	padding-left: 8px;
}
</style>
</head>

<body>
	<%@include file="/wap/inc/head.jsp"%>
	<div class="all">
		<div class="box">
			<%
				List<Directory> dirList = DirectoryHelper.getByParentrackcode(parentId);
				if(dirList != null && !dirList.isEmpty()){
				%>
			<div class="classList">
				<ul>
					<%
				for(Directory dir : dirList){
					%><li><a
						href="/wap/resultlist.jsp?productsort=<%=dir.getId() %>"><%=dir.getRakmst_rackname() %>(<%=((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dir.getId())%>)</a></li>
					<%
					List<Directory> childDirList = DirectoryHelper.getByParentrackcode(dir.getId());
					if(childDirList != null && !childDirList.isEmpty()){
						for(Directory childDir : childDirList){
							%><li class="newli"><a
						href="/wap/resultlist.jsp?productsort=<%=childDir.getId() %>"><%=childDir.getRakmst_rackname() %>(<%=((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(childDir.getId())%>)</a></li>
					<%
						}
					}
				}
				%>
				</ul>
			</div>
			<%
				} %>
		</div>

	</div>

	<!-- 尾部 -->
	<%@ include file="/wap/inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>