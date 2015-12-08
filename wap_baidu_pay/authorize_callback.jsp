<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.*,net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.bean.id.SequenceIdGenerator,com.d1.util.*,com.d1.bean.*,com.d1.helper.*"%><%!
public static void setCookie(HttpServletResponse response , String name , String value , int expireTime){
	Cookie userIdCookie = new Cookie(name, value);
	userIdCookie.setPath("/");
	userIdCookie.setDomain("d1.cn");
	userIdCookie.setMaxAge(expireTime);
	response.addCookie(userIdCookie);
}	
%>
<%
//String appId = "wx23ea18f35e5db774";
//String appSecret = "38b518033fdc5372289c70875824a169";

String appId = PubConfig.get("WeiXinAppId");
String appSecret = PubConfig.get("WeiXinAppSecret");

String code=request.getParameter("code");
String callBackUrl = request.getParameter("callback");
String tokenurl="https://api.weixin.qq.com/sns/oauth2/access_token";
String parm="appid="+appId+"&secret="+appSecret+"&code="+code+"&grant_type=authorization_code";
String ret=  HttpUtil.getUrlContentByPost(tokenurl, parm,"utf-8");
//String  originalId = "gh_081aec5f45ab";

String originalId = "weixin";

JSONObject  jsonob = JSONObject.fromObject(ret); 
%>
<%

String access_token = jsonob.getString("access_token");  
String openid = jsonob.getString("openid");  
//session.setAttribute("WXAccessToken", access_token);
String loginurl="https://api.weixin.qq.com/sns/userinfo";
parm="access_token="+access_token+"&openid="+openid+"&lang=zh_CN";
ret=  HttpUtil.getUrlContentByPost(loginurl, parm,"utf-8");
WeixinShopToken weixinShopToken = (WeixinShopToken)WeixinShopTokenHelper.CreateToken(openid, originalId);
//setCookie(response,"token",weixinShopToken.getToken(),(int)(Tools.YEAR_MILLIS/1000));
//response.sendRedirect(callBackUrl);
%>
<html>
	<head></head>
	<body>
		
		<script type="text/javascript" >
		window.localStorage.setItem("token","<%=weixinShopToken.getToken()%>");
		
		window.location.href = "<%=callBackUrl %>";
		
		//alert(window.location.href+":"+window.localStorage.getItem("token"));
		
		//document.write("<a href='" +  + "'")
		
		</script>
		
		<a href="<%=callBackUrl %>" ><%=callBackUrl %></a>
		
	</body>
</html>