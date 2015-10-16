<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.bean.User,
	com.d1.bean.*,
	com.d1.bean.id.SequenceIdGenerator,
	com.d1.helper.*,
	com.d1.util.*,
	java.util.*,
	net.sf.json.*,
	com.d1.Const" %>
<%
String token = request.getParameter("token").replace("'", "");
//String originalId = "gh_081aec5f45ab";
String originalId = "weixin";

String openId = WeixinShopTokenHelper.checkToken(token,originalId);



Map<String,Object> map = new HashMap<String,Object>();
if (openId != null && openId != "") {
	
	
	boolean userExists = false;

	User u;
	
	WeixinOpenIdMbrIdPair weixinOpenIdMbrIdPair 
		= WeixinOpenIdMbrIdPairHelper.getWeixinOpenIdMbrIdPairByWeixinOpenId(openId, originalId);

	String d1UserId = "";
	
	if (weixinOpenIdMbrIdPair!=null) {
		u = UserHelper.getById(String.valueOf(weixinOpenIdMbrIdPair.getMbrmstId()));
		if (u!=null) {
			userExists = true;
			d1UserId = u.getId();
		}
	}
	
	if (!userExists) {
	
		String d1Username = openId + "@@" + originalId;
		u = UserHelper.getByUsername(d1Username);
		if (u==null) {
			
			
		
			Date currDate = new Date();
			String pwd = "9EF5D4D62B8169AFCAB7D4B4DADF7C9628AC";
			
			String nickname = "";
			String sex = "";
			String country = ""; 
			String province = "";
			
			String ret =  HttpUtil.getUrlContentByPost("get_user_weixin_info.jsp", "token="+token ,"utf-8");
			
			if(!Tools.isNull(ret)&&ret.indexOf("\"errcode\":")==-1){
				JSONObject  jsonuser = JSONObject.fromObject(ret); 
				  nickname = jsonuser.getString("nickname");  
				  sex = jsonuser.getString("sex");  
				  country = jsonuser.getString("country");  
				  province = jsonuser.getString("province"); 
				 
			}
			
			
			u = new com.d1.bean.User();
			u.setId(SequenceIdGenerator.generate("3"));
			u.setMbrmst_uid(d1Username);
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
			u.setMbrmst_srcurl("");
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
			session.setAttribute(Const.LOGIN_USER_ID_PREFIX, u.getId());
			WeixinOpenIdMbrIdPairHelper.MapWeixinOpenIdAndMbrId(openId, originalId, Integer.parseInt(u.getId()));
			map.put("status","0");
			map.put("d1_user_id", u.getId());
		}
		else {
			map.put("status","0");
			map.put("d1_user_id", u.getId());
		}
	}
	else {
		map.put("status","0");
		map.put("d1_user_id", d1UserId);
	}
}
else {
	map.put("status","1");
	map.put("error_message","Openid is invalid!");
}

out.print(JSONObject.fromObject(map));



%>