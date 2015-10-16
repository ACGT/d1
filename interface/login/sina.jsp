<%@ page contentType="text/html; charset=UTF-8" %>
<%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*,
weibo4j.*,
weibo4j.Oauth,
weibo4j.Weibo,
weibo4j.Users,
weibo4j.Account,
weibo4j.Timeline,
weibo4j.model.SinaUser,
weibo4j.model.RateLimitStatus,
weibo4j.http.*"%><%@include file="/inc/logheader.jsp"%><%
com.d1.bean.User lUser = UserHelper.getLoginUser(request, response);
%><%
Oauth oauth = new Oauth();
session.setAttribute("accessToken",oauth.access_token);
	response.sendRedirect(oauth.authorize("code"));
%>