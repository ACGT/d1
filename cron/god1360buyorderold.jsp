<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.io.File,
java.io.FileWriter,
java.io.IOException,
java.text.SimpleDateFormat,
java.util.ArrayList,
java.util.List,
java.util.Date,
net.sf.json.JSONArray,
net.sf.json.JSONObject,
com.d1.bean.Sku,
com.d1.bean.Product,
com.d1.bean.OrderCache,
com.d1.helper.ProductHelper,
com.d1.helper.SkuHelper,
com.d1.service.Order360buyService,
com.d1.util.Tools,
org.apache.commons.lang.StringEscapeUtils,
com.jd.open.api.sdk.*,
com.jd.open.api.sdk.request.order.*,
com.jd.open.api.sdk.response.order.*
"%>

<%
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	String url="http://gw.api.360buy.com/routerjson";
	//String app_Key="3CE1352FB4E8F1F90D215D3F17938D17";
	//String app_Secret="ba4bdb36428c46af8106f47e73f84742";
	//http://auth.sandbox.360buy.com/oauth/authorize?response_type=code&client_id=C60AE89B30E7797244148D17C3C59517&redirect_uri=http://www.d1.com.cn/cron/tt.jsp&state=d1jd&scope=read
String app_Key="3CE1352FB4E8F1F90D215D3F17938D17";
	String app_Secret="ba4bdb36428c46af8106f47e73f84742";
	String accessToken = "274e9ca8-7534-452b-90d8-45848f8cc732";

	 JdClient client = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
	OrderSearchRequest request1 = new OrderSearchRequest();
	SimpleDateFormat  df2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	request1.setStartDate("2012-12-05 18:19:00");
	request1.setEndDate(df2.format(new Date()));
	request1.setOrderState("WAIT_SELLER_STOCK_OUT");
	request1.setPage("1");
	request1.setPageSize("100");
	OrderSearchResponse response1 = client.execute(request1);
	//out.println(response1.getMsg());
	String reqmst=response1.getMsg();
	 JSONObject  jsonob = JSONObject.fromObject(reqmst); 
	 String json_order_search = jsonob.getString("order_search_response");  
	 JSONObject  json_order = JSONObject.fromObject(json_order_search); 
	 String json_order_str=json_order.getString("order_search");
	 JSONObject  jsonorder = JSONObject.fromObject(json_order_str); 
	 int json_order_total=Tools.parseInt(jsonorder.getString("order_total"));
	 if (json_order_total>0){
		 JSONArray jsons = jsonorder.getJSONArray("order_info_list");  
	      int jsonLength = jsons.size();  
	      //对json数组进行循环  
	      //jsonLength=1;
	        for (int i = 0; i < jsonLength; i++) {  
	        	 String order_id_360buy = "";
	        	try{
	        	 JSONObject tempJson = JSONObject.fromObject(jsons.get(i));
	        	 order_id_360buy = StringEscapeUtils.escapeSql(tempJson.getString("order_id")); 
	        	 Order360buyService os = (Order360buyService)Tools.getService(Order360buyService.class);
	        	 JdClient client2 = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
	        	 OrderPrintDataGetRequest request2 = new OrderPrintDataGetRequest();
	        	 request2.setOrderId(order_id_360buy);
	        	 OrderPrintDataGetResponse response2 = client2.execute(request2);
	        	 //System.out.println(response2.getMsg()); 
	        	 String Printreqmsg=response2.getMsg();
	        	 JSONObject  jsonob2 = JSONObject.fromObject(Printreqmsg); 
	        	 String order_printdata_response = jsonob2.getString("order_printdata_response");  
	        	// System.out.println("order_printdata_response:"+order_printdata_response);
	        	 JSONObject  print_order = JSONObject.fromObject(order_printdata_response); 
	       
	        	 String print_order_str=print_order.getString("order_printdata");
	        	 JSONObject  jsonorder2 = JSONObject.fromObject(print_order_str); 
	         	 String cky2_name= jsonorder2.getString("cky2_name");
	         	 if (cky2_name.indexOf("LBP -")>=0){
	         	  cky2_name=cky2_name.replace("LBP - ", "");
	         	 }
	        	 //System.out.println("cky2_name:"+cky2_name);
	        	 if (request.getParameter("log")!=null&&request.getParameter("log").equals("1")){
	        	 FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
			        fw.write(tempJson.toString());
			        fw.flush();
			        fw.close();
	        	 }
	        	 
	            OrderCache orderd1 = os.createOrderFrom360Buy(tempJson);

	            if(orderd1!=null){System.out.println("京东商城订单:"+order_id_360buy+"----复制到d1订单成功，orderId="+orderd1.getId());}
	            else{
	            	System.out.println("京东商城订单:"+order_id_360buy+"----已经同步过");
	            }
	        	}catch(Exception ex ){
	        		//ex.printStackTrace();
	        		FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
			        fw.write("京东同订单号：="+order_id_360buy+"出错");
			        fw.flush();
			        fw.close();
	        		continue;
	        	}
	        	}
	            
	      
	 }

}
%>