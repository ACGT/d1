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
String APPID=PubConfig.get("WeiXinAppId");
String backurl=request.getParameter("backurl");
String REDIRECT_URI="http://m.d1.cn/wap/wx2.jsp?url="+backurl+"";

String REDIRECT_URI2=URLEncoder.encode(REDIRECT_URI);
String loginurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri="+REDIRECT_URI2+"&response_type=code&scope=snsapi_base&state="+getRandomString(16)+"#wechat_redirect";
//String loginurl2="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri=http%3A%2F%2Fchong.qq.com%2Fphp%2Findex.php%3Fd%3D%26c%3DwxAdapter%26m%3DmobileDeal%26showwxpaytitle%3D1%26vb2ctag%3D4_2030_5_1194_60&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
System.out.println(loginurl);

response.sendRedirect(loginurl);
       
       
       
%>