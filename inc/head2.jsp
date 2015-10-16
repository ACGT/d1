<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%
String chePingAn = Tools.getCookie(request,"PINGAN");
%>
<div id="header">
	<h1><a href="/" title="返回首页">优尚购物</a></h1>
	<p class="user_help">
		<span class="f_r"><a href="/user/">我的帐户</a>| <a href="/user/selforder.jsp">订单查询</a>| <a href="/user/ticket.jsp">我的优惠券</a>| <a href="/jifen/index.jsp">积分换购</a>|<a href="/help/">帮助中心</a></span>	<span class="ShowWelcome" id="ShowWelcome">&nbsp;</span></p>
    <p class="<%="1".equals(chePingAn)?"pinganlogo":"" %>"></p>
    <div class="clear"></div>
</div>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/head2012.js")%>"></script>