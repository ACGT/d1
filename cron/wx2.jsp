<%@ page contentType="text/html; charset=UTF-8" 
import="com.d1.util.HttpUtil"
%><%@include file="/inc/header.jsp"%>
<%
//String strPostUrl="https://api.weixin.qq.com/cgi-bin/token";
//String strparm="grant_type=client_credential&appid=wxf4e9b021c59f5bcd&secret=e854ccbf71c2c7be620dbd088fc345d9";
//String ret=  HttpUtil.getUrlContentByPost(strPostUrl, strparm,"utf-8");
//System.out.println(ret);

//JSONObject  jsonob = JSONObject.fromObject(ret); 
//String access_token = jsonob.getString("access_token");  
String APPID="wxf4e9b021c59f5bcd";
String loginurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect";



//String OPENID="";
//String gourl="https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN"
%>