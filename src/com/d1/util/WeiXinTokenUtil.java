package com.d1.util;

import com.d1.PubConfig;
import com.d1.bean.WeixinShopToken;
import com.d1.helper.WeixinShopTokenHelper;

import net.sf.json.JSONObject;

/*ͨ�������ȡ����΢��api��access_token,access_token 2Сʱ�ͻ���ڣ����Լ��������ʱҪˢ�����»�ȡ*/
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
		if(access_token==null||currentTime-exr_timeStamp>=(7000*1000)){//�����˻��߸ճ�ʼ������7000������7200��Ϊ����ǰȥ��ȡ��
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
