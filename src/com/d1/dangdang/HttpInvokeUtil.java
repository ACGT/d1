package com.d1.dangdang;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class HttpInvokeUtil {

	public static String getMethod(String method, Map<String, String> parameters)
			throws IOException {
		Map<String, String> p = getAllparameters(method, parameters);
		ApiConfigs apiConfigs = new ApiConfigs();
		apiConfigs.setApi_url(ApiConfigs.API_URL);
		apiConfigs.setApp_key(ApiConfigs.APP_KEY);
		apiConfigs.setApp_secret(ApiConfigs.APP_SECRET);
		return getInvoke(apiConfigs, ApiConfigs.SESSION, p);
	}

	public static String postMethod(String method,
			Map<String, String> parameters, String xmlpostname, String xml)
			throws IOException {
		Map<String, String> p = getAllparameters(method, parameters);
		ApiConfigs apiConfigs = new ApiConfigs();
		apiConfigs.setApi_url(ApiConfigs.API_URL);
		apiConfigs.setApp_key(ApiConfigs.APP_KEY);
		apiConfigs.setApp_secret(ApiConfigs.APP_SECRET);
		return postInvoke(apiConfigs, ApiConfigs.SESSION, p, xmlpostname, xml);
	}

	public static String getInvoke(ApiConfigs apiConfigs, String session,
			Map<String, String> parameters) throws IOException {
		String result = null;
		String getURL = getSignUrl(apiConfigs, session, parameters);
		URL getUrl = new URL(getURL);
		HttpURLConnection connection = (HttpURLConnection) getUrl
				.openConnection();
		connection.setConnectTimeout(ApiConfigs.CONNECTTIMEOUT);
		connection.setReadTimeout(ApiConfigs.READTIMEOUT);
		connection.connect();
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				connection.getInputStream(), "GBK"));
		StringBuilder lines = new StringBuilder();
		String line = null;
		while ((line = reader.readLine()) != null) {
			lines.append(line);
		}
		reader.close();
		connection.disconnect();
		result = lines.toString();
		return result;
	}

	public static String postInvoke(ApiConfigs apiConfigs, String session,
			Map<String, String> parameters, String xmlpostname, String xml)
			throws IOException {

		String postURL = ApiConfigs.API_URL + "&"
				+ getSignUrl(apiConfigs, session, parameters);
		URL postUrl = new URL(postURL);
		HttpURLConnection connection = (HttpURLConnection) postUrl
				.openConnection();
		connection.setConnectTimeout(ApiConfigs.CONNECTTIMEOUT);
		connection.setReadTimeout(ApiConfigs.READTIMEOUT);

		connection.addRequestProperty("Content-Type",
				"multipart/form-data; boundary=FoeeWxM0WaLNKwsc5Tj6_W7O5Fd9n7");

		connection.addRequestProperty("Content-Length",
				xml.getBytes("GBK").length + "");

		xml = "--FoeeWxM0WaLNKwsc5Tj6_W7O5Fd9n7\r\n"
				+ "Content-Disposition: form-data; name=\"" + xmlpostname
				+ "\"; filename=\"pollytest.xml\"\r\n"
				+ "Content-Type: application/octet-stream\r\n"
				+ "Content-Transfer-Encoding: binary\r\n" + "\r\n" + xml
				+ "\r\n" + "--FoeeWxM0WaLNKwsc5Tj6_W7O5Fd9n7--\r\n";
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.setRequestMethod("POST");
		connection.setUseCaches(false);
		connection.setInstanceFollowRedirects(true);
		connection.connect();
		DataOutputStream out = new DataOutputStream(
				connection.getOutputStream());

		out.writeBytes(xml);

		out.flush();
		out.close();
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				connection.getInputStream(), "GBK"));
		StringBuilder lines = new StringBuilder();
		String line = null;
		while ((line = reader.readLine()) != null) {
			lines.append(line);
		}
		reader.close();
		connection.disconnect();
		return lines.toString();
	}

	private static String getSignUrl(ApiConfigs apiConfigs, String session,
			Map<String, String> parameters) throws UnsupportedEncodingException {
		StringBuilder url = new StringBuilder();
		String method = parameters.get("method");
		String timestamp = parameters.get("timestamp");
		String format = parameters.get("format");
		String app_key = ApiConfigs.APP_KEY;
		String sign = null;
		String sign_method = parameters.get("sign_method");

		String app_secret = ApiConfigs.APP_SECRET;
		/* 拼凑get请求的URL字串，使用URLEncoder.encode对特殊和不可见字符进行编码 */

		/* 计算sign 1)根据参数名称将所有系统级调用参数按照字母先后顺序排序 */
		sign = "app_key" + app_key + "format" + format + "method" + method
				+ "session" + session + "sign_method" + sign_method
				+ "timestamp" + timestamp + "v1.0";

		/* 2)将secret(App Secret)拼接到参数字符串头、尾 */
		sign = app_secret + sign + app_secret;

		/* 3)进行md5加密后 */
		sign = md5(sign);

		/* 4)转化成大写 */
		sign = sign.toUpperCase();

		/* 5) 参数URLEncoding为GBK编码，然后拼装 */
		parameters.put("app_key", app_key);
		parameters.put("session", session);
		parameters.put("sign", sign);
		Set<Entry<String, String>> set = parameters.entrySet();
		for (Entry<String, String> entry : set) {
			url.append(entry.getKey()).append("=")
					.append(URLEncoder.encode(entry.getValue(), "GBK"))
					.append("&");
		}

		String getURL = ApiConfigs.API_URL + "&"
				+ url.substring(0, url.length() - 1);
		//System.out.println(getURL);
		return getURL;
	}

	private static String md5(String plainText) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes());
			byte b[] = md.digest();
			int i;
			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			return buf.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}

	private static Map<String, String> getAllparameters(String method,
			Map<String, String> parameters) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String timestamp = df.format(new Date());
		String format = "xml";
		String sign_method = "md5";
		Map<String, String> p = new HashMap<String, String>();
		p.put("method", method);
		p.put("timestamp", timestamp);
		p.put("format", format);
		p.put("sign_method", sign_method);
		if (parameters != null) {
			Set<Entry<String, String>> set = parameters.entrySet();
			for (Entry<String, String> entry : set) {
				p.put(entry.getKey(), entry.getValue());
			}
		}
		return p;
	}

}
