package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Product;
import com.d1.bean.RackcodeTop;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 分类热门排行辅助类
 * @author chengang
 * @createTime 2011-10-28 21:27:12
 *
 */
public class RcktopHelper {
	
	public static final BaseManager manager = Tools.getManager(RackcodeTop.class);
	
	/**
	 * 根据分类获取热卖排行
	 * @param rack_code - 分类
	 * @param length - 获取的集合数量
	 * @return List<RackcodeTop>
	 */
	public static List<RackcodeTop> getHotMale(String rack_code , long length){
		if(length <= 0) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		if(!Tools.isNull(rack_code)) listRes.add(Restrictions.eq("rcktop_rackcode", rack_code));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.asc("rcktop_seq"));
		
		List list = manager.getList(listRes, listOrder, 0, 100);
		
		if(list == null || list.isEmpty()) return null;
		
		int count = 0;
		int size = list.size();
		List<RackcodeTop> listRock = new ArrayList<RackcodeTop>();
		for(int i=0;i<size&&count<length;i++){
			RackcodeTop top = (RackcodeTop)list.get(i);
			Product product = ProductHelper.getById(top.getRcktop_gdsid());
			if(product != null && ProductHelper.isNormal(product)){
				listRock.add(top);
				count++;
			}
		}
		
		return listRock;
	}

}
