<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="../islogin.jsp" %><%
String id = request.getParameter("id");
UserAddress address = UserAddressHelper.getById(id);
if(address == null){
	out.print("{\"success\":false,\"message\":\"找不到收货人！\"}");
	return;
}
if(!lUser.getId().equals(String.valueOf(address.getMbrcst_mbrid()))){//不是一个人
	out.print("{\"success\":false,\"message\":\"您没有权限进行操作！\"}");
	return;
}
Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(true));
map.put("Name",address.getMbrcst_name());
map.put("Sex",address.getMbrcst_rsex());
map.put("ProvID",address.getMbrcst_provinceid());
map.put("CityID",address.getMbrcst_cityid());
map.put("RAddress",address.getMbrcst_raddress());
map.put("RPhone",address.getMbrcst_rphone());
map.put("RTelephone",address.getMbrcst_rtelephone());
map.put("REmail",address.getMbrcst_remail());
map.put("RZipCode",address.getMbrcst_rzipcode());
map.put("is_default",address.getMbrcst_isDefault());
out.print(JSONObject.fromObject(map));
%>