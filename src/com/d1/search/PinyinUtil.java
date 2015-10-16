package com.d1.search;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;

import com.d1.util.Tools;
     
/**
 * �õ�����ƴ�����õ���pinyin4j��Դ��Ŀ
 * @author kk
 *
 */
public class PinyinUtil {     
	
	/**
	 * �õ�ȫƴ
	 * @param s
	 * @return
	 * @throws Exception
	 */
	public static String getFullPinyin(String s) throws Exception{
		if(Tools.isNull(s))return null;
		try{
			HanyuPinyinOutputFormat hanYuPinOutputFormat = new HanyuPinyinOutputFormat();      
		     
			//������ã���Сд�����귽ʽ��      
			hanYuPinOutputFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);       
			hanYuPinOutputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);     
			hanYuPinOutputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
			
			//char[] cs = s.toCharArray();
			String r = "";
			for(int i=0;i<s.length();i++){
				String ch = ""+s.charAt(i);
				if(ch.matches("[\\u4e00-\\u9fa5]+")){
					//���ڶ����֣�ֻ�õ�һ��
					String[] ps = PinyinHelper.toHanyuPinyinStringArray(s.charAt(i), hanYuPinOutputFormat);
					r+=ps[0];
				}else{
					r+=s.charAt(i);
				}
			}
			
			return r;
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * �õ���ĸ
	 * @param s
	 * @return
	 * @throws Exception
	 */
	public static String getFirstPinyin(String s) throws Exception{
		if(Tools.isNull(s))return null;
		try{
			HanyuPinyinOutputFormat hanYuPinOutputFormat = new HanyuPinyinOutputFormat();      
		     
			//������ã���Сд�����귽ʽ��      
			hanYuPinOutputFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);       
			hanYuPinOutputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);     
			hanYuPinOutputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
			
			//char[] cs = s.toCharArray();
			String r = "";
			for(int i=0;i<s.length();i++){
				String ch = ""+s.charAt(i);
				if(ch.matches("[\\u4e00-\\u9fa5]+")){
					//���ڶ����֣�ֻ�õ�һ��
					String[] ps = PinyinHelper.toHanyuPinyinStringArray(s.charAt(i), hanYuPinOutputFormat);
					String py = ps[0];
					
					int firstLength = 1 ;
					if(py.startsWith("zh")||py.startsWith("ch")||py.startsWith("sh")){
						firstLength = 2 ;
					}
					
					r+=py.substring(0,firstLength);
					for(int j=0;j<py.length()-firstLength;j++){
						r+='_';
					}
				}else{
					r+=s.charAt(i);
				}
			}
			
			return r;
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	 
	public static void main(String[] args)throws Exception {      
	   String str = "ӡ����˿˿��������������";      
	   System.out.println(getFullPinyin(str));      
	   System.out.println(getFirstPinyin(str));
	}      
}   