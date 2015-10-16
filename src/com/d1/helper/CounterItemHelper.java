package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Award;
import com.d1.bean.CounterItem;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 
 * @author zpp
 *
 */
public class CounterItemHelper {

	public static ArrayList<CounterItem>  getCounterItem(Long counterdtl_mstid,Long counterdtl_pos,Long counterdtl_status,boolean isorder){
		ArrayList<CounterItem> list=new ArrayList<CounterItem>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("counterdtl_mstid", counterdtl_mstid));
		clist.add(Restrictions.eq("counterdtl_pos", counterdtl_pos));
		clist.add(Restrictions.eq("counterdtl_status", counterdtl_status));
		List<BaseEntity> list2 =null;
		
		if(isorder){
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("counterdtl_seq"));
			olist.add(Order.asc("id"));
			list2 = Tools.getManager(CounterItem.class).getList(clist, olist, 0, 1000);
		}else{
			list2 = Tools.getManager(CounterItem.class).getList(clist, null, 0, 1000);
		}
		if(list2==null||list2.size()==0)return null;
		for(BaseEntity be:list2){
			list.add((CounterItem)be);
		}
		return list;
	}
}
