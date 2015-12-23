<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.util.HttpUtil"%><%@include file="/inc/header.jsp"%>
<%!
public static String getRandomString(int length){  
    String str="abcdefghijklmnopqrstuvwxyz0123456789";  
    Random random = new Random();  
    StringBuffer sb = new StringBuffer();  
      
    for(int i = 0 ; i < length; ++i){  
        int number = random.nextInt(36);//[0,62)  
          
        sb.append(str.charAt(number));  
    }  
    return sb.toString();  
}  
%>
<%
//String strPostUrl="https://api.weixin.qq.com/cgi-bin/token";
//String strparm="grant_type=client_credential&appid=wxf4e9b021c59f5bcd&secret=e854ccbf71c2c7be620dbd088fc345d9";
//String ret=  HttpUtil.getUrlContentByPost(strPostUrl, strparm,"utf-8");
//System.out.println(ret);

//JSONObject  jsonob = JSONObject.fromObject(ret); 
//String access_token = jsonob.getString("access_token");  
String APPID=PubConfig.get("WeiXinAppId");
String backurl=request.getParameter("backurl");
String mid=request.getParameter("mid");
String REDIRECT_URI="http://m.d1.cn/interface/login/weixinlogin.jsp";
//System.out.println(backurl+"====backurl======mid=="+mid);
if(!Tools.isNull(backurl)){
	REDIRECT_URI=REDIRECT_URI+"?backurl="+backurl;
	if(!Tools.isNull(mid)){
		REDIRECT_URI=REDIRECT_URI+"&mid="+mid;
		}
}else{
if(!Tools.isNull(mid)){
	REDIRECT_URI=REDIRECT_URI+"?mid="+mid;
	}
}
String REDIRECT_URI2=URLEncoder.encode(REDIRECT_URI);
//String loginurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri="+REDIRECT_URI2+"&response_type=code&scope=snsapi_base&state="+getRandomString(16)+"#wechat_redirect";
String loginurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri="+REDIRECT_URI2+"&response_type=code&scope=snsapi_base&state="+getRandomString(16)+"#wechat_redirect";

//String loginurl2="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri=http%3A%2F%2Fchong.qq.com%2Fphp%2Findex.php%3Fd%3D%26c%3DwxAdapter%26m%3DmobileDeal%26showwxpaytitle%3D1%26vb2ctag%3D4_2030_5_1194_60&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
System.out.println(loginurl);

response.sendRedirect(loginurl);

//String OPENID="";
//String gourl="https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN"
%>