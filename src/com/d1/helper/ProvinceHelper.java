package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;

import com.d1.bean.Province;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 省份表帮助类
 * @author kk
 *
 */
public class ProvinceHelper {
	
	public static final BaseManager manager = Tools.getManager(Province.class);
	
	/**
	 * 根据省份id得到省份名
	 * @param id
	 * @return
	 */
	public static String getProvinceNameViaId(String id){
		Province p = (Province)Tools.getManager(Province.class).get(id);
		if(p==null)return "";
		return p.getPrvmst_name();
	}
	
	/**
	 * 获得所有省份
	 * @return List
	 */
	public static List<BaseEntity> getAllProvince(){
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.asc("prvmst_name"));
		
		return manager.getList(null, listOrder, 0, 100);
	}
}
