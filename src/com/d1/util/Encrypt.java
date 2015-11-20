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
	private static final byte[] sourceKey = {};//密钥
	private static final Key key = new SecretKeySpec(sourceKey, Algorithm);
	private String charset = "GBK";

	/**
	 * 加密
	 * 
	 * @param source
	 *            明文
	 * @return  密文
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
	 * 解密
	 * 
	 * @param source
	 *            密文
	 * @return  明文
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
		cipher.init(Cipher.DECRYPT_MODE, key);// 使用私钥解密
		tran = cipher.doFinal(new BASE64Decoder().decodeBuffer(source));
		result = new String(tran, charset);
		return result;
	}

	/**
	 * 获得字符集
	 * 
	 * @return
	 */
	public String getCharset() {
		return charset;
	}

	/**
	 * 设置字符集 默认“GBK”
	 * 
	 * @return
	 */
	public void setCharset(String charset) {
		this.charset = charset;
	}
}
