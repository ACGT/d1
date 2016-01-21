<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.*,net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.bean.*,com.d1.helper.*,java.util.*,com.d1.util.*,com.d1.PubConfig"%>
<%
//String appId = "wx23ea18f35e5db774";
//String appSecret = "38b518033fdc5372289c70875824a169";


String appId = PubConfig.get("WeiXinAppId");
String appSecret = PubConfig.get("WeiXinAppSecret");


String token = request.getParameter("token");
WeixinShopToken weixinShopToken = (WeixinShopToken)WeixinShopTokenHelper.manager.findByProperty("token", token);
String openId = weixinShopToken.getOpen_id();
/* 
String tokenurl="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId 
	+ "&secret=" + appSecret;

String ret=  HttpUtil.getUrlContentByPost(tokenurl, "","utf-8");

JSONObject  jsonob = JSONObject.fromObject(ret); 
String access_token = jsonob.getString("access_token");  
 */
String loginurl="https://api.weixin.qq.com/cgi-bin/user/info";
String parm="access_token="+WeiXinTokenUtil.getAccess_token()+"&openid="+openId+"&lang=zh_CN";
String  ret=  HttpUtil.getUrlContentByPost(loginurl, parm,"utf-8");
out.print(ret);
%>