package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Award;
import com.d1.bean.AwardUseLog;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;
//兑换积分详细表
public class AwardUseLogHelper {
	
	public static final BaseManager manager = Tools.getManager(AwardUseLog.class);
	/**
	 * 根据会员id获取会员积分兑换记录
	 * 
	 * @param mbrid 会员id
	 * @return
	 */
	public static  ArrayList<AwardUseLog> getAwardUseLogByMbrid(String mbrid)
	{
		if(Tools.isNull(mbrid)) return null;
		ArrayList<AwardUseLog> rlist=new ArrayList<AwardUseLog>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("scrchgawd_mbrid",Tools.parseLong(mbrid)));
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("scrchgawd_applytime"));
		List<BaseEntity> list = Tools.getManager(AwardUseLog.class).getList(clist, olist, 0, 1000);
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((AwardUseLog)be);
		}
		
		return rlist ;
	}
}