<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.bean.id.SequenceIdGenerator"%><%@include
	file="/inc/header.jsp"%>
<%

//注册页面不需要缓存。
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
String act = request.getParameter("rec_act");
String info="";

String backurl = request.getParameter("url");
if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/";
	}
}

if("post".equals(request.getMethod().toLowerCase()) && "getcode".equals(act)){//注册
	String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
	String yzcode=request.getParameter("yzcode");
	String phone = request.getParameter("phone");
	if(phone == null||phone.length()==0) 
	{
	  info="获取验证码的手机号码不能为空！";
	}
	else if(!Tools.isMobile(phone)){
		info="手机号码格式有误，请修改";
	}else if(yzcode == null || vImageCode==null|| !vImageCode.equals(yzcode)){
		info="验证码输入错误，请重试！";
	}else
	{
		User user = UserHelper.getByUsername(phone);
		if(user == null){
			info="该手机号还没有注册会员，请更换一个";
		}
		else
		{
			response.sendRedirect("/wap/getpwd.jsp?tele="+phone+"&sign=vcode&yzcode="+yzcode+"");
		}
	}
	
}


if("post".equals(request.getMethod().toLowerCase()) && "s".equals(act))
{
	String tele=request.getParameter("tele");
	String code=request.getParameter("code");
	if(tele==null||tele.length()==0)
	{
		info="手机号码不能为空！";
	}
	else if(!Tools.isMobile(tele))
	{
		info="手机号码格式不正确！";
	}
	else if(code==null||code.length()==0)
	{
		info="验证码不能为空！";
	}
	else if(code.length()<4||code.length()>6)
	{
		info="验证码格式不正确！";
	}
	else
	{
		User user=UserHelper.getByUsername(tele);
		if(user==null)
		{
			info="该手机号还没有注册为会员！";
		}
		else
		{
			PhoneCode pc=PhoneCodeHelper.getPhoneCodeByTele(tele);
			if(pc==null)
			{
				info="该手机号还没有获取验证码！";
			}
			else
			{
				if(!pc.getPhonecode_code().equals(code)){
					info="验证码输入不正确！";
				}
				else
				{
					response.sendRedirect("/wap/getpwd1.jsp?tele="+tele);
				}
			}
		}
	}
}


%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>D1优尚网-手机版-取回密码</title>
<script type="text/javascript" src="/res/wap/js/jquery-1.7.min.js"></script>
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
			src="http://images.d1.com.cn/wap/newlogo.jpg" /></a> <br /> 第1步/共3步<br />
		<span id="erroinfo" style="color: red; font-weight: bold;"><%= info %></span>
		<form id="get" action="forgetpwd.jsp?rec_act=getcode" method="post">
			输入手机号：
			<br />
			<input type="text" id="phone" name="phone" maxlength="64"></input>
			<div class="yztxt">
				<input name="yzcode" id="yzcode" placeholder="请输验证码"
					class="yzcode mgt10" type="text"> <img id="vPic"
					class="vPic"
					style="vertical-align: bottom; cursor: pointer; margin-top: 3px;"
					width="86" height="36" /> <a class="ref"
					href="javascript:getyzcode();">刷新</a>
			</div>
			<input type="submit" id="regist" value="获取验证码" id="regist"
				style="width: 90px;" />
		</form>
		<br />
		<form id="s" action="forgetpwd.jsp?rec_act=s" method="post">
			<div style="background: ##E0FFFF">如果您已收到短信激活码，可直接输入"手机号"和"验证码"取回密码</div>
			手机号：
			<br />
			<input type="text" id="tele" name="tele" maxlength="64"></input>

			<br /> 短信激活码：
			<br />
			<input type="text" id="code" name="code" maxlength="6"
				style="width: 50px;"></input>

			<br />
			<input type="submit" value="提&nbsp;交" style="width: 60px;" />
		</form>
		<a href="/wap/login.jsp">返回登录页</a> <br /> <br /> <a href="/mindex.jsp">返回首页</a>&nbsp;&nbsp;<a
			href="/wap/login.jsp">登录</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a><br />
		切换到<a href="http://www.d1.com.cn">电脑版</a> <br />京ICP证030072号
	</div>
	<script>
	function getyzcode(){

		$.ajax({
	        type: "get",
	        dataType: "json",
	        url: "/ajax/wap/getyzcode.jsp",
	        cache: false,
	        error: function(json){
	        	alert("内部错误");
	        },
	        success: function(json){
	        	
	        	$("#vPic").attr("src",json.code);
	        }
	    });

	}
	getyzcode();
	</script>
</body>
</html>