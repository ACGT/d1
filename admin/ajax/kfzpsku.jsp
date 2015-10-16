<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkkfmng.jsp"%>
<%
 
String zpgdsid = request.getParameter("zpgdsid");
 


if(Tools.isNull(zpgdsid)){
	out.print("{\"code\":1,\"message\":\"商品编号不能为空！\"}");
	return;
}
Product p=ProductHelper.getById(zpgdsid);
if(p==null){
	out.print("{\"code\":1,\"message\":\"商品ID错误或商品SKU不能为空！\"}");
	return;
}
if(!Tools.isNull(p.getGdsmst_skuname1())){
	List<Sku> list=SkuHelper.getSkuListViaProductId(zpgdsid);
	StringBuilder slist=new StringBuilder();
	for(Sku s:list){
		
	if(s!=null) slist.append("{\"skuid\":"+s.getId()+",\"skuname\":\""+s.getSkumst_sku1()+"\"},");
	}
	if (slist.length()>0){
		out.print("{\"code\":0,\"message\":\"\",\"skulist\":["+slist.substring(0, slist.length()-1)+"]}");
		
	}else{
		out.print("{\"code\":3,\"message\":\"\"}");
	}
	

}else{
	out.print("{\"code\":2,\"message\":\"商品没有SKU\"}");
	return;
}

%>