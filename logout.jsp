<%@ page contentType="text/html; charset=UTF-8"%><%@include file="inc/header.jsp"%><%
UserHelper.loginout(request,response);
//session.setAttribute("showmsg","");
String refererUrl73934y = request.getHeader("Referer") ;
if(refererUrl73934y==null){
	refererUrl73934y = request.getHeader("referer");
}
Cookie showmsgCookie = new Cookie("showmsg", null);
showmsgCookie.setPath("/");
showmsgCookie.setMaxAge(0);//直接过期
response.addCookie(showmsgCookie);
if(Tools.isNull(refererUrl73934y))refererUrl73934y="/";
response.sendRedirect(refererUrl73934y);
return;
%>