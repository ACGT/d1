<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.xml.XMLSerializer,java.net.*,org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document"%><%@include file="/inc/header.jsp"%>
<%@include file="/interface/pay/PayConfig.jsp"%>

<%

String AppId = PubConfig.get("WeiXinAppId");
String secret=PubConfig.get("WeiXinAppSecret");
String tokenurl="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+AppId+"&secret="+secret+"";
String rettoken=  HttpUtil.getUrlContentByGet(tokenurl,"utf-8");
System.out.println("rettoken==============="+rettoken);
JSONObject  jsonotoken = JSONObject.fromObject(rettoken); 
String access_token = jsonotoken.getString("access_token"); 
//String ulrgetuser="https://api.weixin.qq.com/cgi-bin/user/info/updateremark?access_token="+access_token+"";
//String retuser=  HttpUtil.getUrlContentByGet(ulrgetuser,"utf-8");
//System.out.println("retuser==============="+retuser);

String ticketurl="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+access_token+"&type=wx_card";
System.out.println(ticketurl);
String ret2=  HttpUtil.getUrlContentByGet(ticketurl,"utf-8");
System.out.println("share==============="+ret2);
JSONObject  jsonob = JSONObject.fromObject(ret2); 
String jsapi_ticket = jsonob.getString("ticket");  
// 注意 URL 一定要动态获取，不能 hardcode
String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");
httpurl="http://m.d1.cn/wap/wxhbok.html";
String httpurl2=URLEncoder.encode(httpurl);
String httppic="http://images.d1.com.cn/wap/2015/06/wxhbfx_01.jpg";
Map<String, String> ret = WeiXinSignSHA.sign(jsapi_ticket, httpurl2);
ret.put("appid", AppId);
ret.put("SUCCESS", "true");
ret.put("shareurl",httpurl2);
ret.put("sharetitle","大家快来领红包");
ret.put("sharepic",httppic);
out.print(JSONObject.fromObject(ret));
System.out.println(JSONObject.fromObject(ret));
%>