<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/inc/header.jsp"%>
<%!
 private static long getOrderPoint(String mbrid, String orderid){
		long orderpint=0;
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("usrpoint_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("usrpoint_odrid", orderid));
	clist.add(Restrictions.eq("usrpoint_type", new Long(2)));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.desc("usrpoint_createdate"));
	List<BaseEntity> list = Tools.getManager(UsrPoint.class).getList(clist, olist, 0, 1000);
	if(list==null||list.size()==0)return orderpint;
	for(BaseEntity be:list){
		orderpint+=((UsrPoint)be).getUsrpoint_score().longValue();
	}
	return orderpint;
}
%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "0");
	out.print(json);
	return;
}
String odrid=request.getParameter("odrid");
if(odrid==null){
	json.put("status", "0");
	out.print(json);
	return;
}
long orderpoint = getOrderPoint(lUser.getId(), odrid);
	json.put("status", "1");
	json.put("ordercom", orderpoint);
	out.print(json);
 
%>