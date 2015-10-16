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
 * ��Ʒ�ʴ�����
 * @author chengang
 * @createTime 2011-10-30 20:46:24
 *
 */
public class GoodsAskHelper {
	
	public static BaseManager manager = Tools.getManager(GoodsAsk.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return GoodsAsk
	 */
	public static GoodsAsk getById(String id){
		if(Tools.isNull(id)) return null;
		return (GoodsAsk)manager.get(id);
	}
	
	/**
	 * �����Ʒ���ʴ�ĳ���
	 * @param productId - ��ƷID
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
	 * �����Ʒ�ʴ�ļ���
	 * @param productId - ��Ʒ ID
	 * @param start - ��ʼ
	 * @param length - ����
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
     * ��ȡ���ʵ����䣨����ȫ�ԣ�
     * @param gdscom_uid ��Աid
     * @return �µĻ�Աuid
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
     * ��ȡ���ҵ���Ʒ��ѯ��(�ѻظ�)
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
         * ��ȡ���ҵ���Ʒ��ѯ��(δ�ظ�)
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
