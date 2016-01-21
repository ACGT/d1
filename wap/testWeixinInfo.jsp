<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.*,net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.bean.*,com.d1.helper.*,java.util.*,com.d1.util.*,com.d1.PubConfig"%>
<%!
	private static String access_token;
	private static long exr_timeStamp;
	public static String getAccess_token() {
		System.out.println("#############access_token:"+access_token);
		System.out.println("############exr_timeStamp:"+exr_timeStamp);
		String appId = PubConfig.get("WeiXinAppId");
		String appSecret = PubConfig.get("WeiXinAppSecret");
		long currentTime=System.currentTimeMillis();
		if(access_token==null||currentTime-exr_timeStamp>=(7000*1000)){//过期了或者刚初始化，用7000而不是7200是为了提前去获取。
			System.out.print("token过期了，重新获取########################");
			String tokenurl="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId 
				+ "&secret=" + appSecret;
			String ret=  HttpUtil.getUrlContentByPost(tokenurl, "","utf-8");

			JSONObject  jsonob = JSONObject.fromObject(ret); 
			access_token= jsonob.getString("access_token");  
			exr_timeStamp=currentTime;
		}

		return access_token;
	}
%>
	<%
	String appId = PubConfig.get("WeiXinAppId");
	String appSecret = PubConfig.get("WeiXinAppSecret");

	String token = request.getParameter("token");
	WeixinShopToken weixinShopToken = (WeixinShopToken) WeixinShopTokenHelper.manager.findByProperty("token",token);
	String openId = weixinShopToken.getOpen_id();
	
	String loginurl = "https://api.weixin.qq.com/cgi-bin/user/info";
	String parm = "access_token=" + getAccess_token() + "&openid=" + openId + "&lang=zh_CN";
	String ret = HttpUtil.getUrlContentByPost(loginurl, parm, "utf-8");
	System.out.print("##############################;ret:"+ret);
	out.print(ret);
%>