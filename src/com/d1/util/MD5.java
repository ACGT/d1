package com.d1.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5
{
	/**
	 * 16位MD5加密
	 * @param s
	 * @return
	 */
	public static String toMD5(String s)
	{
		char hexDigits[] = {
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
		'e', 'f'};
		try {
		byte[] strTemp = s.getBytes();
		MessageDigest mdTemp = MessageDigest.getInstance("MD5");
		mdTemp.update(strTemp);
		byte[] md = mdTemp.digest();
		int j = md.length;
		char str[] = new char[j * 2];
		int k = 0;
		for (int i = 0; i < j; i++) {
		byte byte0 = md[i];
		str[k++] = hexDigits[byte0 >>>4 & 0xf];
		str[k++] = hexDigits[byte0 & 0xf];
		}
		
		String res =  new String(str);
		if(res!=null&&res.length()==32)res = res.substring(8,24);
		return res;
		}
		catch (Exception e){
		return null;
		}
	}
	
	/**
	 * 32位MD5加密
	 * @param s
	 * @return
	 */
	public static String to32MD5(String s){
		char hexDigits[] = {
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
		'e', 'f'};
		try {
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>>4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
		
			String res =  new String(str);
			if(res != null && res.length()>32) res = res.substring(0,32);
			return res;
		}
		catch (Exception e){
			return null;
		}
	}
	
	/**
	 * 32位MD5加密
	 * @param s
	 * @return
	 */
	public static String to32MD5(String s , String character){
		char hexDigits[] = {
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
		'e', 'f'};
		try {
			byte[] strTemp = s.getBytes(character);
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>>4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
		
			String res =  new String(str);
			if(res != null && res.length()>32) res = res.substring(0,32);
			return res;
		}
		catch (Exception e){
			return null;
		}
	}
	
	public static byte[] getKeyedDigest(byte[] buffer, byte[] key) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(buffer);
            return md5.digest(key);
        } catch (NoSuchAlgorithmException e) {
        }
        return null;
    }
	
		
	public static String getKeyedDigest(String strSrc, String key) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(strSrc.getBytes("UTF8"));
            
            String result="";
            byte[] temp;
            temp=md5.digest(key.getBytes("UTF8"));
    		for (int i=0; i<temp.length; i++){
    			result+=Integer.toHexString((0x000000ff & temp[i]) | 0xffffff00).substring(6);
    		}
    		
    		return result;
    		
        } catch (NoSuchAlgorithmException e) {
        	
        	e.printStackTrace();
        	
        }catch(Exception e)
        {
          e.printStackTrace();
        }
        return null;
    }

	public static void main(String[] args) throws Exception {
		//System.out.println(System.getProperty("java.library.path"));
		//System.setProperty("java.library.path", "d:/");
		//System.out.println(MD5.to32MD5("1234"));
		System.loadLibrary("util8848");
		
	}
}
