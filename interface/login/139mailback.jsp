<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator" %>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.MalformedURLException"%>
<%@page import="java.rmi.RemoteException"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.dom4j.Document"%>
<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.io.SAXReader"%>
<%@include file="../../inc/header.jsp"%><%!

private static final Object obj = new Object();//同步锁

private static String MsgUrlTogo(String strMsg, String strUrl){
	StringBuilder stbScript = new StringBuilder();
	stbScript.append("<script type=\"text/javascript\">");
	stbScript.append("alert('").append(strMsg).append("!');");
	if(Tools.isNull(strUrl)) strUrl = PubConfig.get("HomePage");
	stbScript.append("location.href='").append(strUrl).append("';");
	stbScript.append("</script>");
	
	return stbScript.toString();
}


%><%
String strKey = PubConfig.get("139mail_key");//md5加密密钥
String strClickSysId = request.getParameter("clickSysId");//合作商id
String strusertoken = request.getParameter("usertoken");//token
String strUserAccount = request.getParameter("userAccount");//登录用户帐号
String strRType = request.getParameter("rType");//转向Url类型
String strRUrl = request.getParameter("rUrl");//转向url
String strMKey = request.getParameter("mKey");//签名
String strTimestamp = request.getParameter("timestamp");//时间戳

//当前时间戳 - 2000-01-01 00:00:00 的秒数
long lngNowTimetamp = (System.currentTimeMillis()-946656000000l)/1000;

long lngTimestamp = Tools.parseLong(strTimestamp);
if(lngTimestamp <= 0){
	out.print(MsgUrlTogo("时间戳参数出错！","http://www.d1.com.cn"));
	return;
}
//时间戳过期判断
if(Math.abs(lngNowTimetamp - lngTimestamp) > 10*60){
	out.print(MsgUrlTogo("验证超时！","http://www.d1.com.cn"));
	return;
}
//签名合法判断
String strEncodeUrl = URLEncoder.encode(strRUrl,"UTF-8");
String strEncodeUserAccount = URLEncoder.encode(strUserAccount,"UTF-8");

//自己生成的签名
String strMKey2 = strClickSysId + strEncodeUserAccount + strRType + strEncodeUrl + strTimestamp + strKey;
String strxmlkey = strClickSysId + strEncodeUserAccount + strusertoken + strTimestamp + strKey;
//System.err.println(strMKey2);

strMKey2 = MD5.to32MD5(strMKey2).toUpperCase();
String xmlkey=MD5.to32MD5(strxmlkey).toUpperCase();

//System.err.println(strMKey+"||"+strMKey2);

if(strMKey == null || !strMKey.equals(strMKey2)){
	out.print(MsgUrlTogo("签名不正确！","http://www.d1.com.cn"));
	return;
}
String posturl="http://openlogin.mail.10086.cn/WebConfirm.ashx";
StringBuilder sb=new StringBuilder();
sb.append("<?xml version=\"1.0\" encoding=\"GB2312\"?>");
sb.append("<requestdata>");
sb.append("<clicksysid>"+strClickSysId+"</clicksysid>");
sb.append("<useraccount>"+strEncodeUserAccount+"</useraccount>");
sb.append("<usertoken>"+strusertoken+"</usertoken>");
sb.append("<mkey>"+xmlkey+"</mkey>");
sb.append("<timestamp>"+strTimestamp+"</timestamp>");
sb.append("</requestdata>");



String content=sb.toString();
String getret=HttpUtil.postData(posturl, content, "GB2312");

//System.out.println(getret);
String retcode="";
if(!Tools.isNull(getret)){
try{
InputStream in = null;

	in = new ByteArrayInputStream(getret.getBytes("GB2312"));
	SAXReader reader = new SAXReader();
	InputStreamReader   isr   =   new   InputStreamReader(in,"GB2312");
	Document doc = reader.read(isr);
	Element root = doc.getRootElement();
	retcode=root.elementTextTrim("retcode");
}catch(Exception e){
	e.printStackTrace();
}
}
if(retcode.equals("000")){
String strUserName = strUserAccount+"@@139邮箱";

User u = null;
synchronized(obj){
	u = UserHelper.getByUsername(strUserName);
	if(u == null){//会员不存在
		Date currDate = new Date();
		String pwd = "139youxiang1103";
		
		u = new User();
		u.setId(SequenceIdGenerator.generate("3"));
		u.setMbrmst_uid(strUserName);
		u.setMbrmst_pwd(pwd);
		u.setMbrmst_passwd(MD5.to32MD5(pwd));
		u.setMbrmst_question("");
		u.setMbrmst_answer("");
		u.setMbrmst_createdate(currDate);
		u.setMbrmst_modidate(currDate);
		u.setMbrmst_lastdate(currDate);
		u.setMbrmst_name("139邮箱用户");
		u.setMbrmst_visittimes(new Long(0));
		u.setMbrmst_sex(new Long(0));
		u.setMbrmst_email("");
		u.setMbrmst_hphone("");
		u.setMbrmst_usephone("");
		u.setMbrmst_haddr("");
		u.setMbrmst_countryid(new Long(1));
		u.setMbrmst_provinceid(new Long(1));
		u.setMbrmst_cityid(new Long(1));
		u.setMbrmst_postcode("");
		u.setMbrmst_certifiertype(new Long(0));
		u.setMbrmst_certifierno("");
		u.setMbrmst_myd1type(new Long(0));
		u.setMbrmst_myd1count(new Long(10));
		u.setMbrmst_myd1codes("");
		u.setMbrmst_specialtype(new Long(0));
		u.setMbrmst_srcurl("");
		u.setMbrmst_peoplercm("");
		u.setMbrmst_subad("");
		u.setMbrmst_temp("139邮箱");
		u.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
		u.setMbrmst_bookletflag(new Long(0));
		u.setMbrmst_buyerrcount(new Long(0));
		u.setMbrmst_buyquestionid("");
		u.setMbrmst_downflag(new Long(0));
		u.setMbrmst_magazineflag(new Long(0));
		u.setMbrmst_validflag(new Long(0));
		u.setMbrmst_rcmcount(new Long(0));
		u.setMbrmst_ip("");
		u.setMbrmst_bktstep(new Long(0));
		u.setMbrmst_aliasname("");
		u.setMbrmst_src(new Long(0));
		u.setMbrmst_sendcount(new Long(0));
		u.setMbrmst_replycount(new Long(0));
		u.setMbrmst_kicktype(new Long(0));
		u.setMbrmst_bbsAlllogintimes(new Long(0));
		u.setMbrmst_bbsDaylogintimes(new Long(0));
		u.setMbrmst_allsrc(new Long(0));
		u.setMbrmst_jcsrc(new Long(0));
		u.setMbrmst_goldsrc(new Long(0));
		u.setMbrmst_goldallsrc(new Long(0));
		u.setMbrmst_birthflag(new Long(0));
		u.setMbrmst_tktmail(new Long(0));
		u.setMbrmst_ip(request.getRemoteAddr());
		u = (User)UserHelper.manager.create(u);
		
		if(u != null && u.getId() != null){
			Mail139User mail139 = Mail139UserHelper.getByAccount(strUserAccount);
			if(mail139 != null){
				mail139 = new Mail139User();
				mail139.setMbr139_userAccount(strUserAccount);
				mail139.setMbr139_rtype(new Long(Tools.parseLong(strRType)));
				mail139.setMbr139_rurl(strRUrl!=null?strRUrl:"");
				mail139.setMbr139_mbrid(new Long(u.getId()));
				Mail139UserHelper.manager.create(mail139);
			}
		}
	}
}
if(u == null || u.getId() == null){
	out.print(MsgUrlTogo("获得用户信息出错，请重新登录！",null));
	return;
}
session.removeAttribute("showmsg");
UserHelper.setLoginUserId(session,u.getId());

Tools.setCookie(response,"lhdltemp","fanxian_139",(int)(Tools.DAY_MILLIS*3/1000));
Tools.removeCookie(response,"d1.com.cn.srcurl");
IntfUtil.KillsCookies(response,"lhdltemp");

//查询购物车中商品数量
int cartLength = CartHelper.getTotalProductCount(request,response);
if(cartLength > 0){
	response.sendRedirect("/flow.jsp");
}else{
	if (!Tools.isNull(strRUrl)){
		response.sendRedirect(strRUrl);
	}else{
	response.sendRedirect("/");
	}
}
}else{
	out.print(MsgUrlTogo("获得用户信息出错，请重新登录！","/login.jsp"));
	return;
}
%>