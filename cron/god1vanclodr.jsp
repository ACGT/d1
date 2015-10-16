<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.MalformedURLException"%>
<%@page import="java.rmi.RemoteException"%>
<%@page import="java.util.Iterator"%>
<%@page import="javax.xml.namespace.QName"%>
<%@page import="javax.xml.rpc.ParameterMode"%>
<%@page import="javax.xml.rpc.ServiceException"%>
<%@page import="javax.xml.soap.SOAPException"%>
<%@page import="org.apache.axis.client.Call"%>
<%@page import="org.apache.axis.client.Service"%>
<%@page import="org.apache.axis.encoding.XMLType"%>
<%@page import="org.apache.axis.message.SOAPHeaderElement"%>
<%@page import="org.dom4j.Document"%>
<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.io.SAXReader"%>
<%!
private String deccode(String str){
	String strret="";
	try{
	String key="bjlsysgs";
	String iv="bjlsysgs";
	 strret=DESUtil.decryptDES(str, key, iv);
			//DESUtil.decryptDES(str,key,iv);
	}catch(Exception e){
		e.printStackTrace();
	}
	return strret;
}
private String encode(String str){
	String strret="";
	try{
	String key="bjlsysgs";
	String iv="bjlsysgs";
	 strret=DESUtil.encryptDES(str, key, iv);
			//DESUtil.decryptDES(str,key,iv);
	}catch(Exception e){
		e.printStackTrace();
	}
	return strret;
}
private synchronized void GetOrderByTime(Call call,String namespace,String supplierid){
	 call.setOperationName(new QName(namespace,"GetOrderByTime"));   
	   call.addParameter(new QName(namespace,"swsSupplierID"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"page"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"pageSize"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"startTime"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"endTime"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"sort"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"status"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"orderCode"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"addressee"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"phone"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.setUseSOAPAction(true);
	   call.setSOAPActionURI(namespace+"GetOrderByTime");
	   call.setReturnType(XMLType.XSD_STRING);
     
	   long pages=1;
	   //long pages_size=100;
	   SimpleDateFormat  df2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	   try{
		   String result = "";
		   String  starttime= "";
		   String  endtime= "";
		   String orderid= "";
		   try{
		  endtime=df2.format(new Date());
          starttime=df2.format(Tools.addDate(new Date(), -10));
		   }catch(Exception e){
			   e.printStackTrace();
		  }
        //orderid="213060727829";
		//orderid=encode(orderid);
	    result = (String)call.invoke(new Object[]{supplierid,"1","1","2013-06-06 18:34:43",endtime,"0","NEW","","",""});
	  // System.out.println(result);
		  
	  
	   InputStream in = null;
	   
	in = new ByteArrayInputStream(result.getBytes("UTF-8"));
	SAXReader reader = new SAXReader();
	InputStreamReader   isr   =   new   InputStreamReader(in,"UTF-8");
		Document doc = reader.read(isr);
		Element root = doc.getRootElement();
		 String remark=root.elementTextTrim("swssupplierid"); // 备注
		 String resultcode=root.elementTextTrim("resultcode"); // 备注
		//System.out.println(remark);
		 if(resultcode.equals("0")){
		Iterator resultdetail = root.elementIterator("resultdetail"); 
      while (resultdetail.hasNext()) {
   	   Element recordEle = (Element) resultdetail.next();
   	   String allinfonum=recordEle.elementTextTrim("allordernum"); // 备注
   		   int pagesnum=(int)Math.ceil(Tools.parseFloat(allinfonum)/20f);
   	       for (int j=1;j<=pagesnum;j++){
   		  String retstr = (String)call.invoke(new Object[]{supplierid,j+"","20","2013-06-06 18:34:43",endtime,"0","NEW","","",""});
   		 //System.out.println(retstr);
   		      createOrderList(retstr,namespace,supplierid);
   	       }
         }
		 }
   }catch(Exception e){
	   e.printStackTrace();
  }
}
private void createOrderList(String retstr,String namespace,String supplierid){
	try{
		 InputStream in = null;
		 	in = new ByteArrayInputStream(retstr.getBytes("UTF-8"));
		 	SAXReader reader = new SAXReader();
		 	InputStreamReader   isr   =   new   InputStreamReader(in,"UTF-8");
				Document doc = reader.read(isr);
				Element root = doc.getRootElement();
				 //System.out.println(root.asXML());
				Iterator resultdetail = root.elementIterator("resultdetail"); 
		        while (resultdetail.hasNext()) {
		     	   Element recordEle = (Element) resultdetail.next();
	              Iterator orderlist = recordEle.elementIterator("orderlist");
	             
	              while (orderlist.hasNext()) {
	            	  Element plistEle = (Element) orderlist.next();
	            	  Iterator order = plistEle.elementIterator("order");
	            	  while (order.hasNext()) { 
	            		  Element orderEle = (Element) order.next();
	            		  String orderid = orderEle.elementTextTrim("orderid"); // 订单号
	            		  orderid=deccode(orderid);
	           		      String needinvoice=orderEle.elementTextTrim("needinvoice"); // 是否需要发票
	           		       needinvoice=deccode(needinvoice);
	           		        Element noticeEle=null;
	            		 // System.out.println(orderid+"-------------------"+needinvoice);
	           		      if(needinvoice.equals("True")){
	           		    	noticeEle=getnotice(orderid,namespace,supplierid);
	           		       }
	            		  
	            		  OrderVanclService os = (OrderVanclService)Tools.getService(OrderVanclService.class);
	            		  OrderCache orderd1 = os.createOrderFromVancl(orderEle,noticeEle);
	            		  if(orderd1!=null)System.out.println("订单"+orderd1.getId()+"同步成功！");
	            				   
	            	  }
	              }
		        }
	}catch(Exception e){
		
	}
}

private Element  getnotice(String orderid,String namespace,String supplierid){
	String uname="KGsDb8/aa5p2+D0yfmTPXw==";
	String pwd="28HIZHCEwmbWk5q5+I4rGfIPe5oi6eKi";
	try{
	 String gourl2="http://sws2.vjia.com/swsms/GetInvoiceInfoService.asmx";
	   Service service2 = new Service();
	   Call call2 = (Call)service2.createCall();
	   call2.setTargetEndpointAddress(new java.net.URL(gourl2));
	   SOAPHeaderElement soapHeaderElement2 = new SOAPHeaderElement(namespace, "MySoapHeader");   
        soapHeaderElement2.setNamespaceURI(namespace);   
        try{   
        soapHeaderElement2.addChildElement("Uname").setValue(uname);   
        soapHeaderElement2.addChildElement("Password").setValue(pwd);   
        }   
        catch (SOAPException e2)   
        {   
               e2.printStackTrace();   
               }   
     call2.addHeader(soapHeaderElement2);   
     call2.setOperationName(new QName(namespace,"GetInvoiceInfo"));   
     call2.addParameter(new QName(namespace,"swsSupplierID"),XMLType.XSD_STRING, ParameterMode.IN);
     call2.addParameter(new QName(namespace,"DECformCode"),XMLType.XSD_STRING, ParameterMode.IN);
     call2.setUseSOAPAction(true);
     call2.setSOAPActionURI(namespace+"GetInvoiceInfo");
     call2.setReturnType(XMLType.XSD_STRING);
  
     orderid=encode(orderid);
	   try{
	   String result = (String)call2.invoke(new Object[]{supplierid,orderid});
	   //System.out.println(result);
	   InputStream in = null;
	 	in = new ByteArrayInputStream(result.getBytes("UTF-8"));
	 	SAXReader reader = new SAXReader();
	 	InputStreamReader   isr   =   new   InputStreamReader(in,"UTF-8");
			Document doc = reader.read(isr);
			Element root = doc.getRootElement();
			Iterator resultdetail = root.elementIterator("resultdetail"); 
	        while (resultdetail.hasNext()) {
	     	   Element recordEle = (Element) resultdetail.next();
             Iterator invoicelist = recordEle.elementIterator("invoice");
            
             while (invoicelist.hasNext()) {
            	 Element invoiceEle = (Element) invoicelist.next();
            	 return invoiceEle;
             }
	        }
	   }catch(Exception e){
			e.printStackTrace();
		}
	 }catch(Exception e3){
		 e3.printStackTrace();
		}
	   return null;
}
%><%
String namespace="http://swsms.vjia.org/";
String supplierid="vancl2430";
String uname="KGsDb8/aa5p2+D0yfmTPXw==";
String pwd="28HIZHCEwmbWk5q5+I4rGfIPe5oi6eKi";
String gourl="http://sws2.vjia.com/swsms/GetOrderService.asmx";

try {
	   Service service = new Service();
	   Call call = (Call)service.createCall();
	   call.setTargetEndpointAddress(new java.net.URL(gourl));
	   SOAPHeaderElement soapHeaderElement = new SOAPHeaderElement(namespace, "MySoapHeader");   
 soapHeaderElement.setNamespaceURI(namespace);   
 try  
 {   
     soapHeaderElement.addChildElement("Uname").setValue(uname);   
     soapHeaderElement.addChildElement("Password").setValue(pwd);   
 }   
 catch (SOAPException e)   
 {   
     e.printStackTrace();   
 }   
 call.addHeader(soapHeaderElement);   
 
 GetOrderByTime(call,namespace,supplierid);
 
 
} catch (ServiceException e) {
	   // TODO Auto-generated catch block
	   e.printStackTrace();
	  } 
%>