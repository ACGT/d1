<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.bean.id.SequenceIdGenerator"%><%@include
	file="/inc/header.jsp"%>
<%

String info="";
String tele="";
if(request.getParameter("tele")!=null&&request.getParameter("tele").length()>0)
{
	tele=request.getParameter("tele").trim();
}
String sct=request.getParameter("sign");
if("post".equals(request.getMethod().toLowerCase())&&("update").equals(sct))
{
	
	String pwd=request.getParameter("password");
	if(pwd==null||pwd.length()==0)
	{
		info="密码不能为空！";
	}
	else if(pwd.length()<6||pwd.length()>14)
	{
		info="密码长度不正确！";
	}
	else if(pwd.indexOf(" ")>=0)
	{
		info="密码中不能包含空格！";
	}
	else
	{
		

		User user=UserHelper.getByUsername(tele);
		if(user==null)
		{
			info="该手机没有注册为会员！";
		}
		else
		{
			user.setMbrmst_passwd(MD5.to32MD5(pwd));
			user.setMbrmst_pwd(MD5.to32MD5(pwd));
			if(Tools.getManager(User.class).update(user, true)){
				response.sendRedirect("resetpwdsucc.jsp");
			}else{
				info="修改失败！";
			}
		}
	}
}



%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>D1优尚网-手机版-取回密码</title>
<style type="text/css">
body {
	background: #fff;
	font: 14px Arial, "微软雅黑";
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

.clear {
	clear: both;
	font-size: 1px;
	line-height: 0;
	height: 0px;
	*zoom: 1;
}

img {
	border: none;
}

input {
	width: 150px;
}

.red {
	color: #f00;
}
</style>
</head>

<body>
	<div style="padding-left: 4px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>>取回密码 <br />
		</div>
		<a href="mindex.jsp"><img
			src="http://images.d1.com.cn/wap/newlogo.jpg" /></a> <br /> 第3步/共3步<br />
		<span id="erroinfo" name="erroinfo"
			style="color: red; font-weight: bold;"><%= info %></span>

		<form id="update" action="getpwd1.jsp?sign=update" method="post">
			<input type="hidden" id="tele" name="tele" value="<%= tele%>" />
			请设置您的新密码：
			<input type="password" id="password" name="password" maxlength="14"></input>
			<span id="pass_Notice" style="color: #f00">密码长度6-14位，支持数字、符号、字母，字母区分大小写</span>

			</br>

			<input type="submit" value="提交" style="width: 80px;" />
		</form>
		<br /> <br /> <a href="/mindex.jsp">返回首页</a>&nbsp;&nbsp;<a
			href="/wap/login.jsp">登录</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a>
		<br /> 切换到<a href="http://www.d1.com.cn">电脑版</a> <br />京ICP证030072号
	</div>
</body>
</html>


