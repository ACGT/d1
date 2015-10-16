<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%
String sid="";
String img="";
if(request.getParameter("sid")!=null)
{
	sid=request.getParameter("sid");
}
if(request.getParameter("con")!=null)
{
	img=request.getParameter("con");
}
if(Tools.isNull(sid)){
	out.print("{\"succ\":false,message:\"商户信息id不能为空！\"}");
    return;
}
/*
if(Tools.isNull(img)){
	out.print("{\"succ\":false,message:\"浮动广告信息不能为空！\"}");
    return;
}*/

//验证a链接是否存在外链
if(!check_url(img)){
	  out.print("{\"succ\":false,message:\"您所要保存的内容存在外链，请修改后保存！\"}");
	  return;
}

ShopInfo sif=(ShopInfo)Tools.getManager(ShopInfo.class).get(sid);
if(sif==null){
	out.print("{\"succ\":false,message:\"该商户信息不存在！\"}");
    return;
}
if(!sif.getShopinfo_shopcode().equals(session.getAttribute("shopcodelog").toString())){
	out.print("{\"succ\":false,message:\"您没有权限执行此操作！\"}");
    return;
}
try{
	sif.setShopinfo_floatcontent(img);
	if(Tools.getManager(ShopInfo.class).update(sif, true)){
		out.print("{\"succ\":true,message:\"添加浮动广告信息成功！\"}");
	    return;
	}else{
		out.print("{\"succ\":false,message:\"添加浮动广告信息失败！\"}");
		return;
	}
}catch(Exception e){
	//out.print(e.getMessage());
	out.print("{\"succ\":false,message:\"添加浮动广告信息出错，请稍后重试！\"}");
    return;
}

%>