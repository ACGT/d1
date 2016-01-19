<%@ page contentType="text/html; charset=UTF-8"  import="java.io.*,java.net.*,java.security.MessageDigest,org.apache.commons.codec.binary.Base64"%><%@include file="/inc/header.jsp"%>
<%@page import="org.dom4j.Document"%>
<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.io.SAXReader"%>
<%!
public static String postShipXml(String strxml,String apiUrl,String parternId,String customerId,String clientId){
	String responseString = "";
	try{
	//打开连接
		URL url = new URL(apiUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setDoOutput(true);
		connection.setRequestMethod("POST");
		OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8");
		//加密
		MessageDigest messagedigest = MessageDigest.getInstance("MD5");
		messagedigest.update((strxml + parternId).getBytes("UTF-8"));
		byte[] abyte0 = messagedigest.digest();
		String data_digest = new String(Base64.encodeBase64(abyte0));
		
		//开始时间
	
		
		//查询
		String queryString = "logistics_interface=" + URLEncoder.encode(strxml, "UTF-8")
				+ "&data_digest="+ URLEncoder.encode(data_digest,"UTF-8")
				+ "&clientId=" + URLEncoder.encode(clientId, "UTF-8");
		//System.out.println(queryString);
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
public static String shipprintOrder(HttpServletResponse response,String odrids,String parternId,String customerId,String clientId){
	
	
String apiUrl = "http://58.32.246.71:8000/CommonOrderModeBServlet.action";
//String apiUrl = "http://service.yto56.net.cn/CommonOrderModeBServlet.action";

//String parternId = "123456";
//	String clientId = "K10101010";
//	String customerId = "K10101010";
//String clientId = "KGJB00001";
//String customerId = "KGJB00001";
//String parternId = "7XnZRHNx";
//String customerId = "KGJB00001";

//String parternId = "123456";
//String mailNo = "5555555358";//申请但没有使用过的电子面单号

 String[] odrs=odrids.split(",");
int odrlen=odrs.length;
//for(int i=0; i<array.length; i++){
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMddHHmmssSSS");
		 String printpcs=fmt.format(new Date());
boolean ret=false;
for(int i=0;i<odrlen;i++)
{
	String odrid=odrs[i];
	if(Tools.isNull(odrid))continue;
	try{
 
	OrderMain odrm = (OrderMain)Tools.getManager(OrderMain.class).get(odrid);
		if(odrm==null)continue;
		try{
		if(!Tools.isNull(odrm.getOdrmst_goodsodrid())){
			continue;
		}
		}catch(Exception ex){
			continue;
		}
	

	//数据
	StringBuilder xmlBuilder = new StringBuilder();
	xmlBuilder.append("<RequestOrder>");
	xmlBuilder.append("<clientID>"+clientId+"</clientID>");//商家代码
	xmlBuilder.append("<logisticProviderID>YTO</logisticProviderID>");//物流公司ID
	xmlBuilder.append("<customerId>"+customerId+"</customerId>");//商家代码
	xmlBuilder.append("<txLogisticID>"+clientId+odrid+"</txLogisticID>");//物流订单号
	xmlBuilder.append("<tradeNo>1</tradeNo>");//业务交易号（可选）
	xmlBuilder.append("<totalServiceFee>1</totalServiceFee>");//总服务费[COD]
	xmlBuilder.append("<codSplitFee>1</codSplitFee>");//物流公司分润[COD]
	xmlBuilder.append("<orderType>1</orderType>");//订单类型(0-COD,1-普通订单,3-退货单)
	xmlBuilder.append("<serviceType>1</serviceType>");//服务类型(1-上门揽收, 2-次日达 4-次晨达 8-当日达,0-自己联系)。默认为0
	xmlBuilder.append("<flag>1</flag>");//订单flag标识，便于以后分拣和标识默认为 0
	xmlBuilder.append("<sendStartTime>"+format.format(new Date())+"</sendStartTime>");//物流公司上门取货时间段，通过“yyyy-MM-dd HH:mm s.S z”格式化，本文中所有时间格式相同。
	xmlBuilder.append("<sendEndTime>"+format.format(new Date())+"</sendEndTime>");//物流公司上门取货时间段，通过“yyyy-MM-dd HH:mm s.S z”格式化，本文中所有时间格式相同。
	xmlBuilder.append("<goodsValue>"+odrm.getOdrmst_gdsmoney()+"</goodsValue>");//商品金额，包括优惠和运费，但无服务费
	xmlBuilder.append("<itemsValue>0</itemsValue>");//代收金额
	xmlBuilder.append("<insuranceValue>0</insuranceValue>");//保值金额（暂时没有使用，默认为0.0）
	xmlBuilder.append("<special>1</special>");//商品类型（保留字段，暂时不用）
	xmlBuilder.append("<remark></remark>");//备注
	xmlBuilder.append("<deliverNo>1</deliverNo>");
	xmlBuilder.append("<type>1</type>");  //订单类型
	xmlBuilder.append("<totalValue>0</totalValue>");//goodsValue+总服务费
	xmlBuilder.append("<itemsWeight>1</itemsWeight>");//货物总重量
	xmlBuilder.append("<packageOrNot>1</packageOrNot>");
	xmlBuilder.append("<orderSource>1</orderSource>");
	xmlBuilder.append("<sender>");//发件人
	xmlBuilder.append("<name>D1优尚网</name>");//用户姓名
	xmlBuilder.append("<postCode>510440</postCode>");//邮编
	xmlBuilder.append("<phone>020-36675701</phone>");//用户电话
	xmlBuilder.append("<mobile></mobile>");//用户移动电话
	xmlBuilder.append("<prov>广东省</prov>");//用户所在省
	xmlBuilder.append("<city>广州市,白云区</city>");//用户所在市县（区）
	xmlBuilder.append("<address>D1优尚网</address>");//用户详细地址
	xmlBuilder.append("</sender>");
	xmlBuilder.append("<receiver>");//收件人
	xmlBuilder.append("<name>"+odrm.getOdrmst_rname().replace("&middot;", "").replace("(", "").replace(")", "").replace("&", "")+"</name>");
	xmlBuilder.append("<postCode>"+odrm.getOdrmst_rzipcode()+"</postCode>");
	xmlBuilder.append("<phone></phone>");
	xmlBuilder.append("<mobile>"+(odrm.getOdrmst_rphone().length()>11?odrm.getOdrmst_rphone().substring(0,11):odrm.getOdrmst_rphone())+"</mobile>");
	xmlBuilder.append("<prov>"+odrm.getOdrmst_rprovince()+"</prov>");
	//重庆市 南岸区
	String city=odrm.getOdrmst_rcity();
	if(!Tools.isNull(city)&&city.split(" ").length>1){
		city=city.replace(" ", ",");
	}
	xmlBuilder.append("<city>"+city+"</city>");
	xmlBuilder.append("<address>"+odrm.getOdrmst_raddress()+"</address>");

	xmlBuilder.append("</receiver>");
	xmlBuilder.append("<items>");
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrdtl_odrid", odrid));
	List<BaseEntity> list2 = Tools.getManager(OrderItemMain.class).getList(listRes, null, 0, 20);
	for(BaseEntity be:list2){
		OrderItemBase oi= (OrderItemBase)be;
		String gdsname=oi.getOdrdtl_gdsname();
		gdsname=gdsname.replace("%", "");
	xmlBuilder.append("<item>");
	xmlBuilder.append("<itemName>"+gdsname+"</itemName>");//商品名称
	xmlBuilder.append("<number>"+oi.getOdrdtl_gdscount()+"</number>");//商品数量
	xmlBuilder.append("<itemValue>"+Tools.getDouble(oi.getOdrdtl_finalprice().doubleValue(),2)+"</itemValue>");//商品单价（两位小数）
	xmlBuilder.append("</item>");
	}
	xmlBuilder.append("</items>");
	xmlBuilder.append("</RequestOrder>");
	long a = System.currentTimeMillis();
	System.out.println(xmlBuilder.toString());
	String responseString=postShipXml(xmlBuilder.toString(), apiUrl,parternId,customerId,clientId);
	//结束时间
	long b = System.currentTimeMillis();
	
	//响应时间
	long c = b - a;
	//System.err.print("响应时间："+c + "ms\n");
	
	System.err.print("请求的返回信息："+responseString);
	try{
		byte[] temp=responseString.getBytes("GBK");//这里写原编码方式
	    String newStr=new String(temp,"utf-8");//这里写转换后的编码方式
		 /*FileWriter fw2 = new FileWriter(new File("/var/ytmailnott.txt"),true);
			fw2.write(newStr+"时间"+new Date()+System.getProperty("line.separator"));
			fw2.write(responseString+"时间"+new Date()+System.getProperty("line.separator"));
			fw2.flush();
			fw2.close();*/
	 InputStream ini = new ByteArrayInputStream(responseString.getBytes("UTF-8"));
		SAXReader readeri = new SAXReader();
		InputStreamReader   isr   =   new   InputStreamReader(ini,"UTF-8");
			Document doc = readeri.read(isr);
			Element root = doc.getRootElement();
			 String succ=root.elementTextTrim("success"); // 备注
			//System.out.println(succ);
			 if(succ.equals("true")){
			Iterator resultdetail = root.elementIterator("orderMessage"); 
	  while (resultdetail.hasNext()) {
	   	   Element recordEle = (Element) resultdetail.next();
	   	   String mailNo=recordEle.elementTextTrim("mailNo"); // 快递单号
	   	String bigPen=recordEle.elementTextTrim("bigPen"); // 快递单号
	   	if(Tools.isNull(bigPen))bigPen="";
		boolean  sendflag=saveShipCode(odrid, "圆通快递", mailNo,bigPen,printpcs);
	   /* FileWriter fw = new FileWriter(new File("/var/ytmailno.txt"),true);
		fw.write("圆通单号="+mailNo+"=d1订单号="+odrid+"=大头笔="+bigPen+"==时间"+new Date()+System.getProperty("line.separator"));
		fw.flush();
		fw.close();*/
	   	if(sendflag){
	   		ret=true;
	   	}else{
	   		cancelshipcode(odrid,parternId,customerId,clientId,mailNo);
	   	}
	  }
			 } 
}catch(Exception e){
	continue;
}
}catch(Exception ex){
	continue;
}

}
if(!ret)printpcs="";
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
public static boolean cancelshipcode(String odrid,String parternId,String customerId,String clientId,String mailNo){
// String apiUrl = "http://service.yto56.net.cn/CommonOrderModeBServlet.action";
 String apiUrl = "http://58.32.246.71:8000/CommonOrderModeBServlet.action";
	//测试环境：http://112.64.239.247:7800/web/CommonOrderModeBServlet.action
	//	生产环境：http://service.yto56.net.cn/CommonOrderModeBServlet.action
OrderMain odrm = (OrderMain)Tools.getManager(OrderMain.class).get(odrid);
	if(odrm==null)return false;
	String shipcode=odrm.getOdrmst_goodsodrid();
	if(!Tools.isNull(mailNo))shipcode=mailNo;
		//数据
		StringBuilder xmlBuilder = new StringBuilder();
		xmlBuilder.append("<UpdateInfo>");
		xmlBuilder.append("<logisticProviderID>YTO</logisticProviderID>");
		xmlBuilder.append("<clientID>"+clientId+"</clientID>");
		xmlBuilder.append("<mailNo>"+shipcode+"</mailNo>");
		xmlBuilder.append("<txLogisticID>"+clientId+odrid+"</txLogisticID>");
		xmlBuilder.append("<infoType>INSTRUCTION</infoType>");
		xmlBuilder.append("<infoContent>WITHDRAW</infoContent>");
		xmlBuilder.append("<remark>商品没了</remark>");
		xmlBuilder.append("</UpdateInfo>");
		long a = System.currentTimeMillis();
		System.err.print(xmlBuilder.toString());
		String responseString=postShipXml(xmlBuilder.toString(), apiUrl,parternId,customerId,clientId);
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
				 String succ=root.elementTextTrim("success"); // 备注
				 //System.out.println(succ);
				 if(succ.equals("true")){
					 FileWriter fw = new FileWriter(new File("/var/ytmailno.txt"),true);
						fw.write("取消圆通单号="+shipcode+"=d1订单号="+odrid+"==时间"+new Date()+System.getProperty("line.separator"));
						fw.flush();
						fw.close();
						odrm.setOdrmst_ads1("");
						odrm.setOdrmst_goodsodrid("");
						odrm.setOdrmst_d1shipmethod("");
						Tools.getManager(OrderMain.class).update(odrm, true);
						 
					 
					 return true;
				 } 
	}catch(Exception e){
		e.printStackTrace();
	}
		return false;
}
%>
<%/*
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "odr_printyt");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}*/
//测试账号：K21000119          秘钥： u2Z1F7Fh
String parternId = "u2Z1F7Fh";
String clientId = "K21000119";
String customerId = "K21000119";
String odrid=request.getParameter("odrid");
String type=request.getParameter("type");//n创建新订单   c取消订单

if("c".equals(type)){
	boolean t=cancelshipcode(odrid,parternId,customerId,clientId,"");
	if(t){
	out.print("取消成功！！！");
	}else{
		out.print("取消失败！！！");
	}
}else{

String pcnos= shipprintOrder(response,odrid,parternId,customerId,clientId);
if(Tools.isNull(pcnos)){
	out.print("获取快递单号错误");
}else{
response.sendRedirect("/admin/OrderM/odrprintytlist.jsp?pcnos="+pcnos);
}
}

%>