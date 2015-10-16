package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;


import com.d1.bean.HelpContent;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 帮助内容常用工具类
 * @author zpp
 *
 */
public class HelpContentHelper {
	/**
	 * 根据主题获得相应帮助内容
	 * @return
	 */
	public static ArrayList<HelpContent> getHelpContentByCode(String code){
		ArrayList<HelpContent> rlist = new ArrayList<HelpContent>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("helpmst_code", code));

		//加入排序条件
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("helpmst_seq"));
		
		List<BaseEntity> list = Tools.getManager(HelpContent.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((HelpContent)be);
		}
		return rlist ;
	}

}
