 <%@ page contentType="text/html; charset=UTF-8"%><%@page import="
java.io.InputStream,
java.io.OutputStream,
java.net.URL,
java.security.SecureRandom,
java.net.URLEncoder,
java.security.cert.X509Certificate,
javax.net.ssl.HttpsURLConnection,
javax.net.ssl.KeyManager,
javax.net.ssl.SSLContext,
javax.net.ssl.SSLSocketFactory,
javax.net.ssl.X509TrustManager,
org.apache.http.conn.ssl.AllowAllHostnameVerifier
 "%><%!
 private static final AllowAllHostnameVerifier HOSTNAME_VERIFIER = new AllowAllHostnameVerifier();  
	private static X509TrustManager xtm = new X509TrustManager() {
	public void checkClientTrusted(X509Certificate[] chain, String authType) {}
	    public void checkServerTrusted(X509Certificate[] chain, String authType) {
	    }
	    public X509Certificate[] getAcceptedIssuers() {
	        return null;
	       }
	   }; 
	private static  X509TrustManager[] xtmArray = new X509TrustManager[] { xtm };
	private static HttpsURLConnection conn=null;
	public static InputStream sendPOSTRequestForInputStream(String path, String params, String encoding) throws Exception{
	// 1> 组拼实体数据
	//method=save&name=liming&timelength=100
		byte[] entity = params.getBytes();
	URL url = new URL(path);
	conn = (HttpsURLConnection) url.openConnection();
	if (conn instanceof HttpsURLConnection) {   
	     // Trust all certificates   
	     SSLContext context = SSLContext.getInstance("TLS");   
	     context.init(new KeyManager[0], xtmArray, new SecureRandom());   
	     SSLSocketFactory socketFactory = context.getSocketFactory();   
	     ((HttpsURLConnection) conn).setSSLSocketFactory(socketFactory);   
	     ((HttpsURLConnection) conn).setHostnameVerifier(HOSTNAME_VERIFIER);   
	 }
	conn.setConnectTimeout(5 * 1000);
	conn.setRequestMethod("POST");
	conn.setDoOutput(true);//允许输出数据
	conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
	conn.setRequestProperty("Content-Length", String.valueOf(entity.length));
	OutputStream outStream = conn.getOutputStream();
	outStream.write(entity);
	outStream.flush();
	outStream.close();
	if(conn.getResponseCode() == 200){
	return conn.getInputStream();
	}
	return conn.getInputStream();
	}
	public static void closeConnection(){
	if (conn!=null)
	conn.disconnect();
	}
	private static void printIoStream(InputStream stream) throws Exception{
	    BufferedInputStream buff = new BufferedInputStream(stream);
	    Reader r = new InputStreamReader(buff, "UTF-8");
	    BufferedReader br = new BufferedReader(r);
	    StringBuffer strHtml = new StringBuffer("");
	    String strLine = null;
	    while ((strLine = br.readLine()) != null) {
	        strHtml.append(strLine + "\r\n");
	    }
	    System.out.println(strHtml.toString());
	}
	%>