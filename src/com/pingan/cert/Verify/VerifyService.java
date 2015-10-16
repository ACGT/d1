package com.pingan.cert.Verify;
import java.io.FileInputStream;
import java.security.PublicKey;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;

public class VerifyService {

	//公钥证书位置
	private String certFilePath;

	private static String algorithm = "SHA1withRSA";

	public VerifyService(String certFilePath) {
		super();
		this.certFilePath = certFilePath;
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

		boolean success = sign3.verify(hex2byte(hexStr));
		return success;
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
