<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.xml.XMLSerializer,java.net.*,org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document"%><%@include file="/inc/header.jsp"%>
<%@include file="../PayConfig.jsp"%>

<%!

public static String getRandomString(int length){  
    String str="abcdefghijklmnopqrstuvwxyz0123456789";  
    Random random = new Random();  
    StringBuffer sb = new StringBuffer();  
      
    for(int i = 0 ; i < length; ++i){  
        int number = random.nextInt(36);//[0,62)  
          
        sb.append(str.charAt(number));  
    }  
    return sb.toString();  
}  

public static class WeiXinRequestComparator 

implements Comparator {

public int compare(Object element1, 

Object element2) {

String lower1 = element1.toString();
String lower2 = element2.toString();
lower1=lower1.substring(0,lower1.indexOf("="));
lower2=lower2.substring(0,lower2.indexOf("="));
if (lower1.length()>lower2.length()){
	lower1=lower1.substring(0,lower2.length());
	int ret=lower1.compareTo(lower2);
	//System.out.println("返回结果："+ret);
	if (ret ==0){
		//System.out.println("返回结果："+ret);
		return 1;
	}else{
		return ret;
	}
}else if (lower1.length()<lower2.length()){
	lower2=lower2.substring(0,lower1.length());
	int ret=lower1.compareTo(lower2);
	if (ret ==0){
		return -1;
	}else{
		return ret;
	}
}else{
	int ret=lower1.compareTo(lower2);
	return ret;
}
}

}

private static String create_nonce_str() {
    return UUID.randomUUID().toString();
}

private static String create_timestamp() {
    return Long.toString(System.currentTimeMillis() / 1000);
}
%>
<%
response.setContentType("text/html;charset=UTF-8");
String strOdrID = request.getParameter("OdrID");

OrderBase order = OrderHelper.getById(strOdrID);
System.out.println(strOdrID+"===================================");
if(order == null){
	out.print("查询订单出错！");
	return;
}
if(!lUser.getId().equals(String.valueOf(order.getOdrmst_mbrid()))){
	out.print("查询订单出错。");
	return;
}
if(Tools.longValue(order.getOdrmst_orderstatus()) != 0){
	out.print("您的订单不在未支付状态！");
	return;
}

//防止刷页面

Long lastPostTime = (Long)Const.LIMIT_HASH_MAP.get(new Long(lUser.getId()));
if(lastPostTime!=null){
	if(System.currentTimeMillis()-lastPostTime.longValue()<Const.LIMIT_MILLSECONDS){
		out.println("请不要刷页面！");
		return;
	}
}
Const.LIMIT_HASH_MAP.put(new Long(lUser.getId()),new Long(System.currentTimeMillis()));

String body = "D1优尚网" + strOdrID + "订单";//商品名称


Map<String, String> requestParams = new HashMap<String, String>();
request.setCharacterEncoding("utf-8");
/**商品名称*/

/**商品总价*/
String totalFee = Tools.getFormatMoney(Tools.doubleValue(order.getOdrmst_acturepaymoney())*100);//订单总价
 
/**未完成支付，用户点击链接返回商户url*/

/**req_data的内容*/
/**
<xml>
   <appid>wx2421b1c4370ec43b</appid>
   <attach>支付测试</attach>
   <body>JSAPI支付测试</body>
   <mch_id>10000100</mch_id>
   <nonce_str>1add1a30ac87aa2db72f57a2375d8fec</nonce_str>
   <notify_url>http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php</notify_url>
   <openid>oUpF8uMuAJO_M2pxb1Q9zNjWeS6o</openid>
   <out_trade_no>1415659990</out_trade_no>
   <spbill_create_ip>14.23.150.211</spbill_create_ip>
   <total_fee>1</total_fee>
   <trade_type>JSAPI</trade_type>
   <sign>0CB01533B8C1EF103065174F50BCA001</sign>
</xml>
*/
StringBuilder reqData = new StringBuilder();
String nonce_str=getRandomString(32);
String ipstr=request.getRemoteAddr();
String user_openid=session.getAttribute("Weixinopenid").toString();

System.out.println(user_openid+"====user_openid");
String MchId = PubConfig.get("WeiXinMchId");
String PayUrl = PubConfig.get("WeiXinPayUrl");
String AppSecret = PubConfig.get("WeiXinAppSecret");
String AppId = PubConfig.get("WeiXinAppId");
String NotifyUrl = PubConfig.get("WeiXinNotifyUrl");
String paykey=PubConfig.get("WeiXinPayKey");
String attach="D1优尚网";
//"lvsqaxsshhjtjkckkxdcphmsmzsnljuv";
//String urlendcode=URLEncoder.encode(NotifyUrl,"utf-8");
ArrayList<String> results=new ArrayList<String>();

results.add("appid="+AppId);
results.add("attach="+attach);
results.add("body="+body);
results.add("mch_id="+MchId);
results.add("nonce_str="+nonce_str);
results.add("notify_url="+NotifyUrl);
results.add("openid="+user_openid);
results.add("out_trade_no="+strOdrID);
results.add("spbill_create_ip="+ipstr);
results.add("total_fee="+totalFee);
results.add("fee_type=CNY");
results.add("trade_type=JSAPI");

Collections.sort(results,new WeiXinRequestComparator());
String stringA=results.toString();
stringA=stringA.replace("[", "").replace("]", "").replace(", ", "&");
String stringSignTemp= stringA+"&key="+paykey;
System.out.println(stringSignTemp);

String sign=MD5.to32MD5(stringSignTemp,"utf-8").toUpperCase();
System.out.println(sign);
reqData.append("<xml>");
reqData.append("<appid>"+AppId+"</appid>");
reqData.append("<attach>"+attach+"</attach>");
reqData.append("<body>"+body+"</body>");
reqData.append("<mch_id>"+MchId+"</mch_id>");//商户号
reqData.append("<nonce_str>"+nonce_str+"</nonce_str>");//随机字符串
reqData.append("<notify_url>"+NotifyUrl+"</notify_url>");//通知地址
reqData.append("<openid>"+user_openid+"</openid>");
reqData.append("<out_trade_no>"+strOdrID+"</out_trade_no>");//商户订单号
reqData.append("<spbill_create_ip>"+ipstr+"</spbill_create_ip>");//终端IP
reqData.append("<total_fee>"+totalFee+"</total_fee>");//总金额
reqData.append("<fee_type>CNY</fee_type>");//币种
reqData.append("<trade_type>JSAPI</trade_type>");
reqData.append("<sign>"+sign+"</sign>");
reqData.append("</xml>");




String businessResult =  HttpUtil.postData(PayUrl, reqData.toString(), "utf-8");
System.out.println(businessResult);
InputStream in = null;

	in = new ByteArrayInputStream(businessResult.getBytes("UTF-8"));
	SAXReader reader = new SAXReader();
	InputStreamReader   isr   =   new   InputStreamReader(in,"UTF-8");
		Document doc = reader.read(isr);
		Element root = doc.getRootElement();
		String return_code=root.elementTextTrim("return_code"); 
		if("SUCCESS".equals(return_code)){
		 String result_code=root.elementTextTrim("result_code"); // 备注
		 if("SUCCESS".equals(return_code)){
			 
			 
		 String prepay_id=root.elementTextTrim("prepay_id"); // 备注
		 String timeStamp=create_timestamp();
		 String jsnonceStr=create_nonce_str();
		 ArrayList<String> results2=new ArrayList<String>();
		 results2.add("appId="+AppId);
		 results2.add("timeStamp="+timeStamp);
		 results2.add("nonceStr="+jsnonceStr);
		 results2.add("package=prepay_id="+prepay_id);
		 results2.add("signType=MD5");
	       Collections.sort(results2,new WeiXinRequestComparator());
	       String stringA2=results2.toString();
	       stringA=stringA2.replace("[", "").replace("]", "").replace(", ", "&");
	       String SignTemp2= stringA+"&key="+paykey;
	       String sign2=MD5.to32MD5(SignTemp2,"utf-8").toUpperCase();
		 out.print("{\"SUCCESS\":true,\"appid\":\""+AppId+"\",\"prepay_id\":\""+prepay_id+"\",\"timeStamp\":\""+timeStamp+"\",\"nonceStr\":\""+jsnonceStr+"\",\"sign\":\""+sign2+"\"}");
		 System.out.print("{\"SUCCESS\":true,\"appid\":"+AppId+",\"prepay_id\":"+prepay_id+",\"timeStamp\":"+timeStamp+",\"nonceStr\":"+jsnonceStr+",\"sign\":"+sign2+"}");
		 //System.out.println("{\"SUCCESS\":true,\"prepay_id\":"+prepay_id+"}");
		 }else{
				out.print("{\"SUCCESS\":flase}");
		 }
		}else{
			out.print("{\"SUCCESS\":flase}");
		}
%>

