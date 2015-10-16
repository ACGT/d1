<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%><%@include file="/inc/islogin.jsp"%><% 
//检查密码
String id = (String)session.getAttribute("FindPassword");
FindPassword fp = FindPasswordHelper.getById(id);
//无权限
if(fp == null || !fp.getSelf_mbruid().equals(lUser.getId())){
	out.print("-1");
	return;
}

String pwd=request.getParameter("pwd");
String repwd=request.getParameter("repwd");

if(Tools.isNull(pwd) ||  pwd.length()< 6 || pwd.length()>14){
	out.print("-2");
	return;
}
if(!pwd.equals(repwd)){
	 out.print("-3");
  	   return;
}

lUser.setMbrmst_passwd(MD5.to32MD5(pwd));
lUser.setMbrmst_pwd(MD5.to32MD5(pwd));
if(Tools.getManager(User.class).update(lUser, false)){
	session.removeAttribute("FindPassword");
	out.print("1"); 
	return;
}else{
	out.print("0"); 
	return;
}
%>