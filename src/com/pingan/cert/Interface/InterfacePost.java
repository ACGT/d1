package com.pingan.cert.Interface;


import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.Charset;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;

import org.apache.commons.httpclient.protocol.Protocol;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.d1.Const;
import com.pingan.cert.Verify.PinganBisUtil;

public class InterfacePost {

	public InterfacePost() {
	}
	//平安参数
		public static	String strPayPostUrl_T="https://wanlitong-staging.pingan.com.cn/lpmsweb/checkPayment.do";
		public static	String strPayPostUrl="https://www.wanlitong.com/lpmsweb/checkPayment.do";
			//跳至万里通前的gURL
		public static	String strPayGUrl="https://www.d1.com.cn/pingan/Notify.jsp";
		public static   String strPayGUrl_T="http://tt.d1.com.cn/pingan/Notify.jsp";
			//跳至万里通回调URL-
		public  static   String strPayBackUrl="https://www.d1.com.cn/pingan/return_Notify.jsp";
		public  static  String strPayBackUrl_T="https://tt.d1.com.cn/pingan/return_Notify.jsp";
		//退货
		public  static  String strTuiHuo = "https://eairiis-prddmz.paic.com.cn/invoke/wm.tn/receive?";
		public  static  String strTuiHuo_T = "https://eairiis-stgdmz.paic.com.cn/invoke/wm.tn/receive?";  
        
		//上传
		public  static  String strUpodr = "https://eairiis-prddmz.paic.com.cn/invoke/wm.tn/receive?";
		//万里通分配的合作伙伴代码
		public  static  String strPayPartner="79_0";
		public  static  String strPayPartner_T="P4000004";
	        //万里通分配的折抵类的产品编码
		public  static  String strPayParam="0902079";
		public  static  String strPayParam_T="0902107";
	        //加签私钥证书密码
		//public static  String strPayPfxPwd="wanlitong";
		public static  String strPayPfxPwd="wanlitong";
		public  static String strPayPfxPwd_T="622689";
		
		
		public  static String pakeytt="hm.Tf5WifEI4u9hA";
		public  static String intfurltt="https://jk-bis-stg.dmzstg.pingan.com.cn:7443/bis/merService";
		public  static String pakey="KlGYF2rkF0aoBevK";
		public  static String intfurl="https://jkbis.wanlitong.com/bis/merService";
		private static final String TARGET_BEFORE = "http://";
		private static final String TARGET_AFTER=":8080/bis/appSend";
		public static final Charset CHARSET_ISO8859_1 = Charset.forName("iso8859_1");
		
		private static final String PROPERTY_TYPE = "Content-Type";
		private static final String PROPERTY = "application/x-www-form-urlencoded";
		
		public static String PostXml(String ip,String postUrl,String postData){
			URL url = null;
			try {
				url = new URL(TARGET_BEFORE + ip + TARGET_AFTER);
			} catch (MalformedURLException e) {
				e.printStackTrace();
			}
			HttpsURLConnection conn = getHttpsConn(postUrl);
			DataOutputStream out = null;
			try {
				conn.setConnectTimeout(120*1000);
				conn.setDoOutput(true);
				conn.setDoInput(true);
				conn.setRequestMethod("POST");
				conn.setUseCaches(false);
				conn.setRequestProperty(PROPERTY_TYPE, PROPERTY);
				
				conn.connect();
				/*String filenameToSend = "test.xml";
				File f = new File(filenameToSend);
				byte data[] = new byte[(int) f.length()];
				FileInputStream fis = new FileInputStream(filenameToSend);
				fis.read(data);
				fis.close();
				String xmlStr=new String(data);
				System.out.println(xmlStr);
				//InputStream in = null;
				   
		    	//in = new ByteArrayInputStream(xmlStr.getBytes("GBK"));
		    	//SAXReader reader = new SAXReader();
		    	//InputStreamReader   isr   =   new   InputStreamReader(in,"GBK");
				//Document doc = reader.read(isr);
				//Element root = doc.getRootElement(); 
				//Element partner = (Element) root.selectSingleNode("//bisdata/bizdata/sign/value");
			 	//partner.addText(PinganBisUtil.encrypt(doc.asXML(),"hm.Tf5WifEI4u9hA")); 
			 	//System.out.println(doc.asXML());
			
				String dataStr=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","data");
				System.out.println(dataStr);
				String sign=PinganBisUtil.encrypt(dataStr, "hm.Tf5WifEI4u9hA");
				System.out.println(sign);
				String returnXml=PinganBisUtil.getSignXMLString(xmlStr,sign);
				System.out.println(returnXml);
				*/
				byte data[] = null;
				String encode=PinganBisUtil.getNodeValues(postData,  "bizdata","encode");
				
				//有中文必须指定编码格式
				if(PinganBisUtil.isEmpty(encode)){
					data=postData.getBytes();
				}else{
					data=postData.getBytes(encode);
				}
				
				out =  new DataOutputStream(conn.getOutputStream());
		        out.write(data);
				out.flush();
				out.close();
				System.out.println(conn.getResponseCode() + ">>" + conn.getResponseMessage());
				byte[] bytes= toByteArray(conn.getInputStream());
				String ret ="";
				if(bytes == null || bytes.length == 0){
					System.out.println("time out");

				}else{
					 ret = new String(bytes, "GBK");
					System.out.println("biz:"+ret);
					
				}
				//conn.disconnect();
				conn.disconnect();
				return ret;
			} catch (Exception e) {
				e.printStackTrace();
			}
	      return "";
			
		}
        
		private static HttpsURLConnection getHttpsConn(String connurl){
			try {
				URL url = new URL(connurl);
				HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
				SSLContext sc;
				sc = SSLContext.getInstance("SSL");
				sc.init(null, new TrustManager[]{ new miTM()}, new SecureRandom());
				conn.setSSLSocketFactory(sc.getSocketFactory());
				return conn;
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (KeyManagementException e) {
				e.printStackTrace();
			} catch (IOException e){
				e.printStackTrace();
			}
			return null;
		}
		
		public static byte[] toByteArray(InputStream is) throws IOException
		  {
		    ByteArrayOutputStream out = new ByteArrayOutputStream();
		    byte[] data = new byte[4096];
		    int len;
		    while ((len = is.read(data)) != -1) {
		      out.write(data, 0, len);
		      out.flush();
		    }
		    return out.toByteArray();
		  }
		
		public static String Postdata(String postUrl,String postData)
		{
			String strxml=null;
			try {
				// 要提交到的地址
				//String url = strTuiHuo_T;
				String url =postUrl;
				// 要提交的文件名,具体到路径
				//String filenameToSend = "VERIFY.xml";
				// JKS证书路径
				//String keyStore = "pingan/zhengshu/stg.pfx";
				String keyStore = Const.PROJECT_PATH+"pingan/zhengshu/pingan2012.pfx";
				//String keyStore = Const.PROJECT_PATH+"pingan/zhengshu/wanlitong11222.pfx";
				
				// JKS密码
				//String keyStorePassword = "22622689";
				String keyStorePassword = strPayPfxPwd;
				// 私钥证书路径
				//String trustStore = "cacertstg.jks";
				String trustStore = Const.PROJECT_PATH+"pingan/zhengshu/pingan2012.jks";
				//String trustStore = Const.PROJECT_PATH+"pingan/zhengshu/pingan222.jks";
				// 私钥证书密码
				System.out.println(trustStore);
				String trustStorePassword = strPayPfxPwd;
				//String trustStorePassword = "PA1208";
				InterfacePost ix = new InterfacePost();

				strxml=ix.connect(url, postData, keyStore, keyStorePassword, trustStore, trustStorePassword);

			} catch (Exception e) {
				e.printStackTrace();
			}
			return strxml;
		}

	public String  connect(String url1, String content, 
			String keyStore, String keyStorePassword, 
			String trustStore, String trustStorePassword) throws Exception {
		
		Protocol.registerProtocol("https", new Protocol("https", new MySSLSocketFactory(), 443));
		
		URL url = new URL(url1);
		
		System.out.println("InterfacePost:"+url1);

		HostnameVerifier hv = new HostnameVerifier() {
			public boolean verify(String urlHostName, SSLSession session) {
				return true;
			}
		};
/*
		System.setProperty("javax.net.ssl.keyStore",keyStore);
		System.setProperty("javax.net.ssl.keyStorePassword", keyStorePassword);
		System.setProperty("javax.net.ssl.trustStore",trustStore);
		System.setProperty("javax.net.ssl.trustStorePassword", trustStorePassword);
		System.setProperty("javax.net.ssl.keyStoreType", "pkcs12");
		System.setProperty("java.protocol.handler.pkgs","sun.net.www.protocol"); 
		*/
		//trustAllHttpsCertificates();
		HttpsURLConnection.setDefaultHostnameVerifier(hv);
		
		HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
		
		connection.setRequestProperty("Content-Type", "text/xml");
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.setRequestMethod("POST");
		connection.setUseCaches(false);
		byte[] requestStringBytes = content.getBytes("UTF-8");
		OutputStream out = connection.getOutputStream();
		
		out.write(requestStringBytes);
		out.flush();
		out.close();
		
		String aLine = null;
		InputStreamReader inReader = new InputStreamReader(connection.getInputStream(), "UTF-8");
		BufferedReader aReader = new BufferedReader(inReader);
		StringBuffer sb = new StringBuffer();
		while ((aLine = aReader.readLine()) != null){
			sb.append(aLine).append("\n");
		}

		aReader.close();
		
		connection.disconnect();
		return sb.toString();
		
		
		/*System.setProperty("javax.net.ssl.keyStore",keyStore);
		System.setProperty("javax.net.ssl.keyStorePassword", keyStorePassword);
		System.setProperty("javax.net.ssl.trustStore",trustStore);
		System.setProperty("javax.net.ssl.trustStorePassword", trustStorePassword);
		System.setProperty("javax.net.ssl.keyStoreType", "pkcs12");
		System.setProperty("java.protocol.handler.pkgs","sun.net.www.protocol"); 
		
		Protocol.registerProtocol("https", new Protocol("https", new MySSLSocketFactory(), 443)); 
		MultiThreadedHttpConnectionManager connectionManager =	new MultiThreadedHttpConnectionManager();
		
		HttpClient httpClient=new HttpClient(connectionManager);
		httpClient.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(60000));
		httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(60000); 
		
		System.out.println("InterfacePost:"+url1+"<<<<<<<<<<<<<<<<<<<<");
		PostMethod post = new PostMethod(url1);
		
		try{
			post.setRequestEntity(new StringRequestEntity(content, "text/xml","UTF-8"));  
		
			httpClient.executeMethod(post);
		
			byte[] responseBody = post.getResponseBody();
			
			System.out.println(">>>>>>>>>>>>>>>>>>>>>"+new String(responseBody,"UTF-8")+"<<<<<<<<<<<<<<<<<<<<<<");
			return new String(responseBody,"UTF-8");
		}catch(Exception ex){
			throw ex;
		}finally{
			post.releaseConnection();
		}*/
	}
	
	public static void main(String[] args)throws Exception{
		Document doc;
		SAXReader reader = new SAXReader();
		try {
		
			doc = reader.read("D:/jlgao/workspace/d1web/var/20150114104105715upload.xml");
			String xmlStr=doc.asXML();
			System.out.println(xmlStr);
			Element root = doc.getRootElement(); 
			String dataStr=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","data");
			System.out.println(dataStr);
			String sign=PinganBisUtil.encode(dataStr, "hm.Tf5WifEI4u9hA");
			System.out.println(sign);
			//String returnXml=PinganBisUtil.getSignXMLString(xmlStr,sign);
			//System.out.println(returnXml);
			Element partner = (Element) root.selectSingleNode("//bisdata/bizdata/sign/value");
		 	partner.addText(sign); 
			String encode=PinganBisUtil.getNodeValues(xmlStr,  "bizdata","encode");
		 	String strupurl="https://jk-bis-stg.dmzstg.pingan.com.cn:7443/bis/merService";
			String strxml= PostXml("114.246.174.48",strupurl,doc.asXML());
			//String strxml=HttpUtil.postData(strupurl,doc.asXML(),"utf-8");
			System.out.println(strxml);
		}
	catch(Exception ex){
		ex.printStackTrace();
	}
		//if(true){
			/*BufferedReader br = new BufferedReader(new FileReader(new File("/var/11.xml")));
			String line = null ;
			StringBuffer sb = new StringBuffer();
			while((line=br.readLine())!=null){
				sb.append(line).append(System.getProperty("line.separator"));
			}
			br.close();*/
			
			//String strxml= Postdata("https://eairiis-prddmz.paic.com.cn/invoke/wm.tn/receive?", sb.toString());
			
			
		//}
	}
	
	private static void trustAllHttpsCertificates() throws Exception {  
        javax.net.ssl.TrustManager[] trustAllCerts = new javax.net.ssl.TrustManager[1];  
        javax.net.ssl.TrustManager tm = new miTM();  
        trustAllCerts[0] = tm;  
        javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext  
                .getInstance("SSL");  
        sc.init(null, trustAllCerts, null);  
        javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc  
                .getSocketFactory());  
    }  
	
	static class miTM implements javax.net.ssl.TrustManager,  
    javax.net.ssl.X509TrustManager {  
		public java.security.cert.X509Certificate[] getAcceptedIssuers() {  
		    return null;  
		}  
		
		public boolean isServerTrusted(  
		        java.security.cert.X509Certificate[] certs) {  
		    return true;  
		}  
		
		public boolean isClientTrusted(  
		        java.security.cert.X509Certificate[] certs) {  
		    return true;  
		}  
		
		public void checkServerTrusted(  
		        java.security.cert.X509Certificate[] certs, String authType)  
		        throws java.security.cert.CertificateException {  
		    return;  
		}  
		
		public void checkClientTrusted(  
		        java.security.cert.X509Certificate[] certs, String authType)  
		        throws java.security.cert.CertificateException {  
		    return;  
		}  
	}  
}
