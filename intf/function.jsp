<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*"%><%!
public static ArrayList<OrderBase> getByIds(String order_ids){
	ArrayList<OrderBase> list=new ArrayList<OrderBase>();
	 String orders[]=order_ids.split(",");
	 for(int i=0;i<orders.length;i++){
		 OrderBase o=OrderHelper.getById(orders[i]);
		 if(o!=null){
			 list.add(o); 
		 }
	}
	 return list;
}
//获取订单状态
public static String checkOrderStatus(int orderstatus,double getmoney,Date odrmst_realshipdate ,double ticketvalue){
String status = "1";
/**
新订单:1;
已确认(尚未发货和支付):2;
已发货:3;
已支付:4;
已完成:5;
已作废(已取消):6
**/
if(orderstatus<0){
	status = "6";
}
else if(orderstatus==0 ){
	status = "1";
}
else if(odrmst_realshipdate==null && getmoney==ticketvalue){
	status = "2";
}
else if(odrmst_realshipdate!=null){
	status = "3";
}else if(getmoney>0 && ticketvalue!=getmoney ){
	status = "4";
}
else if(orderstatus==51 || orderstatus==5 || orderstatus==61 || orderstatus==6){
	status = "5";
}

return status;
}
public static double getTktRa(double tktvalue,String odrid )
{
	List<OrderItemBase> list=OrderItemHelper.getOdrdtlListByOrderId(odrid);
	double allmoney=0;
	double retra=1;
	for(OrderItemBase odrdtl:list)
	{
		if (!"000".equals(odrdtl.getOdrdtl_rackcode()) && Tools.isNull(odrdtl.getOdrdtl_gifttype()))
		{
			allmoney+=odrdtl.getOdrdtl_finalprice()*odrdtl.getOdrdtl_gdscount();
		}	
	}
	if (allmoney!=0)
	{
		retra=Tools.getDouble(1-tktvalue/allmoney,3);
	}
	if(retra<0 || retra>1 ){
		retra=1;
	}
	
	return retra;
}
//计算订单总佣金
public static double gettotal(String odrid, double fltTktmstTktValue){
	double total=0;
	 ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(odrid);
	 boolean type1=false;boolean type2=false;boolean type3=false;
	double bl=0;
	 if(orderitemlist!=null){
		  for(OrderItemBase itembase:orderitemlist){
			  Product product=ProductHelper.getById(itembase.getOdrdtl_gdsid());
			  if(product!=null){
				
				  String strGdsmstBrand=product.getGdsmst_brand();
				  String strOdrdtlRackCode=itembase.getOdrdtl_rackcode();
				 
				  double price=Tools.getDouble(itembase.getOdrdtl_finalprice(),2);
				
             if (strGdsmstBrand.equals("001346" )|| //F&M
                 strGdsmstBrand.equals("001561") ||//YouSoo
                 strGdsmstBrand.equals("001564"))//小栗舍

             {
                 bl=0.15;
                 type1=true;
             }
             else if (strOdrdtlRackCode.startsWith("02") || strOdrdtlRackCode.startsWith("03") || strOdrdtlRackCode.startsWith("015009"))//服装
             {
                bl=0.08;
                 type2=true;
             }
             else
             {
                 bl=0.04;
                 type3=true;
             }
           
             double yongjin=itembase.getOdrdtl_gdscount().intValue()*Tools.getDouble(price,2);
             yongjin*=bl;
             total+=yongjin;
			  }
		  }
	  }
	 double d=0;
	  if(type3) d=0.04;
	  else if(type2) d=0.08;
	  else if(type1) d=0.15;
	  total-=fltTktmstTktValue*d;
	  return total;
}
public static ArrayList<OrderCache> getOrderCacheList(String odrmst_temp,Date start,Date end,String last_order_id){
	ArrayList<OrderCache> list=new ArrayList<OrderCache>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.ge("odrmst_orderdate", start));
	listRes.add(Restrictions.le("odrmst_orderdate", end));
	if(!Tools.isNull(last_order_id)){
		listRes.add(Restrictions.gt("id", last_order_id));
	}
	listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("id"));
	List<BaseEntity> list2 = Tools.getManager(OrderCache.class).getList(listRes, listOrder, 0, 2000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderCache)be);
	}
	return list;
}
public static ArrayList<OrderMain> getOrderMainList(String odrmst_temp,Date start,Date end,String last_order_id){
	ArrayList<OrderMain> list=new ArrayList<OrderMain>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.ge("odrmst_orderdate", start));
	listRes.add(Restrictions.le("odrmst_orderdate", end));
	if(!Tools.isNull(last_order_id)){
		listRes.add(Restrictions.gt("id", last_order_id));
	}
	listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("id"));
	List<BaseEntity> list2 = Tools.getManager(OrderMain.class).getList(listRes, listOrder, 0, 2000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderMain)be);
	}
	return list;
}
public static ArrayList<OrderRecent> getOrderRecentList(String odrmst_temp,Date start,Date end,String last_order_id){
	ArrayList<OrderRecent> list=new ArrayList<OrderRecent>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.ge("odrmst_orderdate", start));
	listRes.add(Restrictions.le("odrmst_orderdate", end));
	if(!Tools.isNull(last_order_id)){
		listRes.add(Restrictions.gt("id", last_order_id));
	}
	listRes.add(Restrictions.like("odrmst_temp", odrmst_temp+"%"));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.asc("id"));
	List<BaseEntity> list2 = Tools.getManager(OrderRecent.class).getList(listRes, listOrder, 0, 2000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((OrderRecent)be);
	}
	return list;
}

public static ArrayList<OrderBase> getOrderList(String odrmst_temp,Date start,Date end,String last_order_id){
	ArrayList<OrderBase> list=new ArrayList<OrderBase>();
	ArrayList<OrderCache> listcache=getOrderCacheList(odrmst_temp, start, end,last_order_id);
	if(listcache!=null){
		for(OrderCache ordercache:listcache){
			list.add(ordercache);
		}
	}
	ArrayList<OrderMain> listmain=getOrderMainList(odrmst_temp, start, end,last_order_id);
	if(listmain!=null){
		for(OrderMain ordermain:listmain){
			list.add(ordermain);
		}
	}
	ArrayList<OrderRecent> listrecent=getOrderRecentList(odrmst_temp, start, end,last_order_id);
	if(listrecent!=null){
		for(OrderRecent orderrecent:listrecent){
			list.add(orderrecent);
		}
	}
	if(list==null || list.size()==0){
		return null;
	}
	Collections.sort(list,new OrderIdComparator());
	return list;
}

%>