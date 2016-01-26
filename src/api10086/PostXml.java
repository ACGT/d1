package api10086;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.CoreConnectionPNames;

import com.d1.Const;

public class PostXml {

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
	public static HttpClient getInstance() throws Exception {
		HttpClient client = new DefaultHttpClient();
		SSLContext ctx = SSLContext.getInstance("TLS");
		KeyStore ks = KeyStore.getInstance("pkcs12");
		ks.load(new FileInputStream(Const.PROJECT_PATH+Dom4J.getDocumentValue("keyStore")), Dom4J.getDocumentValue("keyPassword").toCharArray());
		KeyManagerFactory kmf = KeyManagerFactory.getInstance("sunx509");
		kmf.init(ks, Dom4J.getDocumentValue("keyPassword").toCharArray());
		KeyStore ts = KeyStore.getInstance("jks");
		ts.load(new FileInputStream(Const.PROJECT_PATH+Dom4J.getDocumentValue("trustStore")), Dom4J.getDocumentValue("trustPassword").toCharArray());
		TrustManagerFactory tmf = TrustManagerFactory.getInstance("sunx509");
		tmf.init(ts);
		ctx.init(kmf.getKeyManagers(), new TrustManager[] { tm }, null);
		SSLSocketFactory ssf = new SSLSocketFactory(ctx);
		ssf.setHostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
		ClientConnectionManager ccm = client.getConnectionManager();
		SchemeRegistry sr = ccm.getSchemeRegistry();
		sr.register(new Scheme("https", ssf, 443));
		client = new DefaultHttpClient(ccm, client.getParams());
		return client;
	}

	public String PostData(String xmlpost) throws Exception {
		HttpClient httpsClient = PostXml.getInstance();
		httpsClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,
				200);
		HttpPost httpGet = new HttpPost(Dom4J.getDocumentValue("url"));
		//StringEntity entiy = new StringEntity(new XmlRequest().getXmlRequest(), "UTF-8");
		StringEntity entiy = new StringEntity(xmlpost, "UTF-8");
		httpGet.setEntity(entiy);
		HttpResponse response = httpsClient.execute(httpGet);
		BufferedReader br = new BufferedReader(new InputStreamReader(response
				.getEntity().getContent(),"UTF-8"));
		StringBuffer content = new StringBuffer();
		for (String line; (line = br.readLine()) != null;) {
			content.append(line + "\r\n");
		}
		System.out.println(content.toString());
		return content.toString();
	}
}


