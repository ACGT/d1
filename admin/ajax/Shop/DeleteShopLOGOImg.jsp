<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>

<%
String sid="";
String img="";
if(request.getParameter("sid")!=null)
{
	sid=request.getParameter("sid");
}
if(Tools.isNull(sid)){
	out.print("{\"succ\":false,message:\"商户信息id不能为空！\"}");
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
	sif.setShopinfo_bigimg("");
	if(Tools.getManager(ShopInfo.class).update(sif, true)){
		out.print("{\"succ\":true,message:\"删除招牌背景图成功！\"}");
	    return;
	}
	
	else{
		out.print("{\"succ\":false,message:\"删除招牌背景图失败！\"}");
		return;
	}
}
catch(Exception e){
	//out.print(e.getMessage());
	out.print("{\"succ\":false,message:\"添加招牌背景图出错，请稍后重试！\"}");
    return;
}

%>