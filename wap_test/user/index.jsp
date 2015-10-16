<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%>
<%if (1==1){
	response.sendRedirect("/wap/user/index.html");
	return;
}%>
<%@include file="../inc/islogin.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-手机版-会员<%= lUser.getMbrmst_uid() %></title>
<style type="text/css">
body {
	line-height: 21px;
	background: #fff;
	padding-left: 4px;
	color: #333
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

img {
	border: none;
}
</style>
</head>
<body style="">
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div>
		<div>
			<br /> <a href="/mindex.jsp">首页</a>>我的优尚<br />
		</div>
		用户名：<%= lUser.getMbrmst_uid() %><br /> 会员级别：<% if(lUser.getMbrmst_specialtype()==0){ 
                out.print("普通会员");
            }
			else
			{
				UserVip uv=(UserVip)Tools.getManager(UserVip.class).get(lUser.getId());
	        	if(uv!=null)
	        	{ 
	        		out.print("白金会员");
	        	}
	        	else
	        	{
	        		out.print("VIP会员");
	        	}
				}
            %>
		<br /> 预存款：<%= PrepayHelper.getPrepayBalance(lUser.getId()) %>元<br />
		会员积分：<%= (int)(UserScoreHelper.getRealScore(lUser.getId())+0.5) %>分<br />
		<a href="myorder.jsp">我的订单</a><br /> <a href="favorite.jsp">我的收藏(<%=FavoriteHelper.getLengtByUserId(lUser.getId()) %>)
		</a> <br /> <a href="ticket.jsp">我的优惠券</a> <br /> <a href="address.jsp">收货地址簿</a>
		<br /> <a href="updatepassword.jsp">修改密码</a><br /> <a
			href="comment1.jsp">我的评价</a> <br /> <a href="consult.jsp">我的商品咨询</a>
		<br />
	</div>

	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->

</body>
</html>