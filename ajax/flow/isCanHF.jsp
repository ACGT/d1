<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%@include file="../islogin.jsp" %><%
String id = request.getParameter("MbrcstID");
UserAddress address = UserAddressHelper.getById(id);
if(address == null){
	out.print("{\"success\":false,\"message\":\"找不到收货人！\"}");
	return;
}
if(!lUser.getId().equals(String.valueOf(address.getMbrcst_mbrid()))){//不是一个人
	out.print("{\"success\":false,\"message\":\"收货人地址错误！\"}");
	return;
}
long cityId = Tools.longValue(address.getMbrcst_cityid());
if(cityId <= 0){
	out.print("{\"success\":false,\"message\":\"查询收货人城市出错！\"}");
	return;
}
//没有团购物品才判断是否能够货到付款
//城市是否支持货到付款
int iCanHF = 0;

if(!CartHelper.hasGroupProduct(request,response)){
	if(CityShipFeeHelper.getCityCanHF(cityId)){//并且支持货到付款的
		iCanHF = 1;
	}
}

out.print("{\"success\":true,\"message\":\"查询成功！\",\"CanHF\":"+iCanHF+"}");
return;
%>