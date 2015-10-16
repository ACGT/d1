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
private synchronized void  GetProductInfo(Call call,String namespace,String supplierid)
{
	   call.setOperationName(new QName(namespace,"GetProductInfo"));   
	   call.addParameter(new QName(namespace,"swsSupplierID"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"page"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"pageSize"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"status"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"startTime"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"endTime"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.addParameter(new QName(namespace,"isNew"),XMLType.XSD_STRING, ParameterMode.IN);
	   call.setUseSOAPAction(true);
	   call.setSOAPActionURI(namespace+"GetProductInfo");
	   call.setReturnType(XMLType.XSD_STRING);
       
	   long pages=1;
	   //long pages_size=100;
	   try{
	   //String result = (String)call.invoke(new Object[]{supplierid,"1","1","up","","","all"});
	   String result = (String)call.invoke(new Object[]{supplierid,"1","1","all","2013-05-20 00:00:00","2014-06-20 00:00:00","all"});
	   //System.out.println(result);
	  
	   InputStream in = null;
	   
 	in = new ByteArrayInputStream(result.getBytes("UTF-8"));
 	SAXReader reader = new SAXReader();
 	InputStreamReader   isr   =   new   InputStreamReader(in,"UTF-8");
		Document doc = reader.read(isr);
		Element root = doc.getRootElement();
		 String remark=root.elementTextTrim("swssupplierid"); // 备注
		Iterator resultdetail = root.elementIterator("resultdetail"); 
        while (resultdetail.hasNext()) {
     	   Element recordEle = (Element) resultdetail.next();
     	   String allinfonum=recordEle.elementTextTrim("allinfonum"); // 备注
     	   System.out.println("凡客商品数："+allinfonum);
     	   int pagesnum=(int)Math.ceil(Tools.parseFloat(allinfonum)/100f);
     	   for (int j=1;j<=pagesnum;j++){
     		  
     		 // String retstr = (String)call.invoke(new Object[]{supplierid,j+"","100","up","","","all"});
     		 String retstr = (String)call.invoke(new Object[]{supplierid,j+"","100","all","2013-05-20 00:00:00","2014-06-20 00:00:00","all"});
     		  //System.out.println(retstr);
       		  createGds(retstr);
     	   }
        }
	   }catch(Exception e){
		   e.printStackTrace();
	   }

}
private void createGds(String retstr){
	try{
	 InputStream in = null;
	   
	 	in = new ByteArrayInputStream(retstr.getBytes("UTF-8"));
	 	SAXReader reader = new SAXReader();
	 	InputStreamReader   isr   =   new   InputStreamReader(in,"UTF-8");
			Document doc = reader.read(isr);
			Element root = doc.getRootElement();
			Iterator resultdetail = root.elementIterator("resultdetail"); 
	        while (resultdetail.hasNext()) {
	     	   Element recordEle = (Element) resultdetail.next();
              Iterator productlist = recordEle.elementIterator("productlist");
              while (productlist.hasNext()) {
            	  Element plistEle = (Element) productlist.next();
            	  Iterator product = plistEle.elementIterator("product");
            	  while (product.hasNext()) {
	                	  Element pEle = (Element) product.next();
	  	   			 String sku=pEle.elementTextTrim("sku"); // 备注
	  	   	         String size=pEle.elementTextTrim("size"); // 备注
	  	   	         String barcode=pEle.elementTextTrim("barcode"); // 备注
	  	   	         String productcode=pEle.elementTextTrim("productcode"); // 备注
	  	   	         String developid=pEle.elementTextTrim("developid"); // 备注
	  	   	         String productname=pEle.elementTextTrim("productname"); // 备注
	  	   	         String color=pEle.elementTextTrim("color"); // 备注
	  	   	         String fororder=pEle.elementTextTrim("fororder"); // 备注
	  	   	         String onsale=pEle.elementTextTrim("onsale"); // 备注
	  	   	         sku=deccode(sku);
	  	   	         size=deccode(size);
	  	           	 barcode=deccode(barcode);
	  	           	 productcode=deccode(productcode);
	  	           	 developid=deccode(developid);
	  	             productname=deccode(productname);
	  	             color=deccode(color);
	  	             fororder=deccode(fororder);
	  	             onsale=deccode(onsale);
	  	   	 GdsVancl gdsvancl=(GdsVancl)Tools.getManager(GdsVancl.class).findByProperty("gdsvancl_sku", sku);
	  	   		if(gdsvancl==null){
	  	   		GdsVancl gdsvancladd=new GdsVancl();
	  	   	     gdsvancladd.setGdsvancl_gdsid(barcode.substring(0,8));
	  	   	     gdsvancladd.setGdsvancl_barcode(barcode);
	  	   	     gdsvancladd.setGdsvancl_color(color);
	  	   	     gdsvancladd.setGdsvancl_developid(developid);
	  	   	     gdsvancladd.setGdsvancl_fororder(new Long(fororder));
	  	   	     gdsvancladd.setGdsvancl_productcode(productcode);
	  	   	     gdsvancladd.setGdsvancl_productname(productname);
	  	   	     gdsvancladd.setGdsvancl_size(size);
	  	   	     gdsvancladd.setGdsvancl_sku(sku);
	  	   	     gdsvancladd.setGdsvancl_onsale(onsale);
	  	   	     Tools.getManager(GdsVancl.class).create(gdsvancladd);
	  	   		}else if(!gdsvancl.getGdsvancl_barcode().equals(barcode)||!gdsvancl.getGdsvancl_onsale().equals(onsale)
	  	   				||gdsvancl.getGdsvancl_fororder().longValue()!=Tools.parseLong(fororder)){
	  	   		   gdsvancl.setGdsvancl_barcode(barcode);
	  	   		   gdsvancl.setGdsvancl_gdsid(barcode.substring(0,8));
	  	   		   gdsvancl.setGdsvancl_onsale(onsale);
	  	           gdsvancl.setGdsvancl_fororder(new Long(fororder));
	  	           Tools.getManager(GdsVancl.class).update(gdsvancl, true);
	  	   		   }

	  	   				
            	  }
              }
	        }
	}catch(Exception e){
		e.printStackTrace();
	}
}
private  ArrayList<GdsVancl> getGdsVanclList(String onsale){
	ArrayList<GdsVancl> list=new ArrayList<GdsVancl>();
	List<SimpleExpression> rlist=new ArrayList<SimpleExpression>();
	//rlist.add(Restrictions.eq("gdsvancl_onsale", onsale));
	//rlist.add(Restrictions.eq("gdsvancl_sku", "01680947"));
	List<BaseEntity> blist=Tools.getManager(GdsVancl.class).getList(null, null, 0, 2000);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity be:blist)
		{
			list.add((GdsVancl)be);
		}
	}
	return list;
}
private synchronized void  GoStorageSync(String uname,String pwd,String namespace,String supplierid)
{
	StringBuilder sb=new StringBuilder();
	ArrayList<GdsVancl> list =getGdsVanclList("true");
	int allnum=list.size();
	int pagesnum=(int)Math.ceil(allnum/100f);
	for(int j=0;j<allnum;j++){
		GdsVancl gv=list.get(j);
		String  barcode=gv.getGdsvancl_barcode();
		String  gvsku=gv.getGdsvancl_sku();
		String gvonsale=gv.getGdsvancl_onsale();
		long  gvgdscount=gv.getGdsvancl_fororder().longValue();
	 String productId="";
   	 String psku="";
   	 long stockcount=0;
   	 if(barcode.length()>8){
			 productId=barcode.substring(0, 8);
			 psku=barcode.substring(8);
			}else{
				productId=barcode;
			}
   	Sku sku=null;
   	 if(!Tools.isNull(psku)){
   	  sku=SkuHelper.getSku(productId, psku);
   	   	 }
   	 Product product=ProductHelper.getById(productId);
   	 //System.out.println(productId+"-----"+psku);
   	 if(product!=null){
   	    if(sku!=null){
    		stockcount=sku.getSkumst_vstock().longValue();
    		if(stockcount!=gvgdscount||gvonsale.equals("false")){
    		if(j%100==0){
    		    sb.append(barcode+","+stockcount);
    		}else{
    			sb.append("|"+barcode+","+stockcount);
    		}
    		}
    	  }else{
    		  if(Tools.isNull(psku)){
    		    stockcount=product.getGdsmst_virtualstock().longValue();
    		    if(stockcount!=gvgdscount||gvonsale.equals("false")){
    		    if(j%100==0){
    		        sb.append(barcode+","+stockcount);
    		     }else{
    			    sb.append("|"+barcode+","+stockcount);
    		      }
    		    }
    		}else{
    			 System.out.println("库存更新失败SKU="+gvsku+"---条码编号="+barcode);
       		       try {
       		             FileWriter fw = new FileWriter(new File("/var/vanclerror.txt"),true);
    		   	         fw.write("库存更新失败SKU="+gvsku+"---条码编号="+barcode+System.getProperty("line.separator"));
    			         fw.flush();
    			         fw.close();
				         } catch (IOException e) {
					      // TODO Auto-generated catch block
					       e.printStackTrace();
				         }
    		   }
    	  }

   	 }

		if((j+1)%100==0||(j+1)==allnum){
			String barCodeAndQuantity=sb.toString();
			 try {
		             FileWriter fw = new FileWriter(new File("/var/vanclerror.txt"),true);
	   	         fw.write("库存更新"+barCodeAndQuantity+System.getProperty("line.separator"));
		         fw.flush();
		         fw.close();
		         } catch (IOException e) {
			      // TODO Auto-generated catch block
			       e.printStackTrace();
		         }
			barCodeAndQuantity=encode(barCodeAndQuantity);
			  
			sb.delete(0, sb.length());
	        if(barCodeAndQuantity.length()>0){
	        try{
	        	String gourl2="http://sws2.vjia.com/swsms/StorageSyncService.asmx";
	 		   Service service2 = new Service();
	 		   Call call2 = (Call)service2.createCall();
	 		   call2.setTargetEndpointAddress(new java.net.URL(gourl2));
	 		   SOAPHeaderElement soapHeaderElement2 = new SOAPHeaderElement(namespace, "MySoapHeader");   
	 	       soapHeaderElement2.setNamespaceURI(namespace);   
	 	     try  
	 	       {   
	 	        soapHeaderElement2.addChildElement("Uname").setValue(uname);   
	 	        soapHeaderElement2.addChildElement("Password").setValue(pwd);   
	 	        }   
	 	         catch (SOAPException e2)   
	 	          {   
	 	           e2.printStackTrace();   
	 	          }   
	 	       call2.addHeader(soapHeaderElement2);   
	 	       call2.setOperationName(new QName(namespace,"StorageSync"));   
	 	       call2.addParameter(new QName(namespace,"supplierId"),XMLType.XSD_STRING, ParameterMode.IN);
	 	       call2.addParameter(new QName(namespace,"barCodeAndQuantity"),XMLType.XSD_STRING, ParameterMode.IN);
	 	       call2.setUseSOAPAction(true);
	 	       call2.setSOAPActionURI(namespace+"StorageSync");
	 	       call2.setReturnType(XMLType.XSD_STRING);
		    

			  
			   String result = (String)call2.invoke(new Object[]{supplierid,barCodeAndQuantity});
			  // System.out.println(result);
			  
			   InputStream in = null;
			   
			in = new ByteArrayInputStream(result.getBytes("UTF-8"));
			SAXReader reader = new SAXReader();
			InputStreamReader   isr   =   new   InputStreamReader(in,"UTF-8");
				Document doc = reader.read(isr);
				Element root = doc.getRootElement();
				 String resultcode=root.elementTextTrim("resultcode"); // 返回信息代码
				//System.out.println(resultcode);
				String resultmessage=root.elementTextTrim("resultmessage"); // 返回异常信息
				//System.out.println(resultmessage);
				String swssupplierid=root.elementTextTrim("swssupplierid"); // 供应商ID
				//System.out.println(swssupplierid);
				String resultdetail=root.elementTextTrim("resultdetail"); // 返回正常信息
				//System.out.println(resultdetail);
				try {
  		             FileWriter fw = new FileWriter(new File("/var/vanclerror.txt"),true);
		   	         fw.write("库存更新状态返回resultcode="+resultcode+System.getProperty("line.separator"));
		   	         fw.write("resultmessage="+resultmessage+System.getProperty("line.separator"));
		   	         fw.write("swssupplierid="+swssupplierid+System.getProperty("line.separator"));
		   	         fw.write("resultdetail="+resultdetail+System.getProperty("line.separator"));
			         fw.flush();
			         fw.close();
			         } catch (IOException e) {
				      // TODO Auto-generated catch block
				       e.printStackTrace();
			         }


			   }catch(Exception e){
					e.printStackTrace();
		       }
	        System.out.println("-----凡客同步100个商品库存-------------");
	       }
		}
	}
	
	  
}
%><%
String namespace="http://swsms.vjia.org/";
String supplierid="vancl2430";
String uname="KGsDb8/aa5p2+D0yfmTPXw==";
String pwd="28HIZHCEwmbWk5q5+I4rGfIPe5oi6eKi";
String gourl="http://sws2.vjia.com/swsms/GetProductInfoService.asmx";
Date dd=new Date();

try {
	if (dd.getHours()>=7){
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
 GetProductInfo(call,namespace,supplierid);

		  
		   
		 
		   GoStorageSync(uname,pwd,namespace,supplierid);
	}
 
} catch (ServiceException e) {
	   // TODO Auto-generated catch block
	   e.printStackTrace();
	  } 
%>

