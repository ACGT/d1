package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.City;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

/**
 * ʡ�ݳ��б������
 * @author kk
 *
 */
public class CityHelper {
	
	/**
	 * ����id�õ�������
	 * @param id
	 * @return
	 */
	public static String getCityNameViaId(String id){
		City p = (City)Tools.getManager(City.class).get(id);
		if(p==null)return "";
		return p.getCtymst_name();
	}
	
	/**
	 * ����ʡ��id��ȡ���г����б�
	 * @param provinceId
	 * @return
	 */
	public static ArrayList<City> getCitysViaProvinceId(String provinceId){
		if(provinceId==null||!StringUtils.isDigits(provinceId))return null;
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("ctymst_provinceid", new Long(provinceId)));
		
		List<BaseEntity> list = Tools.getManager(City.class).getList(clist, null, 0, 1000);
		ArrayList<City> rlist = new ArrayList<City>();
		if(list==null||list.size()==0)return null;
		for(BaseEntity c:list){
			rlist.add((City)c);
		}
		return rlist ;
	}
}
