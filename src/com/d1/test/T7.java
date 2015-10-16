package com.d1.test;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.d1.bean.Sku;
import com.d1.helper.SkuHelper;
import com.d1.util.Tools;
import com.jd.ac.sdk.api.DefaultJdClient;
import com.jd.ac.sdk.api.JdClient;
import com.jd.ac.sdk.api.JdException;
import com.jd.ac.sdk.api.request.ware.WareIdsSearchRequest;
import com.jd.ac.sdk.api.request.ware.WareSkuSearchRequest;
import com.jd.ac.sdk.api.response.ware.WareIdsSearchResponse;
import com.jd.ac.sdk.api.response.ware.WareSkuSearchResponse;

public class T7{
	public static void main(String[] args)throws Exception{
		//------------------------------取所有上架商品京东商品ID---------------------------------
		SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		java.util.Date   nowszf=new   java.util.Date();  
		String url="http://gw.shop.360buy.com/routerjson";
		String vender_id="10521";
		String vender_key="769277E9690036242E89CF6A0504C40F";
		JdClient client = new DefaultJdClient(url, vender_id,vender_key);
		WareIdsSearchRequest request = new WareIdsSearchRequest();
		//List<Field> queryFields = new ArrayList<Field>();
		//Field field = new Field("product_no","1");
		//queryFields.add(field);
		//request.setQueryFields(queryFields);
		request.setWareState("selling");
		//request.setStartTime("2011-06-01 10:00:00");
		//request.setEndTime("2011-8-25 10:00:00");
		request.setStartTime("");
		request.setEndTime("");
		request.setPage("1");
		request.setPageSize("10");
		WareIdsSearchResponse response = client.execute(request);
         String reqmst=response.getMsg();
		System.out.println(response.getMsg());
		
		//reqmst="{\"ware_ids_search_response\": {\"ware_ids\":{\"vender_id\":10521,\"ware_id_list\":[\"1100011962\",\"1100017482\",\"1100018827\"],\"ware_total\":3},\"code\":\"0\"}}";
		JSONObject  jsonob = JSONObject.fromObject(reqmst); 
    	
   	 String ware_ids_search = jsonob.getString("ware_ids_search_response");  
   //	 System.out.println("ware_ids_search_response:"+ware_ids_search);
   	JSONObject  jsonware = JSONObject.fromObject(ware_ids_search); 
   	String ware_ids = jsonware.getString("ware_ids");  
   	System.out.println("ware_ids:"+ware_ids);
	 JSONObject  jsonware_ids = JSONObject.fromObject(ware_ids); 
	 
	//------------------------------取所有上架商品京东商品SKU_ID,及对应D1商品的商品ID和SKU---------------------------------
	 
	
	 int json_order_total=Tools.parseInt(jsonware_ids.getString("ware_total"));
	 for(int k=13;k<=(json_order_total/10+1);k++){
		 JdClient clientpage = new DefaultJdClient(url, vender_id,vender_key);
			WareIdsSearchRequest requestpage = new WareIdsSearchRequest();
			requestpage.setWareState("selling");
			requestpage.setPage(k+"");
			requestpage.setPageSize("10");
		WareIdsSearchResponse responsepage = clientpage.execute(requestpage);
     String reqmstpage=responsepage.getMsg();
		System.out.println(reqmstpage);
		stockUpGo(reqmstpage);
	 }
	
		
	}
	
	public static void up360buystock(){
		//------------------------------取所有上架商品京东商品ID---------------------------------

		String url="http://gw.shop.360buy.com/routerjson";
		String vender_id="10521";
		String vender_key="769277E9690036242E89CF6A0504C40F";
		JdClient client = new DefaultJdClient(url, vender_id,vender_key);
		WareIdsSearchRequest request = new WareIdsSearchRequest();
		request.setWareState("selling");
		request.setStartTime("");
		request.setEndTime("");
		request.setPage("1");
		request.setPageSize("10");
		String reqmst="";
		try {
			WareIdsSearchResponse response = client.execute(request);
			  reqmst=response.getMsg();
		} catch (JdException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
		//System.out.println(response.getMsg());
		
		//reqmst="{\"ware_ids_search_response\": {\"ware_ids\":{\"vender_id\":10521,\"ware_id_list\":[\"1100011962\",\"1100017482\",\"1100018827\"],\"ware_total\":3},\"code\":\"0\"}}";
		JSONObject  jsonob = JSONObject.fromObject(reqmst); 
		
		 String ware_ids_search = jsonob.getString("ware_ids_search_response");  
		// System.out.println("ware_ids_search_response:"+ware_ids_search);
		JSONObject  jsonware = JSONObject.fromObject(ware_ids_search); 
		String ware_ids = jsonware.getString("ware_ids");  
		//System.out.println("ware_ids:"+ware_ids);
	 JSONObject  jsonware_ids = JSONObject.fromObject(ware_ids); 
	 
	//------------------------------取所有上架商品京东商品SKU_ID,及对应D1商品的商品ID和SKU---------------------------------
	 

	 int json_order_total=Tools.parseInt(jsonware_ids.getString("ware_total"));
	 for(int k=1;k<=(json_order_total/10+1);k++){
		 JdClient clientpage = new DefaultJdClient(url, vender_id,vender_key);
			WareIdsSearchRequest requestpage = new WareIdsSearchRequest();
			requestpage.setWareState("selling");
			requestpage.setPage(k+"");
			requestpage.setPageSize("10");
			String reqmstpage="";
		try {
			WareIdsSearchResponse responsepage = clientpage.execute(requestpage);
			reqmstpage=responsepage.getMsg();
		} catch (JdException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
		//System.out.println(reqmstpage);
		stockUpGo(reqmstpage);
	 }

		
	}
	
	public static synchronized void stockUpGo(String gdsware){
		String url="http://gw.shop.360buy.com/routerjson";
		String vender_id="10521";
		String vender_key="769277E9690036242E89CF6A0504C40F";
		JSONObject  jsonob = JSONObject.fromObject(gdsware); 
     	 String ware_ids_search = jsonob.getString("ware_ids_search_response");  
	   	 System.out.println("ware_ids_search_response:"+ware_ids_search);
	   	JSONObject  jsonware = JSONObject.fromObject(ware_ids_search); 
	   	String ware_ids = jsonware.getString("ware_ids");  
	   	System.out.println("ware_ids:"+ware_ids);
		 JSONObject  jsonware_ids = JSONObject.fromObject(ware_ids); 
		 //--------------------------取消京东商品SKU，及对应D1的商品ID和SKU-----------------------------------
			try {
		 JdClient clientgds = new DefaultJdClient(url, vender_id,vender_key);
		 WareSkuSearchRequest req = new WareSkuSearchRequest();
		 List<String > idList = new ArrayList<String >();
		 req.setIdType("JD_WARE");
		 
		 JSONArray jsons = jsonware_ids.getJSONArray("ware_id_list");  
			int jsonLength = jsons.size();  
		        for (int i = 0; i < jsonLength; i++) {  
		        	System.out.println(jsons.get(i));
		        	idList.add(jsons.get(i).toString());
		        }
		     req.setIdList(idList);
		   	 WareSkuSearchResponse rsp;
		
				rsp = clientgds.execute(req);
		
		   	String rspsku= rsp.getMsg();
		   		System.out.println(rsp.getMsg());
		   		JSONObject  jsonsku = JSONObject.fromObject(rspsku); 
				String ware_sku_search = jsonsku.getString("ware_sku_search_response");  
			   	// System.out.println("ware_sku_search_response:"+ware_sku_search);
			   	JSONObject  ware_sku = JSONObject.fromObject(ware_sku_search); 
			   	String sku_search = ware_sku.getString("sku_search");  
			   	System.out.println("sku_search:"+sku_search);
				 JSONObject  jsonsku_search = JSONObject.fromObject(sku_search); 
				 int json_sku_total=Tools.parseInt(jsonsku_search.getString("sku_total"));
				 if (json_sku_total>0){
				      JSONArray jsonsgds = jsonsku_search.getJSONArray("sku_info_list");  
				      int jsonskulen = jsonsgds.size();  
				   	//System.out.println("长度："+jsonskulen);
				      for (int i = 0; i < jsonskulen; i++) {  
				        	 JSONObject Jsonsku = JSONObject.fromObject(jsonsgds.get(i));
				        	 String sku_id = Jsonsku.getString("sku_id"); 
				        	 String outer_sku_id = Jsonsku.getString("outer_sku_id");
				        	 System.out.println(sku_id+"===="+outer_sku_id);
				        	 String productId="";
				        	 String psku="";
				        	 if(outer_sku_id.length()>8){
								 productId=outer_sku_id.substring(0, 8);
								 psku=repstr(outer_sku_id.substring(8));
								}
				        	 System.out.println("商品ID:"+productId+"---sku:"+psku);
				        	 Sku sku=SkuHelper.getSku(productId, psku);
				        	 long  skustockcount=0;
				        	 if (sku!=null&&sku.getSkumst_stock().longValue()>0){
				        		 System.out.println("sku_ID:"+sku_id+"商品ID:"+productId+"---sku:"+psku+"库存："+sku.getSkumst_stock().longValue());
				        		 skustockcount=sku.getSkumst_stock().longValue();
				        		 
				        		/* JdClient clientstock = new DefaultJdClient(url, vender_id,vender_key);
					        	 WareSkuStockUpdateRequest reqstock = new WareSkuStockUpdateRequest();
					        	 reqstock.setTradeNo(Long.toString(System.currentTimeMillis()));
					        	 reqstock.setSkuId(sku_id);
					        	 reqstock.setSkuSubtractNum(skustockcount+"");
					        	 WareSkuStockUpdateResponse rspstock = clientstock.execute(reqstock);
					        	 String repstockmsg=rspstock.getMsg();
					        	 if(repstockmsg==null){
					        		 System.out.println("库存更新失败="+outer_sku_id+"---京东SKUID："+sku_id);
					        		/*  try {
					        		FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
								
					     			fw.write(System.getProperty("line.separator")+"库存更新失败="+outer_sku_id+System.getProperty("line.separator"));
					     			fw.flush();
					     			fw.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}*/
					        	// }
					           // else{
					        	//	 System.out.println("库存更新成功="+outer_sku_id+"---京东SKUID："+sku_id+"库存为："+skustockcount);
					        	// }
				        	}
				        	 
				       

				        	 

				        }
				 }
		   		
		   		
		   		
			} catch (JdException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	/**
	 * i    (
o   )
-    /
t    (
y    )
黑色  #
白色  *
浅灰色u
棕色  v
空格  z
	 * @param str
	 * @return
	 */
	private static String repstr(String str){
		str=str.replace("i", "（");
		str=str.replace("o", "）");
		str=str.replace("-", "/");
		str=str.replace("t", "(");
		str=str.replace("y", ")");
		str=str.replace("#", "黑色");
		str=str.replace("*", "白色");
		str=str.replace("u", "灰色");
		str=str.replace("v", "棕色");
		str=str.replace("z", " ");
		return str;
	}
}
