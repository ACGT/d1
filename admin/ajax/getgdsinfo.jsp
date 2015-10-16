<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/admin/chkrgt.jsp"%>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "sg_admin");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>
<% 
String gdsid=request.getParameter("gdsid");
if(Tools.isNull(gdsid)){
	out.print("{\"success\":false,message:\"商品ID不能为空！\"}");
    return;
}
Product p=ProductHelper.getById(gdsid);
if(p==null){
	out.print("{\"success\":false,message:\"商品ID不存在！\"}");
    return;
}
Map<String,Object> map = new HashMap<String,Object>();
map.put("gname",p.getGdsmst_gdsname());
map.put("gimg",!Tools.isNull(p.getGdsmst_img310())?p.getGdsmst_img310():"");
map.put("success",new Boolean(true));

out.print(JSONObject.fromObject(map));
%>