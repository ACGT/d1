<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%><%
String brand = request.getParameter("brand");
if(brand != null){
	ArrayList<Gdsser> list =GdsserHelper.getGdsserByBrandid(brand);
	if(list != null && !list.isEmpty()){
		StringBuilder sb = new StringBuilder();
		for(Gdsser g : list){
			sb.append(g.getId()).append("|").append(g.getGdsser_title()).append(",");
		}
		int length = sb.length();
		if(length>0){
			sb.delete(length-1,length);
		}
		out.print(sb.toString());
	}else{
		out.print("-1");
	}
}