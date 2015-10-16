package com.d1.helper;

import com.d1.bean.WeixinShopUser;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

public class WeixinShopUserHelper {
	
	public static final BaseManager manager = Tools.getManager(WeixinShopUser.class);
	
}
