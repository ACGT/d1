package com.pingan.cert.Verify;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;




public class PinganBisUtil {
	/**
	 * 
	 * @param input:data下面的所有数据，不包含data节点
	 * @param key：万里通分配给商户的密钥
	 * @return 加密后的签名
	 */
	public static String encode(String bisData,String keyContent){
		if(null==keyContent || isEmpty(bisData)){
			return null;
		}
		String sign = "";
		
		pinganMD5 md5 = new pinganMD5(bisData);
		String md5DataStr = md5.compute();
		//AES加密
		sign = encrypt(md5DataStr, keyContent);	
		
		return sign;
	}

	public static String encrypt(String input, String key) {
		byte[] crypted = null;
		try {
			SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, skey);
			crypted = cipher.doFinal(input.getBytes());
		} catch (Exception e) {
		}
		return new String(Base64.encodeBase64(crypted));
	}
      public static boolean isEmpty(String str) {
  		return str == null || str.trim().length() == 0;
  	}
  	//将加签的值放到value节点下
  	public static String getSignXMLString(String xmlString,String sign) {
  		String StrVal = "";
  		if (xmlString != null && !"".equals(xmlString)) {
  			boolean isExistStr = xmlString.contains("<sign>");
  			int a = xmlString.lastIndexOf("<value>");
  			int b = xmlString.lastIndexOf("</value>");
  			String requestXML = "";
  			String requestXMLStr="";
  			requestXML = xmlString.substring(0, b);
  			requestXMLStr = xmlString.substring(b, xmlString.length());
  			if (isExistStr) {
  				StrVal = requestXML+sign+requestXMLStr;
  			} else {
  				StrVal = requestXML;
  			}
  		}
  		return StrVal.trim();
  	}
  	 public static String getNodeValues(String xmlString, String... names)
  	  {
  	    if ((names == null) || (names.length == 0)) {
  	      return null;
  	    }
  	    String nodeValue = xmlString;
  	    for (String name : names) {
  	      nodeValue = getNodeValue(nodeValue, name);
  	      if (nodeValue == null) {
  	        return null;
  	      }
  	    }
  	    return nodeValue;
  	  }
  	 public static String getNodeValue(String xmlString, String name)
  	  {
  	    if (xmlString == null) {
  	    
  	      return null;
  	    }
  	    int startPos = xmlString.indexOf("<" + name + ">");
  	    if (startPos == -1) {
  	      
  	      return null;
  	    }
  	    int endPos = xmlString.lastIndexOf("</" + name + ">");
  	    if (endPos == -1) {
  	      return null;
  	    }
  	    return xmlString.substring(startPos + ("</" + name + ">").length() - 1, endPos);
  	  }
}
