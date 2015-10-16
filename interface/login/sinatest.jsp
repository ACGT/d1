<%@ page contentType="text/html; charset=UTF-8" %><%@page 
import="weibo4j.Account,
weibo4j.Oauth,
weibo4j.Users,
weibo4j.Weibo,
weibo4j.http.AccessToken,
weibo4j.model.RateLimitStatus,
weibo4j.model.SinaUser"%><%
String code="16874770e3054c1503bf764add98a0f8";
String hoststr="127.0.0.1";
Weibo weibo = new Weibo(hoststr);
Oauth oauth = new Oauth(weibo);
AccessToken accessToken = oauth.getAccessTokenByCode(code);
if(accessToken == null){
	System.out.print("获取失败！");
	return;
}
weibo.setToken(accessToken.getAccessToken());
//获取访问限制
Account am = new Account(weibo);
RateLimitStatus ratelimit = am.getAccountRateLimitStatus();
if(ratelimit == null){
	System.out.print("获取访问限制失败！");
	return;
}
if(ratelimit.getRemainingUserHits() <= 0){
	String time = null;
	if(ratelimit.getResetTimeInSeconds() >= 60){
		time = (ratelimit.getResetTimeInSeconds()/60)+"分钟";
	}else{
		time = ratelimit.getResetTimeInSeconds()+"秒";
	}
	String resetTime = ratelimit.getResetTime();
	String msg = "您本小时内的访问次数已达到上限，请您在今日 "+resetTime+"后继续访问。距离"+resetTime+"还剩"+time+"！";
	System.out.print(msg);
	return;
}
String sinaId = accessToken.getUid();
Users us = new Users(weibo);
SinaUser user = us.showUserById(sinaId);
			if(user != null){
				System.out.println(user.getName());
			}
%>