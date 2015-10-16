package com.d1.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


/**
 * 
 * С���߶��ѣ�ûʲô��˵�ġ�<br/>
 * @author kk
 */
public class StringUtils {
	/**
	 * �ж�һ���ַ����Ƿ�Ϊ��
	 * @param s
	 * @return
	 */
	public static boolean isEmpty(String s){
		return s==null||s.trim().equals("");
	}
	/**
	 * �ж�һ���ַ����ǲ����������
	 * @param s �ַ���
	 * @return
	 */
	public static boolean isDigits(String s){
		if(s==null||s.length()==0)return false;
		for(int i=0;i<s.length();i++){
			if(!Character.isDigit(s.charAt(i)))return false;
		}
		return true;
	}
	
	/**
	 * �õ�һ����ʽ������
	 * @param format yyyyMMdd ��yyyyMM��
	 * @return
	 */
	public static String getFormatDateString(String format){
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(format);
		java.util.Date d = new java.util.Date();
		return sdf.format(d);
	}
	
	/**
	 * ���ַ����е�HTML����ת����ҳ����ʾ�Ĵ���
	 * @param �ַ��� str
	 * @return String �滻����ַ���
	 */
	public static String repstr(String str)	{
		if(str==null)return "";
		str=str.replaceAll(" ", "&nbsp;");
		str=str.replaceAll("<", "&lt;");
		str=str.replaceAll(">", "&gt;");
		str=str.replaceAll("\"", "&quot;");
		str=str.replaceAll("\n", "<br />");
		return str;
	}
	
	/**
	 * ��ҳ���HTML����ת����ҳ����ʾ�Ĵ���
	 * @param String �滻ǰ���ַ���
	 * @return String �滻����ַ���
	 */
	public static String repstr1(String str){
		if(str==null)return "";
		str=str.replaceAll("<", "&lt;");
		str=str.replaceAll(">", "&gt;");
		str=str.replaceAll("\"", "&quot;");
		return str;
	}
	
	/**
	 * ��ҳ����ʾ�Ĵ����滻��HTML����
	 * @param String �滻ǰ���ַ���
	 * @return String �滻����ַ���
	 */
	public static String repstr2(String str){
		if(str==null)return "";
		str=str.replaceAll("&lt;", "<");
		str=str.replaceAll("&gt;", ">");
		str=str.replaceAll("&quot;", "\"");
		return str;
	}
	
	/**
	 * ���ַ�����Ļ��С������š�˫����ȥ����������HTMLͷ��keywords����ʾ
	 * @param str
	 * @return
	 */
	public static String clear(String str){
		if(str==null)return "";
		str=str.replaceAll("<", "");
		str=str.replaceAll(">", "");
		str=str.replaceAll("\"", "");
		str=str.replaceAll("\\s", "");
		return str;
	}
	/**
	 * �����ַ����������ȡ��硰�����123��������9��
	 * @return
	 */
	public static int strLength(String s){
		if(s==null)return 0;
		return s.replaceAll("[^x00-xff]", "kk").length();
	}
	
	/**
	 * ȥ��<>��"������HTML
	 * @param str
	 * @return
	 */
	public static String clearHTML(String str){
		if(str==null)return "";
		str=str.replaceAll("<", "&lt;");
		str=str.replaceAll(">", "&gt;");
		str=str.replaceAll("\"", "&quot;");
		return str;
	}
	
	/**
	 * ��html��ǩ�滻��
	 * 
	 * @param html
	 * @return
	 */
	public static String replaceHtml(String html) {
		String s = "";
		try {
			String regEx = "<.+?>"; // ��ʾ��ǩ
			Pattern p = Pattern.compile(regEx);
			Matcher m = p.matcher(html);
			s = m.replaceAll("");
		} catch (Exception e) {
		}
		return s;
	}
	
	/**
	 * �����ַ������ȣ����ֺ�ȫ�Ƿ�����2���硰�й�go���ĳ�����6��
	 * @param s
	 * @return
	 */
	public static int getCnLength(String s){
		if(Tools.isNull(s))return 0;
		
		int len=0;
		for(int i=0;i<s.length();i++){
			if((""+s.charAt(i)).matches("[^\\x00-\\xff]+")){
				len+=2;
			}else{
				len+=1;
			}
		}
		return len;
	}
	
	/**
	 * �Ժ������ĵ�url���ӱ��룬ֻ�������ģ������ַ�����
	 * @param url
	 * @return
	 */
	public static String encodeUrl(String url){
		return encodeUrl(url,"UTF-8");
	}
	
	/**
	 * �����ĺͺ��ֵ�url����
	 * @param url
	 * @param encoding
	 * @return
	 */
	public static String encodeUrl(String url,String encoding){
		if(Tools.isNull(url))return "";
		url=url.replaceAll(" ", "+");
		StringBuffer sb = new StringBuffer();
		try{
			for(int i=0;i<url.length();i++){
				if((""+url.charAt(i)).matches("[^\\x00-\\xff]+")){//����Ҫ����
					sb.append(java.net.URLEncoder.encode(url.charAt(i)+"",encoding));
				}else{
					sb.append(url.charAt(i));
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return sb.toString();
	}
	
	/**
	 * ȡ�ַ�����substring����substring2("�й�123",5)�õ����й�1�������ĳ�����2��
	 * @param start ��ʼλ�ã�һ����0
	 * @param length ����
	 * @param s
	 * @return
	 */
	public static String getCnSubstring(String s,int start,int length){
		if(Tools.isNull(s))return "";
		if(length<=0||start>=length)return "";
		if(length>getCnLength(s))length=getCnLength(s);
		
		StringBuffer sb = new StringBuffer();
		int loc = 0;
		for(int i=0;i<s.length();i++){
			String c = s.charAt(i)+"";
			
			if(loc>length)break;
			if(loc>=start&&loc<start+length)sb.append(c);

			loc+=getCnLength(c);
		}
		
		return sb.toString();
	}
	
	/**
	 * DES��Կ
	 */
	private static String key = "9i8u4r3e";
	
	static{
    	try{
    		BufferedReader br = new BufferedReader(new FileReader(new File("/etc/des.passwd")));
    		String line = null ;
    		if((line=br.readLine())!=null){
    			key = line.trim();
    		}
    		br.close();
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    }
	
	/**
	 * DES����
	 * @param message
	 * @param key
	 * @return
	 * @throws Exception
	 */
    public static String decrypt(String message) throws Exception {      
    	BASE64Decoder base64Decoder = new BASE64Decoder();  
    	byte[] bytesrc=base64Decoder.decodeBuffer(message);
    	Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");      
    	DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));      
    	SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");      
    	SecretKey secretKey = keyFactory.generateSecret(desKeySpec);      
    	IvParameterSpec iv = new IvParameterSpec(key.getBytes("UTF-8"));      
    	cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);      
    	byte[] retByte = cipher.doFinal(bytesrc);      
    	return new String(retByte,"UTF-8");      	    
    }
 
    /**
     * DES����
     * @param message
     * @param key
     * @return
     * @throws Exception
     */
    public static String encrypt(String message) throws Exception {    
    	Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");      
    	DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));      
    	SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");      
    	SecretKey secretKey = keyFactory.generateSecret(desKeySpec);      
    	IvParameterSpec iv = new IvParameterSpec(key.getBytes("UTF-8"));      
    	cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);      
    	byte[] encryptbyte = cipher.doFinal(message.getBytes("UTF-8")); 
    	BASE64Encoder base64Encoder = new BASE64Encoder();   
    	String ret = base64Encoder.encode(encryptbyte);
    	ret = ret.replaceAll("\\s", "");
    	return ret;    	           
    }     

	public static void main(String[] args) throws Exception {
		String source = "���䣺13900000000@sohu.com";// Ҫ���ܵ��ַ���
		String cryptograph = encrypt(source);// ���ɵ�����
		
		System.out.println(cryptograph);

		String target = decrypt(cryptograph);// ��������
		System.out.println(target);
	}
}
