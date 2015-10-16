package com.d1.util;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.configuration.XMLConfiguration;
import org.apache.log4j.Logger;

import com.d1.Const;

/**
 * ���д���Ĺ�����
 * @author k
 *
 */
public class UserCityPools{

	private static Logger log = Logger.getLogger(UserCityPools.class);
	
	/**
	 * ����
	 */
	private static HashMap<String,String> hashCity = new HashMap<String,String>(4500);
	
	/**
	 * ��˳������
	 */
	private static ArrayList<String> cityList = new ArrayList<String>();
	
	/**
	 * ʡ��һ����������ʡ�����֣��ڶ�����ʡ��code
	 */
	private static HashMap<String,String> province = new HashMap<String,String>(40);
	
	/**
	 * ����city����
	 * @return ArrayList
	 */
	@SuppressWarnings("rawtypes")
	public static ArrayList getCityList(){
		return cityList;
	}
	
	
	/**
	 * ��ȡhashCity
	 * @return hashCity
	 */
	@SuppressWarnings("rawtypes")
	public static HashMap getHashCity(){
		return hashCity;
	}

	static {
		log.info("��ʼ�������ļ���ʼ...");
		String cityPath = Const.PROJECT_PATH+"conf/CityCodes.xml";
		try{
			XMLConfiguration config = new XMLConfiguration();
			config.load(new File(cityPath));
			String[] areaCodes = config.getStringArray("CityCodes.CityCode[@areaCode]");
			String[] names = config.getStringArray("CityCodes.CityCode[@name]");
			for(int i=0;i<areaCodes.length;i++){
				hashCity.put(areaCodes[i],names[i]);
				cityList.add(areaCodes[i]+"|"+names[i]);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		log.info("��ʼ�������ļ�����...");
		log.info("��ʼ��1kaʡ��");
		String provincePath = Const.PROJECT_PATH+"conf/1kaProvince.xml";
		try{
			XMLConfiguration config = new XMLConfiguration();
			config.load(new File(provincePath));
			String[] areaCodes = config.getStringArray("CityCodes.CityCode[@areaCode]");
			String[] names = config.getStringArray("CityCodes.CityCode[@name]");
			for(int i=0;i<areaCodes.length;i++){
				province.put(names[i],areaCodes[i]);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		log.info("��ʼ��1kaʡ�ݽ���");
	}
	
	/**
	 * ���ݴ����ʡ�ݺͳ��л��������е�Code
	 * @param provice - ʡ��
	 * @param city - ����
	 * @return String - ����code
	 */
	public static String getCityCode(String provice , String city){
		String provinceCode = province.get(provice);
		if(provinceCode==null) return "861101";//���û�����ʡ�ݵĻ���ô��Ĭ��Ϊ����������
		String str = null;
		for(int i=1;i<31;i++){
			String cc = null;//��ϳ���code
			if(i<10) cc = provinceCode+"0"+i;
			else cc = provinceCode+""+i;
			String cityName = hashCity.get(cc);
			if(cityName!=null && cityName.indexOf(city)>-1){
				str = cc;
				break;
			}
		}
		if(str == null ) {//Ĭ��δĳ��ʡ��һ������
			str = provinceCode+"01";
		}
		return str;
	}
	
	/**
	 * ��ʡ�ݱ��option�ַ���
	 * @param selectedValue
	 * @param cssstyle
	 */
	public static String provinceToOptionString(String selectedValue,String cssstyle){
		StringBuffer sb = new StringBuffer();
		if(cssstyle==null)cssstyle="";
		if(selectedValue==null)selectedValue="";
		
		
		for(int i=0;i<cityList.size();i++){
			String key = (String)cityList.get(i);
			if(key==null)continue;
			String k = key.substring(0,key.indexOf("|"));
			String v = key.substring(key.indexOf("|")+1);
			if(k.startsWith("86")&&k.length()==4){
				String pk = k.substring(2);
				sb.append("<option value='"+pk+"' ").append(cssstyle);
				if(selectedValue.equals(pk))sb.append(" selected=\"selected\"");
				sb.append(">").append(v);
				sb.append("</option>");
				sb.append(System.getProperty("line.separator"));
			}
		}
		return sb.toString();
	}
	
	/**
	 * WML�У���ʡ�ݱ��option�ַ���
	 * @param selectedValue
	 * @param cssstyle
	 */
	public static String provinceToOptionStringWML(String selectedValue){
		StringBuffer sb = new StringBuffer();
		if(selectedValue==null)selectedValue="";
		
		for(int i=0;i<cityList.size();i++){
			String key = (String)cityList.get(i);
			if(key==null)continue;
			String k = key.substring(0,key.indexOf("|"));
			String v = key.substring(key.indexOf("|")+1);
			if(k.startsWith("86")&&k.length()==4){
				String pk = k.substring(2);
				sb.append("<option value='"+pk+"' ");
				sb.append("onpick='/wap/regist.jsp?cityCode2="+pk+"'");
				if(selectedValue.equals(pk))sb.append(" selected=\"selected\"");
				sb.append(">").append(v);
				sb.append("</option>");
				sb.append(System.getProperty("line.separator"));
			}
		}
		return sb.toString();
	}
	/**
	 * ��ʡ���ݱ��option��
	 * @param cssstyle
	 * @param provinceCode  ʡ��Ӧ��ֵ����ʾ��ʾ��ʡ������ʲô������ʾ
	 * @return
	 */
	public static String districtToOptionString(String selectedValue,String cssstyle,String provinceCode){
		StringBuffer sb = new StringBuffer();
		if(cssstyle==null)cssstyle="";
		if(selectedValue==null)selectedValue="";
		if(provinceCode==null||provinceCode.length()==0)return "";
		
		for(int i=0;i<cityList.size();i++){
			String key = (String)cityList.get(i);//861112|������
			if(key==null)continue;
			String k = key.substring(0,key.indexOf("|"));
			String v = key.substring(key.indexOf("|")+1);
			if(k.startsWith("86")&&k.length()==6){
				String k1 = k.substring(2,4);
				String k2 = k.substring(4,6);
				if(provinceCode.equals(k1)){
					sb.append("<option value='"+k2+"' ").append(cssstyle);
					if(selectedValue.equals(k2))sb.append(" selected=\"selected\"");
					sb.append(">").append(v);
					sb.append("</option>");
					sb.append(System.getProperty("line.separator"));
				}
				
			}
		}
		return sb.toString();
	}
	/**
	 * WML�У��ѳ������ݱ��option��
	 * @param selectedValue
	 * @param provinceCode  ʡ��Ӧ��ֵ����ʾ��ʾ��ʡ������ʲô������ʾ
	 * @return
	 */
	public static String districtToOptionStringWML(String selectedValue,String provinceCode){
		StringBuffer sb = new StringBuffer();
		if(selectedValue==null)selectedValue="";
		if(provinceCode==null||provinceCode.length()==0)return "";
		
		for(int i=0;i<cityList.size();i++){
			String key = (String)cityList.get(i);//861112|������
			if(key==null)continue;
			String k = key.substring(0,key.indexOf("|"));
			String v = key.substring(key.indexOf("|")+1);
			if(k.startsWith("86")&&k.length()==6){
				String k1 = k.substring(2,4);
				String k2 = k.substring(4,6);
				if(provinceCode.equals(k1)){
					sb.append("<option value='"+k2+"' ");
					if(selectedValue.equals(k2))sb.append(" selected=\"selected\"");
					sb.append(">").append(v);
					sb.append("</option>");
					sb.append(System.getProperty("line.separator"));
				}
				
			}
		}
		return sb.toString();
	}
	
	/**
	 * ����citycode��ȡ cityȫ��
	 * @author liubing
	 * @param cityCode   ���б���
	 * @return  String[]=����,ʡ��,����
	 */
	public static String getCityName(String cityCode){
		String[] arrCityName = {"","",""};
		if (cityCode.length()==6){
			arrCityName[0] = (String) hashCity.get(cityCode.substring(0,2));
			arrCityName[1] = (String) hashCity.get(cityCode.substring(0,4));
			arrCityName[2] = (String) hashCity.get(cityCode);
		}else if (cityCode.length()==4){
			arrCityName[0] = (String) hashCity.get(cityCode.substring(0,2));
			arrCityName[1] = (String) hashCity.get(cityCode.substring(0,4));
		}else if (cityCode.length()==2){
			arrCityName[0] = (String) hashCity.get(cityCode.substring(0,2));
		}
		return arrCityName[0]+" "+arrCityName[1]+" "+arrCityName[2];
	}
	
	/**
	 * ����citycode��ȡ cityȫ�ƣ��������ֲ������й�
	 * @author liubing
	 * @param cityCode   ���б���
	 * @return  String[]=����,ʡ��,����
	 */
	public static String getCityName2(String cityCode){
		String[] arrCityName = {"",""};
		if (cityCode.length()==6){
			arrCityName[0] = (String) hashCity.get(cityCode.substring(0,4));
			arrCityName[1] = (String) hashCity.get(cityCode);
		}else if (cityCode.length()==4){
			arrCityName[0] = (String) hashCity.get(cityCode.substring(0,2));
			arrCityName[1] = (String) hashCity.get(cityCode.substring(0,4));
		}else if (cityCode.length()==2){
			arrCityName[0] = (String) hashCity.get(cityCode.substring(0,2));
		}
		return arrCityName[0]+" "+arrCityName[1];
	}
	
	/**
	 * ����citycode��ȡ���е�����
	 * @param cityCode - ���б���
	 * @return ����
	 */
	public static String getCityName3(String cityCode) {
		return (String) hashCity.get(cityCode);
	}
	
	/**
	 * ������������ƴ�ӵ�ʱ��ʹ��
	 * @author liubing
	 * @param cityCode ���б���
	 * @return String[]= ����
	 */
	public static String getCityName4(String cityCode){
		cityCode = "86"+cityCode;
		String cityName = "";
		if (cityCode.length()==6){
			cityName = (String) hashCity.get(cityCode);
		}else if (cityCode.length()==4){
			cityName = (String) hashCity.get(cityCode.substring(0,4));
		}else if (cityCode.length()==2){
			cityName = (String) hashCity.get(cityCode.substring(0,2));
		}
		return cityName;
	}
	
	/**
	 * �ж��������к����ǲ�����ͬһ�����У�
	 * @param cityCode1  ������4λ���룬������86
	 * @param cityCode2  ������4λ���룬������86
	 * @return true ͬ��
	 */
	public static boolean isInSameCity(String cityCode1,String cityCode2){
		if(cityCode1==null||cityCode2==null||cityCode1.length()!=4||cityCode2.length()!=4)
			return false;
		
		String c1 = cityCode1.substring(0,2);
		String c2 = cityCode2.substring(0,2);
		
		String c3 = cityCode1.substring(3,4);
		String c4 = cityCode2.substring(3,4);
		
		if(!c1.equals(c2)){
			return false;
		}else{
			if(c1.equals("11") //����
					||c1.equals("12")//���
					||c1.equals("31")//�Ϻ�
					||c1.equals("50"))//����
			{
				return true ;
			}else{
				if(c3.equals(c4)){
					return true;
				}else{
					return false;
				}
			}
		}
	}
	
	/**
	 * ��ʡ���ݱ��ģ��select����ul
	 * @param cssstyle
	 * @param provinceCode  ʡ��Ӧ��ֵ����ʾ��ʾ��ʡ������ʲô������ʾ
	 * @return
	 */
	public static String districtToSelect(){
		StringBuffer sb = new StringBuffer();		
		int j=1;
		for(int i=0;i<cityList.size();i++){
			String key = (String)cityList.get(i);
			if(key==null)continue;
			String k = key.substring(0,key.indexOf("|"));
			String v = key.substring(key.indexOf("|")+1);
			if(k.startsWith("86")&&k.length()==4){
				String pk = k.substring(2);
				sb.append("<li onclick=\"reg_setValue('Srh_Province2','Pro"+j+"','"+pk+"','cityCode2')\">");
				sb.append("<a href='###' id='Pro"+j+"' >"+v+"</a> ");
				sb.append("</li>");
				sb.append(System.getProperty("line.separator"));
				j++;
			}
		}
		return sb.toString();
	}
}

