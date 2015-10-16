<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
Map<String,Object> map = new HashMap<String,Object>();
String uid="";
String showmsg = Tools.getCookie(request,"showmsg");
if(lUser != null){
	uid=lUser.getMbrmst_uid();
	if(!Tools.isNull(showmsg) && uid.endsWith("caibei") && lUser.getMbrmst_name().trim().equals("QQ彩贝")){
		uid=URLDecoder.decode(showmsg,"GBK");
	}else if(!Tools.isNull(showmsg)  && lUser.getMbrmst_name().trim().equals("QQ登录用户")){
		uid=URLDecoder.decode(showmsg,"GBK");
		
	}else if(!Tools.isNull(showmsg) && (uid.endsWith("@51fanli") || uid.endsWith("xunlei"))){
		uid=URLDecoder.decode(showmsg,"GBK");
	}
	//if(session.getAttribute("showmsg")!=null&&!Tools.isNull(session.getAttribute("showmsg").toString())){
		//uid=session.getAttribute("showmsg").toString();
	//}
	map.put("message","您好，<span title=\""+uid+"\">"+StringUtils.getCnSubstring(uid,0,18)+"</span>，欢迎来到D1购物（<a href=\"/logout.jsp\" target=\"_self\">退出登录</a>）");
	map.put("success" , new Boolean(true));
	map.put("cardNum" , new Long(CartHelper.getTotalProductCount(request,response)));
}else{
	map.put("success" , new Boolean(true));
	map.put("message" , "你好,欢迎来到D1购物,请&nbsp;<a href=\"/login.jsp\" class=\"gray_btn\">登录</a>&nbsp;或&nbsp;<a href=\"/register.jsp\" target=_blank class=\"gray_btn\">注册</a>");
}
out.print(JSONObject.fromObject(map));
%>