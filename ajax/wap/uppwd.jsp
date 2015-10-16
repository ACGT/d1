<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%
JSONObject json = new JSONObject();
String infos="";
if(lUser==null){
	infos="请先登陆！";
}else{


	String password=request.getParameter("newpwd");
	String password1=request.getParameter("rnewpwd");
	String oldpassword=request.getParameter("oldpwd");
	
	if(oldpassword==null||oldpassword.length()==0)
	{
		infos="原密码不能为空";
	}
	else if(oldpassword.length()<6||oldpassword.length()>14)
	{
		infos="原密码长度不正确";
	}
	else if(password==null||password.length()==0)
	{
		infos="新密码不能为空！";
	}
	else if(password.length()<6||password.length()>14)
	{
		infos="新密码长度不正确";
	}
	else if(password1==null||password1.length()==0)
	{
		infos="确认密码不能为空";
	}
	else if(password1.length()<6||password1.length()>14)
	{
		infos="确认密码长度不对";
	}
	else if(password.indexOf(" ")>=0)
	{
		infos="新密码不能为空格";
	}
	else if(!password.equals(password1))
	{
		infos="两次密码输入不一致";
	}
	else{
		
		if(!MD5.to32MD5(oldpassword).equals(lUser.getMbrmst_passwd())){
			infos="原密码输入错误";
			json.put("status", "0");
			json.put("message", infos);
			out.print(json);
			return;
		}
		
		lUser.setMbrmst_passwd(MD5.to32MD5(password));
		lUser.setMbrmst_pwd(MD5.to32MD5(password));
		if(Tools.getManager(User.class).update(lUser, false)){
			json.put("status", "1");
			json.put("message", "修改成功");
			out.print(json);
			return;
		}
		else{
			infos="修改密码失败，请稍后重试";
		}
	}
	
}
json.put("status", "0");
json.put("message", infos);
out.print(json);
%>