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
 * 小工具而已，没什么多说的。<br/>
 * @author kk
 */
public class StringUtils {
	/**
	 * 判断一个字符串是否为空
	 * @param s
	 * @return
	 */
	public static boolean isEmpty(String s){
		return s==null||s.trim().equals("");
	}
	/**
	 * 判断一个字符串是不是数字组成
	 * @param s 字符。
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
	 * 得到一个格式化日期
	 * @param format yyyyMMdd 或yyyyMM等
	 * @return
	 */
	public static String getFormatDateString(String format){
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(format);
		java.util.Date d = new java.util.Date();
		return sdf.format(d);
	}
	
	/**
	 * 把字符串中的HTML代码转换成页面显示的代码
	 * @param 字符串 str
	 * @return String 替换后的字符传
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
	 * 把页面的HTML代码转换成页面显示的代码
	 * @param String 替换前的字符串
	 * @return String 替换后的字符串
	 */
	public static String repstr1(String str){
		if(str==null)return "";
		str=str.replaceAll("<", "&lt;");
		str=str.replaceAll(">", "&gt;");
		str=str.replaceAll("\"", "&quot;");
		return str;
	}
	
	/**
	 * 把页面显示的代码替换成HTML代码
	 * @param String 替换前的字符串
	 * @return String 替换后的字符串
	 */
	public static String repstr2(String str){
		if(str==null)return "";
		str=str.replaceAll("&lt;", "<");
		str=str.replaceAll("&gt;", ">");
		str=str.replaceAll("&quot;", "\"");
		return str;
	}
	
	/**
	 * 把字符串里的换行、尖括号、双引号去掉，用于在HTML头的keywords里显示
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
	 * 中文字符算两个长度。如“舍得网123”长度是9！
	 * @return
	 */
	public static int strLength(String s){
		if(s==null)return 0;
		return s.replaceAll("[^x00-xff]", "kk").length();
	}
	
	/**
	 * 去掉<>和"，屏蔽HTML
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
	 * 把html标签替换掉
	 * 
	 * @param html
	 * @return
	 */
	public static String replaceHtml(String html) {
		String s = "";
		try {
			String regEx = "<.+?>"; // 表示标签
			Pattern p = Pattern.compile(regEx);
			Matcher m = p.matcher(html);
			s = m.replaceAll("");
		} catch (Exception e) {
		}
		return s;
	}
	
	/**
	 * 返回字符串长度，汉字和全角符号算2。如“中国go”的长度是6！
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
	 * 对含有中文的url链接编码，只编码中文，其他字符不动
	 * @param url
	 * @return
	 */
	public static String encodeUrl(String url){
		return encodeUrl(url,"UTF-8");
	}
	
	/**
	 * 对中文和汉字的url编码
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
				if((""+url.charAt(i)).matches("[^\\x00-\\xff]+")){//中文要编码
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
	 * 取字符串的substring，如substring2("中国123",5)得到“中国1”，中文长度是2！
	 * @param start 开始位置，一般用0
	 * @param length 长度
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
	 * DES密钥
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
	 * DES解密
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
     * DES加密
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
		String source = "邮箱：13900000000@sohu.com";// 要加密的字符串
		String cryptograph = encrypt(source);// 生成的密文
		
		System.out.println(cryptograph);

		String target = decrypt(cryptograph);// 解密密文
		System.out.println(target);
	}
}
