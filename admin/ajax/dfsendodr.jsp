<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkdfmng.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
String shipname = request.getParameter("shipname");
String shipcode = request.getParameter("shipcode");
String odrid=request.getParameter("odrid");
String shopCode=session.getAttribute("dfshopcode").toString();
String shopusr=session.getAttribute("dfadmin").toString();
if(Tools.isNull(odrid)||Tools.isNull(shipname)||Tools.isNull(shipcode)){
	out.print("{\"code\":1,message:\"发货快递单号不能为空！\"}");
	return;
}
OrderBase ob=OrderHelper.getById(odrid);
if(ob!=null&&shopCode.equals(ob.getOdrmst_sndshopcode())){
boolean  sendflag=OrderHelper.sendodr(odrid, shipname, shipcode, shopusr, shopCode);
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