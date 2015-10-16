<%@ page contentType="text/html; charset=UTF-8" import="com.d1.alipay.*,org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document"%><%@include file="/inc/header.jsp"%><%@include file="../PayConfig.jsp"%><%!
static String getVerifyData(Map map) {
    String service = (String) ((Object[]) map.get("service"))[0];
    String v = (String) ((Object[]) map.get("v"))[0];
    String sec_id = (String) ((Object[]) map.get("sec_id"))[0];
    String notify_data = (String) ((Object[]) map.get("notify_data"))[0];
    System.out.println("通知参数为："+"service=" + service + "&v=" + v + "&sec_id=" + sec_id + "&notify_data="+ notify_data);
    return "service=" + service + "&v=" + v + "&sec_id=" + sec_id + "&notify_data="
           + notify_data;
}
%>
<%
System.out.println("接收到通知!");
/**获得通知参数*/
Map map = request.getParameterMap();
/**获得通知签名*/
String sign = (String) ((Object[]) map.get("sign"))[0];
/**获得待验签名的数据*/
String verifyData = getVerifyData(map);
System.out.println("verifyData:"+verifyData);
boolean verified = false;
String notify_data = (String) ((Object[]) map.get("notify_data"))[0];
HashMap<String, String> notify_datainfo = null;
InputStream in = null;
try {
	in = new ByteArrayInputStream(notify_data.getBytes("UTF-8"));
	SAXReader reader = new SAXReader();
	Document doc = reader.read(in);
	
	Element root = doc.getRootElement();
	
	List es = root.elements();
	if(es != null && !es.isEmpty()){
		notify_datainfo = new HashMap<String,String>();
		int size = es.size();
		for(int i=0;i<size;i++){
			Element el = (Element)es.get(i);
			notify_datainfo.put(el.getName(),el.getTextTrim());
		}
	}
}catch(UnsupportedEncodingException e){
	e.printStackTrace();
}catch (DocumentException e){
	e.printStackTrace();
} finally{
	try{
		if(in != null) in.close();
	} catch(IOException e){
		System.err.println("chanet close inputstream error!");
	}
}
try {
	/**验签名*/
    verified = wapMD5Signature.verify(verifyData, sign, AlipayConfig.key);
} catch (Exception e) {
    e.printStackTrace();
}
/**验证签名通过*/
if (verified) {
	/**根据交易状态处理业务逻辑*/
	/**当交易状态成功，处理业务逻辑成功。仅回写success字符串*/
	if(notify_datainfo.get("trade_status")=="TRADE_FINISHED" || notify_datainfo.get("trade_status")=="TRADE_SUCCESS"){
		// out.print("成功");
	}
		String orderid=notify_datainfo.get("out_trade_no");
		OrderBase order = OrderHelper.getById(orderid);
		if(order != null && Tools.longValue(order.getOdrmst_orderstatus()) == 0){
			String total_fee = notify_datainfo.get("total_fee");
			double r3_amount = Tools.parseDouble(total_fee);
			
			OrderService os = (OrderService)Tools.getService(OrderService.class);
			int reValue = os.updateOrderStatus(order,r3_amount);
	        if(reValue == 0){
	        	logInfo("支付宝支付，非即时反馈，订单："+orderid+"支付成功！");
	        }
		}
		out.print("success");
	
} else {
	System.out.println("接收支付宝系统通知验证签名失败，请检查！");
    out.print("fail");
}

%>