package com.pingan.cert.Verify;

import com.d1.Const;

/**
 * 
 * @author fangbin001
 * 该类主要是做签名验证,如果为true则代表通过校验,反之则无法通过,是伪造的数据
 *
 */
public class VerifyCertData {
	
	/**
	 * 
	 * 校验证书，合作方获得所得到的参数(SERVLET中request.getQueryString()方法获得)，整体送入该方法，返回校验成败标志，成功--true，失败--false
	 * 
	 */
	public static boolean verifyCert(String veryfyString,String certFilePath) {
 
		boolean re = true;
		VerifyService signatureService = new VerifyService(certFilePath);
		System.out.print(certFilePath);
		// 最后一个 & 符号的位置
		int lastSeparator = veryfyString.lastIndexOf("&");
		String srcStr = veryfyString.substring(0, lastSeparator);

		// 最后一个 = 符号的位置
		int lastSeparator2 = veryfyString.lastIndexOf("=");
		String signedStr = veryfyString.substring(lastSeparator2 + 1);

		try {
			 re = signatureService.verify(srcStr, signedStr);
		} catch (Exception e) {
			// 校验出现异常
			re=false;
			e.printStackTrace();
		}
		return re;
	}
	public static boolean chkSign(String strSing){
		boolean resultTrue = VerifyCertData.verifyCert(strSing, Const.PROJECT_PATH+"pingan/zhengshu/V_GROUP_LPMS_PARTNER_SIGN.cer1");
       return resultTrue;
	}
}
