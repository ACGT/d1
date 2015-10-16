package com.d1.test;
import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringEscapeUtils;
import org.codehaus.jackson.map.ObjectMapper;

import com.d1.bean.OrderCache;
import com.d1.service.Order360buyService;
import com.d1.util.Tools;
import com.jd.ac.sdk.api.DefaultJdClient;
import com.jd.ac.sdk.api.JdClient;
import com.jd.ac.sdk.api.request.order.OrderPrintDataGetRequest;
import com.jd.ac.sdk.api.request.order.OrderSearchOfflineRequest;
import com.jd.ac.sdk.api.response.order.OrderPrintDataGetResponse;
import com.jd.ac.sdk.api.response.order.OrderSearchOfflineResponse;

public class T6 {
	public static void main(String[] args)throws Exception{
		SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		java.util.Date   nowszf=new   java.util.Date();  
		String url="http://gw.shop.360buy.com/routerjson";
		String vender_id="10521";
		String vender_key="769277E9690036242E89CF6A0504C40F";
		JdClient client = new DefaultJdClient(url, vender_id,vender_key);
		OrderSearchOfflineRequest request = new OrderSearchOfflineRequest();
		request.setStartDate("2012-03-22 23:00:00");
		request.setEndDate(df2.format(new Date()));
		request.setOrderState("WAIT_SELLER_STOCK_OUT");
		request.setPage("1");
		request.setPageSize("1");
		//request.setOptionalFields("vender_id,order_id,pay_type,order_total_price,order_payment,freight_price,seller_discount");
		//request.setOptionalFields("order_state,order_state_remark,pay_type,order_total_price,order_payment,freight_price,seller_discount");
		OrderSearchOfflineResponse response = client.execute(request);
		System.out.println(response.getMsg());
	
		String reqmsg=response.getMsg();
    //reqmsg="{\"order_search_offline_response\":{\"order_search\":{\"order_total\":1,\"order_info_list\":[{\"vender_id\":\"10521\",\"order_id\":\"184379258\",\"order_state\":\"WAIT_SELLER_STOCK_OUT\",\"pay_type\":\"1-货到付款\",\"delivery_type\":\"工作日、双休日与假日均可送货\",\"order_total_price\":\"49.00\",\"order_payment\":\"45.00\",\"seller_discount\":\"4.00\",\"invoice_info\":\"发票类型:普通发票;发票抬头:个人;发票内容:明细;\",\"order_remark\":\"\",\"order_start_time\":\"2012-03-23 16:27:00\",\"consignee_info\":{\"province\":\"江苏\",\"city\":\"南京市\",\"county\":\"白下区\",\"fullname\":\"范翔\",\"telephone\":\"13815853887\",\"mobile\":\"13815853887    \",\"full_address\":\"江苏南京市白下区洪武路328号\"},\"item_info_list\":[{\"sku_id\":\"1002778661\",\"ware_id\":\"1001303970\",\"jd_price\":\"49.00\",\"sku_name\":\"【FEEL MIND】春季新款高弹修身纯色男士长袖T恤 三色 11-12501 白色 L\",\"gift_point\":\"0\",\"outer_sku_id\":\"01720270*zLi180-96Ao\",\"item_total\":\"1\"}]}]},\"code\":\"0\"}}";
		ObjectMapper mapper = new ObjectMapper();
	         try {
	        	 if(reqmsg.indexOf("order_search_offline_response")>=0){
	        	 JSONObject  jsonob = JSONObject.fromObject(reqmsg); 
	        	
	        	 String json_order_search = jsonob.getString("order_search_offline_response");  
	        	 System.out.println("order_search_offline_response:"+json_order_search);
	        	 JSONObject  json_order = JSONObject.fromObject(json_order_search); 
	       
	        	 String json_order_str=json_order.getString("order_search");
	        	 System.out.println("order_search:"+json_order);  
	        	 JSONObject  jsonorder = JSONObject.fromObject(json_order_str); 
	         	 int json_order_total=Tools.parseInt(jsonorder.getString("order_total"));
	        	 if (json_order_total>0){
	        	      JSONArray jsons = jsonorder.getJSONArray("order_info_list");  
	        	      int jsonLength = jsons.size();  
	        	      //对json数组进行循环  
	        	      //jsonLength=1;
	        	        for (int i = 0; i < jsonLength; i++) {  
	        	        	
	        	        	
	        	        	 JSONObject tempJson = JSONObject.fromObject(jsons.get(i));
	        	        	 String order_id_360buy = StringEscapeUtils.escapeSql(tempJson.getString("order_id")); 
	        	        	 Order360buyService os = (Order360buyService)Tools.getService(Order360buyService.class);
	        	        	 JdClient client2 = new DefaultJdClient(url, vender_id,vender_key);
	        	        	 OrderPrintDataGetRequest request2 = new OrderPrintDataGetRequest();
	        	        	 request2.setOrderId(order_id_360buy);
	        	        	 OrderPrintDataGetResponse response2 = client2.execute(request2);
	        	        	 System.out.println(response2.getMsg()); 
	        	        	 String Printreqmsg=response2.getMsg();
	        	        	 JSONObject  jsonob2 = JSONObject.fromObject(Printreqmsg); 
	        	        	 String order_printdata_response = jsonob2.getString("order_printdata_response");  
	        	        	 System.out.println("order_printdata_response:"+order_printdata_response);
	        	        	 JSONObject  print_order = JSONObject.fromObject(order_printdata_response); 
	        	       
	        	        	 String print_order_str=print_order.getString("order_printdata");
	        	        	 JSONObject  jsonorder2 = JSONObject.fromObject(print_order_str); 
	        	         	 String cky2_name= jsonorder2.getString("cky2_name");
	        	         	 if (cky2_name.indexOf("LBP -")>=0){
	        	         	  cky2_name=cky2_name.replace("LBP - ", "");
	        	         	 }
	        	        	 System.out.println("cky2_name:"+cky2_name);
	        	            OrderCache orderd1 = os.createOrderFrom360Buy(tempJson);
	        	            if(orderd1!=null)System.out.println("京东商城订单复制到d1订单成功，orderId="+orderd1.getId());
	        	            // String name = StringEscapeUtils.escapeSql(tempJson.getString("order_id"));  
	        	            //String age = StringEscapeUtils.escapeSql(tempJson.getString("pay_type"));  
	        	            //System.out.println(name+"-"+age);  
	        	       }  
	        	 }
	        	 }else{
	        		 JSONObject  jsonex = JSONObject.fromObject(reqmsg);  
		        	 String ex2 = jsonex.getString("error_response");  
		        	 System.out.print(ex2);
	        	 }
	        	 //order = mapper.readValue(reqmsg , JingDongOrder.class);
	        	 //System.out.println(order.getOrder_total());

		   } catch (Exception e) {
		    // TODO Auto-generated catch block
			   
		    e.printStackTrace();
		   } 



	}
}
