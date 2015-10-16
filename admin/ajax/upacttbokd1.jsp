<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkshop.jsp"%>
<%
String actid=request.getParameter("actid");
String flag=request.getParameter("flag");
if(Tools.isNull(actid)){
	out.print("{\"code\":0,message:\"处理失败！\"}");
	return;
}
String shopCode=session.getAttribute("shopcodelog").toString();
D1ActTb  acttb=(D1ActTb)Tools.getManager(D1ActTb.class).get(actid);

if(acttb!=null){
	if(!shopCode.equals(acttb.getD1acttb_shopcode())){
		out.print("{\"code\":0,message:\"处理失败，请联系管理员！\"}");
	    return;
	}
	acttb.setD1acttb_shmn("test");
	acttb.setD1acttb_shdate(new Date());
	if(Tools.parseInt(flag)==1){
	acttb.setD1acttb_status(new Long(1));	
	}else{
	acttb.setD1acttb_status(new Long(-1));
	}
	Tools.getManager(D1ActTb.class).update(acttb, true);
	out.print("{\"code\":1,message:\"处理成功！\"}");
	return;
}else{
	out.print("{\"code\":0,message:\"处理失败！\"}");
}
%>