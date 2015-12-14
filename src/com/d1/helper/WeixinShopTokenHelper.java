package com.d1.helper;

import com.d1.bean.WeixinShopToken;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

import java.util.*;

public class WeixinShopTokenHelper {
	
	public static final BaseManager manager = Tools.getManager(WeixinShopToken.class);
	
	public static WeixinShopToken getTokenEntity(String token) {
		
		return (WeixinShopToken)manager.findByProperty("token", token);
		
	}
	
	
	public static String checkToken(String token, String originalId) {
		
		WeixinShopToken weixinShopToken = getTokenEntity(token);
		
		
		
		String openId = "";
		
		if (weixinShopToken!=null)
		{
		
			long currentDateStamp = (new Date()).getTime();
		
			//currentDate = currentDate.getDate();
		
			if (weixinShopToken.getOriginal_id().equals(originalId)) {
				if (weixinShopToken.getStatus()==1 && weixinShopToken.getExpire_date()>currentDateStamp) {
					openId = weixinShopToken.getOpen_id();

				}
			}
		}
		
		return openId;
		
	}	
	public static WeixinShopToken CreateToken(String openId, String originalId) {
		WeixinShopToken weixinShopToken = new WeixinShopToken();
		weixinShopToken.setStatus(1);
		weixinShopToken.setOpen_id(openId);
		weixinShopToken.setOriginal_id(originalId);
		long currentDateStamp = (new Date()).getTime();
		currentDateStamp = 1000*60*60*24+currentDateStamp;
		weixinShopToken.setExpire_date(currentDateStamp);
		String token = getRandomString(10)+(new Date()).getTime();
		weixinShopToken.setToken(token);
		weixinShopToken = (WeixinShopToken)WeixinShopTokenHelper.manager.create(weixinShopToken);
		return weixinShopToken;
	}
	
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
}
