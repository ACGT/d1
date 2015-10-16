package com.d1.alipay;

import java.io.UnsupportedEncodingException;
import java.security.SignatureException;

import org.apache.commons.codec.digest.DigestUtils;

import com.d1.util.Tools;


/**
 * MD5签名验签类
 * @author 3y
 *@version $Id: wapMD5Signature.java,v 1.1 2012/06/14 05:34:15 ysw Exp $
 */
public class wapMD5Signature{
	/**
	 * 对字符串使用MD5签名,待签名字符串+key值签名
	 * @param content 待签名的字符串
	 * @param key MD5校验码
	 * @return 返回签名字符串
	 * @throws Exception
	 */
	public static String sign(String content, String key) throws Exception {
		String tosign = (content == null ? "" : content) + key;
		System.out.println("signdata:"+tosign);
        try {
            return DigestUtils.md5Hex(getContentBytes(tosign, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            throw new SignatureException("MD5签名[content = " + content + "; charset = utf-8"
                                         + "]发生异常!", e);
        }
		
	}

	/**
	 * 对字符串使用MD5验签,验签内容为签名字符串+key值
	 * @param content 签名字符串
	 * @param sign 签名值
	 * @param key MD5校验码
	 * @return 如果验签成功返回true 验签失败返回false
	 * @throws Exception
	 */
	public static boolean verify(String content, String sign, String key)
			throws Exception {
		  String tosign = (content == null ? "" : content) + key;

	        try {
	            String mySign = DigestUtils.md5Hex(getContentBytes(tosign, "utf-8"));

	            return mySign.equals(sign) ? true : false;
	        } catch (UnsupportedEncodingException e) {
	            throw new SignatureException("MD5验证签名[content = " + content + "; charset =utf-8 " 
	                                         + "; signature = " + sign + "]发生异常!", e);
	        }
	}
	
	/**
	 * 根据编码字符集对字符串使用MD5验签,验签内容为签名字符串+key值
	 * @param content 签名字符串
	 * @param sign 签名值
	 * @param key MD5校验码
	 * @param charset 编码字符集
	 * @return 如果验签成功返回true 验签失败返回false
	 * @throws Exception
	 */
	public static boolean verify(String content, String sign, String key,String charset)
    throws Exception {
	    String tosign = (content == null ? "" : content) + key;
    try {
        String mySign = DigestUtils.md5Hex(getContentBytes(tosign, charset));

        return mySign.equals(sign) ? true : false;
    } catch (UnsupportedEncodingException e) {
        throw new SignatureException("MD5验证签名[content = " + content + "; charset ="+ charset
                                     + "; signature = " + sign + "]发生异常!", e);
    }
}
	
	 /**
	  * 获取指定编码字符集字符串的byte数组
     * @param content 字符串
     * @param charset 编码字符集
     * @return 返回字符串的byte数组
     * @throws SignatureException
     * @throws UnsupportedEncodingException 
     */
    protected static byte[] getContentBytes(String content, String charset)
                                                                    throws UnsupportedEncodingException {
        if (Tools.isNull(charset)) {
            return content.getBytes();
        }

        return content.getBytes(charset);
    }
}

