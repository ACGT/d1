package com.d1.search;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;

import com.d1.util.Tools;
     
/**
 * 得到汉字拼音，用到了pinyin4j开源项目
 * @author kk
 *
 */
public class PinyinUtil {     
	
	/**
	 * 得到全拼
	 * @param s
	 * @return
	 * @throws Exception
	 */
	public static String getFullPinyin(String s) throws Exception{
		if(Tools.isNull(s))return null;
		try{
			HanyuPinyinOutputFormat hanYuPinOutputFormat = new HanyuPinyinOutputFormat();      
		     
			//输出设置，大小写，音标方式等      
			hanYuPinOutputFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);       
			hanYuPinOutputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);     
			hanYuPinOutputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
			
			//char[] cs = s.toCharArray();
			String r = "";
			for(int i=0;i<s.length();i++){
				String ch = ""+s.charAt(i);
				if(ch.matches("[\\u4e00-\\u9fa5]+")){
					//对于多音字，只用第一个
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
	 * 得到生母
	 * @param s
	 * @return
	 * @throws Exception
	 */
	public static String getFirstPinyin(String s) throws Exception{
		if(Tools.isNull(s))return null;
		try{
			HanyuPinyinOutputFormat hanYuPinOutputFormat = new HanyuPinyinOutputFormat();      
		     
			//输出设置，大小写，音标方式等      
			hanYuPinOutputFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);       
			hanYuPinOutputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);     
			hanYuPinOutputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
			
			//char[] cs = s.toCharArray();
			String r = "";
			for(int i=0;i<s.length();i++){
				String ch = ""+s.charAt(i);
				if(ch.matches("[\\u4e00-\\u9fa5]+")){
					//对于多音字，只用第一个
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
	   String str = "印刻真丝丝巾限量抢购将嘟嘟";      
	   System.out.println(getFullPinyin(str));      
	   System.out.println(getFirstPinyin(str));
	}      
}   