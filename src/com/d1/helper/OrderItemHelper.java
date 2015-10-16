package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.OrderItemBase;
import com.d1.bean.OrderItemCache;
import com.d1.bean.OrderItemHistory;
import com.d1.bean.OrderItemMain;
import com.d1.bean.OrderItemRecent;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * ������ϸ�������ط���
 * @author chengang
 * @createTime 2011-10-18 22:31:40
 *
 */
public class OrderItemHelper {
	
	public static final BaseManager manager = Tools.getManager(OrderItemCache.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return OrderItemCache
	 */
	public OrderItemCache getById(String id){
		if(Tools.isNull(id)) return null;
		return (OrderItemCache)manager.get(id);
	}
	
	/**
	 * ��÷���Ʒ���ǲɼ�����ȫ���Ķ�����ϸ�б�
	 * @param orderId - orderId
	 * @return List<OrderItemCache>
	 */
	public static List<OrderItemCache> getOrderItemCacheByOrderId(String orderId){
		if(Tools.isNull(orderId)) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrdtl_odrid", orderId));
		listRes.add(Restrictions.eq("odrdtl_jcflag", new Long(0)));
		listRes.add(Restrictions.eq("odrdtl_gifttype", ""));
		
		List<BaseEntity> list = manager.getList(listRes, null, 0, 1000);
		if(list == null || list.isEmpty()) return null;
		
		List<OrderItemCache> itemList = new ArrayList<OrderItemCache>();
		
		int size = list.size();
		String rackCode = null;
		for(int i=0;i<size;i++){
			OrderItemCache oic = (OrderItemCache)list.get(i);
			rackCode = oic.getOdrdtl_rackcode();
			if(rackCode != null && rackCode.length()>3) rackCode = rackCode.substring(0, 3);
			if(!"000".equals(rackCode)){
				itemList.add(oic);
			}
		}
		
		return itemList;
	}

	/**
	 * ���ݶ����Ż�ȡ�������� --odrdtl_cache
	 */
	public static List<OrderItemBase> getOdrdtlCacheByOrderId(String orderId){
		if(Tools.isNull(orderId)) return null;
		List<OrderItemBase> itemList = new ArrayList<OrderItemBase>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrdtl_odrid", orderId));
		
		List<BaseEntity> list =  Tools.getManager(OrderItemCache.class).getList(listRes, null, 0, 500);
		if(list == null || list.size()==0) return null;
		for(BaseEntity be:list){
			itemList.add((OrderItemBase)be);
		}
		return itemList;
	}
	/**
	 * ���ݶ����Ż�ȡ�������� --odrdtl
	 */
	public static List<OrderItemBase> getOdrdtlByOrderId(String orderId){
		if(Tools.isNull(orderId)) return null;
		List<OrderItemBase> itemList = new ArrayList<OrderItemBase>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrdtl_odrid", orderId));
		
		List<BaseEntity> list =  Tools.getManager(OrderItemMain.class).getList(listRes, null, 0, 500);
		if(list == null || list.size()==0) return null;
		for(BaseEntity be:list){
			itemList.add((OrderItemBase)be);
		}
		return itemList;
	}
	
	/**
	 * ���ݶ����Ż�ȡ�������� --odrdtl_recent
	 */
	public static List<OrderItemBase> getOdrdtRecentlByOrderId(String orderId){
		if(Tools.isNull(orderId)) return null;
		List<OrderItemBase> itemList = new ArrayList<OrderItemBase>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrdtl_odrid", orderId));
		
		List<BaseEntity> list =  Tools.getManager(OrderItemRecent.class).getList(listRes, null, 0, 500);
		if(list == null || list.size()==0) return null;
		for(BaseEntity be:list){
			itemList.add((OrderItemBase)be);
		}
		return itemList;
	}
	
	/**
	 * ���ݶ����Ż�ȡ�������� 
	 */
	public static ArrayList<OrderItemBase>  getOdrdtlListByOrderId(String orderId){
		ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase> ();
		List<OrderItemBase> listitemcache=getOdrdtlCacheByOrderId(orderId);
		if(listitemcache!=null){
			for(OrderItemBase itemcache:listitemcache){
				list.add(itemcache);
			}
		}
		List<OrderItemBase> itemList=getOdrdtlByOrderId(orderId);
		if(itemList!=null){
			for(OrderItemBase itemmain:itemList){
				list.add(itemmain);
			}
		}
		List<OrderItemBase> itemRecentList=getOdrdtRecentlByOrderId(orderId);
		if(itemRecentList!=null){
			for(OrderItemBase item:itemRecentList){
				list.add(item);
			}
		}
		if(list==null || list.size()==0){
			return null;
		}else return list;
	}
	
	
	/**
	 * ���ݶ����Ż�ȡ�������飨��ʷ��¼��
	 * 
	 */
	   public static List<OrderItemBase> getOdrdtHistorylByOrderId(String orderId){
		if(Tools.isNull(orderId)) return null;
		List<OrderItemBase> itemList = new ArrayList<OrderItemBase>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("odrdtl_odrid", orderId));
		
		List<BaseEntity> list =  Tools.getManager(OrderItemHistory.class).getList(listRes, null, 0, 500);
		if(list == null || list.size()==0) return null;
		for(BaseEntity be:list){
			itemList.add((OrderItemBase)be);
		}
		return itemList;
	}
	   
	   /**
	    * ��ȡ���ջ��Ͳ����ջ��Ķ�������
	    */
	   public static ArrayList<OrderItemBase> getMyOrderDetail(String orderId){
		   ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
		   List<OrderItemBase> historylist =getOdrdtHistorylByOrderId( orderId);
		   if(historylist!=null){
				for(OrderItemBase itemmain:historylist){
					list.add(itemmain);
				}
			}
		   List<OrderItemBase> itemList=getOdrdtlByOrderId(orderId);
			if(itemList!=null){
				for(OrderItemBase itemmain:itemList){
					list.add(itemmain);
				}
			}
			List<OrderItemBase> itemRecentList=getOdrdtRecentlByOrderId(orderId);
			if(itemRecentList!=null){
				for(OrderItemBase item:itemRecentList){
					list.add(item);
				}
			}
			if(list==null || list.size()==0){
				return null;
			}else return list;
		   
	   }

public static ArrayList<OrderItemBase> getMyOrderDetail2(String orderId){
	   ArrayList<OrderItemBase> list=new ArrayList<OrderItemBase>();
	  List<OrderItemBase> itemList=getOdrdtlByOrderId(orderId);
		if(itemList!=null){
			for(OrderItemBase itemmain:itemList){
				list.add(itemmain);
			}
		}
		List<OrderItemBase> itemRecentList=getOdrdtRecentlByOrderId(orderId);
		if(itemRecentList!=null){
			for(OrderItemBase item:itemRecentList){
				list.add(item);
			}
		}
		if(list==null || list.size()==0){
			return null;
		}else return list;
	   
}
}