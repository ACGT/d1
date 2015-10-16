package com.d1.helper;

import com.d1.bean.TenpayGds;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;
/***
 * 聚会佣金比例
 * @author 高军亮
 *
 * 2013-3-15
 */
public class TenpayGdsHelper {
	public static BaseManager manager = Tools.getManager(TenpayGds.class);
    
    /**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return TenpayGds
	 */

	public static TenpayGds getBygdsid(String productId){
		if(Tools.isNull(productId)){
			return null;
		}
		return (TenpayGds)Tools.getManager(TenpayGds.class).findByProperty("tenpaygds_gdsid", productId);
	}
}
