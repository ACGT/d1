<%@ page contentType="text/html; charset=UTF-8" %><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*,
weibo4j.Account,
weibo4j.Oauth,
weibo4j.Users,
weibo4j.Weibo,
weibo4j.http.AccessToken,
weibo4j.model.RateLimitStatus,
weibo4j.model.SinaUser,
com.d1.bean.id.SequenceIdGenerator"%><%@include file="/inc/logheader.jsp"%><%!

private static final Object obj = new Object();//同步锁

%><%

String code = request.getParameter("code");
if(Tools.isNull(code)){
	//UserHelper.setTips(session,false,"新浪微博联合登录请求失败！");
	response.sendRedirect("/");
	return;
}

Weibo weibo = new Weibo(request.getRemoteHost());
Oauth oauth = new Oauth(weibo);
AccessToken accessToken = oauth.getAccessTokenByCode(code);
if(accessToken == null){
	out.print("获取失败！");
	return;
}
weibo.setToken(accessToken.getAccessToken());
//获取访问限制
Account am = new Account(weibo);
RateLimitStatus ratelimit = am.getAccountRateLimitStatus();
if(ratelimit == null){
	out.print("获取访问限制失败！");
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
	out.print(msg);
	return;
}
String sinaId = accessToken.getUid();
Users us = new Users(weibo);
SinaUser user = us.showUserById(sinaId);
			if(user != null){
				WeiboUser wb = null;
				
				String sinambr_name = String.valueOf(user.getId());
				String d1loginkey = "opi1p34u19klas09udf53gp3j24jklfe";
				String sinambr_uid = WeiboUserHelper.createRandomCode(30);
				String sinatime = Tools.getDBDate();
				String segcode = MD5.to32MD5(sinambr_name + sinatime + d1loginkey);
				
				synchronized(obj){
					wb = WeiboUserHelper.getByName(String.valueOf(user.getId()),"sinawb");
					if(wb == null){
						
						String sina_pwd = "9EF5D4D62B8169AFCAB7D4B4DADF7C9628AC ";
						
						com.d1.bean.User u = UserHelper.getByUsername(sinambr_uid);
						if(u == null){
							Date currDate = new Date();
							
							u = new com.d1.bean.User();
							u.setId(SequenceIdGenerator.generate("3"));
							u.setMbrmst_uid(sinambr_uid);
							u.setMbrmst_pwd(sina_pwd);
							u.setMbrmst_passwd(MD5.to32MD5(sina_pwd));
							u.setMbrmst_question("");
							u.setMbrmst_answer("");
							u.setMbrmst_createdate(currDate);
							u.setMbrmst_modidate(currDate);
							u.setMbrmst_lastdate(currDate);
							u.setMbrmst_name(sinambr_name);
							u.setMbrmst_visittimes(new Long(0));
							u.setMbrmst_sex(new Long(0));
							u.setMbrmst_email("");
							u.setMbrmst_hphone("");
							u.setMbrmst_usephone("");
							u.setMbrmst_haddr("");
							u.setMbrmst_countryid(new Long(1));
							u.setMbrmst_provinceid(new Long(1));
							u.setMbrmst_cityid(new Long(1));
							u.setMbrmst_postcode("");
							u.setMbrmst_certifiertype(new Long(0));
							u.setMbrmst_certifierno("");
							u.setMbrmst_myd1type(new Long(0));
							u.setMbrmst_myd1count(new Long(10));
							u.setMbrmst_myd1codes("");
							u.setMbrmst_specialtype(new Long(0));
							u.setMbrmst_srcurl("");
							u.setMbrmst_peoplercm("");
							u.setMbrmst_subad("");
							u.setMbrmst_temp("sinawb");
							u.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
							u.setMbrmst_bookletflag(new Long(0));
							u.setMbrmst_buyerrcount(new Long(0));
							u.setMbrmst_buyquestionid("");
							u.setMbrmst_downflag(new Long(0));
							u.setMbrmst_magazineflag(new Long(0));
							u.setMbrmst_validflag(new Long(0));
							u.setMbrmst_rcmcount(new Long(0));
							u.setMbrmst_ip("");
							u.setMbrmst_bktstep(new Long(0));
							u.setMbrmst_aliasname("");
							u.setMbrmst_src(new Long(0));
							u.setMbrmst_sendcount(new Long(0));
							u.setMbrmst_replycount(new Long(0));
							u.setMbrmst_kicktype(new Long(0));
							u.setMbrmst_bbsAlllogintimes(new Long(0));
							u.setMbrmst_bbsDaylogintimes(new Long(0));
							u.setMbrmst_allsrc(new Long(0));
							u.setMbrmst_jcsrc(new Long(0));
							u.setMbrmst_goldsrc(new Long(0));
							u.setMbrmst_goldallsrc(new Long(0));
							u.setMbrmst_birthflag(new Long(0));
							u.setMbrmst_tktmail(new Long(0));
							u.setMbrmst_ip(request.getRemoteAddr());
							u = (com.d1.bean.User)UserHelper.manager.create(u);
						}
						if(u != null && u.getId() != null){
							wb = new WeiboUser();
							wb.setWeibombr_mbrid(new Long(u.getId()));
							wb.setWeibombr_uid(sinambr_uid);
							wb.setWeibombr_name(sinambr_name);
							wb.setWeibombr_flag("sinawb");
							wb.setWeibombr_regflag(new Long(0));
							wb.setWeibombr_createdate(new Date());
							
							WeiboUserHelper.manager.create(wb);
						}
					}
				}
				session.removeAttribute("showmsg");
				UserHelper.setLoginUserId(session,String.valueOf(wb.getWeibombr_mbrid()));
				String retstr = "wbname=" + sinambr_name + "&wbtime=" + sinatime + "&segcode=" + segcode + "&wbflag=sinawb";
				//response.sendRedirect("/buy/chkout_wb.asp?"+retstr);
				response.sendRedirect("/");
			}else{
				out.print("获取登录信息错误！");
			}

%>