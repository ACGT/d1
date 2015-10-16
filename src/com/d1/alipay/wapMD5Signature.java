package com.d1.alipay;

import java.io.UnsupportedEncodingException;
import java.security.SignatureException;

import org.apache.commons.codec.digest.DigestUtils;

import com.d1.util.Tools;


/**
 * MD5ǩ����ǩ��
 * @author 3y
 *@version $Id: wapMD5Signature.java,v 1.1 2012/06/14 05:34:15 ysw Exp $
 */
public class wapMD5Signature{
	/**
	 * ���ַ���ʹ��MD5ǩ��,��ǩ���ַ���+keyֵǩ��
	 * @param content ��ǩ�����ַ���
	 * @param key MD5У����
	 * @return ����ǩ���ַ���
	 * @throws Exception
	 */
	public static String sign(String content, String key) throws Exception {
		String tosign = (content == null ? "" : content) + key;
		System.out.println("signdata:"+tosign);
        try {
            return DigestUtils.md5Hex(getContentBytes(tosign, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            throw new SignatureException("MD5ǩ��[content = " + content + "; charset = utf-8"
                                         + "]�����쳣!", e);
        }
		
	}

	/**
	 * ���ַ���ʹ��MD5��ǩ,��ǩ����Ϊǩ���ַ���+keyֵ
	 * @param content ǩ���ַ���
	 * @param sign ǩ��ֵ
	 * @param key MD5У����
	 * @return �����ǩ�ɹ�����true ��ǩʧ�ܷ���false
	 * @throws Exception
	 */
	public static boolean verify(String content, String sign, String key)
			throws Exception {
		  String tosign = (content == null ? "" : content) + key;

	        try {
	            String mySign = DigestUtils.md5Hex(getContentBytes(tosign, "utf-8"));

	            return mySign.equals(sign) ? true : false;
	        } catch (UnsupportedEncodingException e) {
	            throw new SignatureException("MD5��֤ǩ��[content = " + content + "; charset =utf-8 " 
	                                         + "; signature = " + sign + "]�����쳣!", e);
	        }
	}
	
	/**
	 * ���ݱ����ַ������ַ���ʹ��MD5��ǩ,��ǩ����Ϊǩ���ַ���+keyֵ
	 * @param content ǩ���ַ���
	 * @param sign ǩ��ֵ
	 * @param key MD5У����
	 * @param charset �����ַ���
	 * @return �����ǩ�ɹ�����true ��ǩʧ�ܷ���false
	 * @throws Exception
	 */
	public static boolean verify(String content, String sign, String key,String charset)
    throws Exception {
	    String tosign = (content == null ? "" : content) + key;
    try {
        String mySign = DigestUtils.md5Hex(getContentBytes(tosign, charset));

        return mySign.equals(sign) ? true : false;
    } catch (UnsupportedEncodingException e) {
        throw new SignatureException("MD5��֤ǩ��[content = " + content + "; charset ="+ charset
                                     + "; signature = " + sign + "]�����쳣!", e);
    }
}
	
	 /**
	  * ��ȡָ�������ַ����ַ�����byte����
     * @param content �ַ���
     * @param charset �����ַ���
     * @return �����ַ�����byte����
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

