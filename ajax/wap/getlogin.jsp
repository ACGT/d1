<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject"%><%@include file="/html/header.jsp" %>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "0");
}else{
	String showmsg = Tools.getCookie(request,"showmsg");
	json.put("status", "1");
	String uid=lUser.getMbrmst_uid();
	if((uid.endsWith("@@weixin")||uid.endsWith("@pingan")||uid.endsWith("@@Alipay"))&&lUser.getMbrmst_name().trim()!=null&&lUser.getMbrmst_name().trim().length()>0)
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
	json.put("username", uid.trim());
	if(!Tools.isNull(request.getParameter("u"))){
		json.put("userscore", (int)(UsrPointHelper.getRealScore(lUser.getId())+0.5));
		int utype=lUser.getMbrmst_specialtype().intValue();
		String typen="普通会员";
		if(utype!=0){
			 
	        	UserVip uv=(UserVip)Tools.getManager(UserVip.class).get(lUser.getId());
	        	if(uv!=null){
	        		typen="白金VIP";
	        		utype=2;
	        	}else{
	        		typen="VIP";
	        		utype=1;
	        	}
		}
		json.put("usertype", typen);
		json.put("utype", utype);
	}
}
out.print(json);
%>