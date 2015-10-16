<%@page import="com.d1.helper.ProductHelper"%>
<%@page import="com.d1.Const"%>
<%@ page contentType="text/html; charset=UTF-8"%><%@page import="
java.text.SimpleDateFormat,
java.util.*,
org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document,java.security.*,
net.sf.json.JSONArray,
net.sf.json.JSONObject,
com.d1.bean.*,
com.d1.helper.*,
com.d1.util.*,
java.net.*,
java.io.*,
javax.xml.parsers.*,org.w3c.dom.*,
com.d1.dangdang.ApiConfigs,
com.d1.dangdang.HttpInvokeUtil"%>

<%!


private   String getAllProduct2(String pagesize,String currentpage){
	String method = "dangdang.items.list.get";
	Map<String, String> parameters = new HashMap<String, String>();
	parameters.put("datatype", "8990");
	parameters.put("its", "9999");
	parameters.put("is_cod","9999");
	parameters.put("is_gift","9999");
	parameters.put("its", "9999");
	parameters.put("its", "9999");
	parameters.put("pageSize",pagesize); 
	parameters.put("p",currentpage); 
	String relData = "";
	try{
		relData = HttpInvokeUtil.getMethod(method, parameters);
	}catch(Exception ex){
		
	}
	
	return relData;
}

//获取在当当上架的所有商品

private  HashMap<String, String> getAllProduct(String pagesize,String currentpage){
	String method = "dangdang.items.list.get";
	Map<String, String> parameters = new HashMap<String, String>();
	parameters.put("datatype", "8990");
	parameters.put("its", "9999");
	parameters.put("is_cod","9999");
	parameters.put("is_gift","9999");
	parameters.put("its", "9999");
	parameters.put("its", "9999");
	parameters.put("pageSize",pagesize); 
	parameters.put("p",currentpage); 
	String relData = "";
	try{
		relData = HttpInvokeUtil.getMethod(method, parameters);
	}catch(Exception ex){
		
	}
	
	//解析xml
	//relData=relData.replace("<![CDATA[", "").replace("]]>", "");
	
    HashMap<String, String> productinfo = null;
    InputStream in = null;
    try {
    	in = new ByteArrayInputStream(relData.getBytes("GBK"));
    	SAXReader reader = new SAXReader();
    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
		Document doc = reader.read(isr);
		
		Element root = doc.getRootElement();
		
		List es = root.elements();
		if(es != null && !es.isEmpty()){
			productinfo = new HashMap<String,String>();
			int size = es.size();
			for(int i=0;i<size;i++){
				Element el = (Element)es.get(i);
				//System.out.println(el.getName());
				if(el.getName().equals("totalInfo")){
					  //获取商品汇总信息（商品总数、总页数、当前页）
					//System.out.println(el.element("itemsCount").getTextTrim());
					productinfo.put("itemsCount",el.element("itemsCount").getTextTrim());
					productinfo.put("pageTotal",el.element("pageTotal").getTextTrim());
					productinfo.put("pageSize",el.element("pageSize").getTextTrim());
				}
				
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
	return productinfo;
}
public   void getProduct(String it){
	String method = "dangdang.item.get";
	Map<String, String> parameters = new HashMap<String, String>();
	parameters.put("it",it);
	String relData = "";
	try{
		relData = HttpInvokeUtil.getMethod(method, parameters);
	}catch(Exception ex){
		
	}
	//解析xml
		//relData=relData.replace("<![CDATA[", "").replace("]]>", "");
	
	
	    HashMap<String, String> productinfo = null;
	    InputStream in = null;
	    try {
	    	in = new ByteArrayInputStream(relData.getBytes("GBK"));
	    	SAXReader reader = new SAXReader();
	    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
			Document doc = reader.read(isr);
			
			Element root = doc.getRootElement();
			
			Iterator iter = root.elementIterator("ItemDetail"); // 获取根节点下的子节点ItemDetail

            // 遍历head节点
            while (iter.hasNext()) {

                Element recordEle = (Element) iter.next();
               Iterator iters = recordEle.elementIterator("SpecilaItemInfo"); // 获取子节点ItemDetail下的子节点SpecilaItemInfo
				if(recordEle.selectSingleNode("SpecilaItemInfo")==null){
					String outerItemID = recordEle.elementTextTrim("outerItemID"); 
					Product p=(Product)Tools.getManager(Product.class).get(outerItemID);
					long skustockcount=0; 
					if(p!=null && p.getGdsmst_virtualstock()!=null){
	        			 skustockcount=p.getGdsmst_virtualstock().longValue(); 
	        			
	        		 }
					 if(p==null||p.getGdsmst_validflag()==null||p.getGdsmst_validflag().longValue()!=1){
	        			 skustockcount=0;
	        		 }
					 if(p==null){
					 try {
		  	        		FileWriter fw = new FileWriter(new File("/var/ddstockerror.txt"),true);
		  	     			fw.write(System.getProperty("line.separator")+"当当ID："+it+"对应D1的商品"+outerItemID+"在D1商品没有找到");
		  	     			fw.flush();
		  	     			fw.close();
		  					} catch (IOException e) {
		  						// TODO Auto-generated catch block
		  						e.printStackTrace();
		  					}
						}
					updatestockone(outerItemID,skustockcount+"");
				}else{
                // 遍历Header节点下的Response节点
                while (iters.hasNext()) {

                    Element itemEle = (Element) iters.next();

                    String outerItemID = itemEle.elementTextTrim("outerItemID"); // 拿到ItemDetail下的子节点SpecilaItemInfo下的字节点outerItemID的值
                   if(Tools.isNull(outerItemID)){
                    	/*try {
		  	        		FileWriter fw = new FileWriter(new File("/var/ddstockerror.txt"),true);
		  	     			fw.write(System.getProperty("line.separator")+"当当ID："+it+"对应D1的商品编号为空");
		  	     			fw.flush();
		  	     			fw.close();
		  					} catch (IOException e) {
		  						// TODO Auto-generated catch block
		  						e.printStackTrace();
		  					} */
                    	continue;
                    }
                   /*try {
	  	        		FileWriter fw = new FileWriter(new File("/var/ddstockerror.txt"),true);
	  	     			fw.write(System.getProperty("line.separator")+"当当ID："+it+"对应D1的商品"+outerItemID);
	  	     			fw.flush();
	  	     			fw.close();
	  					} catch (IOException e) {
	  						// TODO Auto-generated catch block
	  						e.printStackTrace();
	  					}*/
                   // 
                  
                    String productId="";
		        	 String psku="";
		        	// if(it.equals("1107405i522")){
		        		 
		        	 //}
		        	// if(!it.equals("1107405i522")) continue;
		        	 if(outerItemID!=null && outerItemID.length()>8){//有sku
						 productId=outerItemID.substring(0, 8);
						 psku=outerItemID.substring(8);
						 
						 
						}if(!Tools.isNull(outerItemID) && !"null".equals(outerItemID) && outerItemID.length()==8){
							productId=outerItemID;
						}
					//	System.out.println(psku);
		        	 Sku sku=SkuHelper.getSku(productId, psku);
		        	 Product p=(Product)Tools.getManager(Product.class).get(productId);
		        	 long  skustockcount=0;

		        	 if (sku!=null && p!=null){
		        		
		        		 skustockcount=sku.getSkumst_vstock().longValue();
		        		 if (skustockcount<=0||sku.getSkumst_validflag().longValue()==0 || p.getGdsmst_validflag()==null||p.getGdsmst_validflag().longValue()!=1){
		        			 skustockcount=0;
		        		 }
		        		
		        	 }else{
		        		 if(!Tools.isNull(psku)){//sku填写错误
		        			 try {
				  	        		FileWriter fw = new FileWriter(new File("/var/ddstockerror.txt"),true);
				  	     			fw.write(System.getProperty("line.separator")+"商品编码："+outerItemID+"的sku填写错误"+System.getProperty("line.separator"));
				  	     			fw.flush();
				  	     			fw.close();
				  					} catch (IOException e) {
				  						// TODO Auto-generated catch block
				  						e.printStackTrace();
				  					} 
		        		 }else{
		        		 
		        		
		        		 if(p!=null && p.getGdsmst_virtualstock()!=null){
		        			 skustockcount=p.getGdsmst_virtualstock().longValue(); 
		        		 }
		        		 if(p==null||p.getGdsmst_validflag()==null||p.getGdsmst_validflag().longValue()!=1){
		        			 skustockcount=0;
		        		 }
		        		 }
		        	 }
		        	
		        	 if(!Tools.isNull(outerItemID) && !"null".equals(outerItemID)){
		        		
		        		 updatestockone(outerItemID,skustockcount+"");
		        	 }else{
		        		 try {
		  	        		FileWriter fw = new FileWriter(new File("/var/ddstockerror.txt"),true);
		  	     			fw.write(System.getProperty("line.separator")+"当当商品编号："+it+"对应商品编码错误"+System.getProperty("line.separator"));
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
	    }catch(UnsupportedEncodingException e){
	    	System.out.println(it+"当当错误："+relData);
			e.printStackTrace();
		}catch (DocumentException e){
			System.out.println(it+"当当错误："+relData);
			e.printStackTrace();
		} finally{
			try{
				if(in != null) in.close();
			} catch(IOException e){
				System.err.println("chanet close inputstream error!");
			}
		}


}
public   void updateddstock(String gShopID){
	//------------------------------取所有上架商品当当商品ID---------------------------------

	 HashMap<String, String> productinfo = getAllProduct("10","1");
	int itemsCount=0;
	int pageSize=30;
	int pageTotal=0;
	if(productinfo!=null && productinfo.size()>0){
		itemsCount=Tools.parseInt(productinfo.get("itemsCount"));//商品总数
		pageSize=Tools.parseInt(productinfo.get("pageSize"));
		pageTotal=Tools.parseInt(productinfo.get("pageTotal"));
		System.out.println("----------当当上架商品总数为："+itemsCount+"-------------");

		for(int i=1;i<=pageTotal;i++){
			String ItemsList = getAllProduct2(pageSize+"",i+"");
			 
				    InputStream in = null;
				    try {
				    	in = new ByteArrayInputStream(ItemsList.getBytes("GBK"));
				    	SAXReader reader = new SAXReader();
				    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
						Document doc = reader.read(isr);
						
						Element root = doc.getRootElement();
						
						
						Iterator iter = root.elementIterator("ItemsList"); // 获取根节点下的子节点ItemDetail

			            // 遍历head节点
			            while (iter.hasNext()) {

			                Element recordEle = (Element) iter.next();
			               Iterator iters = recordEle.elementIterator("ItemInfo"); // 获取子节点ItemDetail下的子节点SpecilaItemInfo

			                // 遍历Header节点下的Response节点
			                while (iters.hasNext()) {

			                    Element itemEle = (Element) iters.next();

			                    String itemID = itemEle.elementTextTrim("itemID"); // 拿到ItemDetail下的子节点SpecilaItemInfo下的字节点outerItemID的值
			                    if(!Tools.isNull(itemID)){
								//System.out.println("当当ID："+itemID);
	
									getProduct(itemID);
								}
			                  try {
			     	        		FileWriter fw = new FileWriter(new File("/var/ddstockerror.txt"),true);
			     	     			fw.write(System.getProperty("line.separator")+"itemID="+itemID);
			     	     			fw.flush();
			     	     			fw.close();
			     					} catch (IOException e) {
			     						// TODO Auto-generated catch block
			     						e.printStackTrace();
			     					}
					        	
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
					/**
				    sb.append("</ItemsList>");	
				    sb.append("</request>");
				    return sb.toString();
				    **/
			
			 
		}
	}
	
}

//更新商品库存
public void updatestockone(String oit,String stk){
 	//System.out.println("当当库存同步"+oit+"-----"+stk);
	String method = "dangdang.item.stock.update";
	Map<String, String> parameters = new HashMap<String, String>();
	parameters.put("oit",oit); //企业商品标识符
	parameters.put("stk",stk);
	String relData = "";
	try{
		relData = HttpInvokeUtil.getMethod(method, parameters);
	}catch(Exception ex){
		
	}
	
//System.out.print(relData);
	 HashMap<String, String> productinfo = null;
	    InputStream in = null;
	    try {
	    	in = new ByteArrayInputStream(relData.getBytes("GBK"));
	    	SAXReader reader = new SAXReader();
	    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
			Document doc = reader.read(isr);
			Element root = doc.getRootElement();
			Iterator iter = root.elementIterator("Result"); 

         // 遍历head节点
         while (iter.hasNext()) {
        	 Element itemEle = (Element) iter.next();
        	 String operation=itemEle.elementTextTrim("operation");
        	 String operCode=itemEle.elementTextTrim("operCode");
        	 if(!"0".equals(operCode)){
        		 try {
 	        		FileWriter fw = new FileWriter(new File("/var/ddstockerror.txt"),true);
 	     			fw.write(System.getProperty("line.separator")+"当当库存更新失败="+oit+operation+System.getProperty("line.separator"));
 	     			fw.flush();
 	     			fw.close();
 					} catch (IOException e) {
 						// TODO Auto-generated catch block
 						e.printStackTrace();
 					}
        	 }
        	 
        	//System.out.println(gShopID+"当当库存同步"+oit+operation);
         }
	    }catch(Exception e){
	    	
	    }
	
}
//批量更新商品库存

%>
<%
String app_key = "2100001892";
String app_secret = "9836659BF1AF5ABAC8821B4C35E88878";
String sessionkey =HttpUtil.getUrlContentByGet("http://www.d1.com.cn/inf/dangdang/sk.jsp?get=true", "gbk");
ApiConfigs.APP_KEY = app_key;
ApiConfigs.APP_SECRET = app_secret;
ApiConfigs.SESSION = sessionkey;
Date dd=new Date();
int currentMinute = java.util.Calendar.getInstance().get(java.util.Calendar.MINUTE) ;

if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	   String gShopID = "7342";

	updateddstock(gShopID);

	//updatestockone("01720821均码",gShopID,"4");
//String s="01720821均码";
//s=new String(s.getBytes("GBk"),"GBK").trim();
//s=URLEncoder.encode(s, "GBK");
//out.print(s);
}
//getProduct(gShopID,"1384941702");
//updateddstock(gShopID);
%>