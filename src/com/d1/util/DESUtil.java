package com.d1.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Key;
import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
public class DESUtil {
	 // a weak key

    private static String encoding = "UTF-8";
    // ��Կ
    private String sKey = "";


    public DESUtil(String sKey) {
        this.sKey = sKey;
    }

    /**
     * �����ַ���
     */
    public String encryptStr(String str) {
        String result = str;
        if (str != null && str.length() > 0) {
            try {
                byte[] encodeByte = symmetricEncrypto(str.getBytes(encoding));
                result = Base64Util.encode(encodeByte);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * �����ַ���
     */
    public String decryptStr(String str) {
        String result = str;
        if (str != null && str.length() > 0) {
            try {
                byte[] encodeByte = Base64Util.decode(str);

                byte[] decoder = symmetricDecrypto(encodeByte);
                result = new String(decoder, encoding);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }


    /**
     * ����byte[]
     */
    public byte[] ebotongEncrypto(byte[] str) {
        byte[] result = null;
        if (str != null && str.length > 0) {
            try {
                byte[] encodeByte = symmetricEncrypto(str);
                result = Base64Util.encode(encodeByte).getBytes();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * ����byte[]
     */
    public byte[] ebotongDecrypto(byte[] str) {
        byte[] result = null;
        if (str != null && str.length > 0) {
            try {

                byte[] encodeByte = Base64Util.decode(new String(str, encoding));
                //byte[] encodeByte = base64decoder.decodeBuffer(new String(str));
                byte[] decoder = symmetricDecrypto(encodeByte);
                result = new String(decoder).getBytes(encoding);
                result = new String(decoder).getBytes();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }


    /**
     * �ԳƼ����ֽ����鲢����
     *
     * @param byteSource ��Ҫ���ܵ�����
     * @return           �������ܵ�����
     * @throws Exception
     */
    public byte[] symmetricEncrypto(byte[] byteSource) throws Exception {
        try {
            int mode = Cipher.ENCRYPT_MODE;
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            byte[] keyData = sKey.getBytes();
            DESKeySpec keySpec = new DESKeySpec(keyData);
            Key key = keyFactory.generateSecret(keySpec);
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(mode, key);

            byte[] result = cipher.doFinal(byteSource);
            return result;
        } catch (Exception e) {
            throw e;
        } finally {
        }
    }

    /**
     * �Գƽ����ֽ����鲢����
     *
     * @param byteSource ��Ҫ���ܵ�����
     * @return           �������ܵ�����
     * @throws Exception
     */
    public byte[] symmetricDecrypto(byte[] byteSource) throws Exception {
        try {
            int mode = Cipher.DECRYPT_MODE;
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            byte[] keyData = sKey.getBytes();
            DESKeySpec keySpec = new DESKeySpec(keyData);
            Key key = keyFactory.generateSecret(keySpec);
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(mode, key);
            byte[] result = cipher.doFinal(byteSource);
            return result;
        } catch (Exception e) {
            throw e;
        } finally {

        }
    }

    /**
     * ɢ���㷨
     *
     * @param byteSource
     *            ��Ҫɢ�м��������
     * @return ����ɢ�м��������
     * @throws Exception
     */
    public static byte[] hashMethod(byte[] byteSource) throws Exception {
        try {
            MessageDigest currentAlgorithm = MessageDigest.getInstance("SHA-1");
            currentAlgorithm.reset();
            currentAlgorithm.update(byteSource);
            return currentAlgorithm.digest();
        } catch (Exception e) {
            throw e;
        }
    }


    /**
     * ���ļ�srcFile���м���������ļ�distFile
     * @param srcFile �����ļ�
     * @param distFile ���ܺ���ļ�
     * @throws Exception
     */
    public void EncryptFile(String srcFile,String distFile) throws Exception{

        InputStream  is=null;
        OutputStream out  = null;
        CipherInputStream cis =null;
        try {
            int mode = Cipher.ENCRYPT_MODE;
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            byte[] keyData = sKey.getBytes();
            DESKeySpec keySpec = new DESKeySpec(keyData);
            Key key = keyFactory.generateSecret(keySpec);
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(mode, key);
            is= new FileInputStream(srcFile);
            out  = new FileOutputStream(distFile);
            cis = new CipherInputStream(is,cipher);
            byte[] buffer = new byte[1024];
            int r;
            while((r=cis.read(buffer))>0){
                out.write(buffer, 0, r);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            cis.close();
            is.close();
            out.close();
        }
    }

    /**
     * �����ļ�srcFile��Ŀ���ļ�distFile
     * @param srcFile �����ļ�
     * @param distFile ���ܺ���ļ�
     * @throws Exception
     */
    public void DecryptFile(String srcFile,String distFile) throws Exception{

        InputStream  is=null;
        OutputStream out  = null;
        CipherOutputStream cos =null;
        try {
            int mode = Cipher.DECRYPT_MODE;
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            byte[] keyData = sKey.getBytes();
            DESKeySpec keySpec = new DESKeySpec(keyData);
            Key key = keyFactory.generateSecret(keySpec);
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(mode, key);
            byte[] buffer = new byte[1024];
            is= new FileInputStream(srcFile);
            out  = new FileOutputStream(distFile);
            cos = new CipherOutputStream(out,cipher);

            int r;
            while((r=is.read(buffer))>=0){
                cos.write(buffer, 0, r);
            }

        } catch (Exception e) {
            throw e;
        } finally {
            cos.close();
            is.close();
            out.close();
        }
    }


    /**
     * ���ļ����м���64λ����
     * @param srcFile Դ�ļ�
     * @param distFile Ŀ���ļ�
     */
    public void  BASE64EncoderFile(String srcFile,String distFile){
        InputStream inputStream =null;
        OutputStream out  = null;
        try {
            inputStream = new FileInputStream(srcFile);

            out  = new FileOutputStream(distFile);
            byte[] buffer = new byte[1024];
            while(inputStream.read(buffer)>0){
                out.write(ebotongEncrypto(buffer));
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            try {
                out.close();
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }


    }

    /**
     * ���ļ����н���64λ����
     * @param srcFile Դ�ļ�
     * @param distFile Ŀ���ļ�
     */
    public void BASE64DecoderFile(String srcFile,String distFile){
        InputStream inputStream =null;
        OutputStream out  = null;
        try {
            inputStream = new FileInputStream(srcFile);

            out  = new FileOutputStream(distFile);
            byte[] buffer = new byte[1412];

            while(inputStream.read(buffer)>0){
                out.write(ebotongDecrypto(buffer));
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            try {
                out.close();
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }
    public static String encryptDES(String encryptString, String encryptKey,String iv) throws Exception {
    	String ecode="UTF-8";
    	byte[] ivb=iv.getBytes(ecode);
     	IvParameterSpec zeroIv = new IvParameterSpec(ivb);
    	SecretKeySpec key = new SecretKeySpec(encryptKey.getBytes(ecode), "DES");
    	Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
    	cipher.init(Cipher.ENCRYPT_MODE, key, zeroIv);
    	byte[] encryptedData = cipher.doFinal(encryptString.getBytes(ecode));
     
    	return new BASE64Encoder().encode(encryptedData);
    }
    
    public static String decryptDES(String decryptString, String decryptKey,String iv) throws Exception {
    	String ecode="UTF-8";
    	byte[] ivb=iv.getBytes(ecode);
    	byte[] byteMi = new BASE64Decoder().decodeBuffer(decryptString);
    	IvParameterSpec zeroIv = new IvParameterSpec(ivb);
    	SecretKeySpec key = new SecretKeySpec(decryptKey.getBytes(ecode), "DES");
    	Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
    	cipher.init(Cipher.DECRYPT_MODE, key, zeroIv);
    	byte decryptedData[] = cipher.doFinal(byteMi);
    	
    	return new String(decryptedData,ecode);
    }
    public static void main(String[] args) throws Exception {  
    	
    /*  DESUtil des = new DESUtil( "hellod12" );  
       String str1 = "1513301|527795815@qq.com|1357440933765" ;  
       //str1=URLEncoder.encode(str1, "utf-8");
       // DES �����ַ���  
       String str2 =des.encryptStr(str1); 
      // String s=URLDecoder.decode("%2BrNO0fgEAlj3snCjafFuFD9nZqce1Vs9cp%2FoKDh2FkUsD2ItbrjWxA%3D%3D","utf-8");
       // DES �����ַ���  
       String deStr = des.decryptStr(str2);  
       System. out .println( " ����ǰ�� " + str1);  
       System. out .println( " ���ܣ� " + str2);  
       System. out .println( " ���ܺ� " + URLEncoder.encode(str2, "utf-8"));  
       //System. out .println( " ���ܣ� " + s);  
       System. out .println( " ���ܣ� " + deStr); 
       System. out .println( " ���ܣ� " + URLDecoder.decode(deStr, "utf-8")); */
    	  //DESUtil des = new DESUtil( "bjlsysgs" );
    	/*String ss="JmbW/fhPbrKGHFKaZHSB5ygWI8JydKMMEq0W3gFN+/6lxG1+z9pYuQ7GtXKExqgTKXhAiDY1fTIg0rmg3Vkxmy68M/o5T2+qnCTIATSzd/A=";
    	//
    	
    	String ss2 =decryptDES(ss,"bjlsysgs","bjlsysgs");

    	System. out .println(ss2);*/
    	
    	
        //System. out .println( " ���ܣ� " + URLDecoder.decode(decryptDES(ss,"bjlsysgs","bjlsysgs"), "GBK"));
    	 // +uQgeL522YQ=</productcode><developid>E8uaWTQHubg=
    	
    }  
 
}
