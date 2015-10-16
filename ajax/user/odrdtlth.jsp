<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="../islogin.jsp" %><%!
public static OrderItemBase getOrderItem(String orderId,String subodrid){
	if(Tools.isNull(orderId)) return null;
	OrderBase order = (OrderBase)OrderHelper.getById(orderId);

	if(order==null||order.getOdrmst_orderstatus().longValue()<3)return null;
	if(order instanceof OrderMain){
		
		return (OrderItemBase)Tools.getManager(OrderItemMain.class).get(subodrid);
	}else if(order instanceof OrderRecent){
	   	return (OrderItemBase)Tools.getManager(OrderItemRecent.class).get(subodrid);
	}
	return null;
}
%>
<%String req_odrid=request.getParameter("req_odrid");

String req_subodrid=request.getParameter("req_subodrid");
String req_thtype=request.getParameter("req_thtype");
String req_paytype=request.getParameter("req_paytype");
String req_thwhy=request.getParameter("req_thwhy");
String req_memo=request.getParameter("req_memo");

if(Tools.isNull(req_odrid)||Tools.isNull(req_subodrid)){
	out.print("{\"success\":false,\"message\":\"订单号错误！\"}");
    return;
}
if(Tools.isNull(req_subodrid)){
	out.print("{\"success\":false,\"message\":\"分类名称不能为空！\"}");
    return;
}
	
	OrderItemBase odritem=getOrderItem(req_odrid,req_subodrid);
	
	if(odritem!=null&&odritem.getOdrdtl_shipstatus().longValue()>=2){
		//if(odritem!=null){
	 
		OrderBase order = (OrderBase)OrderHelper.getById(odritem.getOdrdtl_odrid());
		
		//更新退换货信息
		OrderMain orderMain = (OrderMain)Tools.getManager(OrderMain.class).get(odritem.getOdrdtl_odrid());
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String gdsid = odritem.getOdrdtl_gdsid()==null?"":odritem.getOdrdtl_gdsid();
		String thtxt="退货";
		if(req_thtype.equals("2"))thtxt="换货";
		if(orderMain != null) {
			orderMain.setOdrmst_internalmemo("用户申请"+thtxt+","+thtxt+"商品:"+gdsid+","+thtxt+"原因:"+req_thwhy+",客户留言:"+req_memo+"("+format.format(new Date())+")<br>"+orderMain.getOdrmst_internalmemo());
		
			Tools.getManager(OrderMain.class).update(orderMain, true);
		}else {
			OrderRecent orderRecent = (OrderRecent)Tools.getManager(OrderRecent.class).get(odritem.getOdrdtl_odrid());
			
			if(orderRecent != null) {
				orderRecent.setOdrmst_internalmemo("用户申请"+thtxt+","+thtxt+"商品:"+gdsid+","+thtxt+"原因:"+req_thwhy+",客户留言:"+req_memo+"("+format.format(new Date())+")<br>"+orderRecent.getOdrmst_internalmemo());
				
				Tools.getManager(OrderRecent.class).update(orderRecent, true);				
			}
		}
		
		OdrShopTh odrth2=(OdrShopTh)Tools.getManager(OdrShopTh.class).findByProperty("odrshopth_subodrid", new Long(req_subodrid));
		if(odrth2==null){
   try{
	   OdrShopTh odrth=new OdrShopTh();
	odrth.setOdrshopth_shopcode(odritem.getOdrdtl_shopcode());
	odrth.setOdrshopth_odrid(req_odrid);
	odrth.setOdrshopth_mbrid(new Long(order.getOdrmst_mbrid()));
	odrth.setOdrshopth_rname(order.getOdrmst_rname());
	odrth.setOdrshopth_phone(order.getOdrmst_rphone());
	odrth.setOdrshopth_subodrid(new Long(req_subodrid));
	odrth.setOdrshopth_gdsid(odritem.getOdrdtl_gdsid());
	odrth.setOdrshopth_gdsname(odritem.getOdrdtl_gdsname());
	odrth.setOdrshopth_gdscount(odritem.getOdrdtl_gdscount());
	odrth.setOdrshopth_money(odritem.getOdrdtl_totalmoney());
	odrth.setOdrshopth_thtype(new Long(req_thtype));
	odrth.setOdrshopth_paytype(new Long(req_paytype));
	odrth.setOdrshopth_thwhy(req_thwhy);
	odrth.setOdrshopth_memo(req_memo);
	odrth.setOdrshopth_status(new Long(0));
	odrth.setOdrshopth_createdate(new Date());
	odrth=(OdrShopTh)Tools.getManager(OdrShopTh.class).create(odrth);
		if(odrth.getId()!=null){
			out.print("{\"success\":true,\"message\":\"审请退换货成功，我们会尽快处理您的订单！\"}");
		    return;
		}
		else
		{
			out.print("{\"success\":false,\"message\":\"审请退换货失败，请稍后重试！\"}");
		    return;
		}
		
	}
	catch(Exception e){
		out.print("{\"success\":false,\"message\":\"审请退换货出错，请稍后重试！\"}");
	    return;
	}
  }else{
	  out.print("{\"success\":false,\"message\":\"审请退换货出错,您已经操作过退换货！\"}");
	    return;
  }
	}else{
		out.print("{\"success\":false,\"message\":\"审请退换货出错了，请稍后重试！\"}");
	    return;
	}

%>