<%@ page contentType="text/html; charset=UTF-8"%><%@include file="inc/header.jsp"%><%!
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
String uid = request.getParameter("uid");
String sign = request.getParameter("sign");
if(Tools.isNull(uid) || Tools.isNull(sign)){
	Tools.outJs(out,"参数错误！","/");
	return;
}
User user = UserHelper.getById(uid);
if(user == null){
	Tools.outJs(out,"参数错误！","/");
	return;
}
FindPassword fp = getByMbrid(user);
if(fp == null || Tools.dateValue(fp.getSelf_createtime())<System.currentTimeMillis()-Tools.DAY_MILLIS){
	Tools.outJs(out,"连接已过期，请重新找回密码！","/");
	return;
}
String self_mbrUid=fp.getSelf_mbruid();
Date self_createTime=fp.getSelf_createtime();
String self_Md5Key=MD5.to32MD5(Tools.dateValue(self_createTime)/1000+"ul.^t@pgkl");
if(!sign.equals(MD5.to32MD5(self_mbrUid+self_Md5Key))){
	Tools.outJs(out,"非法的连接请求！","/");
	return;
}

FindPasswordHelper.manager.clearOmCache(fp);
fp.setSelf_sucflag(new Long(1));
FindPasswordHelper.manager.update(fp,true);

/////////////////////////////////////////
session.removeAttribute("showmsg");
session.setAttribute("FindPassword" , fp.getId());
UserHelper.setLoginUserId(session,user.getId());

response.sendRedirect("/user/resetpassword.jsp");
%>