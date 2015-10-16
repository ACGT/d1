<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<%
String addressid=request.getParameter("addressid");
if(!Tools.isNull(request.getParameter("deladdress")) && !Tools.isNull(request.getParameter("addressid")) && !"null".equals(addressid.toLowerCase())){//删除地址
	Tools.getManager(UserAddress.class).delete(addressid);
	response.sendRedirect("address.jsp");
}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—收货地址</title>
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
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>收货地址簿 <br />
		</div>
		<br />
		<%
    ArrayList<UserAddress> list = UserAddressHelper.getUserAddressList(lUser.getId());
	if(list!=null&&list.size()>0){
		int i=0;
		for(UserAddress ua:list){
			
			if(ua.getMbrcst_countryid().intValue()!=100 && Tools.isNull( ua.getMbrcst_memo())){
				i++;
				%>
		<input type="radio" name="address" value="<%= ua.getId()%>"
			<% if(i==1) out.print("checked");%> />
		<%=ua.getMbrcst_name() %>&nbsp;&nbsp;
		<%=ua.getMbrcst_raddress() %>
		&nbsp;&nbsp; <a
			href="/wap/user/addressprovince.jsp?addressid=<%=ua.getId()%>&id=<%=ua.getMbrcst_provinceid()%>">修改</a>&nbsp;&nbsp;<a
			href="address.jsp?addressid=<%=ua.getId()%>&deladdress=1">删除</a> <br />

		<%
			}
		}
	}
	else
	{
		out.print("您还没有收货地址，<a href=\"/wap/user/addressprovince.jsp?op=add\">马上去添加</a>");
	}
    %>

		<div
			style="background: #FFDEAD; padding: 3px; width: 100%; margin-top: 7px;">
			<a href="addressprovince.jsp?op=add">新增</a>&nbsp;&nbsp; <br />
		</div>

	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>

