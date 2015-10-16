<%@ page contentType="text/html; charset=UTF-8" import="oauth.signpost.*,oauth.signpost.basic.*" %><%@include file="../../inc/header.jsp"%><%
OAuthConsumer consumer = new DefaultOAuthConsumer(PubConfig.get("sohu_consumerKey"), PubConfig.get("sohu_consumerSecret"));
OAuthProvider provider = new DefaultOAuthProvider("http://api.t.sohu.com/oauth/request_token",
        "http://api.t.sohu.com/oauth/access_token",
        "http://api.t.sohu.com/oauth/authorize?hd=default");

String authUrl = provider.retrieveRequestToken(consumer,PubConfig.get("sohu_redirect_URI"));

session.setAttribute("resToken",consumer);

response.sendRedirect(authUrl);
%>