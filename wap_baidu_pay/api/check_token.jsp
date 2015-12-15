<%@ page contentType="text/html; charset=UTF-8"
	import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.bean.*,com.d1.helper.*,java.util.*"%>
<%
String token = request.getParameter("token");
WeixinShopToken weixinShopToken = (WeixinShopToken)WeixinShopTokenHelper.manager.findByProperty("token", token);
Map<String,Object> map = new HashMap<String,Object>();
if (weixinShopToken!=null) {
	long currentTimeStamp = (new Date()).getTime();
	
	if (weixinShopToken.getExpire_date()>currentTimeStamp && weixinShopToken.getStatus()==1) {
		map.put("status","0");
		map.put("token_available","1");
	}
	else {
		map.put("status","0");
		map.put("token_available","0");
	}
	
}
else{
	map.put("status","0");
	map.put("token_available","0");
}
out.print(JSONObject.fromObject(map));
%>