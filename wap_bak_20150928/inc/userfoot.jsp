<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*"%>
    <div style=" background:#FFDEAD; padding:3px; width:100%;">
	<a href="/wap/user/index.jsp">我的优尚</a>&nbsp;&nbsp;<a href="/wap/flow.jsp">购物车(<span id="u_cart"><%=new Long(CartHelper.getTotalProductCount(request,response)) %></span>)</a>&nbsp;&nbsp;<br/>
	<a href="/mindex.jsp">首页</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a><br/>
	切换到<a href="http://www.d1.com.cn">电脑版</a>
	<br/>京ICP证030072号
	</div>
	