<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%
String pwd=request.getParameter("pwd");
String uid=request.getParameter("uid");

if(Tools.isNull(pwd) ||  pwd.length()< 6 || pwd.length()>14){
	out.print("-2");
	return;
}

User user=UserHelper.getByUsername(uid);
if(user==null)
{
	out.print("-4"); 
	return;
	}
user.setMbrmst_passwd(MD5.to32MD5(pwd));
user.setMbrmst_pwd(MD5.to32MD5(pwd));
if(Tools.getManager(User.class).update(user, true)){
	out.print("1"); 
	return;
}else{
	out.print("0"); 
	return;
}
%>