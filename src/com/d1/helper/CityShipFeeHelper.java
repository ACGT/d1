package com.d1.helper;

import com.d1.bean.CityShipFee;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * �Ƿ�֧�ֻ����������
 * @author chengang
 * @createTime 2011-10-13 17:11:46
 *
 */
public class CityShipFeeHelper {
	
	public static final BaseManager manager = Tools.getManager(CityShipFee.class);
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return CityShipFee
	 */
	public static CityShipFee getById(String id) {
		if(Tools.isNull(id)) return null;
		return (CityShipFee)manager.get(id);
	}
	
	/**
	 * �鿴ĳ�������Ƿ�֧�ֻ�������
	 * @param cityId - ����ID
	 * @return Ture or False
	 */
	public static boolean getCityCanHF(long cityId){
		if(cityId <= 0) return false;
		CityShipFee cf = (CityShipFee)manager.findByProperty("cityid", new Long(cityId));
		if(cf == null) return false;
		return Tools.longValue(cf.getIfcanhf())==1?true:false;
	}

}
