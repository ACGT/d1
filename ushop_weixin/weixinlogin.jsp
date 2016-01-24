<%@ page contentType="text/html; charset=UTF-8"
	import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.bean.id.SequenceIdGenerator"%><%@include
	file="/inc/header.jsp"%><%!
public static void setCookie(HttpServletResponse response , String name , String value , int expireTime){
	Cookie userIdCookie = new Cookie(name, value);
	userIdCookie.setPath("/");
	userIdCookie.setDomain("d1.cn");
	userIdCookie.setMaxAge(expireTime);
	response.addCookie(userIdCookie);
}

private static final Object obj = new Object();//同步锁
%>
<%String APPID=PubConfig.get("WeiXinAppId");
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
if(ret.indexOf("errcode")>=0){
	response.sendRedirect(backurl+"&err=1");
	 return;
}
System.out.println("微信登录:"+ret);
//System.out.println(ret);
JSONObject  jsonob = JSONObject.fromObject(ret); 
String access_token = jsonob.getString("access_token");  
String openid = jsonob.getString("openid");  
//System.out.println(ret);
session.setAttribute("WXAccessToken", access_token);
String loginurl=PubConfig.get("WeiXinLoginUrl");
parm="access_token="+access_token+"&openid="+openid+"&lang=zh_CN";
 ret=  HttpUtil.getUrlContentByPost(loginurl, parm,"utf-8");
System.out.println("==========="+ret);
/*
{"openid":"ovYIruG0NbapYmCPogxbEncMC984","nickname":"高军亮","sex":1,"language":"zh_CN","city":"海淀"
	,"province":"北京","country":"中国","headimgurl":"http:\/\/wx.qlogo.cn\/mmopen\/4hGaVehXuC1oXdKOaibu2A3ooc7iboJjlgP6f9m09qF72UW9CUc4aGGoquRTYI1O3lBIAzEsPlxDu7iaZAicNS4gmJCvOibdL7yFh\/0"
	,"privilege":[]}
*/
String nickname =""; 
String sex ="";
String country = ""; 
String province = "";
String headerImgUrl="";
if(!Tools.isNull(ret)&&ret.indexOf("\"errcode\":")==-1){
JSONObject  jsonuser = JSONObject.fromObject(ret); 
  nickname = jsonuser.getString("nickname");  
  sex = jsonuser.getString("sex");  
  country = jsonuser.getString("country");  
  province = jsonuser.getString("province"); 
 headerImgUrl=jsonuser.getString("headimgurl");
}
	String strUserName = openid+"@@weixin";
	


	
	User u = null;
	UserWeiXin wx=null;
	synchronized(obj){
		wx = (UserWeiXin)Tools.getManager(UserWeiXin.class).findByProperty("weixin_openid", openid);
		u = UserHelper.getByUsername(strUserName);
		if(u == null){//会员不存在
			Date currDate = new Date();
    		String pwd = "9EF5D4D62B8169AFCAB7D4B4DADF7C9628AC";
			
			u = new com.d1.bean.User();
			u.setId(SequenceIdGenerator.generate("3"));
			u.setMbrmst_uid(strUserName);
			u.setMbrmst_pwd(pwd);
			u.setMbrmst_passwd(MD5.to32MD5(pwd));
			u.setMbrmst_question("");
			u.setMbrmst_answer("");
			u.setMbrmst_createdate(currDate);
			u.setMbrmst_modidate(currDate);
			u.setMbrmst_lastdate(currDate);
			u.setMbrmst_name(nickname);
			u.setMbrmst_visittimes(new Long(0));
			u.setMbrmst_sex(new Long(Tools.parseLong(sex)));
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
			u.setMbrmst_srcurl(headerImgUrl);
			u.setMbrmst_peoplercm("");
			u.setMbrmst_subad("");
			u.setMbrmst_temp("WeiXin_login");
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
			u = (User)UserHelper.manager.create(u);
		}
	}
	
	if(u == null || u.getId() == null){
		out.print("获得用户信息出错，请重新登录！");
		return;
	}
	else{
		WeixinOpenIdMbrIdPairHelper.MapWeixinOpenIdAndMbrId(openid, "weixin", Integer.parseInt(u.getId()));
	}
	
	
	if(u != null && u.getId() != null&&wx==null){
		wx = new UserWeiXin();
		wx.setWeixin_mbrid(new Long(Tools.parseLong(u.getId())));
		wx.setWeixin_name(nickname);
		wx.setWeixin_openid(openid);
		wx.setWeixin_sex(Tools.parseInt(sex));
		
		
		Tools.getManager(UserWeiXin.class).create(wx);

	}
	
	

	
   if (wx!=null&&u != null && u.getId() != null){
		UserHelper.setLoginUserId(session,u.getId());
		
		
		session.setAttribute("WeixinUName", nickname);
		session.setAttribute("Weixinopenid", openid);
		 setCookie(response,"WeixinUName",nickname,(int)(Tools.YEAR_MILLIS/1000));
		 setCookie(response,"Weixinopenid",openid,(int)(Tools.YEAR_MILLIS/1000));
	}
	

	 if("null".equals(backurl)||Tools.isNull(backurl)){

	   String url="flow.html";

	    response.sendRedirect(url);

	 return;
	 }else{

		 response.sendRedirect(backurl);
		 return;
	 }

%>