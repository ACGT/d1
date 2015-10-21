<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*"%><%@include file="/html/header.jsp" %>
<%!private static String getcom(String comname){
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
%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "0");
	out.print(json);
	return;
}
String odrid=request.getParameter("odrid");
OrderBase ob=OrderHelper.getById(odrid);
JSONArray jsonarr=new JSONArray();
if(ob==null){
	json.put("status", "0");
	out.print(json);
	return;
}
json.put("status", "1");
DecimalFormat df = new DecimalFormat("0.00");
List<OrderItemBase> oitems=OrderItemHelper.getOdrdtlListByOrderId(odrid);

   if(oitems==null||oitems.size()==0)
   {
		json.put("status", "0");
		out.print(json);
		return;
	}
    int shipstatus=0;
	 if(!Tools.isNull(ob.getOdrmst_shipmethod())){
		 shipstatus=1;
	 }
	long orderstatus=ob.getOdrmst_orderstatus().longValue();
	 String statustxt="";
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
	 json.put("order_shopcode", ob.getOdrmst_sndshopcode());
	 json.put("order_odrid", ob.getId());
	 json.put("order_shipcom", getcom(ob.getOdrmst_d1shipmethod()));
	 json.put("order_shipcode", ob.getOdrmst_goodsodrid());
	 json.put("order_shipname", ob.getOdrmst_d1shipmethod());
	 json.put("order_name", ob.getOdrmst_rname());
	 json.put("order_address", ob.getOdrmst_rprovince()+ob.getOdrmst_rcity()+ob.getOdrmst_raddress());
	 json.put("order_phone", ob.getOdrmst_rphone());
	 json.put("order_actmoney", ob.getOdrmst_d1actmoney());
	 json.put("order_tktmoney", ob.getOdrmst_tktvalue().doubleValue()-ob.getOdrmst_d1actmoney().doubleValue());

	 int payId=Integer.parseInt(ob.getOdrmst_payid());
	 int p=0;
		switch (payId){
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
			p=2;
			break;
		case 20:
			p=4;
			break;
		case 21:
			p=3;
			break;
		case 14:
		case 31:
			p=5;
			break;
		case 33:
			p=1;
		case 60:
			p=6;
			break;
	}
	 
	 json.put("order_payid", p);
	 json.put("order_paymethod", ob.getOdrmst_paymethod());
	 json.put("order_memo", ob.getOdrmst_customerword());
	 json.put("order_shipfee", ob.getOdrmst_shipfee());
	 json.put("orderstatus", orderstatus);
	 json.put("order_statustxt", statustxt);
	 json.put("order_shipstatus", ob.getOdrmst_orderstatus());
	 json.put("order_allmoney", df.format(ob.getOdrmst_acturepaymoney().doubleValue()+ob.getOdrmst_prepayvalue().doubleValue()));

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
	 jsonarr.add(jsonitem);
}
json.put("order_items", jsonarr);
out.print(json);
%>