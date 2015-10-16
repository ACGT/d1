<%@page import="com.d1.service.OrderDDService"%>
<%@page import="com.d1.helper.ProductHelper"%><%@page import="com.d1.Const"%>
<%@ page contentType="text/html; charset=UTF-8"%><%@page import="
java.text.SimpleDateFormat,
java.util.*,
org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document,java.security.*,
net.sf.json.JSONArray,
net.sf.json.JSONObject,
com.d1.bean.*,
com.d1.helper.*,
com.d1.util.*,
com.d1.service.*,
com.d1.bean.id.OrderIdGenerator,
com.d1.bean.id.SequenceIdGenerator,
com.jd.ac.sdk.api.DefaultJdClient,
java.net.*,
java.io.*,
javax.xml.parsers.*,org.w3c.dom.*,
com.jd.ac.sdk.api.JdClient,
com.jd.ac.sdk.api.JdException,
com.jd.ac.sdk.api.request.ware.WareIdsSearchRequest,
com.jd.ac.sdk.api.request.ware.WareSkuSearchRequest,
com.jd.ac.sdk.api.request.ware.WareSkuStockUpdateRequest,
com.jd.ac.sdk.api.response.ware.WareIdsSearchResponse,
com.jd.ac.sdk.api.response.ware.WareSkuSearchResponse,
com.jd.ac.sdk.api.response.ware.WareSkuStockUpdateResponse"%>
<%
   String gShopID = "7342";
String key = "d1.com.cn";
%>
<%!
public String  do_get(String strUrl) throws IOException{
	StringBuilder sb = new StringBuilder();
	URL url = new URL(strUrl);
	URLConnection cn = url.openConnection();

	BufferedReader br = new BufferedReader(new InputStreamReader(
			cn.getInputStream()));
	
	String line = null;
	while ((line = br.readLine()) != null) {
		sb.append(line);
	}
	
	return sb.toString();
}
public String generate_sign(Map maps) throws CloneNotSupportedException {
	Object[] keys = maps.keySet().toArray();
	/**
	 *对keys按字母字典排序,冒泡算法;
	 **/
	boolean issort = false;
	Object tmp = "";
	while(!issort){
		issort = true; 
		for(int i = 0;i < keys.length-1;i++){
			if(((String)keys[i]).compareTo((String)keys[i+1]) > 0){
				tmp = keys[i+1];
				keys[i+1] = keys[i];
				keys[i] = tmp;
				issort = false;
			}
		}
	}

	String step2="";
	String key="";
	try{
		for(int i = 0; i < keys.length; i++){
			
			//step2 = step2 + URLEncoder.encode(maps.get(keys[i]).toString(), "GBK").trim();
			step2 = step2 +new String(maps.get(keys[i]).toString().trim().getBytes("GBK"),"GBK").trim();
		
		}
	
		 key=URLEncoder.encode("d1.com.cn","GBK");
	}catch(Exception e){
		
	}
	
	String step3=step2+key;
	//System.out.println(step2);
	//System.out.println();
	/**进行签名，注意考虑到md5加密输出的大小写问题，所有约定md5的输出均为小写**/
	step3=MD5.to32MD5(step3).toLowerCase();	
	
	 return step3;
}
/**
 * @brief 对字符串进行URL编码，遵循rfc1738 urlencode
 * @param 需要用到的参数
 * @return URL编码后的字符串
 */
public String get_urlencoded_string(Map maps){
	
	 Iterator iter = maps.entrySet().iterator();
	 String param = "";
	 while(iter.hasNext()){
			Map.Entry entry = (Map.Entry)iter.next();
			String key = (String)entry.getKey();
			try{
			String value = URLEncoder.encode((String)entry.getValue());
			param = param+"&"+key+"="+value;
			}catch(Exception e){
				
			}
	 }
	 if(param.length() > 1)
	 	param.substring(1);
	 return param;
}


private   String getAllOrder(String shopid,String pagesize,String currentpage,String odrid){
	String url="http://api.dangdang.com/v2/searchOrders.php";
	Map param = new HashMap<String,String>();
	param.put("gShopID",shopid);
	param.put("o",odrid);//订单编号
	param.put("os","101"); //订单状态  等待发货
	param.put("sm","9999"); //送货方式
	param.put("pm","9999");//付款方式
	param.put("sendMode","9999");//配送方式
	param.put("pageSize",pagesize); 
	param.put("p",currentpage); 
	String sign="";
	try{
	 sign = generate_sign(param);
	}catch(Exception ex){
		
	}
	param.put("validateString",sign);
	//out.println(sign);
	String urlParam = get_urlencoded_string(param);
	String relData = "";
	try{
		relData=do_get(url+"?"+urlParam);
	}catch(Exception ex){
		
	}
	
	return relData;
}

//获取在当当上架的所有商品

private  HashMap<String, String> getOrderInfo(String shopid,String pagesize,String currentpage){
	String url="http://api.dangdang.com/v2/searchOrders.php";
	Map param = new HashMap<String,String>();
	param.put("gShopID",shopid);
	param.put("o","");//订单编号
	param.put("os","101"); //订单状态  等待发货
	param.put("sm","9999"); //送货方式
	param.put("pm","9999");//付款方式
	param.put("sendMode","9999");//配送方式
	param.put("pageSize",pagesize); 
	param.put("p",currentpage); 
	String sign="";
	try{
	 sign = generate_sign(param);
	}catch(Exception ex){
		
	}
	param.put("validateString",sign);
	//out.println(sign);
	String urlParam = get_urlencoded_string(param);
	String relData = "";
	try{
		relData=do_get(url+"?"+urlParam);
	}catch(Exception ex){
		
	}
	
	//解析xml
	//relData=relData.replace("<![CDATA[", "").replace("]]>", "");
	
    HashMap<String, String> orderinfo = null;
    InputStream in = null;
    try {
    	in = new ByteArrayInputStream(relData.getBytes("GBK"));
    	SAXReader reader = new SAXReader();
    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
		Document doc = reader.read(isr);
		
		Element root = doc.getRootElement();
		
		List es = root.elements();
		if(es != null && !es.isEmpty()){
			orderinfo = new HashMap<String,String>();
			int size = es.size();
			for(int i=0;i<size;i++){
				Element el = (Element)es.get(i);
				//System.out.println(el.getName());
				if(el.getName().equals("totalInfo")){
					  //获取订单汇总信息（等待发货订单数、总页数、当前页）
					//System.out.println(el.element("itemsCount").getTextTrim());
					orderinfo.put("sendGoodsOrderCount",el.element("sendGoodsOrderCount").getTextTrim());
					orderinfo.put("pageTotal",el.element("pageTotal").getTextTrim());
					orderinfo.put("pageSize",el.element("pageSize").getTextTrim());
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
	return orderinfo;
}

public   void getOrder(String gShopID,String odrid){
	//------------------------------取所有上架商品当当商品ID---------------------------------

	 HashMap<String, String> ordertinfo = getOrderInfo(gShopID,"10","1");
	int itemsCount=0;
	int pageSize=10;
	int pageTotal=0;
	if(ordertinfo!=null && ordertinfo.size()>0){
		itemsCount=Tools.parseInt(ordertinfo.get("sendGoodsOrderCount"));//等待发货订单数
		pageSize=Tools.parseInt(ordertinfo.get("pageSize"));
		pageTotal=Tools.parseInt(ordertinfo.get("pageTotal"));
		System.out.println("----------等待发货订单数为："+itemsCount+"-------------");
		for(int i=1;i<=pageTotal;i++){
			String ItemsList =getAllOrder(gShopID,pageSize+"",i+"",odrid);
			 
				    InputStream in = null;
				    try {
				    	in = new ByteArrayInputStream(ItemsList.getBytes("GBK"));
				    	SAXReader reader = new SAXReader();
				    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
						Document doc = reader.read(isr);
						
						Element root = doc.getRootElement();
						Iterator iter = root.elementIterator("OrdersList"); // 获取根节点下的子节点ItemDetail

			            // 遍历head节点
			            while (iter.hasNext()) {

			                Element recordEle = (Element) iter.next();
			               Iterator iters = recordEle.elementIterator("OrderInfo"); // 获取子节点ItemDetail下的子节点SpecilaItemInfo

			                // 遍历Header节点下的Response节点
			                while (iters.hasNext()) {

			                    Element itemEle = (Element) iters.next();
			                    String orderID=itemEle.elementTextTrim("orderID"); 
			                 //  System. out.print("说火热："+consigneeName);
			                  OrderDDService odd = (OrderDDService)Tools.getService(OrderDDService.class);
								try{
									 OrderCache orderd1=odd.createOrderFromDangd(itemEle, gShopID);
									 if(orderd1!=null){System.out.println("当当订单:"+orderID+"----复制到d1订单成功，orderId="+orderd1.getId());}
					    	            else{
					    	            	System.out.println("当当订单:"+orderID+"----已经同步过");
					    	            }
								
								}catch(Exception e){
									
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
private   String getOdrdtl(String shopid,String odrid){
	String url="http://api.dangdang.com/v2/getOrderDetail.php";
	Map param = new HashMap<String,String>();
	param.put("gShopID",shopid);
	param.put("o",odrid);//订单编号
	String sign="";
	try{
	 sign = generate_sign(param);
	}catch(Exception ex){
		
	}
	param.put("validateString",sign);
	//out.println(sign);
	String urlParam = get_urlencoded_string(param);
	String relData = "";
	try{
		relData=do_get(url+"?"+urlParam);
	}catch(Exception ex){
		
	}
	 HashMap<String, String> productinfo = null;
	    InputStream in = null;
	   try{
	    	in = new ByteArrayInputStream(relData.getBytes("GBK"));
	    	SAXReader reader = new SAXReader();
	    	InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
			Document doc = reader.read(isr);
			Element root = doc.getRootElement();
			String fpinfo="";//发票信息
			Iterator fpiter = root.elementIterator("receiptInfo"); 
         while (fpiter.hasNext()) {
         	 Element fpele = (Element) fpiter.next();
         	 fpinfo="发票抬头:"+fpele.elementTextTrim("receiptName")+"发票内容:"+fpele.elementTextTrim("receiptDetails")+"发票金额:"+fpele.elementTextTrim("receiptMoney");
         }
         String zffs="商户合作支付";//支付方式
         int payid=28;int paytype=4;
         Iterator zpfsiter = root.elementIterator("buyerInfo"); 
         while (zpfsiter.hasNext()) {
         	 Element fpele = (Element) zpfsiter.next();
         	 zffs=fpele.elementTextTrim("buyerPayMode");
         	 if(zffs.equals("货到付款")){
         		 payid=0;paytype=1;
         	 }else if(zffs.equals("邮局汇款")){
         		 payid=1;paytype=2;
         	 }else if(zffs.equals("银行汇款")){
         		 payid=2;paytype=3;
         	 }
         }
        System.out.println("发票信息："+fpinfo);
        System.out.println(zffs);
	   }catch(Exception e){
		   
	   }
	return relData;
}
%>
<%
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	//updateddstock(gShopID);
//getOrder(gShopID,"4996035783");
//out.print(getAllOrder(gShopID,"5","1",""));
out.print(getOdrdtl(gShopID,"4998202986"));
	//updatestockone("01720821均码",gShopID,"4");
//String s="01720821均码";
//s=new String(s.getBytes("GBk"),"GBK").trim();
//s=URLEncoder.encode(s, "GBK");
//out.print(s);
}
//getProduct(gShopID,"1384941702");
//updateddstock(gShopID);
%>