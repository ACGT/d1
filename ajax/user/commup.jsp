<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>

<%
if(lUser==null||!lUser.getMbrmst_uid().trim().equals("gjltest")) {
	response.setHeader("_d1-Ajax","2");
	%>$.inCart.close();Login_Dialog();<%
	return;
}
String cid = request.getParameter("comid"); 
Comment com=CommentHelper.getById(cid);
if(com!=null){
	com.setGdscom_status(new Long(0));
	Tools.getManager(Comment.class).update(com, false);
	out.print("{\"code\":0,\"message\":\"更新成功！\"}");
	return;
}else{
	out.print("{\"code\":0,\"message\":\"更新失败！\"}");
	return;
}
%>