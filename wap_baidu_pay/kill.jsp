<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.bean.User,
	com.d1.bean.*,
	com.d1.bean.id.SequenceIdGenerator,
	com.d1.helper.*,
	com.d1.util.*,
	java.util.*,
	net.sf.json.*,
	com.d1.Const" %><%
	
	String token = request.getParameter("token");
	String originalId = "weixin";
	String openId = WeixinShopTokenHelper.checkToken(token,originalId);
	WeixinOpenIdMbrIdPair weixinOpenIdMbrIdPair
		= WeixinOpenIdMbrIdPairHelper.getWeixinOpenIdMbrIdPairByWeixinOpenId(openId, originalId);
	User u = UserHelper.getById(String.valueOf(weixinOpenIdMbrIdPair.getMbrmstId()));
	boolean ret = Tools.getManager(User.class).delete(u);     //UserHelper.manager.delete(String.valueOf(weixinOpenIdMbrIdPair.getMbrmstId()));
	WeixinOpenIdMbrIdPairHelper.manager.delete(String.valueOf(weixinOpenIdMbrIdPair.getId()));
	out.print(String.valueOf(weixinOpenIdMbrIdPair.getMbrmstId())+"!"+weixinOpenIdMbrIdPair.getId()+"!"+String.valueOf(ret)+"!"+u.getMbrmst_uid());
	
	//response.sendRedirect("../logout.jsp");
	
	%>