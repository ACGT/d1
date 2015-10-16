package com.d1.test;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

import sun.net.www.protocol.http.HttpURLConnection;
 

public class sendmail {
	public static boolean saveUrlAs(String photoUrl, String fileName) {
		//此方法只能用于HTTP协议
		try {
		URL url = new URL(photoUrl);
		HttpURLConnection connection = (HttpURLConnection) url.
		openConnection();
		DataInputStream in = new DataInputStream(connection.getInputStream());
		DataOutputStream out = new DataOutputStream(new FileOutputStream(
		fileName));
		byte[] buffer = new byte[4096];
		int count = 0;
		while ((count = in.read(buffer)) > 0) {
		out.write(buffer, 0, count);
		}
		out.close();
		in.close();
		return true;
		} catch (Exception e) {
		return false;
		}
		}

		public String getDocumentAt(String urlString) {
		//此方法兼容HTTP和FTP协议
		StringBuffer document = new StringBuffer();
		try {
		URL url = new URL(urlString);
		URLConnection conn = url.openConnection();
		BufferedReader reader = new BufferedReader(new InputStreamReader(
		conn.
		getInputStream()));
		String line = null;
		while ((line = reader.readLine()) != null) {
		document.append(line + "\n");
		}
		reader.close();
		} catch (MalformedURLException e) {
		System.out.println("Unable to connect to URL: " + urlString);
		} catch (IOException e) {
		System.out.println("IOException when connecting to URL: " +
		urlString);
		}
		return document.toString();
		}

		public static void main(String[] args) throws IOException {
		/*String photoUrl = "http://119.254.89.66/UploadFile/2009-11/2009111018594396580.jpg";
		String fileName = photoUrl.substring(photoUrl.lastIndexOf("/"));
		String filePath = "d:/";
		boolean flag = saveUrlAs(photoUrl, filePath + fileName);
		System.out.println("Run ok!\nGet URL file " + flag);
		*/
		BufferedReader br = new BufferedReader(new FileReader("d:/imgurl.txt"));
		String s;
		while((s=br.readLine())!=null){
				System.out.println(s);
		}
		br.close();


		
		
		}

 
	
	
}
