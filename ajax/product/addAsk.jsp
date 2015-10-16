<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
String gdsask_mbrid = "0";//会员号 //如果未登录咨询，则为游客
String gdsask_uid = "游客";//登录名

if(lUser != null){
	gdsask_mbrid = lUser.getId();
	gdsask_uid = lUser.getMbrmst_uid();
}
String gdsask_gdsid = request.getParameter("gdsask_gdsid");

Product product = ProductHelper.getById(gdsask_gdsid);
if(product == null){
	out.print("{\"success\":false,\"message\":\"找不到您要咨询的物品信息！\"}");
	return;
}
String gdsask_gdsname = product.getGdsmst_gdsname();
String gdsask_type = request.getParameter("gdsask_type");
if(!Tools.isMath(gdsask_type)){
	out.print("{\"success\":false,\"message\":\"您还没有选择咨询类型！\"}");
	return;
}
String gdsask_content = request.getParameter("gdsask_content");
if(gdsask_content == null){
	out.print("{\"success\":false,\"message\":\"您还没有填写咨询内容！\"}");
	return;
}
GoodsAskCache gac = new GoodsAskCache();
gac.setGdsask_content(gdsask_content);
gac.setGdsask_createdate(new Date());
gac.setGdsask_gdsid(gdsask_gdsid);
gac.setGdsask_gdsname(gdsask_gdsname);
gac.setGdsask_mbrid(new Long(gdsask_mbrid));
gac.setGdsask_status(new Long(0));
gac.setGdsask_type(new Long(gdsask_type));
gac.setGdsask_uid(gdsask_uid);
gac = (GoodsAskCache)Tools.getManager(GoodsAskCache.class).create(gac);
if(gac != null && gac.getId() != null){
	out.print("{\"success\":true,\"message\":\"咨询提交成功，请耐心等待回复。我们的回复时间为每天9:00-18:00。\"}");
	return;
}else{
	out.print("{\"success\":false,\"message\":\"咨询提交出错，请稍后再试！\"}");
	return;
}
%>