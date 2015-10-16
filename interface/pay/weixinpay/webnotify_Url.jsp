<%@ page contentType="text/html; charset=UTF-8" import="org.dom4j.DocumentHelper,com.d1.alipay.*,org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document"%><%@include file="/inc/header.jsp"%><%@include file="../PayConfig.jsp"%><%!

public static Map xmltoMap(String xml) {  
    try {  
        Map map = new HashMap();  
        Document document = DocumentHelper.parseText(xml);  
        Element nodeElement = document.getRootElement();  
        List node = nodeElement.elements();  
        for (Iterator it = node.iterator(); it.hasNext();) {  
            Element elm = (Element) it.next();  
            map.put(elm.getName(), elm.getText());  
            elm = null;  
        }  
        node = null;  
        nodeElement = null;  
        document = null;  
        return map;  
    } catch (Exception e) {  
        e.printStackTrace();  
    }  
    return null;  
}  
static String getVerifyData(Map map,String AppSecret) {
	ArrayList<String> results=new ArrayList<String>();
	Iterator it = map.keySet().iterator();
    while (it.hasNext()) {
        String key = it.next().toString();
        if("sign".equals(key))continue;
        results.add(key+"="+map.get(key));
    }
	
	Collections.sort(results,new WeiXinRequestComparator());
	String stringA=results.toString();
	stringA=stringA.replace("[", "").replace("]", "").replace(", ", "&");
	String stringSignTemp= stringA+"&key="+AppSecret;
	System.out.println(stringSignTemp);
	String sign=MD5.to32MD5(stringSignTemp,"utf-8").toUpperCase();
	System.out.println(sign);
    return  sign;
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

%>
<%
System.out.println("接收到微信支付通知!");
/**获得通知参数*/
Map map = request.getParameterMap();

BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream(),"UTF-8"));  
String line = null;  
StringBuilder sb = new StringBuilder();  
while((line = br.readLine())!=null){  
    sb.append(line);  
}  


InputStream in = null;
System.out.println(sb.toString());
in = new ByteArrayInputStream(sb.toString().getBytes("UTF-8"));
SAXReader reader = new SAXReader();
InputStreamReader   isr   =   new   InputStreamReader(in,"UTF-8");
	Document doc = reader.read(isr);
	Element root = doc.getRootElement();
	String sign=root.elementTextTrim("sign"); 
	String return_code=root.elementTextTrim("return_code"); 
	
if(!"SUCCESS".equals(return_code)){
	System.out.println("接收微信支付系统通知验证签名失败，请检查！");
	String xmlret="<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[FAIL]]></return_msg></xml>";
    out.print(xmlret);
    return;
}
String orderid=root.elementTextTrim("out_trade_no"); 
String total_fee=root.elementTextTrim("total_fee"); 
/**获得通知签名*/
System.out.println(xmltoMap(sb.toString()));
String paykey = PubConfig.get("WeiXinPayKey");
/**获得待验签名的数据*/
String verifyData = getVerifyData(xmltoMap(sb.toString()),paykey);
System.out.println("verifyData:"+verifyData);

/**验证签名通过*/
if (sign.equals(verifyData)) {
	/**根据交易状态处理业务逻辑*/
	/**当交易状态成功，处理业务逻辑成功。仅回写success字符串*/
	
	 /*<xml>
   <appid><![CDATA[wx2421b1c4370ec43b]]></appid>
   <attach><![CDATA[支付测试]]></attach>
   <bank_type><![CDATA[CFT]]></bank_type>
   <fee_type><![CDATA[CNY]]></fee_type>
   <is_subscribe><![CDATA[Y]]></is_subscribe>
   <mch_id><![CDATA[10000100]]></mch_id>
   <nonce_str><![CDATA[5d2b6c2a8db53831f7eda20af46e531c]]></nonce_str>
   <openid><![CDATA[oUpF8uMEb4qRXf22hE3X68TekukE]]></openid>
   <out_trade_no><![CDATA[1409811653]]></out_trade_no>
   <result_code><![CDATA[SUCCESS]]></result_code>
   <return_code><![CDATA[SUCCESS]]></return_code>
   <sign><![CDATA[B552ED6B279343CB493C5DD0D78AB241]]></sign>
   <sub_mch_id><![CDATA[10000100]]></sub_mch_id>
   <time_end><![CDATA[20140903131540]]></time_end>
   <total_fee>1</total_fee>
   <trade_type><![CDATA[JSAPI]]></trade_type>
   <transaction_id><![CDATA[1004400740201409030005092168]]></transaction_id>
</xml>
*/


		
		OrderBase order = OrderHelper.getById(orderid);
		if(order != null && Tools.longValue(order.getOdrmst_orderstatus()) == 0){
			
			double r3_amount = Tools.parseDouble(total_fee)*1.0/100;
			
			OrderService os = (OrderService)Tools.getService(OrderService.class);
			int reValue = os.updateOrderStatus(order,r3_amount);
			System.out.println(reValue);
	        if(reValue == 0){
	        	logInfo("微信支付，非即时反馈，订单："+orderid+"支付成功！");
	        }
		}
		String xmlret="<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
        out.print(xmlret);
	
} else {
	System.out.println("接收微信支付系统通知验证签名失败，请检查！");
	String xmlret="<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[FAIL]]></return_msg></xml>";
    out.print(xmlret);
}

%>