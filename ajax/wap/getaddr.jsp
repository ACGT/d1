<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "-1");
}else{
ArrayList<UserAddress> list = UserAddressHelper.getUserAddressList(lUser.getId());
	if(list!=null&&list.size()>0){
		JSONArray jsonitemarr = new JSONArray();
		json.put("status", "1");
		int i=0;
		String rprovince,rcity;
		for(UserAddress ua:list){
			JSONObject jsonitem = new JSONObject();
			rprovince =  ProvinceHelper.getProvinceNameViaId(ua.getMbrcst_provinceid()+"");
			rcity = CityHelper.getCityNameViaId(ua.getMbrcst_cityid()+"");
			jsonitem.put("rid",ua.getId());
			jsonitem.put("rname",ua.getMbrcst_name());
			jsonitem.put("rprov",rprovince);
			jsonitem.put("rcity",rcity);
			jsonitem.put("raddress",ua.getMbrcst_raddress());
			jsonitem.put("rphone",ua.getMbrcst_rphone());
			jsonitem.put("rtel",ua.getMbrcst_rtelephone());
			jsonitem.put("rflag",ua.getMbrcst_id());
			jsonitemarr.add(jsonitem);
		}
		json.put("addresss",jsonitemarr);
	}else{
		json.put("status", "0");
	}
}
	out.print(json);
%>