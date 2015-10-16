<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%@page	import=" java.awt.image.BufferedImage,javax.imageio.ImageIO,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
String id=request.getParameter("id");
String t=request.getParameter("type");
String gdsid=request.getParameter("gdsid");
if(Tools.isNull(id)){
	out.print("{\"success\":false,message:\"参数不正确！\"}");
	return;
}
if(Tools.isNull(t)){
	out.print("{\"success\":false,message:\"参数不正确！\"}");
	return;	
}
if(Tools.isNull(gdsid))
{
	out.print("{\"success\":false,\"message\":\"商品id不存在！\"}");
	return;
}
Product product=ProductHelper.getById(gdsid);
if(product==null){
	out.print("{\"success\":false,\"message\":\"商品不存在！\"}");
	return;
}else{
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	boolean is_edit = chk_admpower(userid,"d1shop_gdsedit");
	boolean is_add =  chk_admpower(userid,"d1shop_gdsadd");
	if(is_add == true && is_edit==false){//有录入权限没有维护权限
		if(product.getGdsmst_validflag()!=null && product.getGdsmst_validflag()!=0){
			out.print("{\"success\":false,\"message\":\"录入员只能修改录入待上架的商品！\"}");
			return;
		}
	}
}
//写入数据库
try{
	if(!t.equals("6")){
		GdsImgDtl gds=new GdsImgDtl();
		gds=(GdsImgDtl)Tools.getManager(GdsImgDtl.class).get(id);
		if(gds==null||Tools.isNull(gds.getId())){
			out.print("{\"success\":false,message:\"细节图不存在！\"}");
			return;
		}
		if(Tools.getManager(GdsImgDtl.class).delete(gds))
		{
		
			out.print("{\"success\":true,\"message\":\"删除细节图成功！\"}");
			return;	
		
		}
		else
		{
			out.print("{\"success\":false,\"message\":\"删除细节图失败！\"}");
			return;	
		}
	
	}
	else{
		GdsCutImg gci=new GdsCutImg();
		gci=(GdsCutImg)Tools.getManager(GdsCutImg.class).get(id);
		if(gci==null||Tools.isNull(gci.getId())){
			out.print("{\"success\":false,message:\"平铺图不存在！\"}");
			return;
		}
		if(Tools.getManager(GdsCutImg.class).delete(gci))
		{
		
			out.print("{\"success\":true,\"message\":\"删除平铺图成功！\"}");
			return;	
		
		}
		else
		{
			out.print("{\"success\":false,\"message\":\"删除平铺图失败！\"}");
			return;	
		}
	}
}
catch(Exception e){
	//out.print(e.getMessage());
	out.print("{\"succ\":false,message:\"删除图片出错，请稍后重试！\"}");
    return;
}
%>