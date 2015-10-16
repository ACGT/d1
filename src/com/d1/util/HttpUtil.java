package com.d1.util;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class HttpUtil {

	
	/**
	 * �������ȡһ���ı�����Get����
	 * @param urlStr url��http://ip/xx.jsp?uid=90&aa=89
	 * @param encoding UTF-8/GBK
	 * @return String
	 */
	public static String getUrlContentByGet(String urlStr,String encoding){
		  HttpClient httpClient = new HttpClient();
		  
		  httpClient.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(10000));
		  httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(10000);   
		  GetMethod getMethod = new GetMethod(urlStr);
		  getMethod.setRequestHeader("User-Agent","Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)");
		  //ʹ��ϵͳ�ṩ��Ĭ�ϵĻָ�����
		  getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler());
		  try{
			   //ִ��getMethod
			   int statusCode = httpClient.executeMethod(getMethod);
			   if (statusCode != HttpStatus.SC_OK){
			     return "";
			   }
			   //��ȡ���� 
			   byte[] responseBody = getMethod.getResponseBody();
			   //System.out.println(new String(responseBody));
			   //��������
			   return new String(responseBody,encoding);
		  }catch (Exception e){
			  e.printStackTrace();
		  }finally{
		   //�ͷ�����
			  getMethod.releaseConnection();
		  }
		  return "";
	}
	
	/**
	 * ��post������ȡ��������
	 * @param urlStr ����������URL
	 * @param params ��������ʽ��uid=12&pg=2&cid=89
	 * @param encoding �ı��ı���
	 * @return String
	 */
	public static String getUrlContentByPost(String urlStr,String params,String encoding){
		  HttpClient httpClient = new HttpClient();
		  httpClient.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(10000));
		  httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(10000 );   
		  PostMethod postMethod = new PostMethod(urlStr);
		  postMethod.setRequestHeader("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; Maxthon; .NET CLR 1.1.4322)");
		  //ʹ��ϵͳ�ṩ��Ĭ�ϵĻָ�����
		  postMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler());
		  
		  ArrayList<NameValuePair> list = new ArrayList<NameValuePair>();
		  if(params!=null&&params.length()>0){
			  String[] ps = params.split("&");
			  if(ps!=null&&ps.length>0){
				  for(int i=0;i<ps.length;i++){
					  if(ps[i].indexOf("=")>-1){
						  String n = ps[i].substring(0,ps[i].indexOf("="));
						  String v = ps[i].substring(1+ps[i].indexOf("="));
						  list.add(new NameValuePair(n,v));
					  }
				  }
			  }
		  }
		  
		  postMethod.setRequestBody((NameValuePair[])list.toArray(new NameValuePair[0]));
		  
		  try{
			   //ִ��getMethod
			   int statusCode = httpClient.executeMethod(postMethod);
			   if (statusCode != HttpStatus.SC_OK){
				   System.err.println("Method failed: " + postMethod.getStatusLine());
			   }
			   //��ȡ���� 
			   byte[] responseBody = postMethod.getResponseBody();
			   //System.out.println(new String(responseBody));
			   //��������
			   return new String(responseBody,encoding);
		  }catch (Exception e){
			   e.printStackTrace();
		  }finally{
		   //�ͷ�����
			  postMethod.releaseConnection();
		  }
		  return "";
	}
	
	/**
	 * ֱ���ύ����
	 * @param pathUrl url
	 * @param content ����
	 * @param pathUrl
	 */
	public static String postData(String pathUrl,String content,String encoding){
		  HttpClient httpClient = new HttpClient();
		  
		  httpClient.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(30000));
		  httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(30000);   
		  PostMethod postMethod = new PostMethod(pathUrl);
		  
		  postMethod.setRequestHeader("User-Agent","Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)");
		  //ʹ��ϵͳ�ṩ��Ĭ�ϵĻָ�����
		  postMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler());
		  try{
			   postMethod.setRequestEntity(new StringRequestEntity(content, "text/xml",encoding));  
			   //ִ��getMethod
			   int statusCode = httpClient.executeMethod(postMethod);
			   
			   if (statusCode != HttpStatus.SC_OK){
			     return "";
			   }
			   //��ȡ���� 
			   byte[] responseBody = postMethod.getResponseBody();
			   //System.out.println(new String(responseBody));
			   //��������
			   return new String(responseBody,encoding);
		  }catch (Exception e){
			  e.printStackTrace();
		  }finally{
		   //�ͷ�����
			  postMethod.releaseConnection();
		  }
		  return "";
	   }
	
	/**
	 * �õ�bytes������ץȡͼƬ
	 * @param urlStr
	 * @param params
	 * @param encoding
	 * @return
	 */
	public static byte[] getUrlBytes(String urlStr){
		HttpClient httpClient = new HttpClient();
		  
		  httpClient.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(10000));
		  httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(10000);   
		  GetMethod getMethod = new GetMethod(urlStr);
		  getMethod.setRequestHeader("User-Agent","Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)");
		  //ʹ��ϵͳ�ṩ��Ĭ�ϵĻָ�����
		  getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler());
		  
		  try{
			  //ִ��getMethod
			   int statusCode = httpClient.executeMethod(getMethod);
			   if (statusCode != HttpStatus.SC_OK){
			     return null;
			   }
			   //��ȡ���� 
			   byte[] responseBody = getMethod.getResponseBody();
			   //System.out.println(new String(responseBody));
			   //��������
			   return responseBody;
		  }catch (Exception e){
			   e.printStackTrace();
		  }finally{
			  //�ͷ�����
			  getMethod.releaseConnection();
		  }
		  return null;
	}
	
	/**
	 * ��������ӵķ�������������
	 * @param url ���ֻ��������ĩβ�����/
	 */
	public static void checkDeadUrl(String url){
		String content = HttpUtil.getUrlContentByGet(url, "UTF-8");
		if(Tools.isNull(content))return;
		
		Pattern patter = Pattern.compile("[hH][rR][eE][fF]\\s*=\\s*['\"]{0,1}([^ ^'^\">]+)['\" >]"); 
		Matcher matcher = patter.matcher(content);
		while(matcher.find()){
			try{
				String href = matcher.group(1);
				if(!href.startsWith("http://")){
					if(url.startsWith("http://"))url = url.substring("http://".length());
					href="http://"+url.substring(0,url.indexOf("/")+1)+href;
				}
				System.out.println("��ʼץȡ��"+href);
				String xc = getUrlContentByGet(StringUtils.encodeUrl(href),"UTF-8");
				if(Tools.isNull(xc))System.out.println("������>>>>>>>>>>>>>>>>>>>>>>>>>>>"+href+"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
	}
	
	public static void main(String [] args)throws Exception
	{
		/*String ss = HttpUtil.getUrlContentByGet("http://211.103.157.211/shede/index.jsp?c=5","GBK");
		System.out.println(ss);*/
		//System.out.println(getUrlContentByGet("http://www.d1.com.cn/intf/WangYi_OrderList.aspx?unionId=netease&sd=20110919&ed=20110920&verifycode=44c5891e8ba1c88c655a40e49c29fb38","UTF-8"));
		//System.out.println(getUrlContentByGet("http://google.com/","GBK"));
		//System.out.println(8%4);
		//String s = "ShowMsg=QQ%D3%C3%BB%A7%A3%AC%26lt%3Bscript%26gt%3Balert%28%29%26lt%3B%2Fscr&amp;NickName=%26lt%3Bscript%26gt%3Balert%28%29%26lt%3B%2Fscr&amp;CBPoints=100&amp;CBBonus=5%25";
		//System.out.println(java.net.URLDecoder.decode(s,"GBK"));
		/*
		checkDeadUrl("http://www.d1.com.cn/");
		checkDeadUrl("http://www.d1.com.cn/html/cloth/");
		checkDeadUrl("http://www.d1.com.cn/html/man/");
		checkDeadUrl("http://www.d1.com.cn/html/cosmetic/");
		checkDeadUrl("http://www.d1.com.cn/html/ornament/");
		checkDeadUrl("http://www.d1.com.cn/html/shoebag/");
		checkDeadUrl("http://www.d1.com.cn/html/watch/");*/
		
		char c=(char)34425;
		System.out.println(c);
		
		
	}
}
