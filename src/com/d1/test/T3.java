package com.d1.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.util.Iterator;
import java.util.Properties;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;

public class T3 {
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
	public static  String strPayPfxPwd="wanlitong";
	public  static String strPayPfxPwd_T="622689";

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
			String keyStore = "/opt/d1web/pingan/zhengshu/wanlitong11.pfx";
			//String keyStore = "D:\\Java\\jdk1.7.0\\jre\\lib\\security\\cacerts";
			//String keyStore = "/usr/local/jdk/jre/lib/security/cacerts";
			//String keyStore ="jssecacerts";
			
			// JKS密码
			//String keyStorePassword = "22622689";
			String keyStorePassword = strPayPfxPwd;
			// 私钥证书路径
			//String trustStore = "cacertstg.jks";
			//String trustStore = Const.PROJECT_PATH+"pingan/zhengshu/pingan.jks";
			//String trustStore = "/usr/local/jdk/jre/lib/security/cacerts";
			//String trustStore = "D:\\Java\\jdk1.7.0\\jre\\lib\\security\\pingan.jks";
			String trustStore = "/opt/d1web/pingan/zhengshu/pingan.jks";
			// 私钥证书密码
			String trustStorePassword = "PA1208";
			//InterfacePost ix = new InterfacePost();

			strxml=connect8547(url, postData, keyStore, keyStorePassword, trustStore, trustStorePassword);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return strxml;
	}

public  static String  connect8547(String url1, String content, 
		String keyStore, String keyStorePassword, 
		String trustStore, String trustStorePassword) throws Exception {
	URL url = new URL(url1);

	HostnameVerifier hv = new HostnameVerifier() {
		public boolean verify(String urlHostName, SSLSession session) {
			System.out.println("URL Host: " + session.getPeerHost());
			return true;
		}
	};

	System.setProperty("javax.net.ssl.keyStore",keyStore);
	System.setProperty("javax.net.ssl.keyStorePassword", keyStorePassword);
	System.setProperty("javax.net.ssl.trustStore",trustStore);
	System.setProperty("javax.net.ssl.trustStorePassword", trustStorePassword);
	System.setProperty("javax.net.ssl.keyStoreType", "pkcs12");
	System.setProperty("java.protocol.handler.pkgs","sun.net.www.protocol"); 
	
	/*javax.net.ssl.TrustManager[] trustAllCerts = new javax.net.ssl.TrustManager[1];
	javax.net.ssl.TrustManager tm = new MyTrustManager();
	trustAllCerts[0] = tm;
	javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("SSL");
	sc.init(null, trustAllCerts, null);
	javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());*/
	
	
	HttpsURLConnection.setDefaultHostnameVerifier(hv);
	HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
	
	connection.setRequestProperty("Content-Type", "text/xml");
	connection.setDoOutput(true);
	connection.setDoInput(true);
	connection.setRequestMethod("POST");
	connection.setUseCaches(false);

	/*File f = new File(filenameToSend);
	byte data[] = new byte[(int) f.length()];
	FileInputStream fis = new FileInputStream(filenameToSend);
	fis.read(data);
	fis.close();
*/
	byte[] requestStringBytes = content.getBytes("UTF-8");
	OutputStream out = connection.getOutputStream();

	out.write(requestStringBytes);
	String aLine = null;
	InputStreamReader inReader = new InputStreamReader(connection.getInputStream(), "UTF-8");
	BufferedReader aReader = new BufferedReader(inReader);
	StringBuffer sb = new StringBuffer();
	while ((aLine = aReader.readLine()) != null){
		sb.append(aLine).append("\n");
	}
		//System.err.println(aLine);
	aReader.close();
	connection.disconnect();
	
	
	
	Properties ps = System.getProperties();
	Iterator it = ps.keySet().iterator();
	while(it.hasNext()){
		String k = (String)it.next();
		System.out.println(k+"="+ps.getProperty(k));
	}
	
	return sb.toString();
}


public static void main(String[] args)throws Exception{
	
	if(true){
		BufferedReader br = new BufferedReader(new FileReader(new File("/var/hj.txt")));
		String line = null ;
		StringBuffer sb = new StringBuffer();
		while((line=br.readLine())!=null){
			if(line.indexOf("=")>-1){
				System.setProperty(line.substring(0,line.indexOf("=")), line.substring(line.indexOf("=")+1));
			}
		}
		br.close();
	}
	
	if(true){
		BufferedReader br = new BufferedReader(new FileReader(new File("/var/11.xml")));
		String line = null ;
		StringBuffer sb = new StringBuffer();
		while((line=br.readLine())!=null){
			sb.append(line).append(System.getProperty("line.separator"));
		}
		br.close();
		String strxml= Postdata("https://eairiis-prddmz.paic.com.cn/invoke/wm.tn/receive?", sb.toString());
		
		System.out.println(strxml);
	}
}

}
