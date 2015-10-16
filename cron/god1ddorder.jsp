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
java.net.*,
java.io.*,
javax.xml.parsers.*,org.w3c.dom.*,
com.d1.dangdang.ApiConfigs,
com.d1.dangdang.HttpInvokeUtil"%>

<%!
/**
http://oauth.dangdang.com/authorize?appId=2100001892&redirectUrl=http://www.d1.com.cn/inf/dangdang/sk.jsp&responseType=token&state=yourstate
*/


private   String getAllOrder(String shopid,String pagesize,String currentpage,String odrid){
	String method = "dangdang.orders.list.get";
	Map<String, String> parameters = new HashMap<String, String>();
	
	parameters.put("o",odrid);//订单编号
	parameters.put("oit","");//企业商品标识符 
	parameters.put("os","101"); //订单状态  等待发货
	parameters.put("sm","9999"); //送货方式
	parameters.put("pm","9999");//付款方式
	parameters.put("sendMode","9999");//配送方式
	parameters.put("pageSize",pagesize); 
	parameters.put("p",currentpage);  
	String relData = "";
	try{
		relData = HttpInvokeUtil.getMethod(method, parameters);
	}catch(Exception ex){
		
	}
	
	
	//System.out.println(relData);
	return relData;
}

//获取在当当上架的所有商品

private  HashMap<String, String> getOrderInfo(String shopid,String pagesize,String currentpage){
	String method = "dangdang.orders.list.get";
	Map<String, String> parameters = new HashMap<String, String>();
	
	parameters.put("o","");//订单编号
	parameters.put("oit","");//企业商品标识符 
	parameters.put("os","101"); //订单状态  等待发货
	parameters.put("sm","9999"); //送货方式
	parameters.put("pm","9999");//付款方式
	parameters.put("sendMode","9999");//配送方式
	parameters.put("pageSize",pagesize); 
	parameters.put("p",currentpage);  
	String relData = "";
	try{
		relData = HttpInvokeUtil.getMethod(method, parameters);
	}catch(Exception ex){
		ex.printStackTrace();
	}
	if(relData.indexOf("errorMessage")>=0){
	System.out.println("----------"+relData+"-------------");
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

public   String getOrder(String gShopID,String odrid,String ddid){
	//------------------------------取所有上架商品当当商品ID---------------------------------

	 HashMap<String, String> ordertinfo = getOrderInfo(gShopID,"10","1");
	int itemsCount=0;
	int pageSize=10;
	int pageTotal=0;
	System.out.println("当当取的订单数："+ordertinfo.size());
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
						//System.out.println(doc.asXML());
						Element root = doc.getRootElement();
						Iterator iter = root.elementIterator("OrdersList"); // 获取根节点下的子节点ItemDetail

			            // 遍历head节点
			            while (iter.hasNext()) {

			                Element recordEle = (Element) iter.next();
			               Iterator iters = recordEle.elementIterator("OrderInfo"); // 获取子节点ItemDetail下的子节点SpecilaItemInfo
			              //System.out.println("当当订单数据1："+recordEle.asXML().toString());
			                // 遍历Header节点下的Response节点
			                while (iters.hasNext()) {

			                    Element itemEle = (Element) iters.next();
			                    //System.out.println("当当订单数据2："+itemEle.asXML().toString());
			                    String orderID=itemEle.elementTextTrim("orderID"); 
			                    String consigneeName=itemEle.elementTextTrim("consigneeName"); // 收货人姓名
			                    //System.out.println("当当订单consigneeName："+consigneeName);
			           if(Tools.isNull(consigneeName)||consigneeName.length()<3||!consigneeName.substring(consigneeName.length()-3).equals("@@@")){
			                 //System. out.print("当当订单号："+orderID);
			                String relData=getOdrdtl(orderID);
			               // System.out.println("当当订单明细----"+relData);
			                OrderDDService odd = (OrderDDService)Tools.getService(OrderDDService.class);
			                 //System.out.println("当当订单数据："+itemEle.asXML().toString());
								try{
									 OrderCache orderd1=odd.createOrderFromDangd(itemEle, gShopID,ddid,relData);
									 if(orderd1!=null){
										 System.out.println("当当订单:"+orderID+"----复制到d1订单成功，orderId="+orderd1.getId());
										 //return "当当订单:"+orderID+"----复制到d1订单成功，orderId="+orderd1.getId();
									 }
					    	            else{
					    	            	System.out.println("当当订单:"+orderID+"----已经同步过");
					    	            	//return "当当订单:"+orderID+"----已经同步过";
					    	            }
								
								}catch(Exception e){
									//e.printStackTrace();
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
					/**
				    sb.append("</ItemsList>");	
				    sb.append("</request>");
				    return sb.toString();
				    **/
			
			 
		}
	}
	return "";
}

/**
* 订单确认收款，财付通已经完成支付 。orderId必须存在，订单状态必须是0！
* @param orderId 订单id
* @param getmoney 收到多少钱，大于0才有效，小于0不修改。
* @return true 操作成功， false表示没有操作，可能是订单id不存在
* @throws Exception
*/
public synchronized boolean confirmGetMoney(String orderId,float getmoney)throws Exception{
	OrderCache order1 = (OrderCache)Tools.getManager(OrderCache.class).txGet(orderId);
	if(order1==null)return false ;
	
	if(order1.getOdrmst_orderstatus()!=null&&order1.getOdrmst_orderstatus().longValue()==0){
		Tools.getManager(OrderCache.class).txBeforeUpdate(order1);
		order1.setOdrmst_ourmemo(order1.getOdrmst_ourmemo()+ new Date()+"当当同步订单收款");
		if(getmoney>0)order1.setOdrmst_getmoney(new Double(getmoney));
		order1.setOdrmst_validdate(new Date());
		order1.setOdrmst_orderstatus(new Long(2));//确认收款状态
		Tools.getManager(OrderCache.class).txUpdate(order1, true);
		
		//调用存储过程把订单修改成“确认收款”状态
		ProcedureWork work = new ProcedureWork(orderId);
		Tools.getManager(OrderMain.class).currentSession().doWork(work);//执行work
		
		return true ;
	}
	
	return false ;
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
private   String getOdrdtl(String odrid){
	String method = "dangdang.order.details.get";
	Map<String, String> parameters = new HashMap<String, String>();
	
	parameters.put("o",odrid);//订单编号

	String relData = "";
	try{
		relData = HttpInvokeUtil.getMethod(method, parameters);
	}catch(Exception ex){
		
	}
	
	
	return relData;
}
%>
<%
String gShopID = "7342";
String key = "d1.com.cn";
String ddid=request.getParameter("ddid");

String app_key = "2100001892";
String app_secret = "9836659BF1AF5ABAC8821B4C35E88878";
String sessionkey =HttpUtil.getUrlContentByGet("http://www.d1.com.cn/inf/dangdang/sk.jsp?get=true", "gbk");
ApiConfigs.APP_KEY = app_key;
ApiConfigs.APP_SECRET = app_secret;
ApiConfigs.SESSION = sessionkey;

if(!Tools.isNull(ddid)){
	// gShopID = "9544";
}

String ddodrid="";
if(!Tools.isNull(request.getParameter("ddodrid"))){
	ddodrid=request.getParameter("ddodrid");
}
//if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
System.out.print(getOrder(gShopID,ddodrid,ddid));
//out.print(getOdrdtl(gShopID,"5003071406"));

//}

%>