<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.util.HttpUtil"%><%@include file="/inc/header.jsp"%>
<%
String APPID=PubConfig.get("WeiXinAppId");
String code=request.getParameter("code");
String backurl=request.getParameter("backurl");
String mid=request.getParameter("mid");
String secret=PubConfig.get("WeiXinAppSecret");
String tokenurl=PubConfig.get("WeiXinTokenUrl");
tokenurl="https://api.weixin.qq.com/sns/oauth2/access_token";
String parm="appid="+APPID+"&secret="+secret+"&code="+code+"&grant_type=authorization_code";
//response.sendRedirect(loginurl);
//System.out.println(backurl);

String ret=  HttpUtil.getUrlContentByPost(tokenurl, parm,"utf-8");
System.out.println(ret);
JSONObject  jsonob = JSONObject.fromObject(ret); 
String access_token = jsonob.getString("access_token");  
String openid = jsonob.getString("openid");  
session.setAttribute("Weixinopenid",openid);
String url=request.getParameter("url");
response.sendRedirect(url);
%>