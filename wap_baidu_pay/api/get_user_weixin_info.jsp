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
WeixinOpenIdMbrIdPair weixinOpenIdMbrIdPair = WeixinOpenIdMbrIdPairHelper.getWeixinOpenIdMbrIdPairByWeixinOpenId(openId, "weixin");
JSONObject res_json=new JSONObject();
if(weixinOpenIdMbrIdPair!=null){//会员和openid关系表有数据，就取出mbrid,再取出会员信息，不去微信取，因为在微信注册时已经把微信会员的信息取下来了
	System.out.println("###############  从数据库获取用户的信息 #########");
	User d1User=UserHelper.getById(String.valueOf(weixinOpenIdMbrIdPair.getMbrmstId()));
	if(d1User!=null){
	System.out.println("###############  从数据库获取用户的信息：用户存在 #########");
		if("".equals(d1User.getMbrmst_srcurl())||"".equals(d1User.getMbrmst_name())){//如果原来用户没有头像，就获取微信的头像，更新用户表，顺便把获取的信息输出到前端
			String loginurl="https://api.weixin.qq.com/cgi-bin/user/info";
			String parm="access_token="+WeiXinTokenUtil.getAccess_token()+"&openid="+openId+"&lang=zh_CN";
			String  ret=  HttpUtil.getUrlContentByPost(loginurl, parm,"utf-8");
			JSONObject json=JSONObject.fromObject(ret);
			if(json.getString("subscribe").equals("1")){
			if("".equals(d1User.getMbrmst_srcurl())){
	System.out.println("###############  从数据库获取用户的信息：用户没有头像，从微信获取并更新了 #########");
				d1User.setMbrmst_srcurl(json.getString("headimgurl"));
			}
			if("".equals(d1User.getMbrmst_name())){
	System.out.println("###############  从数据库获取用户的信息：用户没有昵称，从微信获取并更新了 #########");
				d1User.setMbrmst_name(json.getString("nickname"));
			}
			UserHelper.manager.update(d1User, true);//更新用户表，清缓存
			}
			out.print(ret);
			return;
		}
		res_json.put("subscribe","1");
		res_json.put("nickname", d1User.getMbrmst_name());
		res_json.put("headimgurl",d1User.getMbrmst_srcurl());
		
	System.out.println("###############  从数据库获取用户的信息：用户有头像 #########");
		out.print(res_json);
		return;
	}
}else{
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
}
%>