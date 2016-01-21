<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.*,net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.bean.*,com.d1.helper.*,java.util.*,com.d1.util.*,com.d1.PubConfig"%>
<%
	//String appId = "wx23ea18f35e5db774";
	//String appSecret = "38b518033fdc5372289c70875824a169";

	String appId = PubConfig.get("WeiXinAppId");
	String appSecret = PubConfig.get("WeiXinAppSecret");

	String token = request.getParameter("token");
	WeixinShopToken weixinShopToken = (WeixinShopToken) WeixinShopTokenHelper.manager.findByProperty("token",token);
	String openId = weixinShopToken.getOpen_id();
	Map<String, Object> map = new HashMap<String, Object>();
	if (weixinShopToken != null) {
		long currentTimeStamp = System.currentTimeMillis();
	System.out.println("##############"+(weixinShopToken.getExpire_date()-currentTimeStamp));
	System.out.println("##############"+weixinShopToken.getStatus());

		if (weixinShopToken.getExpire_date() > currentTimeStamp && weixinShopToken.getStatus() == 1) {//access_token未过期
			map.put("status", "0");
			map.put("token_available", "1");
		} else {//过期

			map.put("status", "0");
			map.put("token_available", "0");

			String tokenurl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="
					+ appId + "&secret=" + appSecret;

			String ret = HttpUtil.getUrlContentByPost(tokenurl, "", "utf-8");

			JSONObject jsonob = JSONObject.fromObject(ret);
			token = jsonob.getString("access_token");
			//更新数据库的access_token
			weixinShopToken.setToken(token);
			System.out.println("access_token更新前"+weixinShopToken.getExpire_date());
			weixinShopToken.setExpire_date(weixinShopToken.getExpire_date()+1000*60*60*2);//access_token有效期2小时
			weixinShopToken.setStatus(1);
			WeixinShopTokenHelper.manager.update(weixinShopToken, true);
			System.out.println("access_token更新后"+weixinShopToken.getExpire_date());
			
		}

	}
	String loginurl = "https://api.weixin.qq.com/cgi-bin/user/info";
	String parm = "access_token=" + token + "&openid=" + openId + "&lang=zh_CN";
	String ret = HttpUtil.getUrlContentByPost(loginurl, parm, "utf-8");
	out.print(ret);
%>