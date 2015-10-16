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
com.d1.helper.ProductHelper,
com.d1.helper.SkuHelper,
com.d1.util.Tools,
com.jd.open.api.sdk.*,
com.jd.open.api.sdk.request.ware.*,
com.jd.open.api.sdk.response.ware.*
"%><%!
public  synchronized void up360buystock(){
	//------------------------------取所有上架商品京东商品ID---------------------------------
	String url="http://gw.api.360buy.com/routerjson";
	String app_Key="3CE1352FB4E8F1F90D215D3F17938D17";
	String app_Secret="ba4bdb36428c46af8106f47e73f84742";
	String accessToken = "fdc5b188-6f3e-4019-afe9-9b72490d74e4";
	 JdClient client = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
	 WareListingGetRequest request1 = new WareListingGetRequest();
	 request1.setCid("");//分类号
	 request1.setPage("1");
	 request1.setPageSize("10");
	// SimpleDateFormat  df2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	// request1.setStartModified("2012-04-05 18:19:00");
	// request1.setEndModified(df2.format(new Date()));
	String reqmst="";
	try {
	 WareListingGetResponse response1 = client.execute(request1);
	  reqmst=response1.getMsg();
	} catch (JdException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//System.out.print(reqmst);
	 JSONObject  jsonob = JSONObject.fromObject(reqmst); 
	 String ware_ids_search = jsonob.getString("ware_listing_get_response");  
	 JSONObject  jsonware = JSONObject.fromObject(ware_ids_search); 
	 int json_total=Tools.parseInt(jsonware.getString("total"));//上架商品数量
	
	 for(int k=1;k<=(json_total/10+1);k++){
		 //System. out.print("总数："+json_total+"页数："+k);
		 JdClient clientpage = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
		 WareListingGetRequest requestpage = new WareListingGetRequest();
			requestpage.setCid("");//分类号
			requestpage.setPage(k+"");
			requestpage.setPageSize("10");
			String reqmstpage="";
			try {
				WareListingGetResponse responsepage = clientpage.execute(requestpage);
				reqmstpage=responsepage.getMsg();
			} catch (JdException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 stockUpGo(reqmstpage, url, app_Key, app_Secret, accessToken);
	 }
}
public  synchronized void stockUpGo(String gdsware,String url,String app_Key,String app_Secret,String accessToken){
	JSONObject  jsonob = JSONObject.fromObject(gdsware); 
 	 String ware_ids_search = jsonob.getString("ware_listing_get_response");  
   	 //System.out.println("ware_ids_search_response:"+ware_ids_search);
   	JSONObject  jsonware = JSONObject.fromObject(ware_ids_search); 
   	JSONArray jsonArray = (JSONArray) jsonware.get("ware_infos");
	for (int i = 0; i < jsonArray.size(); ++i) {
        JSONObject o = (JSONObject) jsonArray.get(i);
       String wareid=o.getString("ware_id");//京东对应的商品ID
       //String outerid=o.getString("outer_id");//外部商品ID
       String item_num=o.getString("item_num");//商品货号
       //根据商品ID获取京东SKU
       JdClient client = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
       WareSkusGetRequest wareSkusGetRequest= new WareSkusGetRequest();
       wareSkusGetRequest.setWareIds(wareid);
       String reqmst="";
       try{
    	   WareSkusGetResponse res = client.execute(wareSkusGetRequest);
    	   reqmst=res.getMsg();
       } catch (JdException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       JSONObject  jsonoc = JSONObject.fromObject(reqmst); 
  	   String ware_skus = jsonoc.getString("ware_skus_get_response");
  	 JSONObject  jsonsku = JSONObject.fromObject(ware_skus); 
  	  JSONArray jsonSkuArray = (JSONArray) jsonsku.get("skus");
  	for (int j = 0; j < jsonSkuArray.size(); ++j) {
  		 JSONObject skuinfo = (JSONObject) jsonSkuArray.get(j);
  		String outer_sku_id=skuinfo.getString("outer_id");//外部SKU 即商品编号+SKU
  		String sku_id=skuinfo.getString("sku_id");
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

    		 skustockcount=sku.getSkumst_vstock().longValue()-1;

          
    		 if (skustockcount<=0||sku.getSkumst_validflag().longValue()==0||product.getGdsmst_validflag()==null|| product.getGdsmst_validflag().longValue()!=1){
    			 skustockcount=0;
    		 }
    		 JdClient clientstock = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
        	 WareSkuStockUpdateRequest reqstock = new WareSkuStockUpdateRequest();
        	 reqstock.setTradeNo(Long.toString(System.currentTimeMillis()));
        	 reqstock.setSkuId(sku_id);
        	 reqstock.setQuantity(skustockcount+"");
        	 reqstock.setOuterId(outer_sku_id);
        	 String repstockmsg="";
        	 try{
        	 	WareSkuStockUpdateResponse rspstock = clientstock.execute(reqstock);
        	  repstockmsg=rspstock.getMsg();
        	 }catch (JdException e) {
     			// TODO Auto-generated catch block
     			e.printStackTrace();
     		}
        	// System.out.println(repstockmsg);
        	 if(Tools.isNull(repstockmsg)){
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
        	 }else{
        		// System.out.println("库存更新成功="+wareid+"---京东SKUID："+sku_id+"外部SKU："+outer_sku_id+"库存数："+skustockcount);
        	 }
    	 }else{
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
	str=str.replace("u", "浅灰色");
	str=str.replace("v", "棕色");
	str=str.replace("k", "红色");
	str=str.replace("g", "紫色");
	str=str.replace("n", "灰色");
	str=str.replace("f", "均码");
	str=str.replace("z", " ");
	return str;
}
%>

<%
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	up360buystock();
	/**
	String url="http://gw.api.sandbox.360buy.com/routerjson";
	//String vender_id="31491";
	//String vender_key="769277E9690036242E89CF6A0504C40F";
	//String app_Key="3CE1352FB4E8F1F90D215D3F17938D17";
	//String app_Secret="ba4bdb36428c46af8106f47e73f84742";
	//String accessToken = "5fb44222-6372-4248-94e2-9c84c37e6bae";
	//http://auth.sandbox.360buy.com/oauth/authorize?response_type=code&client_id=C60AE89B30E7797244148D17C3C59517&redirect_uri=http://www.d1.com.cn/cron/tt.jsp&state=d1jd&scope=read
String app_Key="C60AE89B30E7797244148D17C3C59517";
String app_Secret="f2a38f2ac8b14704858297e01084209d";
String accessToken = "beefbfe9-6c4f-46ac-88b7-d3012e996ea9";


	 JdClient client = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
	 WareListingGetRequest request1 = new WareListingGetRequest();
	 request1.setCid("");//分类号
	 request1.setPage("1");
	 request1.setPageSize("2");
	// SimpleDateFormat  df2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	// request1.setStartModified("2012-04-05 18:19:00");
	// request1.setEndModified(df2.format(new Date()));
	 //WareListingGetResponse response1 = client.execute(request1);
	// String reqmst=response1.getMsg();
	 //JSONObject  jsonob = JSONObject.fromObject(reqmst); 
	// String ware_ids_search = jsonob.getString("ware_listing_get_response");  
	 //JSONObject  jsonware = JSONObject.fromObject(ware_ids_search); 
	 //int json_total=Tools.parseInt(jsonware.getString("total"));//上架商品数量
	 //String ware_ids = jsonware.getString("ware_infos");  
	// JSONObject  jsonware_ids = JSONObject.fromObject(ware_ids); 
	 
	// JSONArray jsons = jsonware_ids.getJSONArray("ware_id");  //京东对应的商品ID
	//JSONArray jsonArray = (JSONArray) jsonware.get("ware_infos");
	//for (int i = 0; i < jsonArray.size(); ++i) {
      //  JSONObject o = (JSONObject) jsonArray.get(i);
       // out.println("ware_id:" + o.getString("ware_id") );
   // }
	 /**
	 for(int k=1;k<=(json_total/10+1);k++){
		 JdClient clientpage = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
		 WareListingGetRequest requestpage = new WareListingGetRequest();
			requestpage.setCid("");//分类号
			requestpage.setPage(k+"");
			requestpage.setPageSize("10");
			String reqmstpage="";
			try {
				WareListingGetResponse responsepage = clientpage.execute(requestpage);
				reqmstpage=responsepage.getMsg();
			} catch (JdException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	 }
	 **/
	 //out.print(jsonware_ids.size());
	// out.print(reqmst);
	/**
	 WareSkusGetRequest wareSkusGetRequest= new WareSkusGetRequest();
       wareSkusGetRequest.setWareIds("1100201842");
       String reqmst="";
       try{
    	   WareSkusGetResponse res = client.execute(wareSkusGetRequest);
    	   reqmst=res.getMsg();
       } catch (JdException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      
       JSONObject  jsonoc = JSONObject.fromObject(reqmst); 
  	   String ware_skus = jsonoc.getString("ware_skus_get_response");
  	 JSONObject  jsonsku = JSONObject.fromObject(ware_skus); 
  	  JSONArray jsonSkuArray = (JSONArray) jsonsku.get("skus");
  	for (int j = 0; j < jsonSkuArray.size(); ++j) {
  		 JSONObject skuinfo = (JSONObject) jsonSkuArray.get(j);
  		String outer_sku_id=skuinfo.getString("outer_id");//外部SKU 即商品编号+SKU
  		String sku_id=skuinfo.getString("sku_id");
    		//out.print(sku_id);
  		 JdClient clientstock = new DefaultJdClient(url, accessToken, app_Key, app_Secret);
    	 WareSkuStockUpdateRequest reqstock = new WareSkuStockUpdateRequest();
    	 //reqstock.setTradeNo(Long.toString(System.currentTimeMillis()));
    	 reqstock.setSkuId(sku_id);
    	 reqstock.setQuantity((j+5)+"");
    	 reqstock.setOuterId(outer_sku_id);
    	 String repstockmsg="";
    	 try{
    	 	WareSkuStockUpdateResponse rspstock = clientstock.execute(reqstock);
    	  repstockmsg=rspstock.getMsg();
    	 }catch (JdException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    	 if(Tools.isNull(repstockmsg)){
    		 System.out.println("库存更新失败="+outer_sku_id+"---京东SKUID："+sku_id);
    	 }
 	 }
  	
  	out.print(reqmst);
  **/
}
%>