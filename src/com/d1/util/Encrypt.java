package com.d1.util;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Encrypt {
	private static final String Algorithm = "DESede";
	private static final byte[] sourceKey = {};//��Կ
	private static final Key key = new SecretKeySpec(sourceKey, Algorithm);
	private String charset = "GBK";

	/**
	 * ����
	 * 
	 * @param source
	 *            ����
	 * @return  ����
	 * @throws InvalidKeyException
	 * @throws UnsupportedEncodingException
	 * @throws NoSuchAlgorithmException
	 * @throws NoSuchPaddingException
	 * @throws IllegalBlockSizeException
	 * @throws BadPaddingException
	 */
	public String encrypt(String source) throws InvalidKeyException,
			UnsupportedEncodingException, NoSuchAlgorithmException,
			NoSuchPaddingException, IllegalBlockSizeException,
			BadPaddingException {
		String result = new String();

		byte[] tran = null;

		byte[] target = source.getBytes(charset);
		Cipher cipher = Cipher.getInstance(Algorithm);
		cipher.init(Cipher.ENCRYPT_MODE, key);
		tran = cipher.doFinal(target);
		result = new BASE64Encoder().encode(tran);
		return result;
	}

	/**
	 * ����
	 * 
	 * @param source
	 *            ����
	 * @return  ����
	 * @throws InvalidKeyException
	 * @throws NoSuchAlgorithmException
	 * @throws NoSuchPaddingException
	 * @throws IllegalBlockSizeException
	 * @throws BadPaddingException
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */
	public String decrypt(String source) throws InvalidKeyException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			IllegalBlockSizeException, BadPaddingException,
			UnsupportedEncodingException, IOException {
		String result = new String();
		byte[] tran = null;

		Cipher cipher = Cipher.getInstance(Algorithm);
		cipher.init(Cipher.DECRYPT_MODE, key);// ʹ��˽Կ����
		tran = cipher.doFinal(new BASE64Decoder().decodeBuffer(source));
		result = new String(tran, charset);
		return result;
	}

	/**
	 * ����ַ���
	 * 
	 * @return
	 */
	public String getCharset() {
		return charset;
	}

	/**
	 * �����ַ��� Ĭ�ϡ�GBK��
	 * 
	 * @return
	 */
	public void setCharset(String charset) {
		this.charset = charset;
	}
}
