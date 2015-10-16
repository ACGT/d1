package com.pingan.cert.Verify;

import java.io.FileInputStream;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.Enumeration;

public class SignatureService {
	private String sslTrustStore4SSLChannel;

	private String sslTrustPassword4SSLChannel;

	private String certFilePath;

	private static String algorithm = "SHA1withRSA";

	public SignatureService(String sslTrustStore4SSLChannel,
			String sslTrustPassword4SSLChannel, String certFilePath) {
		super();
		this.sslTrustStore4SSLChannel = sslTrustStore4SSLChannel;
		this.sslTrustPassword4SSLChannel = sslTrustPassword4SSLChannel;
		this.certFilePath = certFilePath;
	}

	/**
	 * 签名服务
	 */
	public  String sign(String srcStr) throws Exception {

		// KeyStore store = KeyStore.getInstance("JKS");
		KeyStore store = KeyStore.getInstance("PKCS12");
		FileInputStream stream = new FileInputStream(sslTrustStore4SSLChannel); // jks文件名
		String passwd = sslTrustPassword4SSLChannel; // jks文件密码
		store.load(stream, passwd.toCharArray());
		// 获取jks证书别名
		Enumeration en = store.aliases();
		String pName = null;

		while (en.hasMoreElements()) {
			String n = (String) en.nextElement();
			if (store.isKeyEntry(n)) {
				pName = n;
			}
		}

		// 获取证书的私钥
		PrivateKey key = (PrivateKey) store.getKey(pName, passwd.toCharArray());
		// 进行签名服务
		Signature signature = Signature.getInstance(algorithm);
		signature.initSign(key);
		signature.update(srcStr.getBytes());
		byte[] signedData = signature.sign();
		// 将字节数组转换成HEX字符串返回

		return byte2hex(signedData);
	}

	/**
	 * 进行验签服务
	 */
	public boolean verify(String srcStr, String hexStr) throws Exception {
		// 获取指定证书的公钥
		CertificateFactory certInfo = CertificateFactory.getInstance("x.509");
		X509Certificate cert = (X509Certificate) certInfo
				.generateCertificate(new FileInputStream(certFilePath));
		PublicKey publicKey = cert.getPublicKey();
		Signature sign3 = Signature.getInstance(algorithm);
		sign3.initVerify(publicKey);
		sign3.update(srcStr.getBytes());
		// boolean success = sign3.verify(signedData);
		boolean success = sign3.verify(hex2byte(hexStr));
		return success;
	}

	public static String byte2hex(byte[] b) {
		String hs = "";
		String stmp = "";
		for (int i = 0; i < b.length; i++) {
			stmp = Integer.toHexString(b[i] & 0xFF);
			if (stmp.length() == 1) {
				hs += "0" + stmp;
			} else {
				hs += stmp;
			}
		}
		return hs.toUpperCase();

	}

	public static byte[] hex2byte(String hex) throws IllegalArgumentException {
		if (hex.length() % 2 != 0) {
			throw new IllegalArgumentException();
		}
		char[] arr = hex.toCharArray();
		byte[] b = new byte[hex.length() / 2];
		for (int i = 0, j = 0, l = hex.length(); i < l; i++, j++) {
			String swap = "" + arr[i++] + arr[i];
			int byteint = Integer.parseInt(swap, 16) & 0xFF;
			b[j] = new Integer(byteint).byteValue();
		}
		return b;
	}
 
}
