<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static PromotionImagePos getById(String id){
	if(Tools.isNull(id)) return null;
	 return (PromotionImagePos)Tools.getManager(PromotionImagePos.class).get(id);
}
%><%
 if(!Tools.isNull(request.getParameter("add")) && !Tools.isNull(request.getParameter("promotionid")) && !Tools.isNull(request.getParameter("gdsid")) && !Tools.isNull(request.getParameter("x")) && !Tools.isNull(request.getParameter("y")) && !Tools.isNull(request.getParameter("x2")) && !Tools.isNull(request.getParameter("y2"))){
	 PromotionImagePos pimg=new PromotionImagePos();
	 pimg.setPromotionId(request.getParameter("promotionid"));
	 pimg.setProductId(request.getParameter("gdsid"));
	 pimg.setPos_x(Integer.valueOf(request.getParameter("x")).intValue());
	 pimg.setPos_y(Integer.valueOf(request.getParameter("y")).intValue());
	 pimg.setExt1(request.getParameter("x2").toString());
	 pimg.setExt2(request.getParameter("y2").toString());
	// pimg.setPprice(new Float(request.getParameter("price").toString()));
	 pimg=(PromotionImagePos)Tools.getManager(PromotionImagePos.class).create(pimg);
	 if(pimg!=null){
		 out.print("1");
		 return;
	 }else{
		 out.print("0");
		 return;
	 }
 }
if(!Tools.isNull(request.getParameter("id")) && !Tools.isNull(request.getParameter("isdel"))){
	PromotionImagePos pimg=getById(request.getParameter("id"));
	if(Tools.getManager(PromotionImagePos.class).delete(request.getParameter("id"))){
		 out.print("2");
	}else{
		 out.print("3");
	}
}
if(!Tools.isNull(request.getParameter("update")) && !Tools.isNull(request.getParameter("id")) && !Tools.isNull(request.getParameter("promotionid")) && !Tools.isNull(request.getParameter("gdsid")) && !Tools.isNull(request.getParameter("x")) && !Tools.isNull(request.getParameter("y")) && !Tools.isNull(request.getParameter("x2")) && !Tools.isNull(request.getParameter("y2"))){
	PromotionImagePos pimg=getById(request.getParameter("id"));
	pimg.setProductId(request.getParameter("gdsid"));
	 pimg.setPos_x(Integer.valueOf(request.getParameter("x")).intValue());
	 pimg.setPos_y(Integer.valueOf(request.getParameter("y")).intValue());
	 pimg.setExt1(request.getParameter("x2").toString());
	 pimg.setExt2(request.getParameter("y2").toString());
	// pimg.setPprice(new Float(request.getParameter("price").toString()));
	 Tools.getManager(PromotionImagePos.class).clearListCache(pimg);
	 if(Tools.getManager(PromotionImagePos.class).update(pimg, true)){
		 out.print("4");
	 }else{
		 out.print("5");
	}
}
%>