<%@ page contentType="text/html; charset=UTF-8"  import="java.io.*,java.net.*,java.security.MessageDigest,org.apache.commons.codec.binary.Base64"%><%@include file="/inc/header.jsp"%>
<%@page import="org.dom4j.Document"%>
<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.io.SAXReader"%>
<%!
public static String postShipXml(String strxml,String apiUrl,String parternId,String servicetype,String msgId,String partnerKey){
	String responseString = "";
	try{
	//打开连接
		URL url = new URL(apiUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setDoOutput(true);
		connection.setRequestMethod("POST");
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8");
		//加密
		/*MessageDigest messagedigest = MessageDigest.getInstance("MD5");
		messagedigest.update((strxml + partnerKey).getBytes("UTF-8"));
		byte[] abyte0 = messagedigest.digest();
		String data_digest = new String(Base64.encodeBase64(abyte0));
		*/
		String digestString=strxml + partnerKey;
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(digestString.getBytes("UTF-8"));
		byte[] b = md.digest();
		
		//String data_digest =(new sun.misc.BASE64Encoder()).encode(b);
		String data_digest = new String(Base64.encodeBase64(b));
		//开始时间
	
		
		//查询
		String queryString = "bizData=" + URLEncoder.encode(strxml, "UTF-8")
				+ "&serviceType="+ URLEncoder.encode(servicetype,"UTF-8")
				+ "&digest="+ URLEncoder.encode(data_digest,"UTF-8")
				+ "&msgId="+ URLEncoder.encode(msgId,"UTF-8")
				+ "&parternID=" + URLEncoder.encode(parternId, "UTF-8");
		System.out.println(queryString);
		out.write(queryString);
		out.flush();
		out.close();
		//获取服务端的反馈
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				connection.getInputStream(), "UTF-8"));
		StringBuilder lines = new StringBuilder();
		String line = null;
		while ((line = reader.readLine()) != null) {
			lines.append(line);
		}
		reader.close();
		responseString=lines.toString();
		connection.disconnect();
		/*String strLine = "";
		InputStream in = connection.getInputStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(in));
		while ((strLine = reader.readLine()) != null) {
			responseString += strLine + "\n";
		}
		in.close();*/
	}catch(Exception e){
		e.printStackTrace();
	}
	return responseString;
}
public  static String  shipprintOrder(HttpServletResponse response,String odrid,String parternId,String partnerKey){
	
	
//String apiUrl = "http://112.64.239.247:7800/web/CommonOrderModeBServlet.action";
//String apiUrl = "http://183.129.172.49/ems/api/process";

	String apiUrl = "http://ebill.ns.800best.com/ems/api/process";
//String parternId = "123456";
//	String clientId = "K10101010";
//	String customerId = "K10101010";
//String clientId = "KGJB00001";
//String customerId = "KGJB00001";
//String parternId = "7XnZRHNx";
//String customerId = "KGJB00001";

//String parternId = "123456";
//String mailNo = "5555555358";//申请但没有使用过的电子面单号

 

//for(int i=0; i<array.length; i++){

    SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMddHHmmssSSS");
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String printpcs=fmt.format(new Date());
	//数据
	StringBuilder xmlBuilder = new StringBuilder();
xmlBuilder.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
xmlBuilder.append("<PrintRequest xmlns:ems=\"http://express.800best.com\">");  
xmlBuilder.append("<deliveryConfirm>false</deliveryConfirm>");
int n=5;
for(int i=0;i<n;i++)
{
	OrderMain odrm = (OrderMain)Tools.getManager(OrderMain.class).get(odrid);
		if(odrm==null)continue;
		try{
		if(!Tools.isNull(odrm.getOdrmst_goodsodrid())){
			continue;
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	
xmlBuilder.append("<EDIPrintDetailList>"); 
xmlBuilder.append("<sendMan><![CDATA[D1优尚网]]></sendMan>");  
xmlBuilder.append("<sendManPhone><![CDATA[400-680-8666]]></sendManPhone>");  
xmlBuilder.append("<sendManAddress><![CDATA[广州市 白云区]]></sendManAddress>");  
xmlBuilder.append("<sendPostcode><![CDATA[510440]]></sendPostcode>");  
xmlBuilder.append("<sendProvince><![CDATA[广东省]]></sendProvince>");  
xmlBuilder.append("<sendCity><![CDATA[广州市]]></sendCity>");  
xmlBuilder.append("<sendCounty><![CDATA[白云区]]></sendCounty>");  
xmlBuilder.append("<receiveMan><![CDATA["+odrm.getOdrmst_rname().replace("&middot;", "").replace("(", "").replace(")", "")+"]]></receiveMan>");  
xmlBuilder.append("<receiveManPhone><![CDATA["+(odrm.getOdrmst_rphone().length()>11?odrm.getOdrmst_rphone().substring(0,11):odrm.getOdrmst_rphone())+"]]></receiveManPhone>");  
xmlBuilder.append("<receiveManAddress><![CDATA["+odrm.getOdrmst_raddress()+"]]></receiveManAddress>");  
xmlBuilder.append("<receivePostcode><![CDATA["+odrm.getOdrmst_rzipcode()+"]]></receivePostcode>");  
xmlBuilder.append("<receiveProvince><![CDATA["+odrm.getOdrmst_rprovince()+"]]></receiveProvince>"); 
//重庆市 南岸区
	String city=odrm.getOdrmst_rcity();
    String[] cityarr=city.split(" ");
    String citytxt=cityarr[0];
    String Countytxt="";
	if(!Tools.isNull(city)&&city.split(" ").length>1){
		Countytxt=cityarr[1];
	}

xmlBuilder.append("<receiveCity><![CDATA["+city+"]]></receiveCity>");  
xmlBuilder.append("<receiveCounty><![CDATA["+Countytxt+"]]></receiveCounty>");  
xmlBuilder.append("<txLogisticID><![CDATA["+odrid+"]]></txLogisticID>");  
xmlBuilder.append("<itemName><![CDATA[]]></itemName>");  
xmlBuilder.append("<itemWeight><![CDATA[0]]></itemWeight>");  
xmlBuilder.append("<itemCount><![CDATA[1]]></itemCount>");  
xmlBuilder.append("<remark><![CDATA[备注]]></remark>"); 
xmlBuilder.append("</EDIPrintDetailList>");  
xmlBuilder.append("</PrintRequest>");
}
	System.out.println("请求的信息："+xmlBuilder.toString());
	long a = System.currentTimeMillis();
	System.out.println(xmlBuilder.toString());
	String responseString=postShipXml(xmlBuilder.toString(), apiUrl,parternId,"BillPrintRequest",odrid,partnerKey);
	//结束时间
	long b = System.currentTimeMillis();
	
	//响应时间
	long c = b - a;
	//System.err.print("响应时间："+c + "ms\n");
	
	System.err.print("请求的返回信息："+responseString);
	try{
		byte[] temp=responseString.getBytes("GBK");//这里写原编码方式
	    String newStr=new String(temp,"utf-8");//这里写转换后的编码方式
		 FileWriter fw2 = new FileWriter(new File("/var/bshtmailnott.txt"),true);
			fw2.write(newStr+"时间"+new Date()+System.getProperty("line.separator"));
			fw2.write(responseString+"时间"+new Date()+System.getProperty("line.separator"));
			fw2.flush();
			fw2.close();
	 InputStream ini = new ByteArrayInputStream(responseString.getBytes("UTF-8"));
		SAXReader readeri = new SAXReader();
		InputStreamReader   isr   =   new   InputStreamReader(ini,"UTF-8");
			Document doc = readeri.read(isr);
			Element root = doc.getRootElement();
			 String succ=root.elementTextTrim("result"); // 备注
			//System.out.println(succ);
			 if(succ.equals("SUCCESS")){
			Iterator resultdetail = root.elementIterator("EDIPrintDetailList"); 
	  while (resultdetail.hasNext()) {
	   	   Element recordEle = (Element) resultdetail.next();
	   	 String txodrid=recordEle.elementTextTrim("txLogisticID"); // 订单号
	   	   String mailNo=recordEle.elementTextTrim("mailNo"); // 快递单号
	   	String bigPen=recordEle.elementTextTrim("markDestination"); // 快递单号
	   	if(Tools.isNull(bigPen))bigPen="";
	   	boolean  sendflag=saveShipCode(odrid, "百世汇通", mailNo,bigPen,printpcs);
	    FileWriter fw = new FileWriter(new File("/var/ytmailno.txt"),true);
		fw.write("百世汇通="+mailNo+"=d1订单号="+odrid+"=大头笔="+bigPen+"==时间"+new Date()+System.getProperty("line.separator"));
		fw.flush();
		fw.close();
	   	if(!sendflag){
	   		cancelshipcode(odrid,parternId,partnerKey,"");
	   	}
	  }
			 } 
}catch(Exception e){
	e.printStackTrace();
}
return printpcs;
}
public static boolean saveShipCode(String id, String odrmst_d1shipmethod, String odrmst_goodsodrid,String bigpen,String printpcs) {
	try {
		String ordertbl = "main";
		OrderBase order = (OrderBase)Tools.getManager(OrderMain.class).get(id);
		
		if(order == null) {
			order = (OrderBase)Tools.getManager(OrderRecent.class).get(id);
			ordertbl = "recent";
		}
		//System.out.println(order);
		order.setOdrmst_ads1(bigpen);
		order.setOdrmst_goodsodrid(odrmst_goodsodrid);
		order.setOdrmst_d1shipmethod(odrmst_d1shipmethod);
		order.setOdrmst_ads2(printpcs);
		// System.err.print("更新百世汇通电子面单快递单号");
		if(ordertbl.equals("main")) {
			Tools.getManager(OrderMain.class).update(order, true);
		}
		else if (ordertbl.equals("recent")) {
			Tools.getManager(OrderRecent.class).update(order, true);
		}
		return true;
	} catch (Exception e) {
		e.printStackTrace();
		return false;
	}
}
public static boolean cancelshipcode(String odrid,String parternId,String partnerKey,String mailNo){
// String apiUrl = "http://183.129.172.49/ems/api/process";
 String apiUrl = "http://ebill.ns.800best.com/ems/api/process";
	//测试环境：http://112.64.239.247:7800/web/CommonOrderModeBServlet.action
	//	生产环境：http://service.yto56.net.cn/CommonOrderModeBServlet.action
OrderMain odrm = (OrderMain)Tools.getManager(OrderMain.class).get(odrid);
	if(odrm==null)return false;
	String shipcode=odrm.getOdrmst_goodsodrid();
	if(!Tools.isNull(mailNo))shipcode=mailNo;
		//数据
		StringBuilder xmlBuilder = new StringBuilder();
		xmlBuilder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
		xmlBuilder.append("<BillCodeFeedbackRequest xmlns:ems=\"http://express.800best.com\">");
	xmlBuilder.append("<removePrintFeedbackList>");
	xmlBuilder.append("<mailNo><![CDATA["+shipcode.trim()+"]]></mailNo>");
	xmlBuilder.append("</removePrintFeedbackList>");
	xmlBuilder.append("</BillCodeFeedbackRequest>");
 
		long a = System.currentTimeMillis();
		System.err.print("请求的取消信息："+xmlBuilder.toString());
		String responseString=postShipXml(xmlBuilder.toString(), apiUrl,parternId,"BillPrintDeliveryCancel",odrid,partnerKey);
		//结束时间
		long b = System.currentTimeMillis();
		
		//响应时间
		long c = b - a;
		System.err.print("响应时间："+c + "ms\n");
		
		System.err.print("请求的返回信息："+responseString);
		try{
		 InputStream ini = new ByteArrayInputStream(responseString.getBytes("UTF-8"));
			SAXReader readeri = new SAXReader();
			InputStreamReader   isr   =   new   InputStreamReader(ini,"UTF-8");
				Document doc = readeri.read(isr);
				Element root = doc.getRootElement();
				String succ=root.elementTextTrim("result"); // 备注
				//System.out.println(succ);
				 if(succ.equals("SUCCESS")){
					 FileWriter fw = new FileWriter(new File("/var/bshtmailno.txt"),true);
						fw.write("取消百世汇通单号="+shipcode+"=d1订单号="+odrid+"==时间"+new Date()+System.getProperty("line.separator"));
						fw.flush();
						fw.close();
						odrm.setOdrmst_ads1("");
						odrm.setOdrmst_goodsodrid("");
						odrm.setOdrmst_d1shipmethod("");
						Tools.getManager(OrderMain.class).update(odrm, true);
						 System.err.print("更新百世汇通电子面单取消");
					 
					 return true;
				 } 
	}catch(Exception e){
		e.printStackTrace();
	}
		return false;
}
%>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "odr_printyt");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}
String parternId = "510266_0002";
String partnerKey= "YWdODPZ0SBAm";
String odrid=request.getParameter("odrid");
String type=request.getParameter("type");//n创建新订单   c取消订单
String mailno=request.getParameter("mailno");//n创建新订单   c取消订单
if("c".equals(type)){
	boolean t=cancelshipcode(odrid,parternId,partnerKey,mailno);
	if(t){
	out.print("取消成功！！！");
	}else{
		out.print("取消失败！！！");
	}
}else{
String pcnos= shipprintOrder(response,odrid,parternId,partnerKey);
	response.sendRedirect("http://www.d1.com.cn/admin/OrderM/odrprintbshtlist.jsp?pcnos="+pcnos);

}

%>