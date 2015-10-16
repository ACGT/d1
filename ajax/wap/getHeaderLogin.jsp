<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
Map<String,Object> map = new HashMap<String,Object>();
String uid="";

if(lUser != null){
	uid=lUser.getMbrmst_uid();

	map.put("message","您好,<span title=\""+uid+"\">"+StringUtils.getCnSubstring(uid,0,6)+"..."+"</span>&nbsp;&nbsp;<a href=\"/logout.jsp\" target=\"_self\">退出</a><a href=\"/wap/flow.jsp\">&nbsp;&nbsp;购物车("+new Long(CartHelper.getTotalProductCount(request,response))+")&nbsp;</a>");
	map.put("success" , new Boolean(true));
	//map.put("cardNum" , new Long(CartHelper.getTotalProductCount(request,response)));
}else{
	map.put("success" , new Boolean(true));
	map.put("message" , "<ul><li><a href=\"/wap/login.jsp\">&nbsp;登录&nbsp;</a>|</li><li><a href=\"/wap/regist.jsp\">&nbsp;注册&nbsp;</a>|</li><li><a href=\"/wap/flow.jsp\">&nbsp;购物车(0)&nbsp;</a>|</li><li><a href=\"/wap/user/inorder.jsp\"><font color=\"red\">&nbsp;查物流&nbsp;</font></a></li></ul>");
}
out.print(JSONObject.fromObject(map));
%>