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
	 * ���ɶ�ά��
	 * @author 
	 *
	 */
		
		/**
		 * ���ɶ�ά��ͼƬ
		 * @param toEncryptStr Ҫ���ܵ���Ϣ
		 * @return Image
		 * @throws Exception 
		 */
		public static Image generateQR(String codeqr) throws Exception
		{
			//����QR��ά����� 
			Map<EncodeHintType,Object> hints=new HashMap<EncodeHintType,Object>();
			hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H); 
			hints.put(EncodeHintType.CHARACTER_SET, "GBK"); 
			//Encrypt encoder=new Encrypt();
			//����
			String ming=codeqr;//����
//			System.out.println("ming="+ming);
			//String mi=encoder.encrypt(ming);//����
//			System.out.println("mi="+mi);
//			System.out.println("���ܣ�"+encoder.decrypt(mi));
			//���ɶ�λͼ
			BarcodeQRCode qr=new BarcodeQRCode(ming,150,150,hints);//�˴������������ɵĶ�ά�룬���ɨ���������ϢҲ������
			Image image = qr.getImage();
			return image;//���ض�ά��
		}
		
}
