package com.d1.helper;

import java.util.ArrayList;

import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;


import com.d1.bean.SpecialProduct;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;


/**
 * 活动、特价商品工具类
 * @author zpp
 *
 */
public class SpecialProductHelper {
	/**
	 * 根据推荐位号获得推荐列表
	 * @return
	 */
	public static ArrayList<SpecialProduct> getSpecialProductList(String rackcode,String name){
		
ArrayList<SpecialProduct> rlist = new ArrayList<SpecialProduct>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("sprckmst_rackcode", rackcode));
		clist.add(Restrictions.eq("sprckmst_name", name));

		List<BaseEntity> list = Tools.getManager(SpecialProduct.class).getList(clist, null, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((SpecialProduct)be);
		}
		//System.out.println(rlist.size());
		return rlist ;
		
		

	}
}
