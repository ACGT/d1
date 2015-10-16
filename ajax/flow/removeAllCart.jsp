<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
CartHelper.clearAllCookieCarts(request,response);
//查看是否登录
out.print("{\"success\":true,\"cart_goods_area\":\""+(lUser!=null?"您的购物车中没有商品，快去挑选商品吧&nbsp;&nbsp;<a href='/index.jsp'>回到首页&gt;&gt;</a>":"如果您上次退出时，购物车中有商品，那么商品已自动保存，<a href='/login.jsp'>请登录后查看&gt;&gt;</a>")+"\"}");
%>