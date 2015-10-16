package com.pingan.cert.Verify;

import com.d1.Const;

public class TestVerify {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		//明文数据
		String data = "MemberID=110000004161857&EmpFlg=N&UserName=WLTTEST102&EmpOrgName=&sysDate=08%2F24%2F2009+16%3A43%3A44";
		//签名的数据(可以通过的)
		String signatureTure = "6780450D7FF38F9339FA30624534F32465E604AEE0FD0F19CC82A8A519BDBF0FB62C285FFADAB516106110DA5AE5B9A20A56953D13BF300C7EA53DD9E1BB91C02B8E529B89609BA3DA096519F71C298A9C46E948D0B5E3C7A301AD1355C7989070FDDAAB8ABFF2BC9D89FCDD0CCC452AE7932F72AAC5AF7C037616D854D8E356";
		
		/**
		 * 通过request.getQueryString()就可以直接获取下面这个字符串
		 * 在实际代码编写过程,一定要记住就用这个方法来获取,因为万里通的接口可能会随着需求增加若干参数
		 * 如果是写死根据哪几个参数来验签,将会影响到验签的结果
		 */
		String allTrue = data + "&paSignature=" + signatureTure;
		System.out.println("要验签的字符串:" + allTrue);
		//送入到方法中的验签数据,实际就是request.getQueryString()
		
		boolean resultTrue = VerifyCertData.verifyCert(allTrue, "D:/eclipse/workspace/d1web/pingan/zhengshu/V_GROUP_LPMS_PARTNER_SIGN.cer");

		if (resultTrue){
			System.out.println("验签成功");
		} else {
			System.out.println("验签失败");
		}
		
		//签名的数据(不可以通过的,相比上面这条allTure,只是少了前面一个参数MemberID=&,用这个来验证是无法通过的,可见少了字符就会影响到验证的结果)
		String allFalse = "EmpFlg=&UserName=&EmpOrgName=&sysDate=08%2F11%2F2009+20%3A28%3A06&paSignature=6C479F02BEB3A51521F2A093F4A034E021D172A7C62DF39A201DBFB3F28854A33D8AD50B3898D0DF83F3815284596BA77C91D3C00EA99F1490E3DB6543E996846FA73C0D272D96342723FBAAF05F6D2D24AC52C858595259B45C368E1ACCA3DD674F0EE0F12F956340947AB391DB3313D68B8DD24216B2FB110888C0200E842A";
		System.out.println("要验签的字符串:" + allFalse);
		boolean resultFlase = VerifyCertData.verifyCert(allFalse, Const.PROJECT_PATH+"D:/eclipse/workspace/d1web/pingan/zhengshu/V_GROUP_LPMS_PARTNER_SIGN.cer");

		if (resultFlase){
			System.out.println("验签成功");
		} else {
			System.out.println("验签失败");
		}
	}

}
