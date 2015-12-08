<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<%  
	String backurl = request.getParameter("url");
	if(Tools.isNull(backurl)){
		backurl = request.getHeader("referer");
		if(Tools.isNull(backurl)){
			backurl = "/";
		}
	}
	backurl=backurl.replace("#", "");
	String act=request.getParameter("act");
	String infos="";
	if("post".equals(request.getMethod().toLowerCase())&&"update".equals(act))
	{
		String password=request.getParameter("password");
		String password1=request.getParameter("password2");
		String oldpassword=request.getParameter("oldpassword");
		
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
			}
			
			lUser.setMbrmst_passwd(MD5.to32MD5(password));
			lUser.setMbrmst_pwd(MD5.to32MD5(password));
			if(Tools.getManager(User.class).update(lUser, false)){
				response.sendRedirect("upwdsucss.jsp");
			}
			else{
				infos="修改密码失败，请稍后重试";
			}
		}
	}
	%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—修改密码</title>
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, hr, pre, form,
	fieldset, input, textarea, p, label, blockquote, th, td, button, span {
	padding: 0;
	margin: 0;
}

body {
	background: #fff;
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 21px;
	padding-left: 5px;
}

ul {
	list-style: none;
	padding: 0px;
}

img {
	border: none;
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

.top {
	margin-top: 3px;
}

.top ul li {
	float: left;
	border-bottom: solid 1px #000;
}

.top ul li a {
	color: #000;
}

.top ul li a:hover {
	color: #aa2e44;
}
</style>
</head>

<body>
	<!-- 头部 -->
	<%@ include file="/wap/inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>修改密码 <br />
		</div>
		<span style="color: #f00"><%= infos  %></span>
		<form name="form_update" id="form_update"
			action="/wap/user/updatepassword.jsp?act=update" method="post">

			<table border="0" cellspacing="0" cellpadding="0" class="t_update">
				<tr>
					<td>&nbsp;输入原密码：</td>
				</tr>
				<tr>
					<td>&nbsp;<input type="password" id="oldpassword"
						name="oldpassword" /></td>
				</tr>

				<tr>
					<td>&nbsp;请输入新密码(6-14位)：</td>
				</tr>
				<tr>
					<td>&nbsp;<input type="password" name="password" id="password"
						maxlength="14" />

					</td>
				</tr>

				<tr>
					<td>&nbsp;请再次输入新密码：</td>
				</tr>
				<tr>
					<td>&nbsp;<input type="password" name="password2"
						id="password2" maxlength="14" /></td>
				</tr>
				<tr height="10">
					<td><font color="#c2c2c2">密码长度6-14位，请正确填写</font></td>
				</tr>


				<tr height="10">
					<td>&nbsp;<input type="submit" value="提&nbsp;交"
						style="padding: 3px;" /></td>
				</tr>

			</table>
		</form>



	</div>

	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>
