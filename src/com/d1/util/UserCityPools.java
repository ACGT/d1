package com.d1.util;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.configuration.XMLConfiguration;
import org.apache.log4j.Logger;

import com.d1.Const;

/**
 * 城市代码的管理工具
 * @author k
 *
 */
public class UserCityPools{

	private static Logger log = Logger.getLogger(UserCityPools.class);
	
	/**
	 * 城市
	 */
	private static HashMap<String,String> hashCity = new HashMap<String,String>(4500);
	
	/**
	 * 按顺序排列
	 */
	private static ArrayList<String> cityList = new ArrayList<String>();
	
	/**
	 * 省第一个存数的是省的名字，第二个是省的code
	 */
	private static HashMap<String,String> province = new HashMap<String,String>(40);
	
	/**
	 * 所有city数据
	 * @return ArrayList
	 */
	@SuppressWarnings("rawtypes")
	public static ArrayList getCityList(){
		return cityList;
	}
	
	
	/**
	 * 获取hashCity
	 * @return hashCity
	 */
	@SuppressWarnings("rawtypes")
	public static HashMap getHashCity(){
		return hashCity;
	}

	static {
		log.info("初始化城市文件开始...");
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
		log.info("初始化城市文件结束...");
		log.info("初始化1ka省份");
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
		log.info("初始化1ka省份结束");
	}
	
	/**
	 * 根据传入的省份和城市获得这个城市的Code
	 * @param provice - 省份
	 * @param city - 城市
	 * @return String - 城市code
	 */
	public static String getCityCode(String provice , String city){
		String provinceCode = province.get(provice);
		if(provinceCode==null) return "861101";//如果没有这个省份的话那么就默认为北京东城区
		String str = null;
		for(int i=1;i<31;i++){
			String cc = null;//组合城市code
			if(i<10) cc = provinceCode+"0"+i;
			else cc = provinceCode+""+i;
			String cityName = hashCity.get(cc);
			if(cityName!=null && cityName.indexOf(city)>-1){
				str = cc;
				break;
			}
		}
		if(str == null ) {//默认未某个省第一个城市
			str = provinceCode+"01";
		}
		return str;
	}
	
	/**
	 * 把省份变成option字符串
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
	 * WML中，把省份变成option字符串
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
	 * 把省数据变成option串
	 * @param cssstyle
	 * @param provinceCode  省对应的值，表示显示该省，否则什么都不显示
	 * @return
	 */
	public static String districtToOptionString(String selectedValue,String cssstyle,String provinceCode){
		StringBuffer sb = new StringBuffer();
		if(cssstyle==null)cssstyle="";
		if(selectedValue==null)selectedValue="";
		if(provinceCode==null||provinceCode.length()==0)return "";
		
		for(int i=0;i<cityList.size();i++){
			String key = (String)cityList.get(i);//861112|朝阳区
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
	 * WML中，把城市数据变成option串
	 * @param selectedValue
	 * @param provinceCode  省对应的值，表示显示该省，否则什么都不显示
	 * @return
	 */
	public static String districtToOptionStringWML(String selectedValue,String provinceCode){
		StringBuffer sb = new StringBuffer();
		if(selectedValue==null)selectedValue="";
		if(provinceCode==null||provinceCode.length()==0)return "";
		
		for(int i=0;i<cityList.size();i++){
			String key = (String)cityList.get(i);//861112|朝阳区
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
	 * 根据citycode获取 city全称
	 * @author liubing
	 * @param cityCode   城市编码
	 * @return  String[]=国家,省份,城市
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
	 * 根据citycode获取 city全称，返回文字不包含中国
	 * @author liubing
	 * @param cityCode   城市编码
	 * @return  String[]=国家,省份,城市
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
	 * 根据citycode获取城市的名称
	 * @param cityCode - 城市编码
	 * @return 城市
	 */
	public static String getCityName3(String cityCode) {
		return (String) hashCity.get(cityCode);
	}
	
	/**
	 * 仅限任务条件拼接的时候使用
	 * @author liubing
	 * @param cityCode 城市编码
	 * @return String[]= 城市
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
	 * 判断两个城市号码是不是在同一个城市，
	 * @param cityCode1  必须是4位号码，不包括86
	 * @param cityCode2  必须是4位号码，不包括86
	 * @return true 同城
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
			if(c1.equals("11") //北京
					||c1.equals("12")//天津
					||c1.equals("31")//上海
					||c1.equals("50"))//重庆
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
	 * 把省数据变成模拟select产生ul
	 * @param cssstyle
	 * @param provinceCode  省对应的值，表示显示该省，否则什么都不显示
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

