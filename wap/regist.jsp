<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.bean.id.SequenceIdGenerator"%><%@include
	file="/inc/header.jsp"%>
<%

//注册页面不需要缓存。
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
String act = request.getParameter("act_wap");
String v=request.getParameter("v");
String tele=request.getParameter("phone")!=null&&request.getParameter("phone").length()>0?request.getParameter("phone"):"";
String backurl = request.getParameter("url");
String erroinfo="";

if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/";
	}
}
if("post".equals(request.getMethod().toLowerCase())&&"tele".equals(v))
{
   if(tele==null||tele.length()==0)
   {
	   erroinfo="手机号码不能为空！";
   }
   else if(!Tools.isMobile(tele))	
   {
	   erroinfo="手机号码格式不正确！";
   }
   else
   {
	   response.sendRedirect("/wap/registo.jsp?rec_act=getcode&tele="+tele);
   }
}



if("post".equals(request.getMethod().toLowerCase()) && "regist".equals(act)){//注册
	String phone = request.getParameter("tele");
    String code=request.getParameter("code");
    String password = request.getParameter("password");
	if(phone != null) phone = phone.trim();
	if(Tools.isNull(phone))
	{
		erroinfo="手机号码不能为空";
	}
	else if(!Tools.isMobile(phone)){
		
		erroinfo="手机号码格式有误，请修改";
	}
	else
	{
		User user = UserHelper.getByUsername(phone);
		if(user != null){
			erroinfo="手机号已被注册，请更换一个";
		}
		else
		{
			PhoneCode pc=PhoneCodeHelper.getPhoneCodeByTele(phone);
			if(pc==null)
			{
				erroinfo="该手机号还没有发送验证码";
			}
			else if(pc.getPhonecode_status().longValue()==1)
			{
				erroinfo="该手机号已被注册，请更换一个";
			}
			else if(!Tools.isNumber(pc.getPhonecode_code()))
			{
				erroinfo="输入的验证码格式错误，请重新输入";
			}
			else if(!pc.getPhonecode_code().equals(code))
			{
				erroinfo="您输入的验证码错误，请重新输入";
			}
			else if(password == null){
				erroinfo="密码不能为空";
			}
			else if(password.length()<6 || password.length()>14){
				erroinfo="登录密码不能少于6个字符且不能多于14个字符";
			}
			else if(password.indexOf(" ")>-1){
				erroinfo="密码中不能包含空格";
			}
			else
			{
					Date currDate = new Date();
					
					user = new User();
					user.setId(SequenceIdGenerator.generate("3"));
					user.setMbrmst_uid(phone);
					user.setMbrmst_passwd(MD5.to32MD5(request.getParameter("password")));
					user.setMbrmst_pwd(MD5.to32MD5(request.getParameter("password")));
					user.setMbrmst_question("");
					user.setMbrmst_answer("");
					user.setMbrmst_createdate(currDate);
					user.setMbrmst_modidate(currDate);
					user.setMbrmst_lastdate(currDate);
					//int iAtPos = email.indexOf("@");
					//if(iAtPos >= 0){
						//user.setMbrmst_name(email.substring(0,iAtPos));
					//}else{
						//user.setMbrmst_name(email);
					//}
					user.setMbrmst_name(phone);
					user.setMbrmst_visittimes(new Long(1));
					user.setMbrmst_sex(new Long(0));
					//user.setMbrmst_email(email);
					user.setMbrmst_email("");
					user.setMbrmst_hphone("");
					user.setMbrmst_usephone(phone);
					user.setMbrmst_haddr("");
					user.setMbrmst_countryid(new Long(1));
					user.setMbrmst_provinceid(new Long(0));
					user.setMbrmst_cityid(new Long(0));
					user.setMbrmst_postcode("");
					user.setMbrmst_certifiertype(new Long(0));
					user.setMbrmst_certifierno("");
					user.setMbrmst_myd1type(new Long(0));
					user.setMbrmst_myd1count(new Long(10));
					user.setMbrmst_myd1codes("");
					user.setMbrmst_specialtype(new Long(0));
					user.setMbrmst_srcurl("");
					user.setMbrmst_peoplercm("");
					user.setMbrmst_subad("");
					user.setMbrmst_temp("");
					user.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
					user.setMbrmst_bookletflag(new Long(0));
					user.setMbrmst_buyerrcount(new Long(0));
					user.setMbrmst_buyquestionid("");
					user.setMbrmst_downflag(new Long(0));
					user.setMbrmst_magazineflag(new Long(0));
					user.setMbrmst_validflag(new Long(0));
					user.setMbrmst_rcmcount(new Long(0));
					user.setMbrmst_ip("");
					user.setMbrmst_bktstep(new Long(0));
					user.setMbrmst_aliasname("");
					user.setMbrmst_src(new Long(0));
					user.setMbrmst_sendcount(new Long(0));
					user.setMbrmst_replycount(new Long(0));
					user.setMbrmst_kicktype(new Long(0));
					user.setMbrmst_bbsAlllogintimes(new Long(0));
					user.setMbrmst_bbsDaylogintimes(new Long(0));
					user.setMbrmst_allsrc(new Long(0));
					user.setMbrmst_jcsrc(new Long(0));
					user.setMbrmst_goldsrc(new Long(0));
					user.setMbrmst_goldallsrc(new Long(0));
					user.setMbrmst_birthflag(new Long(0));
					user.setMbrmst_tktmail(new Long(0));
					
					user = (User)UserHelper.manager.create(user);
					if(user != null && user.getId()!=null){
						UserHelper.setLoginUserId(session,user.getId());
						pc.setPhonecode_status(new Long(1));
						Tools.getManager(PhoneCode.class).update(pc, true);
						response.sendRedirect("/wap/regsucctele.jsp");
					}else{
						erroinfo="注册失败，请重新再试！";
					}
			}
		}
	}
}


%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>D1优尚网-手机版-手机注册</title>
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
			<a href="/mindex.jsp">首页</a>>注册 <br />
		</div>
		<a href="/mindex.jsp"><img
			src="http://images.d1.com.cn/wap/newlogo.jpg" /></a> <br /> <font
			color="red">温馨提示：如您在电脑上已注册过D1优尚网账号，可</font><a href="/wap/login.jsp">直接登录</a><font
			color="red">，无需再次注册.</font> <br /> <a href="/wap/emailregist.jsp">邮箱注册</a>&nbsp;&nbsp;|&nbsp;&nbsp;手机注册<br />
		<span id="erroinfo" style="color: red; font-weight: bold;"> <%= erroinfo %></span>
		<form id="getcode" action="regist.jsp?v=tele" method="post">
			手机号：
			<br />
			<input type="text" id="phone" name="phone" maxlength="64"></input>

			<br />

			<input type="submit" id="regist" value="获取验证码" style="width: 90px;" />
		</form>
		<br /> 如果您已收到短信激活码，您可在下方填入短信激活码提交<br />
		<form name="form_Regist" id="form_Regist"
			action="/wap/regist.jsp?act_wap=regist" method="post">
			手机号：
			<br />
			<input type="text" id="tele" name="tele" maxlength="64"></input>
			<br /> 短信激活码：
			<br />
			<input type="text" id="code" name="code"></input>
			<br /> 密码：
			<br />
			<input type="password" name="password" id="password" maxlength="14" />
			<span id="pass_Notice" style="color: #f00">密码长度6-14位，支持数字、符号、字母，字母区分大小写</span>
			<br />

			<input type="submit" value="提&nbsp;交" style="width: 60px;" />
		</form>

		<a href="/wap/emailregist.jsp">邮箱注册</a>&nbsp;&nbsp;|&nbsp;&nbsp;手机注册<br />
		==注册会员的好处==<br /> 1、购买商品可享受D1优尚会员优惠资格。<br /> 2、累计购物积分，兑换礼品。<br />
		3、开启收藏夹功能 <br /> <br /> <a href="/mindex.jsp">返回首页</a>&nbsp;&nbsp;<a
			href="/wap/login.jsp">登录</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a>
		<br /> 切换到<a href="http://www.d1.com.cn">电脑版</a> <br />京ICP证030072号
	</div>
</body>
</html>

<script type="text/javascript" language="javascript">

function is_phone(v,obj){
	if (v == ''){
    	$(obj).html("手机号码不能为空，请输入").addClass('red');
    	return;
	}else if (!isMobile(v)){
		$(obj).html("手机号码格式有误，请修改").addClass('red');
		return;
	}else{
		$.ajax({
	        type: "post",
	        dataType: "json",
	        url: "/ajax/wap/validate_wap.jsp",
	        cache: false,
	        data:{phone: v,param:'phone'},
	        error: function(json){
	           $('#phone_Notice1').html(json.message);
	           return;
	        },
	        success: function(json){
	            	if(!json.success){
	            		$('#phone_Notice1').html(json.message);
	            		return;
	                }
	            	
	        },beforeSend: function(){
	        	$('#phone_Notice1').val('验证中...');
	        },complete: function(){
	        	$('#phone_Notice1').val('');
	        }
	    });
    }
	
	$("#phone_Notice1").html("<img src='http://images.d1.com.cn/images2012/New/reg/suc.jpg' />").removeClass('red');
	return;
	
}
</script>

