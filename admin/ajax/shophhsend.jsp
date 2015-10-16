<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkshop.jsp"%>
<%//String userid=session.getAttribute("admin_mng").toString();
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
String odrthid=request.getParameter("odrthid");
String shipname=request.getParameter("shipname");
String shipcode=request.getParameter("shipcode");
if(Tools.isNull(odrthid)){
	out.print("{\"code\":0,message:\"换货单错误！\"}");
	return;
}
if(Tools.isNull(shipname)||Tools.isNull(shipcode)){
	out.print("{\"code\":0,message:\"换快递或货单号不能为空！\"}");
	return;
}
OdrShopTh  odrshopth=(OdrShopTh)Tools.getManager(OdrShopTh.class).get(odrthid);

if(odrshopth!=null){
if (odrshopth.getOdrshopth_status().longValue()==1&&odrshopth.getOdrshopth_thtype().longValue()==2){
	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
	
	OrderBase order = (OrderBase)OrderHelper.getById(odrshopth.getOdrshopth_odrid());
	order.setOdrmst_internalmemo("商户已换货("+format.format(new Date())+")<br>"+order.getOdrmst_internalmemo());
	Tools.getManager(order.getClass()).update(order,true);
	
	odrshopth.setOdrshopth_status(new Long(2));
	odrshopth.setOdrshopth_shipname(shipname);
	odrshopth.setOdrshopth_shipcode(shipcode);
	odrshopth.setOdrshopth_shipdate(new Date());
	Tools.getManager(OdrShopTh.class).update(odrshopth, true);
	out.print("{\"code\":1,message:\"处理换货单成功！\"}");
	return;
}else{
	out.print("{\"code\":0,message:\"处理换货单失败！\"}");
	return;
}
}else{
	out.print("{\"code\":0,message:\"货单号不存在！\"}");
}
%>