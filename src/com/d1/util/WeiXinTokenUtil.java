package com.d1.util;

import com.d1.PubConfig;
import com.d1.bean.WeixinShopToken;
import com.d1.helper.WeixinShopTokenHelper;

import net.sf.json.JSONObject;

/*通过此类获取调用微信api的access_token,access_token 2小时就会过期，所以检测它过期时要刷新重新获取*/
public class WeiXinTokenUtil {
	private static String access_token;
	private static long exr_timeStamp;
	
	public WeiXinTokenUtil() {
		super();
			}
	public static String getAccess_token() {
		System.out.println("#############access_token:"+access_token);
		System.out.println("############exr_timeStamp:"+exr_timeStamp);
		String appId = PubConfig.get("WeiXinAppId");
		String appSecret = PubConfig.get("WeiXinAppSecret");
		long currentTime=System.currentTimeMillis();
		if(access_token==null||currentTime-exr_timeStamp>=(7000*1000)){//过期了或者刚初始化，用7000而不是7200是为了提前去获取。
			String tokenurl="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId 
				+ "&secret=" + appSecret;
			String ret=  HttpUtil.getUrlContentByPost(tokenurl, "","utf-8");

			JSONObject  jsonob = JSONObject.fromObject(ret); 
			access_token= jsonob.getString("access_token");  
			exr_timeStamp=currentTime;
		}

		return access_token;
	}

}
