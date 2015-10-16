<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="../inc/header.jsp"%><%@include file="function360check.jsp"%><%
String bid=request.getParameter("bid");
String rbid=PubConfig.get("cps360_bid");
String cp_key=PubConfig.get("cps360_cpkey");

if(Tools.isNull(bid) || !rbid.equals(bid)){
	out.print("bid错误！");
	return;
}

String bill_month=request.getParameter("bill_month");
if(!Tools.isNull(request.getParameter("month"))){
	bill_month=request.getParameter("month");
}
String last_order_id="";
if(!Tools.isNull(request.getParameter("last_order_id"))){
	last_order_id=request.getParameter("last_order_id");
}
String active_time=request.getParameter("active_time");
String sign=request.getParameter("sign");

long verifytime=System.currentTimeMillis()/1000;

String strcode=bid+"#"+active_time+"#"+cp_key;
String verifycode=MD5.to32MD5(strcode, "utf-8");

if(verifytime-Tools.parseLong(active_time) >15*60 ){
	out.print("检查超时.active_time="+verifytime);
	return;
}
if(!verifycode.equals(sign)){
	out.print("签名验证失败");
	return;
}
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String start_time="";
String end_time="";
ArrayList<OrderBase> list=null;
if(!Tools.isNull(bill_month)){
	start_time=bill_month;
	start_time+="-01 00:00:00";
	int year=Integer.parseInt( bill_month.substring(0,4));
	int month=Integer.parseInt( bill_month.substring(5,7));
	if(month==12){
		month=1;
		year+=1;
	}else{
		month++;
	}
	
	end_time+=year+"-"+new DecimalFormat("00").format(month)+"-01 00:00:00";
}
 if(!Tools.isNull(start_time) && !Tools.isNull(end_time)){
	list=getOrderList_Check("cps360",format.parse(start_time),format.parse(end_time),last_order_id);
}
if(list!=null && list.size()>0){
	StringBuffer str=new StringBuffer();
	str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
	 str.append("<orders>");
	for(OrderBase base:list){
		
		 str.append("<order>");
		
		 str.append("<order_id>");
		 str.append(base.getId());
		 str.append("</order_id>");
		 str.append("<order_time>");
		 str.append(format.format(base.getOdrmst_orderdate()));
		 str.append("</order_time>");
		 str.append("<order_updtime>");
		 str.append(format.format(base.getOdrmst_orderdate()));
		 str.append("</order_updtime>");
		 str.append("<server_price>");//服务费用，如运送费等 
		 str.append(Tools.getDouble(base.getOdrmst_shipfee(),2));
		 str.append("</server_price>");
		 str.append("<total_price>");//订单总金额 
		 str.append(Tools.getDouble(base.getOdrmst_ordermoney(),2));
		 str.append("</total_price>");
		 str.append("<coupon>");//优惠券金额 
		 str.append(Tools.getDouble(base.getOdrmst_tktvalue(),2));
		 str.append("</coupon>");
		 str.append("<total_comm>");//订单总佣金
		 str.append(Tools.getDouble(gettotal(base.getId(), Tools.doubleValue(base.getOdrmst_tktvalue())),2));
		 str.append("</total_comm>");
		 str.append("<commission>");//佣金明细
		  String detail="";
		
		 boolean type1=false;boolean type2=false;boolean type3=false;
		 ArrayList<OrderItemBase> orderitemlist=OrderItemHelper.getOdrdtlListByOrderId(base.getId());
		  if(orderitemlist!=null){
			  int i=0;
			 for(OrderItemBase itembase:orderitemlist){
				  Product product=ProductHelper.getById(itembase.getOdrdtl_gdsid());
				  if(product!=null){
					  
					  String strGdsmstBrand=product.getGdsmst_brand();
					  String strOdrdtlRackCode=itembase.getOdrdtl_rackcode();
					  double  iOdrdtlSpecialFlag=itembase.getOdrdtl_specialflag().doubleValue();
					  double price= Tools.getDouble(itembase.getOdrdtl_finalprice(),2);
					  double fltTktmstTktValue = Tools.doubleValue(base.getOdrmst_tktvalue());
					 
					  double dbl=0; //佣金比率
						String yj="";
                     if (strGdsmstBrand.equals("001346" )|| //F&M
                         strGdsmstBrand.equals("001561") ||//YouSoo
                         strGdsmstBrand.equals("001564"))//小栗舍

                     {
                       yj="15%";
                         dbl=0.15;
                         type1=true;
                     }
                     else if (strOdrdtlRackCode.startsWith("020") || strOdrdtlRackCode.startsWith("030") || strOdrdtlRackCode.startsWith("015009"))//服装//饰品
                     {
                    	 yj="8%";
                         dbl=0.08;
                         type2=true;
                     }else
                     {
                    	 yj="4%";
                         dbl=0.04;
                         type3=true;
                     }
                   
                     double yongjin=itembase.getOdrdtl_gdscount().intValue()*Tools.getDouble(itembase.getOdrdtl_finalprice(),2);
                   
				 if(i>0){
					 detail+="|"; 
					 
				 }
				 detail+=strOdrdtlRackCode+","+yj+","+yongjin*dbl+","+itembase.getOdrdtl_finalprice()+","+itembase.getOdrdtl_gdscount();
				
				 i++;
				  }
				 
			  }
		  }
		  double d=0;
		  if(type3) d=0.04;
		  else if(type2) d=0.08;
		  else if(type1) d=0.15;
		 str.append(detail).append("|").append(Tools.getDouble(base.getOdrmst_tktvalue()*d,2));
		 str.append("</commission>");
		 str.append("</order>");
		
	}
	 str.append("</orders>");
	 out.print(str.toString());
}else{
	StringBuffer str=new StringBuffer();
	str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
	 str.append("<orders>");
	 str.append("</orders>");
	 out.print(str.toString());
	return;
}
%>
