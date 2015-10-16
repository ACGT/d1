<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static OrderItemBase getOrderItem(String orderId,String subodrid){
	if(Tools.isNull(orderId)) return null;
	OrderBase order = (OrderBase)OrderHelper.getById(orderId);
	//if(order==null||order.getOdrmst_orderstatus().longValue()>=3)return null;
	if(order instanceof OrderMain){
		return (OrderItemBase)Tools.getManager(OrderItemMain.class).get(subodrid);
	}else if(order instanceof OrderRecent){
	   	return (OrderItemBase)Tools.getManager(OrderItemRecent.class).get(subodrid);
	}
	return null;
}
%>
<%

String userid="";
//session.getAttribute("admin_mng").toString();
/*
if(session.getAttribute("admin_mng")!=null){
	  
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "odr_shopodrth");
	   if(aplist==null||aplist.size()<=0){
		  out.print("{\"code\":1,message:\"对不起，您没有操作权限！\"}");
		   return;
	   }
} 
else {return;}
*/
/*
String odrthid=request.getParameter("odrthid");

if(Tools.isNull(odrthid)){
	out.print("{\"code\":1,message:\"退货单号不能为空！\"}");
	return;
}

OdrShopTh  odrshopth=(OdrShopTh)Tools.getManager(OdrShopTh.class).get(odrthid);

if(odrshopth!=null){
if (odrshopth.getOdrshopth_status().longValue()==1&&odrshopth.getOdrshopth_thtype().longValue()==1){

	   OrderBase order = (OrderBase)OrderHelper.getById(odrshopth.getOdrshopth_odrid());
		OrderItemBase  odritem=getOrderItem(odrshopth.getOdrshopth_odrid(),odrshopth.getOdrshopth_subodrid()+"");
		
		if(odritem!=null&&order!=null){
			order.setOdrmst_internalmemo(order.getOdrmst_internalmemo()+"<span style=\"color:#ff0000\">商户已同意退款，金额："+odrshopth.getOdrshopth_money()+"元</span>");
			order.setOdrmst_refundtype(new Long(7));
			Tools.getManager(order.getClass()).update(order,true);
			
			odritem.setOdrdtl_purtype(new Long(-21));
			odritem.setOdrdtl_shipstatus(new Long(-3));
			Tools.getManager(odritem.getClass()).update(odritem, true);
		}else{
			out.print("{\"code\":1,message:\"同意处理失败！\"}");
			return;
		}

	
	odrshopth.setOdrshopth_status(new Long(2));
	odrshopth.setOdrshopth_cldate(new Date());
	odrshopth.setOdrshopth_cluser(userid);
	Tools.getManager(OdrShopTh.class).update(odrshopth, true);
	out.print("{\"code\":1,message:\"处理成功！\"}");
	return;
}else{
	out.print("{\"code\":1,message:\"处理失败！\"}");
	return;
}
}else{
	out.print("{\"code\":1,message:\"退货单号不存在！\"}");
}*/
%>