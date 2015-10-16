package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import com.d1.bean.SecKill;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;


public class SecKillHelper {
 public	static ArrayList<SecKill> getTodayProduct(){
		ArrayList<SecKill> list=new ArrayList<SecKill>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.ge("mstjgds_starttime", new Date()));
		listRes.add(Restrictions.le("mstjgds_endtime", new Date()));
		listRes.add(Restrictions.eq("mstjgds_state", new Long(1)));
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("mstjgds_sort"));
		List<BaseEntity> mxlist= Tools.getManager(SecKill.class).getList(listRes, listOrder, 0, 100);
		if(mxlist==null || mxlist.size()==0) return null;
		for(BaseEntity be:mxlist){
			list.add((SecKill)be);
		}
		 return list;
	}
}
