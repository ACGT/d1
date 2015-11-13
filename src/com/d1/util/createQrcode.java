package com.d1.util;
import java.util.HashMap;
import java.util.Map;

import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.BarcodeQRCode;
import com.itextpdf.text.pdf.qrcode.EncodeHintType;
import com.itextpdf.text.pdf.qrcode.ErrorCorrectionLevel;

import net.sf.json.JSONArray;
public class createQrcode {



	/**
	 * 生成二维码
	 * @author 
	 *
	 */
		
		/**
		 * 生成二维码图片
		 * @param toEncryptStr 要加密的信息
		 * @return Image
		 * @throws Exception 
		 */
		public static Image generateQR(String codeqr) throws Exception
		{
			//设置QR二维码参数 
			Map<EncodeHintType,Object> hints=new HashMap<EncodeHintType,Object>();
			hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H); 
			hints.put(EncodeHintType.CHARACTER_SET, "GBK"); 
			//Encrypt encoder=new Encrypt();
			//加密
			String ming=codeqr;//明文
//			System.out.println("ming="+ming);
			//String mi=encoder.encrypt(ming);//密文
//			System.out.println("mi="+mi);
//			System.out.println("解密："+encoder.decrypt(mi));
			//生成二位图
			BarcodeQRCode qr=new BarcodeQRCode(ming,150,150,hints);//此处是用密文生成的二维码，因此扫描出来的信息也是密文
			Image image = qr.getImage();
			return image;//返回二维码
		}
		
}
