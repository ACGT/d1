<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkshop.jsp"%>
<%!
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
String odrthid=request.getParameter("odrthid");
String shopCode=session.getAttribute("shopcodelog").toString();
String shopusr=session.getAttribute("shopadmin").toString();
if(Tools.isNull(odrthid)){
	out.print("{\"code\":1,message:\"退换货单号不能为空！\"}");
	return;
}

OdrShopTh  odrshopth=(OdrShopTh)Tools.getManager(OdrShopTh.class).get(odrthid);
/*
<option value="1">退货</option>
	  <option value="2">换货</option>
*/
if(odrshopth!=null){
if (odrshopth.getOdrshopth_shopcode().equals(shopCode)&&odrshopth.getOdrshopth_status().longValue()==0){
	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	OrderBase order = (OrderBase)OrderHelper.getById(odrshopth.getOdrshopth_odrid());
	if(odrshopth.getOdrshopth_thtype().longValue()==1){
		OrderItemBase  odritem=getOrderItem(odrshopth.getOdrshopth_odrid(),odrshopth.getOdrshopth_subodrid()+"");
		if(odritem!=null){
			String paytypestr="原路退回";
			if (odrshopth.getOdrshopth_paytype().longValue()==1){
				paytypestr="退回预存款";
			}
			order.setOdrmst_internalmemo("<span style=\"color:#ff0000\">商户已同意退款，"+paytypestr+"金额："+odrshopth.getOdrshopth_money()+"元("+format.format(new Date())+")</span>"+order.getOdrmst_internalmemo());
			 ArrayList<OrderItemBase> itemlist=OrderItemHelper.getMyOrderDetail2(odrshopth.getOdrshopth_odrid());
			long orderno=0;
			 if(itemlist!=null && itemlist.size()>0){
	    		
	    		 for(OrderItemBase item:itemlist){
	    			 if(odrshopth.getOdrshopth_subodrid().longValue()==Tools.parseLong(item.getId()))continue;
	    			 if(item.getOdrdtl_purtype().longValue()>0){
	    				 orderno=1;
	    				 break;
	    			 }
	    		 }
	    		 }
			 if(orderno==0){
			   order.setOdrmst_refundtype(new Long(7));
			   order.setOdrmst_orderstatus(new Long(-1));
			 }
			Tools.getManager(order.getClass()).update(order,true);
			
			odritem.setOdrdtl_purtype(new Long(-20));
			Tools.getManager(odritem.getClass()).update(odritem, true);
		}else{
			out.print("{\"code\":1,message:\"同意处理失败！\"}");
			return;
		}
	}else {
		order.setOdrmst_internalmemo("退货已收到商户准备换货("+format.format(new Date())+")"+order.getOdrmst_internalmemo()+"<br>");
		Tools.getManager(order.getClass()).update(order,true);		
	}
	
	
	odrshopth.setOdrshopth_status(new Long(1));
	odrshopth.setOdrshopth_shopcldate(new Date());
	Tools.getManager(OdrShopTh.class).update(odrshopth, true);
	out.print("{\"code\":1,message:\"同意处理成功！\"}");
	return;
	
}else{
	out.print("{\"code\":1,message:\"同意处理失败！\"}");
	return;
}
}else{
	out.print("{\"code\":1,message:\"退换货单号不存在！\"}");
}
%>