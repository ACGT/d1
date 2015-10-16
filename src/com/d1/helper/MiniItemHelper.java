package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.MiniItem;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;


/**
 * 
 * @author zpp
 *
 */
public class MiniItemHelper {

	public static ArrayList<MiniItem> getByMstid(String id){
		ArrayList<MiniItem> list=new ArrayList<MiniItem>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("minidtl_minimstid", new Long(id)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("minidtl_seq"));
		List<BaseEntity> b_list = Tools.getManager(MiniItem.class).getList(clist, olist, 0,200);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((MiniItem)be);
			}
		}
		return list;
		
	}
}
