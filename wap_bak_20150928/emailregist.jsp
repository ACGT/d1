<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="/inc/header.jsp"%>
<%

//注册页面不需要缓存。
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
String act = request.getParameter("act_wap");
String uid="";
String v="";
String yzcode="/ImageCode?r="+new Random().nextInt(10);
String info="";
String backurl = request.getParameter("url");
if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/";
	}
}
if("post".equals(request.getMethod().toLowerCase()) && "regist".equals(act)&&request.getParameter("submit").equals("点击换一张")){//更换验证码
     uid=request.getParameter("email");
     v=request.getParameter("v");
     yzcode="/ImageCode?r="+new Random().nextInt(10);
}
if("post".equals(request.getMethod().toLowerCase()) && "regist".equals(act)&&request.getParameter("submit").equals("立即注册")){//注册
	//Tools.outJs(out, request.getParameter("submit"),"emailregist.jsp");
	String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
	String vCode = request.getParameter("code");
	String vCode1 = request.getParameter("yzcode");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String password2=request.getParameter("password2");
	if(vCode == null || vImageCode==null|| !vImageCode.equals(vCode)){
		info="验证码输入错误，请重试！";
		uid=request.getParameter("email");
	}
	else
	{
		
		if(email != null) email = email.trim();
		if(email.length()==0)
		{
			info="邮箱地址不能为空";
		}
		else if(!Tools.isEmail(email)){
			info="邮箱地址格式有误，请修改";
		}
		else
		{
			User user = UserHelper.getByUsername(email);
			if(user != null){
				info="邮箱已被注册，请更换一个";
			}
			
			else if(password == null){
				info="密码不能为空";
				uid=request.getParameter("email");
			}
			else if(password.length()<6 || password.length()>14){
				info="登录密码不能少于6个字符且不能多于14个字符";
				uid=request.getParameter("email");
			}
			else if(password.indexOf(" ")>-1){
				info="密码中不能包含空格";
				uid=request.getParameter("email");
			}
			else if(password2.length()<6 || password2.length()>14){
				info="确认密码不能少于6个字符且不能多于14个字符";
				uid=request.getParameter("email");
			}
			else if(password2.indexOf(" ")>-1){
				info="确认密码中不能包含空格";
				uid=request.getParameter("email");
			}
			else if(!password.equals(password2)){
				info="两次密码输入不一致";
				uid=request.getParameter("email");
			}
			
			else
			{
				Date currDate = new Date();
				
				user = new User();
				user.setId(SequenceIdGenerator.generate("3"));
				user.setMbrmst_uid(email);
				user.setMbrmst_passwd(MD5.to32MD5(request.getParameter("password")));
				user.setMbrmst_pwd(MD5.to32MD5(request.getParameter("password")));
				user.setMbrmst_question("");
				user.setMbrmst_answer("");
				user.setMbrmst_createdate(currDate);
				user.setMbrmst_modidate(currDate);
				user.setMbrmst_lastdate(currDate);
				int iAtPos = email.indexOf("@");
				if(iAtPos >= 0){
					user.setMbrmst_name(email.substring(0,iAtPos));
				}else{
					user.setMbrmst_name(email);
				}
				user.setMbrmst_visittimes(new Long(1));
				user.setMbrmst_sex(new Long(0));
				user.setMbrmst_email(email);
				user.setMbrmst_hphone("");
				user.setMbrmst_usephone("");
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
					response.sendRedirect("/wap/regsuccess.jsp");
				}else{
					info="注册失败，请重新再试！";
				}
			}
		}
	}
}


%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>D1优尚网-手机版-邮箱注册</title>

<style type="text/css">
    body{ background:#fff;font:14px Arial,"微软雅黑";color:#4b4b4b; padding-bottom:15px; line-height:18px;}
    a {text-decoration:none;color:#4169E1}
	a:hover {color:#aa2e44}
	.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
	img{ border:none;}
	input{ width:150px;}
	.red{ color:#f00;}
</style>
</head>
<body>
<div>
    <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>>注册
    <br/>
    </div>
    <a href="mindex.jsp"><img src="http://images.d1.com.cn/wap/newlogo.jpg" /></a>
    <br/>
    <font color="red">温馨提示：如您在电脑上已注册过D1优尚网账号，可</font><a href="/wap/login.jsp">直接登录</a><font color="red">，无需再次注册.</font>
    <br/>
    邮箱注册&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/wap/regist.jsp">手机注册</a><br/>
    <span id="erroinfo" style=" color:red; font-weight:bold;"><%= info %></span>
     <form name="form_Regist" id="form_Regist" action="/wap/emailregist.jsp?act_wap=regist" method="post" >        
             邮箱地址：<br/>
         <input type="text" id="email" name="email"  maxlength="64" value="<%= uid %>"></input>
      
      <br/>   
                 密码（6-14位）<br/>
         <input type="password" id="password" name="password"  maxlength="14"></input>
        
         <br/>
         确认密码：<br/>
         <input type="password" id="password2" name="password2"  maxlength="14"></input>
       
         <br/>
          
         <img id="vPic" style="vertical-align:bottom;cursor:pointer; margin-top:3px;" width="60" height="24" src="<%= yzcode %>" />&nbsp;
         <span>看不清，<input type="submit" name="submit" value="点击换一张"/></span>
        
         <br/>
         请输入图片中的验证码：<br/>
         <input type="text" name="code" id="code" maxlength="4" style="width:78px;" />
        <input type="hidden" id="yzcode"  name="yzcode" value="<%= yzcode%>"/>
         <br/>
         <input type="submit" value="立即注册" name="submit"  style="width:90px;"></input>
         <br/>
        </form>
          邮箱注册&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/wap/mobileregist.jsp">手机注册</a><br/>
         ==注册会员的好处==<br/>
         1、购买商品可享受D1优尚会员优惠资格。<br/>
         2、累计购物积分，兑换礼品。<br/>
         3、开启收藏夹功能
         <br/>
         <br/>
         <a href="/mindex.jsp">返回首页</a>&nbsp;&nbsp;<a href="/wap/login.jsp">登录</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a><br/>
        <br/>
	切换到<a href="http://www.d1.com.cn">电脑版</a>
	<br/>京ICP证030072号
	</div>
</body>
</html>



