package com.d1.helper;


import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Standard;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 商品规格表的功能实现
 * 
 * @author wdx
 *
 */
public class StandardHelper {

	public static final BaseManager manager = Tools.getManager(Standard.class);
	
	/**
	 * 根据规格id获取规格对象
	 * @param id 规格id
	 * @return 规格对象
	 */
	public static Standard GetStandarBysid(String id)
	{
		if(Tools.isNull(id)){return null;}
		else
		{
            return (Standard)Tools.getManager(Standard.class).get(id);            
		}
	}
	
	/**
	 * 获取一个Standard
	 * @param stdmst_stdname
	 * @param showflag
	 * @return
	 */
	public static Standard getStandards(String stdmst_stdname,int showflag){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("stdmst_stdname", stdmst_stdname));
		clist.add(Restrictions.eq("stdmst_showflag"+showflag, new Long(1)));
		
		List<BaseEntity> list = Tools.getManager(Standard.class).getList(clist, null, 0, 100);
		if(list==null||list.size()==0)return null;
		return (Standard)list.get(0);
	}
	

}
