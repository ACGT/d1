<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="/html/header.jsp"%>

<%
String v=request.getParameter("v");
String tele=request.getParameter("phone")!=null&&request.getParameter("phone").length()>0?request.getParameter("phone"):"";
String mail=request.getParameter("mail")!=null&&request.getParameter("mail").length()>0?request.getParameter("mail"):"";
String uid="";
String backurl = request.getParameter("url");
String erroinfo="";
String password = request.getParameter("password");
PhoneCode pc=null;
if("tele".equals(v))
{

   if(tele==null||tele.length()==0)
   {
	   erroinfo="手机号码不能为空！";
	   out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
   }
   else if(!Tools.isMobile(tele))	
   {
	   erroinfo="手机号码格式不正确！";
	   out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
   }
   String code=request.getParameter("code");

		User user = UserHelper.getByUsername(tele);
		if(user != null){
			erroinfo="手机号已被注册，请更换一个";
			out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
			   return;
		
		}
		else
		{
			user=UserHelper.getByUserPhone(tele);
		  if(user != null){
			erroinfo="手机号已被注册，请更换一个";
			out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
			   return;
		  }
			 pc=PhoneCodeHelper.getPhoneCodeByTele(tele);
			if(pc==null)
			{
				erroinfo="该手机号还没有发送验证码";
				out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
				   return;
			}
			else if(pc.getPhonecode_status().longValue()==1)
			{
				erroinfo="该手机号已被注册，请更换一个";
				out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
				   return;
			}
			else if(!Tools.isNumber(pc.getPhonecode_code()))
			{
				erroinfo="输入的验证码格式错误，请重新输入";
				out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
				   return;
			}
			else if(!pc.getPhonecode_code().equals(code))
			{
				erroinfo="您输入的验证码错误，请重新输入";
				out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
				   return;
			}
			else if(password == null){
				erroinfo="密码不能为空";
				out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
				   return;
			}
			else if(password.length()<6 || password.length()>14){
				erroinfo="登录密码不能少于6个字符且不能多于14个字符";
				out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
				   return;
			}
			else if(password.indexOf(" ")>-1){
				erroinfo="密码中不能包含空格";
				out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
				   return;
			}
		}
		uid=tele;
}
if("mail".equals(v))
{
	String password2 = request.getParameter("password2");
	String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
	String vCode = request.getParameter("code");
	if(vCode == null || vImageCode==null|| !vImageCode.equals(vCode)){
		erroinfo="验证码输入错误，请重试！";
		out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
		   return;
	}
if(mail != null) mail = mail.trim();
if(mail.length()==0)
{
	erroinfo="邮箱地址不能为空";
	  out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
else if(!Tools.isEmail(mail)){
	erroinfo="邮箱地址格式有误，请修改";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
User user = UserHelper.getByUsername(mail);
if(user != null){
	erroinfo="邮箱已被注册，请更换一个";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
else if(password == null){
	erroinfo="密码不能为空";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
else if(password.length()<6 || password.length()>14){
	erroinfo="登录密码不能少于6个字符且不能多于14个字符";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
else if(password.indexOf(" ")>-1){
	erroinfo="密码中不能包含空格";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
else if(password2.length()<6 || password2.length()>14){
	erroinfo="确认密码不能少于6个字符且不能多于14个字符";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
else if(password2.indexOf(" ")>-1){
	erroinfo="确认密码中不能包含空格";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
else if(!password.equals(password2)){
	erroinfo="两次密码输入不一致";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}
uid=mail;
}
if(!"mail".equals(v)&&!"tele".equals(v)){
	erroinfo="参数错误！";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}

    
		
					Date currDate = new Date();
					
					User user = new User();
					user.setId(SequenceIdGenerator.generate("3"));
					user.setMbrmst_uid(uid);
					user.setMbrmst_passwd(MD5.to32MD5(request.getParameter("password")));
					user.setMbrmst_pwd(MD5.to32MD5(request.getParameter("password")));
					user.setMbrmst_question("");
					user.setMbrmst_answer("");
					user.setMbrmst_createdate(currDate);
					user.setMbrmst_modidate(currDate);
					user.setMbrmst_lastdate(currDate);
					user.setMbrmst_name(uid);
					user.setMbrmst_visittimes(new Long(1));
					user.setMbrmst_sex(new Long(0));
					user.setMbrmst_email(mail);
					user.setMbrmst_email("");
					user.setMbrmst_hphone("");
					user.setMbrmst_usephone(tele);
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
					user.setMbrmst_subad("phone");
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
						if("tele".equals(v)){
						pc.setPhonecode_status(new Long(1));
						Tools.getManager(PhoneCode.class).update(pc, true);
						}
						out.print("{\"success\":true,\"message\":\"注册成功！\"}");
						   return;
					}else{
						erroinfo="注册失败，请重新再试！";
						out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
						   return;
					}
	

%>