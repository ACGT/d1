<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/wap/inc/islogin.jsp"%>
<%
String backurl = request.getParameter("url");


if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/";
	}
}
String id=request.getParameter("id");
String infos="";
Product product = ProductHelper.getById(id);
if(product == null){
	infos="找不到您要收藏的物品信息！<a href=\""+backurl+"\">返回上一页</a>";
}
else {
	Favorite fa = FavoriteHelper.addFavorite(lUser,product);
	if(fa != null){
		infos="<font color=\'#f00\'>恭喜您，收藏商品成功！</font><br/>去往<a href=\"/wap/user/favorite.jsp\">我的收藏</a>或者<a href=\""+backurl+"\">返回上一页</a>";
		
	}else{
		infos="收藏失败！<a href=\""+backurl+"\">返回上一页</a>";
	}
}


%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-收藏成功页面</title>
<style type="text/css">
    body{ line-height:21px;background:#fff; padding-left:4px; font-size:16px; color:#333 }
a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
img{ border:none;}
</style>
</head>
<body>
<!-- 头部 -->
<%@ include file="/wap/inc/head.jsp" %>
<!-- 头部结束 -->
<div style=" margin-bottom:15px;">
<%= infos %>
<br/><br/>

<a href="/mindex.jsp">返回首页</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a><br/>
	切换到<a href="http://www.d1.com.cn">电脑版</a>
	<br/>京ICP证030072号
        
</div>

</body>
</html>
