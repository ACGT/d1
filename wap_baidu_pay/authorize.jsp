<%@ page contentType="text/html; charset=UTF-8"
		import="com.d1.*,java.net.URLEncoder,java.io.UnsupportedEncodingException" %>
<%

//String appId = "wx23ea18f35e5db774";
//String appSecret = "38b518033fdc5372289c70875824a169";


String appId = PubConfig.get("WeiXinAppId");
String appSecret = PubConfig.get("WeiXinAppSecret");


String callBack = request.getParameter("callback");
callBack = URLEncoder.encode(callBack,"UTF-8");
callBack = "http://m.d1.cn/ushop_weixin/authorize_callback.jsp?callback=" + callBack;
callBack = URLEncoder.encode(callBack,"UTF-8");
String redirectUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" 
        + appId + "&redirect_uri=" + callBack + "&response_type=code&scope=snsapi_base&state=1000#wechat_redirect";
response.sendRedirect(redirectUrl);
%>