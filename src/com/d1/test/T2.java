package com.d1.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.EntityTemplate;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.CoreConnectionPNames;
  
public class T2 {  
    private static X509TrustManager tm = new X509TrustManager() {  
        public void checkClientTrusted(X509Certificate[] xcs, String string)  
                throws CertificateException {  
        }  
        public void checkServerTrusted(X509Certificate[] xcs, String string)  
                throws CertificateException {  
        }  
        public X509Certificate[] getAcceptedIssuers() {  
            return null;  
        }  
    };  
  
    @SuppressWarnings("deprecation")  
    public static HttpClient getInstance() throws KeyManagementException,  
            NoSuchAlgorithmException {  
        HttpClient client = new DefaultHttpClient();  
        SSLContext ctx = SSLContext.getInstance("TLS");  
        ctx.init(null, new TrustManager[] { tm }, null);  
        SSLSocketFactory ssf = new SSLSocketFactory(ctx);  
        ssf.setHostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);  
        ClientConnectionManager ccm = client.getConnectionManager();  
        SchemeRegistry sr = ccm.getSchemeRegistry();  
        sr.register(new Scheme("https", ssf, 443));  
        client = new DefaultHttpClient(ccm, client.getParams());  
        return client;  
    }  
  
    public static void main(String[] args) throws KeyManagementException,  
            NoSuchAlgorithmException, IllegalStateException, IOException {  
    	
    	BufferedReader br = new BufferedReader(new FileReader(new File("d://11.xml")));
		String line = null ;
		StringBuffer sb = new StringBuffer();
		while((line=br.readLine())!=null){
			sb.append(line).append(System.getProperty("line.separator"));
		}
		br.close();
		
    	HttpClient httpsClient = T2.getInstance();  
        //HttpHost proxy = new HttpHost("172.28.8.246", 8080);  
        //httpsClient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY,proxy);  
        httpsClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,20000);  
        HttpPost httpPost = new HttpPost("https://wanlitong-staging.pingan.com.cn/lpmsweb/checkPayment.do");
        //System.out.println(sb.toString());
        MyContentProducer cp = new MyContentProducer(sb.toString());

        httpPost.setEntity(new EntityTemplate(cp));
        
        HttpResponse response = httpsClient.execute(httpPost);  
        HttpEntity entity = response.getEntity();   
        
        if(true){
	        BufferedReader br123 = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));  
	        StringBuffer content = new StringBuffer();  
	        for (String line123; (line123 = br123.readLine()) != null;) {  
	            content.append(line123 + "\r\n");  
	        }  
	        System.err.println(content.toString());  
        }
    }  
}  