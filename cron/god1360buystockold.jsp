<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.io.File,
java.io.FileWriter,
java.io.IOException,
java.text.SimpleDateFormat,
java.util.ArrayList,
java.util.List,
net.sf.json.JSONArray,
net.sf.json.JSONObject,
com.d1.bean.Sku,
com.d1.bean.Product,
com.d1.helper.ProductHelper,
com.d1.helper.SkuHelper,
com.d1.util.Tools,
com.jd.ac.sdk.api.DefaultJdClient,
com.jd.ac.sdk.api.JdClient,
com.jd.ac.sdk.api.JdException,
com.jd.ac.sdk.api.request.ware.WareIdsSearchRequest,
com.jd.ac.sdk.api.request.ware.WareSkuSearchRequest,
com.jd.ac.sdk.api.request.ware.WareSkuStockUpdateRequest,
com.jd.ac.sdk.api.response.ware.WareIdsSearchResponse,
com.jd.ac.sdk.api.response.ware.WareSkuSearchResponse,
com.jd.ac.sdk.api.response.ware.WareSkuStockUpdateResponse"%><%!
public  synchronized void up360buystock(){
	//------------------------------取所有上架商品京东商品ID---------------------------------

	String url="http://gw.shop.360buy.com/routerjson";
	String vender_id="31491";
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
	stockUpGo(reqmstpage,url,vender_id,vender_key);
 }

	
}

public  synchronized void stockUpGo(String gdsware,String url,String vender_id,String vender_key){
	//String url="http://gw.shop.360buy.com/routerjson";
	//String vender_id="10521";
	//String vender_key="769277E9690036242E89CF6A0504C40F";
	JSONObject  jsonob = JSONObject.fromObject(gdsware); 
 	 String ware_ids_search = jsonob.getString("ware_ids_search_response");  
   	 //System.out.println("ware_ids_search_response:"+ware_ids_search);
   	JSONObject  jsonware = JSONObject.fromObject(ware_ids_search); 
   	String ware_ids = jsonware.getString("ware_ids");  
   //System.out.println("ware_ids:"+ware_ids);
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
	        	//System.out.println(jsons.get(i));
	        	idList.add(jsons.get(i).toString());
	        }
	     req.setIdList(idList);
	   	 WareSkuSearchResponse rsp;
	
			rsp = clientgds.execute(req);
	
	   	String rspsku= rsp.getMsg();
	   		//System.out.println(rsp.getMsg());
	   		JSONObject  jsonsku = JSONObject.fromObject(rspsku); 
			String ware_sku_search = jsonsku.getString("ware_sku_search_response");  
		   	 //System.out.println("ware_sku_search_response:"+ware_sku_search);
		   	JSONObject  ware_sku = JSONObject.fromObject(ware_sku_search); 
		   	String sku_search = ware_sku.getString("sku_search");  
		   //	System.out.println("sku_search:"+sku_search);
			 JSONObject  jsonsku_search = JSONObject.fromObject(sku_search); 
			 int json_sku_total=Tools.parseInt(jsonsku_search.getString("sku_total"));
			 if (json_sku_total>0){
			      JSONArray jsonsgds = jsonsku_search.getJSONArray("sku_info_list");  
			      int jsonskulen = jsonsgds.size();  
			        for (int i = 0; i < jsonskulen; i++) {  
			        	//System.out.println(jsonsgds.get(i));
			        	 JSONObject Jsonsku = JSONObject.fromObject(jsonsgds.get(i));
			        	 String sku_id = Jsonsku.getString("sku_id"); 
			        	 String outer_sku_id = Jsonsku.getString("outer_sku_id");
			        	 String productId="";
			        	 String psku="";
			        	 if(outer_sku_id.length()>8){
							 productId=outer_sku_id.substring(0, 8);
							 psku=repstr(outer_sku_id.substring(8));
							}
			        	 Sku sku=SkuHelper.getSku(productId, psku);
			        	 Product product=ProductHelper.getById(productId);
			        	 long  skustockcount=0;
			        	 if (sku!=null&&product!=null){
			        		// System.out.println("sku_ID:"+sku_id+"商品ID:"+productId+"---sku:"+psku+"库存："+sku.getSkumst_stock().longValue());
			        		if ("03000091".equals(productId)){
			        		skustockcount=sku.getSkumst_vstock().longValue()+5;
			        		}else{
			        		 skustockcount=sku.getSkumst_vstock().longValue();
			        		}
			              
			        		 if (skustockcount<=0||sku.getSkumst_validflag().longValue()==0||product.getGdsmst_validflag()==null|| product.getGdsmst_validflag().longValue()!=1){
			        			 skustockcount=0;
			        		 }
			        		 JdClient clientstock = new DefaultJdClient(url, vender_id,vender_key);
				        	 WareSkuStockUpdateRequest reqstock = new WareSkuStockUpdateRequest();
				        	 reqstock.setTradeNo(Long.toString(System.currentTimeMillis()));
				        	 reqstock.setSkuId(sku_id);
				        	 reqstock.setSkuSubtractNum(skustockcount+"");
				        	 WareSkuStockUpdateResponse rspstock = clientstock.execute(reqstock);
				        	 String repstockmsg=rspstock.getMsg();
				        	 if(repstockmsg==null){
				        		 System.out.println("库存更新失败="+outer_sku_id+"---京东SKUID："+sku_id);
				        		  try {
				        		FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
				     			fw.write(System.getProperty("line.separator")+"库存更新失败="+outer_sku_id+System.getProperty("line.separator"));
				     			fw.flush();
				     			fw.close();
								} catch (IOException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
				        	 }
				        	 //else{
				        	//	 System.out.println("库存更新成功="+outer_sku_id+"---京东SKUID："+sku_id+"库存为："+skustockcount);
				        	 //}
			        	 }
			        	 else{
			        		 try {
					        		FileWriter fw = new FileWriter(new File("/var/buy360error.txt"),true);
					     			fw.write(System.getProperty("line.separator")+"库存更新失败=京东SKUID="+sku_id+"外部ID="+outer_sku_id+System.getProperty("line.separator"));
					     			fw.flush();
					     			fw.close();
									} catch (IOException e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
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
	str=str.replace("k", "红色");
	str=str.replace("g", "紫色");
	str=str.replace("n", "灰色");
	str=str.replace("z", " ");
	return str;
}
%>
<%
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
up360buystock();
}
%>