<%@page import="com.d1.helper.ProductHelper"%>
<%@page import="com.d1.Const"%><%@include file="/admin/chkrgt.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%><%@page import="
java.text.SimpleDateFormat,
java.util.*,
org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document,java.security.*,
net.sf.json.JSONArray,
net.sf.json.JSONObject,
com.d1.bean.*,
com.d1.helper.*,
com.d1.util.*,
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


public   String getProduct(String shopid,String it){
	StringBuilder sb=new StringBuilder();
	String url="http://api.dangdang.com/v2/getItemDetail.php";
	Map param = new HashMap<String,String>();
	param.put("gShopID",shopid);
	param.put("it",it);
	
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

                // 遍历Header节点下的Response节点
                while (iters.hasNext()) {

                    Element itemEle = (Element) iters.next();

                    String outerItemID = itemEle.elementTextTrim("outerItemID"); // 拿到ItemDetail下的子节点SpecilaItemInfo下的字节点outerItemID的值
                    
                   // System.out.println("outerItemID:" + outerItemID);
                    String productId="";
		        	 String psku="";
		        	 if(outerItemID!=null && outerItemID.length()>8){//有sku
						 productId=outerItemID.substring(0, 8);
						 psku=outerItemID.substring(8);
						}if(!Tools.isNull(outerItemID) && !"null".equals(outerItemID) && outerItemID.length()==8){
							productId=outerItemID;
						}
					//	System.out.println(psku);
		        	 Sku sku=SkuHelper.getSku(productId, psku);
		        	 Product p=ProductHelper.getById(productId);
		        	 long  skustockcount=0;
		        	 if (sku!=null && p!=null){
		        		// System.out.println("sku_ID:"+sku_id+"商品ID:"+productId+"---sku:"+psku+"库存："+sku.getSkumst_stock().longValue());
		        		 skustockcount=sku.getSkumst_vstock().longValue();
		        		 if (skustockcount<=0||sku.getSkumst_validflag().longValue()==0 || p.getGdsmst_validflag().longValue()!=1){
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
		        		 
		        		 
		        		 if(p!=null && p.getGdsmst_stock()!=null){
		        			 skustockcount=p.getGdsmst_stock(); 
		        		 }
		        		 if(p.getGdsmst_validflag().longValue()!=1){
		        			 skustockcount=0;
		        		 }
		        		 }
		        	 }
		        	
		        	 if(!Tools.isNull(outerItemID) && !"null".equals(outerItemID)){
		        		 sb.append(updatestockone(outerItemID,shopid,skustockcount+""));
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

return sb.toString();
}


//更新商品库存
public String updatestockone(String oit,String gShopID,String stk){
	
	StringBuilder sb=new StringBuilder();
	
	String url="http://api.dangdang.com/v2/updateItemStock.php";
	Map param = new HashMap<String,String>();
	param.put("gShopID",gShopID);
	param.put("oit",oit); //企业商品标识符
	param.put("stk",stk);
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
//System.	out.print(relData);
	
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
        	 }else{
        		 sb.append("当当库存同步"+oit+operation+"<br/>");
        	 }
        	 
        	// System.out.println("当当库存同步"+oit+operation);
         }
	    }catch(Exception e){
	    	
	    }
	return sb.toString();
}
//批量更新商品库存

%>
<%
String itemid=request.getParameter("txtitemid");
if(!Tools.isNull(itemid)){
 out.print(	getProduct(gShopID,itemid));
}
//getProduct(gShopID,"1384941702");
//updateddstock(gShopID);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>当当手动库存同步</title>
</head>
<body>
<form action="" method="post">
<table>
<tr><td height="15px">&nbsp;</td></tr>
<tr><td>当当商品编号：</td><td><input type="text" name="txtitemid"></input></td> <td><input type="submit" value="库存同步"></input></td></tr>
</table>
</form>
</body>
</html>