package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Comment;
import com.d1.bean.GoodsAsk;
import com.d1.bean.GoodsAskCache;
import com.d1.bean.ProductGroup;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 商品问答辅助类
 * @author chengang
 * @createTime 2011-10-30 20:46:24
 *
 */
public class GoodsAskHelper {
	
	public static BaseManager manager = Tools.getManager(GoodsAsk.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return GoodsAsk
	 */
	public static GoodsAsk getById(String id){
		if(Tools.isNull(id)) return null;
		return (GoodsAsk)manager.get(id);
	}
	
	/**
	 * 获得商品的问答的长度
	 * @param productId - 物品ID
	 * @return int
	 */
	public static int getLengthByProductId(String productId){
		if(Tools.isNull(productId)) return 0;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdsask_gdsid", productId));
		listRes.add(Restrictions.eq("gdsask_status", new Long(1)));
		
		return manager.getLength(listRes);
	}
	
	/**
	 * 获得商品问答的集合
	 * @param productId - 商品 ID
	 * @param start - 开始
	 * @param length - 长度
	 * @return List<GoodsAsk>
	 */
	public static List getlistByProductId(String productId , int start , int length){
		if(Tools.isNull(productId)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdsask_gdsid", productId));
		listRes.add(Restrictions.eq("gdsask_status", new Long(1)));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("id"));
		
		return manager.getList(listRes, listOrder, start, length);
	}
	
	/**
     * 获取提问的邮箱（但不全显）
     * @param gdscom_uid 会员id
     * @return 新的会员uid
     */
    public static String GetAskUid(String gdscom_uid){
    	if(Tools.isNull(gdscom_uid)) return "";
    	String preStr="";
    	if(gdscom_uid.length()>3){
    		preStr=gdscom_uid.substring(0,3);
    	}else{
    		preStr=gdscom_uid.substring(0,1);
    	}
    	String tailStr="";
    	tailStr=gdscom_uid.substring(gdscom_uid.lastIndexOf("@"),gdscom_uid.length());  	
    	return preStr+"****"+tailStr;
    	
    }

    
    public static ArrayList<GoodsAsk> getGoodsAskByKey(String productId,String key){
    	ArrayList<GoodsAsk> list=new ArrayList<GoodsAsk>();
    	 List<GoodsAsk> asklist=GoodsAskHelper.getlistByProductId(productId, 0, GoodsAskHelper.getLengthByProductId(productId));
    	 if(asklist!=null && asklist.size()>0){
    		 for(GoodsAsk ask:asklist){
    			 if(ask.getGdsask_content().indexOf(key, 0)>-1){
    				 list.add(ask);
    			 }
    			// if(ask.getGdsask_content().contains(key)){
    			//	 list.add(ask);
    			// }
    		 }
    	 }
    	 return list;
    }
    
    /**
     * 获取“我的商品咨询”(已回复)
     * 
     */
        public static ArrayList<GoodsAsk> getMyCommentList(Long mbrid){
    		ArrayList<GoodsAsk> list=new ArrayList<GoodsAsk>();
    		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
    		listRes.add(Restrictions.eq("gdsask_mbrid", mbrid));
    		listRes.add(Restrictions.eq("gdsask_replyStatus", new Long(1)));
    		List<Order> listOrder = new ArrayList<Order>();
    		listOrder.add(Order.desc("gdsask_createdate"));
    		
    		List<BaseEntity> asklist= manager.getList(listRes, listOrder, 0, 1000);
    		if(asklist==null || asklist.size()==0) return null;
    		for(BaseEntity be:asklist){
    			list.add((GoodsAsk)be);
    		}
        	 return list;
    	}
        /**
         * 获取“我的商品咨询”(未回复)
         * 
         */
            public static ArrayList<GoodsAskCache> getMyCommentCacheList(Long mbrid){
        		ArrayList<GoodsAskCache> list=new ArrayList<GoodsAskCache>();
        		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
        		listRes.add(Restrictions.eq("gdsask_mbrid", mbrid));
        		//listRes.add(Restrictions.eq("gdsask_replyStatus", new Long(0)));
        		List<Order> listOrder = new ArrayList<Order>();
        		listOrder.add(Order.desc("gdsask_createdate"));
        		
        		List<BaseEntity> asklist= Tools.getManager(GoodsAskCache.class).getList(listRes, listOrder, 0, 1000);
        		if(asklist==null || asklist.size()==0) return null;
        		for(BaseEntity be:asklist){
        			list.add((GoodsAskCache)be);
        		}
            	 return list;
        	}   
        
}
