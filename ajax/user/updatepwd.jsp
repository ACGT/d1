<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
<%@include file="/inc/islogin.jsp"%>
<% 
//检查密码
	String oldpwd=request.getParameter("oldpwd");
	String pwd=request.getParameter("pwd");
	String repwd=request.getParameter("repwd");
	
	if(Tools.isNull(oldpwd)){
		 out.print("-4");
	  	return;
	}
	
	if(Tools.isNull(pwd) ||  pwd.length()< 6 || pwd.length()>14){
		 out.print("-2");
	  	   return;
	}

	if(!pwd.equals(repwd)){
		 out.print("-3");
	  	   return;
	}

	if(!MD5.to32MD5(oldpwd).equals(lUser.getMbrmst_passwd())){
		 out.print("-1");
 	   return;
	}
	
	lUser.setMbrmst_passwd(MD5.to32MD5(pwd));
	lUser.setMbrmst_pwd(MD5.to32MD5(pwd));
	if(Tools.getManager(User.class).update(lUser, false)){
		out.print("1"); 
		return;
	}
	else{
		out.print("0"); 
		return;
	}
%>