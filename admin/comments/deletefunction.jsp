<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%><%
 if(!Tools.isNull(request.getParameter("commentid"))){
	 Comment comment=CommentHelper.getById(request.getParameter("commentid"));
	 comment.setGdscom_status(new Long(3));
	 Tools.getManager(Comment.class).clearListCache(comment);
		if(Tools.getManager(Comment.class).update(comment, true)){
		 out.print("1");
	 }else{
		 out.print("0");
	 }
 }
%>