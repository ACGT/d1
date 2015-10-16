<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
String ProvinceID = request.getParameter("ProvinceID");
if(ProvinceID != null){
	ArrayList<City> list = CityHelper.getCitysViaProvinceId(ProvinceID);
	if(list != null && !list.isEmpty()){
		StringBuilder sb = new StringBuilder();
		for(City city : list){
			sb.append(city.getId()).append("|").append(city.getCtymst_name()).append(",");
		}
		int length = sb.length();
		if(length>0){
			sb.delete(length-1,length);
		}
		out.print(sb.toString());
	}else{
		out.print("-1");
	}
}else{
	List list = ProvinceHelper.getAllProvince();
	if(list != null && !list.isEmpty()){
		StringBuilder sb = new StringBuilder();
		int size = list.size();
		for(int i=0;i<size;i++){
			Province pro = (Province)list.get(i);
			sb.append(pro.getId()).append("|").append(pro.getPrvmst_name()).append(",");
		}
		int length = sb.length();
		if(length>0){
			sb.delete(length-1,length);
		}
		out.print(sb.toString());
	}else{
		out.print("-");
	}
}
%>