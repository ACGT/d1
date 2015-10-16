<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%
if(lUser != null){
	response.sendRedirect("/wap/user/");
	return;
}


String backurl = request.getParameter("url");
if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/wap/user/";
	}
}
//System.out.print(backurl);

   String erroinfo="";
   String rec=request.getParameter("rec");
   
   if("post".equals(request.getMethod().toLowerCase())&&rec.equals("login")) 
   {
	   
	   String uid=request.getParameter("uid");
	   String password=request.getParameter("pwd");
	   if(uid.length()==0&&password.length()>0)
	   {
		   erroinfo="用户名/邮箱不能为空";
	   }
	   if(password.length()==0&&uid.length()>0)
	   {
		   erroinfo="密码不能为空";
	   }
	   if(password.length()==0&&uid.length()==0)
	   {
		   erroinfo="用户名/邮箱且密码不能为空";
	   }
	   if(uid!=null&&uid.length()>0&&password!=null&&password.length()>0)
	   {
		 //开始认证。
		   User user = UserHelper.getByUsername(uid);
		   if(user == null){
			   erroinfo="用户名/Email不正确！";
		   }
		   else
		   {
			   if(!MD5.to32MD5(password).equals(user.getMbrmst_passwd())){
			   	erroinfo="密码不正确！";
			   }
			   else
			   {
			       if(erroinfo.equals(""))
			       {
				     UserHelper.setLoginUserId(session,user.getId());
				   //登录成功处理。
					   //LoginLogHelper.createLog(user);
				      if(backurl.indexOf("/wap/resetpwdsucc.jsp")<0)
				      {
				       response.sendRedirect(backurl);
				      }
				      else
				      {
				    	  response.sendRedirect("http://m.d1.cn");
				      }
			       }
			   }
		   }
	
		   
	   }
   }
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>D1优尚网-手机版-登录</title>
<style type="text/css">
    body{ background:#fff;font:14px Arial,"微软雅黑";color:#4b4b4b; padding-bottom:15px; line-height:18px;}
    a {text-decoration:none;color:#4169E1}
	a:hover {color:#aa2e44}
	.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
	img{ border:none;}
	input{ width:150px;}
</style>
</head>
<body>
<div>
    <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>>登录
    <br/>
    </div>
    <a href="/mindex.jsp"><img src="http://images.d1.com.cn/wap/newlogo.jpg" /></a>
    <br/>
    <font color="red">如您已在电脑上注册，可直接登录。</font>
    <br/>
    <form id="login" method="post" action="login.jsp?rec=login">
    <input type="hidden" name="url" value="<%=backurl %>" />  
    
    <span id="erroinfo" style=" color:red; font-weight:bold;"><%= erroinfo %></span><br/>
            邮箱/用户名/手机号码<br/>
         <input type="text" id="uid" name="uid"></input><br/>密码<br/>
         <input type="password" id="pwd" name="pwd"></input><br/>
         <input type="submit" style=" backgroud-color:#6495ED; color:#333; padding:3px; width:75px; margin-top:5px; font-size:13px;" value="登&nbsp;录" />
         <br/>
    </form>
         <a href="regist.jsp">免费注册</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="/wap/forgetpwd.jsp">忘记密码</a>
         <br/>
         <br/>
         1、如果您已经在电脑上注册D1优尚网，请直接登录。<br/>
         2、如果你还未注册，可以在手机上<a href="regist.jsp">免费注册</a>。
         <br/>
         <br/>
         <a href="/mindex.jsp">首页</a>&nbsp;&nbsp;<a href="/wap/flow.jsp">购物车</a><br/>
         <a href="login.jsp">登录</a>&nbsp;&nbsp;<a href="regist.jsp">注册</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a>
         <br/>
	切换到<a href="http://www.d1.com.cn">电脑版</a>
	<br/>京ICP证030072号
</div>
</body>
</html>


