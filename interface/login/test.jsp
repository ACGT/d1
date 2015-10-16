<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.HttpUtil"%><%@include file="/inc/header.jsp"%>
<%
String APPID=PubConfig.get("WeiXinAppId");
String code=request.getParameter("code");
String backurl=request.getParameter("backurl");
String mid=request.getParameter("mid");
String secret=PubConfig.get("WeiXinAppSecret");
String tokenurl=PubConfig.get("WeiXinTokenUrl");
tokenurl="https://api.weixin.qq.com/cgi-bin/token";
String parm="grant_type=client_credential&appid="+APPID+"&secret="+secret+"";
//https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET
//response.sendRedirect(loginurl);
//System.out.println(backurl);

String ret=  HttpUtil.getUrlContentByPost(tokenurl, parm,"utf-8");
System.out.println(ret);
JSONObject  jsonob = JSONObject.fromObject(ret); 
String access_token = jsonob.getString("access_token");  
  

tokenurl="https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token="+access_token+"";
String jsonstr="{\"expire_seconds\": 1800,\"action_name\": \"QR_SCENE\",\"action_info\": {\"scene\": {\"scene_id\": 100000}}}";
	String ret2=  HttpUtil.postData(tokenurl, jsonstr,"utf-8");
	System.out.println(ret2);
	JSONObject  jsonob2 = JSONObject.fromObject(ret2); 
	String ticket = jsonob2.getString("ticket");  
	tokenurl="https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="+ticket;
		response.sendRedirect(tokenurl);
%>