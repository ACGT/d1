<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
String txt_account = request.getParameter("txt_account");
String txt_password = request.getParameter("txt_password");
String url = request.getParameter("url");
String txt_member = request.getParameter("rember");//是否记住用户名。

if(Tools.isNull(url)) url = "/";

Map<String,Object> map = new HashMap<String,Object>();
map.put("success",new Boolean(false));
map.put("jfflag",new Boolean(false));
map.put("redirect" , url);
map.put("phoneflag",new Boolean(false));

if(Tools.isNull(txt_account)){
	map.put("message","请输入用户名/Email！");
	out.print(JSONObject.fromObject(map));
	return;
}
if(Tools.isNull(txt_password)){
	map.put("message","请输入登录密码！");
	out.print(JSONObject.fromObject(map));
	return;
}
//开始认证。
User user = UserHelper.getByUsername(txt_account);
if(user==null){
	user=UserHelper.getByUserPhone(txt_account);
}
if(user == null){
	map.put("message","用户名/Email/手机号不正确！");
	out.print(JSONObject.fromObject(map));
	return;
}
//System.err.println(user.getMbrmst_passwd()+"--"+MD5.to32MD5(txt_password,"UTF-8"));
if(!MD5.to32MD5(txt_password).equals(user.getMbrmst_passwd())){
	map.put("message","密码不正确！");
	out.print(JSONObject.fromObject(map));
	return;
}
	UserHelper.setLoginUserId(session,user.getId());

//登录成功处理。
//LoginLogHelper.createLog(user);
	user.setMbrmst_lastdate(new Date());
	Tools.getManager(User.class).update(user, false);

//Tools.setCookie(response,Const.LOGIN_USER_COOKIE_ID,user.getMbrmst_cookie(),(int)(3600*3*1000));

//记录用户名，2个星期不用输入用户名
if("1".equals(txt_member)){
	if(Tools.isNull(user.getMbrmst_cookie())){
		user.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
		Tools.getManager(User.class).update(user, false);
	}
	
	Tools.setCookie(response,"LastLoginName",user.getMbrmst_uid(),(int)(3600*24*1000*365l));
}else{
	Tools.removeCookie(response,"LastLoginName");
}

//判断用户是否是手机注册，如果是则跳转到添加email页面，否则正常
if(user.getMbrmst_email()==null||user.getMbrmst_email().trim().length()==0)
{
	map.put("redirect" , "/addemail.jsp");
}

if (user!=null&&(int)(UserScoreHelper.getRealScore(user.getId())+0.5)>=200){
map.put("jfflag",new Boolean(true));
}
if(url.indexOf("/newlogin/valitel.jsp")>=0){
if(user.getMbrmst_phoneflag()==null||user.getMbrmst_phoneflag().longValue()==0){
	map.put("phoneflag",new Boolean(true));
}else{
	map.put("redirect" , "/zhuanti/201303/szn0307/");
	}
}
map.put("success",new Boolean(true));
map.put("message","登录成功！");

out.print(JSONObject.fromObject(map));
%>