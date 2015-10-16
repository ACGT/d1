<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%><%!

/**
 * 找出记录
 * @param user - 用户对象
 * @return FindPassword
 */
public static FindPassword getByMbrid(User user){
	if(user == null) return null;
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("self_mbruid",String.valueOf(user.getId())));
	listRes.add(Restrictions.eq("self_sucflag",new Long(0)));
	
	List list = FindPasswordHelper.manager.getList(listRes, null, 0, 1);
	
	if(list == null || list.isEmpty()) return null;
	return (FindPassword)list.get(0);
}

%><%
String mobile = request.getParameter("mobile");
String code = request.getParameter("code");
if(!Tools.isMath(code) || Tools.isNull(mobile)){
	out.print("{\"success\":false,\"message\":\"参数错误！\"}");
	return;
}
User user = UserHelper.getByUsername(mobile);
if(user == null){
	out.print("{\"success\":false,\"message\":\"找不到用户名，请拨打010-51292956求助客服！\"}");
	return;
}
String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
if(!(code).equals(vImageCode)){
	out.print("{\"success\":false,\"message\":\"验证码输入错误！\"}");
	return;
}
//发邮件了。
String mbrName = Tools.trim(user.getMbrmst_uid());
String email = user.getMbrmst_email();
String self_mbrUid=user.getId();
Date self_createTime=new Date();
Date self_validEndTime= new Date(System.currentTimeMillis()+Tools.DAY_MILLIS);
String self_Md5Key=MD5.to32MD5(Tools.dateValue(self_createTime)/1000+"ul.^t@pgkl");
Long self_sucFlag = new Long(0);

synchronized(user){
	FindPassword fp = getByMbrid(user);
	if(fp == null){
		fp = new FindPassword();
		fp.setSelf_mbruid(self_mbrUid);
		fp.setSelf_createtime(self_createTime);
		fp.setSelf_validendtime(self_validEndTime);
		fp.setSelf_md5key(self_Md5Key);
		fp.setSelf_sucflag(self_sucFlag);
		fp = (FindPassword)FindPasswordHelper.manager.create(fp);
	}else{
		long time = Tools.dateValue(fp.getSelf_createtime());
		if(time < System.currentTimeMillis()){
			fp.setSelf_mbruid(self_mbrUid);
			fp.setSelf_createtime(self_createTime);
			fp.setSelf_validendtime(self_validEndTime);
			fp.setSelf_md5key(self_Md5Key);
			fp.setSelf_sucflag(self_sucFlag);
			FindPasswordHelper.manager.update(fp,true);
		}else{
			self_mbrUid=fp.getSelf_mbruid();
			self_createTime=fp.getSelf_createtime();
			self_Md5Key=fp.getSelf_md5key();
		}
	}
}

String mailbody="尊敬的<b>"+mbrName+"</b>(登录名)您好：<br>";
mailbody = mailbody+"请您点击以下链接修改密码！这个链接24小时内有效。<br>";
mailbody=mailbody+"<p><a href=\"http://www.d1.com.cn/findpwd.jsp?uid="+self_mbrUid+"&sign="+MD5.to32MD5(self_mbrUid+self_Md5Key)+"\">http://www.d1.com.cn/findpwd.jsp?uid="+self_mbrUid+"&sign="+MD5.to32MD5(self_mbrUid+self_Md5Key)+"</a></p>";
mailbody=mailbody+"如果您不能点击以上按钮，请将该链接复制到浏览器地址栏中访问，也可以完成修改新密码！<br>";
mailbody=mailbody+"如有任何疑问，请与D1优尚客服取得联系。";

String mailSubject = "找回D1优尚会员密码";
String mailSendemail = email;
String mailFromemail = "service@d1.com.cn";

Email pwEmail = new Email();
pwEmail.setBody(mailbody);
pwEmail.setOdrid("");
pwEmail.setIfsend(new Long(0));
pwEmail.setCreatetime(new Date());
pwEmail.setSendname("");
pwEmail.setFromemail(mailFromemail);
pwEmail.setSendemail(mailSendemail);
pwEmail.setSubject(mailSubject);

Tools.getManager(Email.class).create(pwEmail);

out.print("{\"success\":true,\"message\":\"邮件发送成功！\"}");
%>