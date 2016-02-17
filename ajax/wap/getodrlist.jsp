<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*"%><%@include file="/html/header.jsp" %>
<%!
public static class OrderBaseComparator implements Comparator<OrderBase>{

	@Override
	public int compare(OrderBase p0, OrderBase p1) {	
		
		if(p1.getOdrmst_orderdate()!=null&&p0.getOdrmst_orderdate()!=null&&p0.getOdrmst_orderdate().getTime() <p1.getOdrmst_orderdate().getTime()){
			return 1 ;
		}else if(p1.getOdrmst_orderdate()!=null&&p0.getOdrmst_orderdate()!=null&&p0.getOdrmst_orderdate().getTime()==p1.getOdrmst_orderdate().getTime()){
			return 0 ;
		}else{
			return -1 ;
		}
	}
}
private static String getcom(String comname){
	String com="";
	 if(comname.indexOf("中通")>=0){
		   com="zhongtong";
	   }else if(comname.indexOf("宅急送")>=0){
		   com="zhaijisong";
	   }else if(comname.indexOf("优速")>=0){
		   com="yousu";
	   }else if(comname.indexOf("天天")>=0){
		   com="tiantian";
	   }else if(comname.indexOf("顺丰")>=0){
		   com="shunfeng";
	   }else if(comname.indexOf("圆通")>=0){
		   com="yuantong";
	   }else if(comname.indexOf("申通")>=0){
		   com="shentong";
	   }else if(comname.indexOf("全峰")>=0){
		   com="quanfeng";
	   }else if(comname.indexOf("汇通")>=0){
		   com="huitong";
	   }else if(comname.indexOf("EMS")>=0){
		   com="ems";
	   }else if(comname.indexOf("韵达")>=0){
		   com="yunda";									   
	   }
	
	return com;
}
public static long getOrderMainlen(String mbrId){
	if(Tools.isNull(mbrId))return 0;
	ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrId)));
	listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(1)));
	listRes.add(Restrictions.le("odrmst_orderstatus",new Long(2)));

	long odrnum = Tools.getManager(OrderMain.class).getLength(listRes);
	 

	
	return odrnum;
}

public static long getOrderMRecentlen(String mbrId){
	if(Tools.isNull(mbrId))return 0;
	ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrId)));
	listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(3)));
	listRes.add(Restrictions.le("odrmst_orderstatus",new Long(31)));
	listRes.add(Restrictions.ne("odrmst_orderstatus",new Long(5)));
	listRes.add(Restrictions.ne("odrmst_orderstatus",new Long(6)));
	//加入main订单
	long odrnum = Tools.getManager(OrderMain.class).getLength(listRes);
	//加入recent订单
			odrnum =+ Tools.getManager(OrderRecent.class).getLength(listRes);
	
	
	return odrnum;
}
%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "0");
	out.print(json);
	return;
}
String status=request.getParameter("status");
if(Tools.isNull(status))status="3";
JSONArray jsonarr=new JSONArray();
ArrayList<OrderBase> list=null;
long num1=0;
long num2=0;
if(status.equals("1")){
	list=OrderHelper.getOrderMain(lUser.getId());
}else if(status.equals("2")){
	list=OrderHelper.getOrderMRecent(lUser.getId());
	num1=list.size();
	num2=getOrderMRecentlen(lUser.getId());
}else if(status.equals("4")){
	list=OrderHelper.getOrderHistoryListByMbrid(lUser.getId(),1000);
	num1=getOrderMainlen(lUser.getId());
	num2=getOrderMRecentlen(lUser.getId());
}else {
	list=OrderHelper.getTotalOrderListIn4Months(lUser.getId());
	num1=getOrderMainlen(lUser.getId());
	num2=getOrderMRecentlen(lUser.getId());
}

int odrcount= list.size();
if(list!=null&&odrcount>0)
{
	json.put("status", "1");
	json.put("allcount", odrcount);
	json.put("num1", num1);
	json.put("num2", num2);
	Collections.sort(list,new OrderBaseComparator());
	String pg=request.getParameter("pg"),psize=request.getParameter("psize");
	
	if(Tools.isNull(pg))pg="1";
	if(Tools.isNull(psize))psize="12";
	int ipg=Tools.parseInt(pg);
	int ipsize=Tools.parseInt(psize);
	PageBean pBean1 = new PageBean(odrcount,ipsize,ipg);
	int pbegin = (pBean1.getCurrentPage()-1)*ipsize;
    int pend = pbegin + ipsize;
    DecimalFormat df = new DecimalFormat("0.00");
    int shipstatus=0;
    long orderstatus=0;
    String statustxt="";
    Date orderdate=null;
    int tktyear2016=0;
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
    Date dStartDate=null;
    Date dsDate=null;
    try{
    	 dStartDate =fmt.parse("2016-02-15");
    	 dsDate =fmt.parse("2016-01-26");
    	 }
    catch(Exception ex){
    	ex.printStackTrace();
    }
    boolean tktyear2016flag=true;
    if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
    {
    	tktyear2016flag=false;
    }
    
	 for(int t=pbegin; t<odrcount&&t<pend;t++ )
     {
		 OrderBase ob = list.get(t);
		 JSONObject jsonorder=new JSONObject();
		 JSONArray jsonorderarr=new JSONArray();
		 shipstatus=0;
		 if(!Tools.isNull(ob.getOdrmst_shipmethod())){
			 shipstatus=1;
		 }
		 orderstatus=ob.getOdrmst_orderstatus().longValue();
		 orderdate=ob.getOdrmst_orderdate();
		 if(tktyear2016flag&&Tools.dateValue(dStartDate)>Tools.dateValue(orderdate)&&Tools.dateValue(orderdate)>=Tools.dateValue(dsDate)){
		 if(orderstatus==1||orderstatus==2||orderstatus==3||orderstatus==31||
				 orderstatus==5||orderstatus==51||orderstatus==6||orderstatus==61){
		 if(tktyear2016==0&&ob.getOdrmst_customerword()!=null&&ob.getOdrmst_customerword().indexOf("新年赠券已领")==-1){
			 tktyear2016=1;
			}
		 }
		 }
		 if(orderstatus==5||orderstatus==51||orderstatus==6||orderstatus==61){
			  statustxt="交易完成";
		  }else if(orderstatus==3||orderstatus==31){
			  statustxt="已发货";
		  }else if(orderstatus==1){
			  statustxt="已确认";
		  }else if(orderstatus==2){
			  statustxt="已收款";
		  }else if(orderstatus==0&&ob.getOdrmst_payid().longValue()==0){
			  statustxt="未确认";
		  }else if(orderstatus==0&&ob.getOdrmst_payid().longValue()>0){
			  statustxt="未支付";
		  }else{
			  statustxt="已取消";
		  }
		 jsonorder.put("order_shopcode", ob.getOdrmst_sndshopcode());
		 jsonorder.put("order_odrid", ob.getId());
		 jsonorder.put("order_shipcom", getcom(ob.getOdrmst_d1shipmethod()));
		 jsonorder.put("order_shipcode", ob.getOdrmst_goodsodrid());
		 jsonorder.put("order_shipname", ob.getOdrmst_d1shipmethod());
		 jsonorder.put("order_status", orderstatus);
		 jsonorder.put("order_statustxt", statustxt);
		 int pid=0;
		 switch (ob.getOdrmst_payid().intValue()){
			case 4:
			case 6:
			case 25:
			case 26:
			case 27:
			case 34:
			case 35:
			case 36:
			case 37:
			case 38:
			case 39:
			case 40:
			case 41:
			case 42:
			case 43:
				pid=2;
				break;
			case 20:
				pid=4;
				break;
			case 21:
				pid=3;
				break;
			case 14:
			case 31:
				pid=5;
				break;
			case 33:
				pid=1;
				break;
			case 60:
				pid=6;
				break;
		}
		 jsonorder.put("order_payid", pid);
		 jsonorder.put("order_comflag", ob.getOdrmst_comvalue().intValue());
		 jsonorder.put("order_shipstatus", ob.getOdrmst_orderstatus());
		 jsonorder.put("order_allmoney", df.format(ob.getOdrmst_acturepaymoney().doubleValue()+ob.getOdrmst_prepayvalue().doubleValue()));

		 List<OrderItemBase> oitems=null;
		     switch(ob.getType())
		     {
			   case 1:
			   {
				   oitems=OrderItemHelper.getOdrdtlCacheByOrderId(ob.getId());
				  break;
			   }
			   case 2:
			   {
				   oitems=OrderItemHelper.getOdrdtlListByOrderId(ob.getId());
				  break;
			   }
			   case 3:
			   {
				   oitems=OrderItemHelper.getOdrdtRecentlByOrderId(ob.getId());
				   break;
			   }
		     }
		 int itemstatus=0;
		 for(OrderItemBase oitem:oitems){
			 JSONObject jsonitem=new JSONObject();
			 Product p=ProductHelper.getById(oitem.getOdrdtl_gdsid());
			 if(oitem.getOdrdtl_shipstatus().longValue()==1&&oitem.getOdrdtl_purtype().longValue()>=0){
			     itemstatus=0;
			 }else if(oitem.getOdrdtl_shipstatus().longValue()>=2&&oitem.getOdrdtl_purtype().longValue()>=0){
				 itemstatus=1;
			 }else{
				 itemstatus=-1; 
			 }
			 jsonitem.put("orderitem_id", oitem.getId());
			 jsonitem.put("orderitem_gdsid", oitem.getOdrdtl_gdsid());
			 jsonitem.put("orderitem_gdsname", oitem.getOdrdtl_gdsname());
			 jsonitem.put("orderitem_price", df.format(oitem.getOdrdtl_finalprice()));
			 jsonitem.put("orderitem_count", oitem.getOdrdtl_gdscount());
			 jsonitem.put("orderitem_img", ProductHelper.getImageTo80(p));
			 jsonitem.put("orderitem_status", itemstatus);
			 String orderid=oitem.getOdrdtl_odrid();
			 String suborderid=oitem.getId();
			 long thtype = -1;
		     	long lstatus = -1;
		     	List<Order> olist=new ArrayList<Order>();
		     	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		     	List<BaseEntity> listOdrShopTh = new ArrayList<BaseEntity>();
		     	OdrShopTh odrShopTh = null;
		     					     	
		     	if(!Tools.isNull(oitem.getOdrdtl_odrid())){
					   listRes.add(Restrictions.eq("odrshopth_odrid", oitem.getOdrdtl_odrid().toString()));
				}
		     	
		     	if(!Tools.isNull(oitem.getId())){
					   listRes.add(Restrictions.eq("odrshopth_subodrid", Long.parseLong(oitem.getId().toString())));
				}
			 listOdrShopTh = Tools.getManager(OdrShopTh.class).getList(listRes, olist, 0, 500);
				
		     	if(listOdrShopTh!=null && listOdrShopTh.size()>0) {
		     		odrShopTh = (OdrShopTh)listOdrShopTh.get(0);
		     		thtype = odrShopTh.getOdrshopth_thtype().longValue(); 
		     		lstatus = odrShopTh.getOdrshopth_status().longValue();
		     	}
			 	String result = "";
					if(thtype==1) {
						if(lstatus==0) {
							result = "<a href='/wap/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>等您退货</A>";
						}else if(lstatus==1) {
							result = "<a href='/wap/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>已退货（待退款）</A>";
						}else if(lstatus==2) {
							result = "<a href='/wap/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>已退款</A>";
						}
					}else if(thtype==2) {
						if(lstatus==0) {
							result = "<a href='/wap/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>等您退回换货</A>";
						}else if(lstatus==1) {
							result = "<a href='/wap/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>已退货(待换货)</A>";
						}else if(lstatus==2) {
							result = "<a href='/wap/user/odrstatusdetail.jsp?odrid="+orderid+"&subodrid="+suborderid+"&thtype="+thtype+"&lstatus="+lstatus+"' target='_blank'>换货完成</A>";
						}	
					}
				
					jsonitem.put("thurl", result);
			 jsonorderarr.add(jsonitem);
		 }
		 jsonorder.put("order_items", jsonorderarr);
		 
		 jsonarr.add(jsonorder);
     }
	 json.put("orders", jsonarr);
	 json.put("tktyears", tktyear2016);
	 
}else{
	json.put("status", "0");
	out.print(json);
	return;
}
out.print(json);
%>