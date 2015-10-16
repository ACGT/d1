package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.PhoneCode;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;


public class PhoneCodeHelper {
	
	public static final BaseManager manager = Tools.getManager(PhoneCode.class);
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return PhoneCode
	 */
	public static PhoneCode getById(String id) {
		if(!Tools.isMath(id)) return null;
		return (PhoneCode)manager.get(id);
	}
	
	/**
	 * 获得PhoneCode通过手机号码
	 * @return PhoneCode
	 */
	public static PhoneCode getPhoneCodeByTele(String tele){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("phonecode_tele", tele));
		
		
		List<BaseEntity> list=manager.getList(listRes, null, 0, 100);
		if(list!=null&&list.size()>0)
		{
			return (PhoneCode)list.get(0);
		}
		return null;
	}
	
	
}
