<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>

<%
String sid="";
String img="";
if(request.getParameter("sid")!=null)
{
	sid=request.getParameter("sid");
}
if(request.getParameter("img")!=null)
{
	img=request.getParameter("img");
}
if(Tools.isNull(sid)){
	out.print("{\"succ\":false,message:\"商户信息id不能为空！\"}");
    return;
}
ShopInfo sif=(ShopInfo)Tools.getManager(ShopInfo.class).get(sid);
if(sif==null && Integer.valueOf(sid)!=-1){
	out.print("{\"succ\":false,message:\"该商户信息不存在！\"}");
    return;
}
if(Integer.valueOf(sid)!=-1 && !sif.getShopinfo_shopcode().equals(session.getAttribute("shopcodelog").toString())){
	out.print("{\"succ\":false,message:\"您没有权限执行此操作！\"}");
    return;
}
try{
	if(Integer.valueOf(sid)==-1){//添加
		sif = new ShopInfo();
		sif.setShopinfo_bigimg(img);
		sif.setShopinfo_shopcode(session.getAttribute("shopcodelog").toString());
    	sif.setShopinfo_createdate(new Date());
    	ShopInfo si_info = (ShopInfo)Tools.getManager(ShopInfo.class).create(sif);
    	if(si_info.getId() != null ){
    		out.print("{\"succ\":true,shop_id:\""+si_info.getId()+"\",message:\"添加招牌背景图成功！\"}");
			//out.print("{\"succ\":true,message:\"添加招牌背景图成功！\"}");
		    return;
		}else{
			out.print("{\"succ\":false,message:\"添加招牌背景图失败！\"}");
			return;
		}
	}else{
		sif.setShopinfo_bigimg(img);
		if(Tools.getManager(ShopInfo.class).update(sif, true)){
			out.print("{\"succ\":true,message:\"修改招牌背景图成功！\"}");
		    return;
		}else{
			out.print("{\"succ\":false,message:\"修改招牌背景图失败！\"}");
			return;
		}
	}
    
}
catch(Exception e){
	//out.print(e.getMessage());
	out.print("{\"succ\":false,message:\"添加招牌背景图出错，请稍后重试！\"}");
    return;
}

%>