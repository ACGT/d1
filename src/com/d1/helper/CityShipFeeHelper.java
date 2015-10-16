package com.d1.helper;

import com.d1.bean.CityShipFee;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 是否支持货到付款辅助类
 * @author chengang
 * @createTime 2011-10-13 17:11:46
 *
 */
public class CityShipFeeHelper {
	
	public static final BaseManager manager = Tools.getManager(CityShipFee.class);
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return CityShipFee
	 */
	public static CityShipFee getById(String id) {
		if(Tools.isNull(id)) return null;
		return (CityShipFee)manager.get(id);
	}
	
	/**
	 * 查看某个城市是否支持货到付款
	 * @param cityId - 城市ID
	 * @return Ture or False
	 */
	public static boolean getCityCanHF(long cityId){
		if(cityId <= 0) return false;
		CityShipFee cf = (CityShipFee)manager.findByProperty("cityid", new Long(cityId));
		if(cf == null) return false;
		return Tools.longValue(cf.getIfcanhf())==1?true:false;
	}

}
