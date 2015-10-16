package com.pingan.cert.Verify;

import com.d1.Const;

/**
 * 
 * @author fangbin001
 * ������Ҫ����ǩ����֤,���Ϊtrue�����ͨ��У��,��֮���޷�ͨ��,��α�������
 *
 */
public class VerifyCertData {
	
	/**
	 * 
	 * У��֤�飬������������õ��Ĳ���(SERVLET��request.getQueryString()�������)����������÷���������У��ɰܱ�־���ɹ�--true��ʧ��--false
	 * 
	 */
	public static boolean verifyCert(String veryfyString,String certFilePath) {
 
		boolean re = true;
		VerifyService signatureService = new VerifyService(certFilePath);
		System.out.print(certFilePath);
		// ���һ�� & ���ŵ�λ��
		int lastSeparator = veryfyString.lastIndexOf("&");
		String srcStr = veryfyString.substring(0, lastSeparator);

		// ���һ�� = ���ŵ�λ��
		int lastSeparator2 = veryfyString.lastIndexOf("=");
		String signedStr = veryfyString.substring(lastSeparator2 + 1);

		try {
			 re = signatureService.verify(srcStr, signedStr);
		} catch (Exception e) {
			// У������쳣
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
