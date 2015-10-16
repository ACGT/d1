<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="../islogin.jsp" %><%!
public static OrderItemBase getOrderItem(String subodrid){
	return (OrderItemBase)Tools.getManager(OrderItemMain.class).get(subodrid) == null?(OrderItemBase)Tools.getManager(OrderItemRecent.class).get(subodrid):(OrderItemBase)Tools.getManager(OrderItemMain.class).get(subodrid);
}
%>
<%
String req_subodrid=request.getParameter("req_subodrid");
String req_usrkd=request.getParameter("req_usrkd");
String req_usrwl=request.getParameter("req_usrwl");

if(Tools.isNull(req_subodrid)){
	out.print("{\"success\":false,\"message\":\"订单号错误！\"}");
    return;
}
	OrderItemBase odritem=getOrderItem(req_subodrid);
	
	OrderMain orderMain = (OrderMain)Tools.getManager(OrderMain.class).get(odritem.getOdrdtl_odrid());
	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if(orderMain != null) {
		orderMain.setOdrmst_internalmemo("用户申请退换货,退货物流公司是:"+req_usrwl+",快递单号是:"+req_usrkd+"("+format.format(new Date())+")<br>"+orderMain.getOdrmst_internalmemo());
	
		Tools.getManager(OrderMain.class).update(orderMain, true);
	}else {
		OrderRecent orderRecent = (OrderRecent)Tools.getManager(OrderRecent.class).get(odritem.getOdrdtl_odrid());
		
		if(orderRecent != null) {
			orderRecent.setOdrmst_internalmemo("用户申请退换货,退货物流公司是:"+req_usrwl+",快递单号是:"+req_usrkd+"("+format.format(new Date())+")<br>"+orderRecent.getOdrmst_internalmemo());
			
			Tools.getManager(OrderRecent.class).update(orderRecent, true);				
		}
	}

	OdrShopTh odrth2=(OdrShopTh)Tools.getManager(OdrShopTh.class).findByProperty("odrshopth_subodrid", new Long(req_subodrid));
	if(odrth2!=null){
   try{
	   odrth2.setOdrshopth_usrkd(req_usrkd);
	   odrth2.setOdrshopth_usrwl(req_usrwl);
	
		if(Tools.getManager(OdrShopTh.class).update(odrth2,false)){
			out.print("{\"success\":true,\"message\":\"修改成功！\"}");
		    return;
		}
		else
		{
			out.print("{\"success\":false,\"message\":\"修改失败！\"}");
		    return;
		}
		
	}
	catch(Exception e){
		out.print("{\"success\":false,\"message\":\"修改失败了！\"}");
	    return;
	}
  }else{
	  out.print("{\"success\":false,\"message\":\"数据不存在！\"}");
	    return;
  }

%>