package com.d1.helper;


import com.d1.bean.WeixinOpenIdMbrIdPair;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

import java.util.*;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;


public class WeixinOpenIdMbrIdPairHelper {
	
	public static final BaseManager manager = Tools.getManager(WeixinOpenIdMbrIdPair.class);
	
	public static WeixinOpenIdMbrIdPair MapWeixinOpenIdAndMbrId(String openId, String originalId, int mbrmstId) {
		
		WeixinOpenIdMbrIdPair weixinOpenIdMbrIdPair 
			= getWeixinOpenIdMbrIdPairByWeixinOpenId(openId,originalId);
		
		if (weixinOpenIdMbrIdPair==null) {
		
			weixinOpenIdMbrIdPair = new WeixinOpenIdMbrIdPair();
			weixinOpenIdMbrIdPair.setMbrmstId(mbrmstId);
			weixinOpenIdMbrIdPair.setOpenId(openId);
			weixinOpenIdMbrIdPair.setOriginalId(originalId);
			weixinOpenIdMbrIdPair 
				= (WeixinOpenIdMbrIdPair)WeixinOpenIdMbrIdPairHelper.manager.create(weixinOpenIdMbrIdPair);
		}
		else {
			
			if (weixinOpenIdMbrIdPair.getMbrmstId()!=mbrmstId) {
				
				weixinOpenIdMbrIdPair.setMbrmstId(mbrmstId);
				
				manager.update(weixinOpenIdMbrIdPair, true);
				
			}
			
		}
		return weixinOpenIdMbrIdPair;
	}
	
	public static WeixinOpenIdMbrIdPair getWeixinOpenIdMbrIdPairByWeixinOpenId(String openId, String originalId) {
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("open_id", openId));
		listRes.add(Restrictions.eq("original_id", originalId));
		List<BaseEntity> listPairs = manager.getListWithoutCache(listRes, null, 0, 1);  //.getListW(listRes, null, 0, 1);
		if (listPairs.size() == 0) {
			return null;
		}
		return (WeixinOpenIdMbrIdPair)listPairs.get(0);
	}

}
