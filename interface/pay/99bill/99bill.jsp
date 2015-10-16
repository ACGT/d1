<%@ page contentType="text/html; charset=UTF-8" import="com.d1.Const,java.io.*,java.security.*,java.security.cert.*"%><%!
/**
 * PKI证书加密工具类
 * @author guangquan.hu
 *
 */
public static class Pkipair {
	/**
	 * 加密方法
	 * 
	 * @param signMsg signMsg
	 * @return String
	 */
	public static String signMsg( String signMsg) {
		
		String base64 = "";
		try {
			// 密钥仓库
			KeyStore ks = KeyStore.getInstance("PKCS12");

			// 读取密钥仓库
			FileInputStream ksfis = new FileInputStream(Const.PROJECT_PATH+"conf/tester-rsa.pfx");
			BufferedInputStream ksbufin = new BufferedInputStream(ksfis);

			char[] keyPwd = "yk0712d1".toCharArray();
			ks.load(ksbufin, keyPwd);
			// 从密钥仓库得到私钥
			PrivateKey priK = (PrivateKey) ks.getKey("test-alias", keyPwd);
			Signature signature = Signature.getInstance("SHA1withRSA");
			signature.initSign(priK);
			signature.update(signMsg.getBytes("UTF-8"));
			sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
			base64 = encoder.encode(signature.sign());
			
		} catch(FileNotFoundException e){
			System.out.println("文件找不到");
		}catch (Exception ex) {
			ex.printStackTrace();
		}
//		System.out.println("test = "+base64);
		return base64;
	}

	
	/**
	 * 
	 * @param val 摘要值
	 * @param msg 快钱传递的密钥
	 * @return boolean
	 */
	public static boolean enCodeByCer(String val, String msg) {
		boolean flag = false;
		try {
			//获得文件
			InputStream inStream = new FileInputStream(Const.PROJECT_PATH+"conf/99bill.rsa.cer");
			//InputStream inStream = this.getClass().getClassLoader().getResourceAsStream("\\demo\\99bill[1].cert.rsa.20140728.cer");
			
			CertificateFactory cf = CertificateFactory.getInstance("X.509");
			X509Certificate cert = (X509Certificate) cf.generateCertificate(inStream);
			//获得公钥
			PublicKey pk = cert.getPublicKey();
			//签名
			Signature signature = Signature.getInstance("SHA1withRSA");
			signature.initVerify(pk);
			signature.update(val.getBytes("UTF-8"));
			
			//解码
			sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
			
//			System.out.println(new String(decoder.decodeBuffer(msg)));
			
			flag = signature.verify(decoder.decodeBuffer(msg));
			System.out.println(flag);
		} catch (Exception e) {
			System.out.println("文件找不到");
		} 
		return flag;
	}

}
%>