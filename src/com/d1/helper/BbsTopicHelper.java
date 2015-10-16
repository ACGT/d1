package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.BbsTopic;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 论坛帖子辅助类
 * @author chengang
 * @createTime 2011-10-30 13:20:19
 *
 */
public class BbsTopicHelper {
	
	public static final BaseManager manager = Tools.getManager(BbsTopic.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return BbsTopic
	 */
	public static BbsTopic getById(String id){
		if(Tools.isNull(id)) return null;
		return (BbsTopic)manager.get(id);
	}
	
	/**
	 * 根据商品id品牌名称分类编号获取品牌故事
	 * @param productId - 物品ID
	 * @param rackcode - 物品分类
	 * @param brandName - 品牌名称
	 * @param length - 记录长度
	 * @return BbsTopic
	 */
	public static BbsTopic getBrandStory(String productId , String rackcode , String brandName){
		if(Tools.isNull(productId) || Tools.isNull(rackcode) || Tools.isNull(brandName)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("bbsmst_brandname", brandName));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.asc("bbsmst_howshow"));
		listOrder.add(Order.desc("bbsmst_time"));
		
		List list = manager.getList(listRes, listOrder, 0, 100);
		
		if(list == null || list.isEmpty()) return null;
		
		int size = list.size();
		for(int i=0;i<size;i++){
			BbsTopic topic = (BbsTopic)list.get(i);
			long howshow = Tools.longValue(topic.getBbsmst_howshow());
			String gdsid = topic.getBbsmst_gdsid();
			String bbsmst_reckcode = topic.getBbsmst_rackcode();
			if((howshow == 3 && gdsid != null && gdsid.indexOf(productId) > -1) || (howshow == 4 && bbsmst_reckcode != null && bbsmst_reckcode.indexOf(rackcode)>-1)){
				return topic;
			}
		}
		
		return null;
	}
	
	/**
	 * 获得物品的晒单帖
	 * @param productId - 物品ID
	 * @param start - 开始位置
	 * @param length - 长度
	 * @return List<BbsTopic>
	 */
	public static List getSDTList(String productId , int start , int length){
		if(Tools.isNull(productId)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("bbsmst_gdsid", productId));
		listRes.add(Restrictions.eq("bbsmst_rid", new Long(14)));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("id"));
		
		return manager.getList(listRes, listOrder, start, length);
	}
	
	/**
	 * 获得物品的晒单帖的长度
	 * @param productId - 物品ID
	 * @return int
	 */
	public static int getSDTLength(String productId){
		if(Tools.isNull(productId)) return 0;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("bbsmst_gdsid", productId));
		listRes.add(Restrictions.eq("bbsmst_rid", new Long(14)));
		
		return manager.getLength(listRes);
	}

}
