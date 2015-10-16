<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.*,com.d1.comp.*,com.d1.helper.*,java.net.*,java.util.*,com.d1.util.Tools,org.hibernate.criterion.*,com.d1.dbcache.core.BaseEntity"%>
<%!
public static ArrayList<OrderBase> getTotalOrderListIn4Months(String mbrId){
	if(Tools.isNull(mbrId))return null;
	ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrId)));
	listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(3)));
	
	//加入缓存订单
	List<BaseEntity> list_cache = Tools.getManager(OrderCache.class).getList(listRes, null, 0, 1000);
	
	if(list_cache!=null&&list_cache.size()>0){
		for(BaseEntity be:list_cache){
			OrderBase ob = (OrderBase)be;
			ob.setType(1);//表示为cache订单
			rlist.add(ob);
		}
	}
	
	//加入main订单
	List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
	
	if(list_main!=null&&list_main.size()>0){
		for(BaseEntity be:list_main){
			OrderBase ob = (OrderBase)be;
			ob.setType(2);//表示为main订单
			rlist.add(ob);
		}
	}
	
	//加入recent订单
	List<BaseEntity> list_recent = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 1000);
	
	if(list_recent!=null&&list_recent.size()>0){
		for(BaseEntity be:list_recent){
			OrderBase ob = (OrderBase)be;
			ob.setType(3);//表示为recent订单
			rlist.add(ob);
		}
	}		
	
	//排序
	Collections.sort(rlist,new OrderTimeComparator());
	
	return rlist;
}

//获取订单详情
 OrderItemBase getById(String id){
	if(Tools.isNull(id)) return null;
	if(Tools.getManager(OrderItemCache.class).get(id)!=null) return (OrderItemBase)Tools.getManager(OrderItemCache.class).get(id);
	else if(Tools.getManager(OrderItemMain.class).get(id)!=null) return (OrderItemBase)Tools.getManager(OrderItemMain.class).get(id);
	else if(Tools.getManager(OrderItemRecent.class).get(id)!=null) return (OrderItemBase)Tools.getManager(OrderItemRecent.class).get(id);
return null;
}

//判断一个订单的商品是否晒单
public int getMyShowByOrder(String userid,String odrid,String gdsid,String odtlid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("myshow_mbrid", new Long(userid)));
	listRes.add(Restrictions.eq("myshow_odrid", odrid));
	listRes.add(Restrictions.eq("myshow_gdsid", gdsid));
	listRes.add(Restrictions.eq("myshow_subodrid", odtlid));
	return Tools.getManager(MyShow.class).getLength(listRes);
	
}

//获取最近4个月的未晒单的订单详情
public ArrayList<OrderItemBase> getOdrDtlIn4Months(String mbrid){
	ArrayList<OrderItemBase> itemlist=new ArrayList<OrderItemBase>();
	/**
	List<OrderItemBase> list=OrderItemHelper.getOdrdtlListByOrderId("120807003834");
		if(list!=null && list.size()>0){
			for(OrderItemBase item:list){
				if(getMyShowByOrder(mbrid,"120807003834",item.getOdrdtl_gdsid())==0){
					itemlist.add(item);
				}
			}
		}
		**/
	
	ArrayList<OrderBase> baselist=getTotalOrderListIn4Months(mbrid);//获得4个月内发货和订单完成的订单
	
	if(baselist!=null && baselist.size()>0){
	 for(OrderBase base:baselist){
		 List<OrderItemBase> list=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
			if(list!=null && list.size()>0){
				for(OrderItemBase item:list){
					if(getMyShowByOrder(mbrid,base.getId(),item.getOdrdtl_gdsid(),item.getId())==0 && item.getOdrdtl_shipstatus()>=1){
						itemlist.add(item);
					}
				}
			}
	 }
	}
	Collections.sort(itemlist,new OrderItemTimeComparator());
	return itemlist;
}
//获取显示的商品图片
public void getProductImg(String gdsid){
	
}
%>