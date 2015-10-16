<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkkfmng.jsp"%>
<%

String odrid = request.getParameter("odrid");
String zpgdsid = request.getParameter("zpgdsid");
String gdssku = request.getParameter("gdssku");



if(Tools.isNull(odrid)||Tools.isNull(zpgdsid)){
	out.print("{\"code\":1,\"message\":\"订单号错误或商品编号不能为空！\"}");
	return;
}
Product p=ProductHelper.getById(zpgdsid);
if(p==null||(!Tools.isNull(p.getGdsmst_skuname1())&&Tools.isNull(gdssku))){
	out.print("{\"code\":1,\"message\":\"商品ID错误或商品SKU不能为空！\"}");
	return;
}
if(Tools.isNull(p.getGdsmst_skuname1()))gdssku="";

OrderBase order = (OrderBase)Tools.getManager(OrderMain.class).get(odrid);

if(order!=null&&order.getOdrmst_orderstatus().longValue()==2){
try{
	OdrTmLog otlog =new OdrTmLog();
	String muser=session.getAttribute("kfadmin").toString();
	otlog.setOdrtmlog_odrid(odrid);
	otlog.setOdrtmlog_user(muser);
	otlog.setOdrtmlog_type("添加赠品信息");
	String nlog="赠品ID："+zpgdsid+"+SKU："+gdssku;

	otlog.setOdrtmlog_oldtxt(nlog);
	otlog.setOdrtmlog_ntxt(nlog);
	Tools.getManager(OdrTmLog.class).create(otlog);
	OrderTmallService os = (OrderTmallService)Tools.getService(OrderTmallService.class);
	os.addzp(odrid, 1, zpgdsid, gdssku);
	out.print("{\"code\":1,\"message\":\"添加赠品成功！\"}");
	return;
}
catch(Exception ex)
{
	//  ex.printStackTrace();
	  out.print("{\"code\":1,\"message\":\"添加赠品失败！\"}");
	  return;
}


}else{
	out.print("{\"code\":1,message:\"添加赠品失败！\"}");
	return;
}

%>