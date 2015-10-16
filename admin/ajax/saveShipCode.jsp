<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
if(session.getAttribute("type_flag")!=null){
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	String powername = "d1odr_send";
	boolean is_power = chk_admpower(userid,powername);
	if(!is_power){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}
%>
<%
String shipname = request.getParameter("shipname");
//System.out.println(shipname);
String shipcode = request.getParameter("shipcode");
//System.out.println(shipcode);
String odrid=request.getParameter("odrid");
String shopCode=session.getAttribute("shopcodelog").toString();
String shopusr=session.getAttribute("shopadmin").toString();
if(Tools.isNull(odrid)||Tools.isNull(shipname)||Tools.isNull(shipcode)){
	out.print("{\"code\":1,message:\"发货快递单号不能为空！\"}");
	return;
}
OrderBase ob=OrderHelper.getById(odrid);
if(ob!=null&&shopCode.equals(ob.getOdrmst_sndshopcode())){
boolean  sendflag=OrderHelper.saveShipCode(odrid, shipname, shipcode);
if(sendflag){
	out.print("{\"code\":1,message:\"发货成功！\"}");
	return;
}else{
	out.print("{\"code\":1,message:\"发货失败！\"}");
	return;
}
}else{
	out.print("{\"code\":1,message:\"发货失败！\"}");
	return;
}
%>