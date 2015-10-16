<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,java.util.regex.*"%><%@include file="/html/header.jsp" %>
<%
JSONObject json = new JSONObject();
Map<String,Object> map = new HashMap<String,Object>();
String id=request.getParameter("id");
Product p=ProductHelper.getById(id);
if(p==null){
	json.put("pstatus", "0");
	return;
}else{
	String reg = "width=?.*?(\\s+)|height=?.*?(\\s+)|WIDTH\\s*\\:?.*?(\\;+)|width\\s*\\:?.*?(\\;+)";
	map.put("pstatus", "1");
	map.put("gdsid", id);
	map.put("gdsjtxt",p.getGdsmst_briefintrduce());
	map.put("gdsdetail", p.getGdsmst_detailintruduce().replaceAll (reg, "$1").replace("<br>", "").replace("<BR>", ""));
}
out.print(JSONObject.fromObject(map));
%>