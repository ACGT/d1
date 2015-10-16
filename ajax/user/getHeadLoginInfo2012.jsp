<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
Map<String,Object> map = new HashMap<String,Object>();
String uid="";
String showmsg = Tools.getCookie(request,"showmsg");
if(lUser != null){
	uid=lUser.getMbrmst_uid();
	if((uid.endsWith("@pingan")||uid.endsWith("@@Alipay"))&&lUser.getMbrmst_name().trim()!=null&&lUser.getMbrmst_name().trim().length()>0)
	{
		uid=lUser.getMbrmst_name().trim();
	}
	if(!Tools.isNull(showmsg) && uid.endsWith("caibei") && lUser.getMbrmst_name().trim().equals("QQ彩贝")){
		uid=URLDecoder.decode(showmsg,"GBK");
	}else if(!Tools.isNull(showmsg)  && lUser.getMbrmst_name().trim().equals("QQ登录用户")){
		uid=URLDecoder.decode(showmsg,"GBK");
		
	}else if(!Tools.isNull(showmsg) && (uid.endsWith("@51fanli") || uid.endsWith("xunlei") || uid.endsWith("@user360"))){
		uid=URLDecoder.decode(showmsg,"GBK");
	}
	//if(session.getAttribute("showmsg")!=null&&!Tools.isNull(session.getAttribute("showmsg").toString())){
		//uid=session.getAttribute("showmsg").toString();
	//}
	map.put("message","您好，<span title=\""+uid+"\" style=\"color:#8cc341\">"+(uid.length()<=14?uid:StringUtils.getCnSubstring(uid,0,14)+"...")+"</span>,欢迎来到D1购物(<a href=\"http://www.d1.com.cn/logout.jsp\" target=\"_self\" style=\"color:#8cc341\">退出登录</a>)&nbsp;&nbsp;&nbsp;&nbsp;");
	map.put("success" , new Boolean(true));
	map.put("cardNum" , new Long(CartHelper.getTotalProductCount(request,response)));
}else{
	map.put("success" , new Boolean(true));
	map.put("message" , "你好，欢迎来到D1购物，请&nbsp;<a href=\"http://www.d1.com.cn/login.jsp\" style=\"color:#8cc341\">登录</a>&nbsp;或&nbsp;<a href=\"http://www.d1.com.cn/register.jsp\" target=_blank style=\"color:#8cc341\">注册</a>&nbsp;&nbsp;&nbsp;&nbsp;");
}
out.print(JSONObject.fromObject(map));
%>