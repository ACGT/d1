package com.d1.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.CharArrayWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.dbcache.core.MyFactory;

public class Tools {
	
	/**
	 * 一年的毫秒数1
	 */
	public static final long YEAR_MILLIS = 31104000000l;
	
	/**
	 * 一月的毫秒数，30天。
	 */
	public static final long MONTH_MILLIS = 2592000000l;
	
	/**
	 * 一周的毫秒数
	 */
	public static final long WEEK_MILLIS = 604800000l;
	
	/**
	 * 一天的毫秒数
	 */
	public static final long DAY_MILLIS = 86400000l;
	
	/**
	 * 一小时的毫秒数
	 */
	public static final long HOUR_MILLIS = 3600000l;
	
	/**
	 * 一分钟的毫秒数
	 */
	public static final long MINUTE_MILLIS = 60000;
	
	/**
	 * 数据库存储时间20001010121212
	 */
	private static final SimpleDateFormat dbFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	
	/**
	 * 常用的时间格式化
	 */
	private static final SimpleDateFormat STOCK_FORMATE = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 格式化日期，2001-12-12
	 */
	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 随机对象
	 */
	public static final Random RANDOM = new Random();
	
	/**
	 * 根据一个Class获得一个BaseManager
	 * @param beanClass
	 * @return
	 */
	public static BaseManager getManager(Class<?> beanClass){
		return MyFactory.getManager(beanClass);
	}
	
	/**
	 * 得到一个Service，Service里的方法都是在一个事务里的！
	 * @param beanClass
	 * @return
	 */
	public static Object getService(Class<?> beanClass){
		return MyFactory.getService(beanClass);
	}
	
	/**
	 * 获得一个多少位左右的数
	 * @param size -获得的数字的位数
	 * @return 一个size长度的数字字符串
	 */
	public static String getRandomMath(int size){
		StringBuffer sb = new StringBuffer();
		Random ran = new Random();
		for (int i=0;i<size;i++){
			sb.append(ran.nextInt(10));
		}
		return sb.toString();
	}
	
	/**
	 * 根据名字获取cookie
	 * @param request
	 * @param name
	 * @return
	 */
	public static Cookie getClientCookie(HttpServletRequest request,String name){
		Cookie cookies [] = request.getCookies ();
		Cookie myCookie = null;
		if (cookies != null){
			for (int i = 0; i < cookies.length; i++){
				if (cookies [i].getName().equals (name)){
					myCookie = cookies[i];
					break;
				}
			}//end for
		}
		return myCookie;
	} 
	
	
	/**
	 * 获得当前的一个格式化的时间
	 * @param format - 格式化字符串
	 * @return String
	 */
	public static String getCurrentDate(String format){
		SimpleDateFormat sf = new SimpleDateFormat(format);
		return sf.format(new Date());
	}
	
	/**
	 * 获得数据库存储时间
	 * @return String 20111111121212
	 */
	public static String getDBDate(){
		return dbFormat.format(new Date());
	}
	
	/**
	 * 格式化日期，返回long
	 * @param date - 字符串 格式：2011-12-12
	 * @return long
	 */
	public static long parseJsDate(String date){
		if(Tools.isNull(date)) return 0;
		try {
			return DATE_FORMAT.parse(date).getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/** 
	* 添加日期 
	* @param d 现日期 
	* @param day 添加的天数 
	* @return 添加后的日期 
	* @throws ParseException 
	*/ 
	public static Date addDate(Date d,long day) throws ParseException { 

	long time = d.getTime(); 
	day = day*24*60*60*1000; 
	time+=day; 
	return new Date(time); 

	} 
	/**
	 * 获得今天得日期 2011-12-12
	 * @return String
	 */
	public static String getDate(){
		return DATE_FORMAT.format(new Date());
	}
	
	/**
	 * 获得今天得日期 2011-12-12
	 * @param time - 毫秒
	 * @return String
	 */
	public static String getDate(long time){
		return DATE_FORMAT.format(new Date(time));
	}
	
	/**
	 * 获得今天得日期 2011-12-12
	 * @param date - 日期
	 * @return String
	 */
	public static String getDate(Date date){
		if(date == null) return "";
		return DATE_FORMAT.format(date);
	}
	/**
	 * 获得两个日期之间的天数 
	 * @param begin - 开始日期
	 * @param end - 结束日期
	 * @return long
	 */
	public static long getDateDiff(String begin, String end){
		long quot = 0;
		if(begin == null || end == null){
			return quot;
		}
	    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	    try {
		    Date begin_t = ft.parse(begin);
		    Date end_t = ft.parse(end);
		    quot = end_t.getTime() - begin_t.getTime();
		    quot = quot/1000/60/60/24;
			//System.out.println("====="+quot);
	    } catch (ParseException e) {
	    	e.printStackTrace();
	    }
		return quot;
	}
	/**
	 * 将时间的STRING格式化一下
	 * @param date
	 * @param format1
	 * @param format2
	 * @return
	 */
	public static String getFormatString(String date,String format1,String format2){
		long ss = Tools.getDateTime(date, format1);
		return Tools.getFormatDate(ss, format2);
	}
	
	
	/**
	 * 获取一个格式化的时间
	 * @param time long
	 * @param format 格式化字符串
	 * @return String
	 */
	public static String getFormatDate(long time , String format){
		SimpleDateFormat sf = new SimpleDateFormat(format);
		Date date = new Date(time);
		return sf.format(date)	;
	}
	
	/**
     * 时间格式化2011-3-23 13:57:43
     * @param time - 时间
     * @return String
     */
    public static String stockFormatDate(long time){
    	return STOCK_FORMATE.format(new Date(time));
    }
    
    /**
    * 时间格式化2011-3-23 13:57:43
    * @param date - 时间对象
    * @return String
    */
    public static String stockFormatDate(Date date){
    	if(date == null) return "";
    	return STOCK_FORMATE.format(date);
    }

    
	/**
	 * 字符串截取
	 * @param str String 要截取的字符串
	 * @param endIndex int 截取数
	 * @return String
	 */
	public static String substring(String s , int length){
		if(s==null||length<=0)return null;
		if(StringUtils.strLength(s)<=length)return s;
		CharArrayWriter cw = new CharArrayWriter();
		int i=0,j=0;boolean loop=true;
		do
		{
			if(i>=s.length())break;
			char c = s.charAt(i);
			String ss = new String(new char[]{c});
			j+=StringUtils.strLength(ss);
			if(j>length)break;
			try 
			{
				cw.write(new char[]{c});
			}
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			i++;
		}
		while(loop);
		return new String(cw.toCharArray());
	}
	
	/**
	 * 写文件，每次写一行，主要用来记录日志，调查用的。。一般做调查的话最好每条题目都用“|”分割，好用命令统计
	 * @param filePath 文件路径，一般存放在网站根目录的log文件夹下面
	 * @param str 内容
	 */
	public static void writeFile(String filePath , String str){
		File file = new File(filePath);
		FileWriter fw = null;
		PrintWriter pw = null;
		try {
			fw = new FileWriter(file , true);
			pw = new PrintWriter(fw);
			pw.println(str);
			pw.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pw!=null) pw.close();
				if(fw!=null) fw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 获得当前日期与本周一相差的天数
	 * @return int
	 */
    private static int getMondayPlus() {
        Calendar cd = Calendar.getInstance();
        // 获得今天是一周的第几天，星期日是第一天，星期二是第二天......
        int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);
        if (dayOfWeek == 1) {
            return 6;
        } else {
            return dayOfWeek - 2;
        }
    }
    
	/**
	 * 获得上周星期一的日期时间,返回long
	 * @return long
	 */
    public static long getPreviousMonday() {
        int mondayPlus = getMondayPlus();
        GregorianCalendar currentDate = new GregorianCalendar();
        currentDate.add(GregorianCalendar.DATE, -(mondayPlus + 7));
        currentDate.set(Calendar.MINUTE, 0);
        currentDate.set(Calendar.SECOND, 0);
        currentDate.set(Calendar.MILLISECOND, 0);
        currentDate.set(Calendar.HOUR_OF_DAY, 0);
        return currentDate.getTimeInMillis();
    }
    
    /**
     * 获得本周星期一的时间,返回long
     * @return long
     */
    public static long getCurrnetMonday(){
    	int mondayPlus = getMondayPlus();
        GregorianCalendar currentDate = new GregorianCalendar();
        currentDate.add(GregorianCalendar.DATE, -mondayPlus);
        currentDate.set(Calendar.MINUTE, 0);
        currentDate.set(Calendar.SECOND, 0);
        currentDate.set(Calendar.MILLISECOND, 0);
        currentDate.set(Calendar.HOUR_OF_DAY, 0);
        return currentDate.getTimeInMillis();
    }
    
    /**
     * 得到今天前几天的凌晨的时间
     * @param dayBefore - 几天前
     * @return long - dayBefore天前凌晨的时间。
     */
    public static long getYesterdayTime(long dayBefore){
    	Calendar cal = Calendar.getInstance();
    	cal.setTimeInMillis(System.currentTimeMillis()-dayBefore*24*60*60*1000);
    	cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		return cal.getTimeInMillis();
    }
    
    /**
     * 获得当前V小时的毫秒数
     * @param v - 当前几小时，可以为负数
     * @return long - 当前V小时的毫秒数
     */
    public static long getHourTime(long v){
    	Calendar cal = Calendar.getInstance();
    	cal.setTimeInMillis(System.currentTimeMillis()+v*Tools.HOUR_MILLIS);
    	cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTimeInMillis();
    }
    
    /**
	 * 看一段字符串中是否是汉字
	 * @param str String 要判断的字符串
	 * @return boolean 布尔值
	 */
	public static boolean isChinese(String str) {
		if(isNull(str)) return false;
		return Pattern.matches("[\u4e00-\u9fa5]*", str);
	}
	
	/**
	 * 看一段字符串是否是字母
	 * @param str String 要判断的字符串
	 * @return boolean 布尔值
	 */
	public static boolean isEnglish(String str) {
		if(isNull(str)) return false;
		return Pattern.matches("[a-zA-Z]*" , str);
	}

	/**
	 * 判断一段字符串是否是数字，不包括全角和负数。
	 * @param str String 字符串
	 * @return boolean 布尔值
	 * @deprecated 不建议使用了。替代为：<code>Tools.isNumber(java.lang.String)</code>
	 */
	public static boolean isMath(String str) {
		if(isNull(str)) return false;
		return Pattern.matches("\\d*" , str);
	}
	
	/**
	 * 判断是否是数字的正则表达式
	 */
	private static final Pattern Pattern_Number = Pattern.compile("\\d+");
	
	/**
	 * 判断一段字符串是否是数字，不包括全角和负数。
	 * 此方法替代<code>Tools.isMath(java.lang.String)</code>
	 * @param str - 字符串
	 * @return boolean 布尔值
	 */
	public static boolean isNumber(String str){
		if(str == null) return false;
		Matcher m = Pattern_Number.matcher(str);
        return m.matches();
	}
	
	/**
	 * 判断一段字符串是否是数字和字母组成.且开头必须是字母
	 * @param str String 字符串
	 * @return boolean 布尔值
	 */
	public static boolean isRegString(String str){
		if(isNull(str)) return false;
		return Pattern.matches("[a-zA-Z][0-9a-zA-Z]*" , str);
	}
	
	/**
	 * 判断一段字符串是否是Email
	 * @param str String 字符串
	 * @return boolean 布尔值
	 */
	public static boolean isEmail(String str){
		if(isNull(str)) return false;
		return Pattern.matches("^([a-zA-Z0-9_\\-]+\\.*)+@([a-zA-Z0-9_\\-]+\\.*)+(\\.(com|cn|mobi|co|net|so|org|gov|tel|tv|biz|cc|hk|name|info|asia|me)){1,2}+$", str);
	}
	
	/**
	 * 匹配字符
	 * @param regex - 通配符
	 * @param str - 需要验证的字符
	 * @return boolean 布尔值
	 */
	public static boolean matches(String regex , String str) {
		if(str == null) return false;
		return Pattern.matches(regex, str);
	}
	
	/**
	 * 关闭数据库连接
	 * @param rs - 返回的数据集
	 * @param st - sql语句执行对象
	 * @param co - 数据库连接
	 */
	public static void closeDBA(ResultSet rs , Statement st , Connection co){
		try {
			if(rs!=null)rs.close();
			if(st!=null)st.close();
			if(co!=null)co.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 读取配置文件
	 * @param filePath - 文件路径
	 * @return 返回属性集
	 */
	public static Properties loadFile(String filePath){
		FileInputStream fis = null;
		try {
			File file = new File(filePath);
			if(!file.exists()) return null;
			fis = new FileInputStream(file);
			Properties pro = new Properties();
			pro.load(fis);
			return pro;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (fis != null) fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 保存记录的文件
	 * @param filePath - 文件路径
	 * @param pro - 持久属性集
	 * @param map - 键值对应的数据 
	 * @param username - 修改文件的用户
	 * @param email - 修改文件的用户email
	 * @param ip - ip地址
	 */
	@SuppressWarnings("rawtypes")
	public static void saveFile(String filePath , Properties pro , HashMap map , String memo){
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(filePath);
			if(map!=null){
				Set set = map.keySet();
				if(!set.isEmpty()){
					Iterator it = set.iterator();
					while(it.hasNext()){
						String key = String.valueOf(it.next());
						pro.setProperty(key, String.valueOf(map.get(key)));
					}
				}
			}
			pro.store(fos, memo);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			try{
				if(fos!=null)fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 是否打印出日志
	 * @param command - 命令
	 * @param isLog - 是否运行日志
	 * @return true or false
	 */
	public static boolean exec(String command , boolean isLog) {
		InputStream ins = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		try {
			Runtime rt = Runtime.getRuntime();
			if(isLog){
				Process proc = rt.exec(command);
				ins = proc.getInputStream();
				isr = new InputStreamReader(ins);
				br = new BufferedReader(isr);
				String line = null;
				StringBuffer sb = new StringBuffer();
				String newline = System.getProperty("line.separator");
				while ((line = br.readLine()) != null) {
					sb.append(line).append(newline);
				}
				System.err.println(sb.toString());
			}else{
				rt.exec(command);
			}
		} catch (Throwable t) {
			t.printStackTrace();
			return false;
		} finally {
			try{
				if (br != null)	br.close();
				if (isr != null)isr.close();
				if(ins != null) ins.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	/**
	 * 清空一个list
	 * @param list - List
	 */
	@SuppressWarnings("rawtypes")
	public static void clearList(List list){
		if(list == null) return;
		list.clear();
		list = null;
	}
	
	/**
	 * 清空一个map
	 * @param map - Map
	 */
	@SuppressWarnings("rawtypes")
	public static void clearMap(Map map) {
		if(map == null) return;
		map.clear();
		map = null;
	}
	
	/**
	 * 逆向解析一个时间，返回一个long型的时间
	 * @param date - 字符型时间
	 * @param format - 格式化时间
	 * @return long 型时间
	 */
	public static long getDateTime(String date , String format) {
		SimpleDateFormat sf = new SimpleDateFormat(format);
		try {
			return sf.parse(date).getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/**
	 * 四舍五入返回一个小数
	 * @param d - 要格式化的数字
	 * @param scale - 返回小数的位数
	 * @return double
	 */
	public static double getDouble(double d , int scale){
		BigDecimal bd = new BigDecimal(d);
		return bd.setScale(scale, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
	
	/**
	 * 精确到元，货到付款用
	 * @param f
	 * @return
	 */
	public static double getDouble5(float f){
		return (double)((int)f);
	}
	
	/**
	 * 精确到元，货到付款用
	 * @param f
	 * @return
	 */
	public static double getDouble5(Double fl){
		if(fl==null)return 0;
		return (double)((int)fl.doubleValue());
	}
	
	/**
	 * 四舍五入返回一个小数
	 * @param f - 要格式化的数字
	 * @param scale - 返回小数的位数
	 * @return float
	 */
	public static float getFloat(float f , int scale){
		BigDecimal bd = new BigDecimal(f);
		return bd.setScale(scale, BigDecimal.ROUND_HALF_UP).floatValue();
	}
	
	/**
	 * 四舍五入返回一个小数
	 * @param f
	 * @param scale
	 * @return
	 */
	public static float getFloat(Float f , int scale){
		if(f==null)return getFloat(0f,scale);
		BigDecimal bd = new BigDecimal(f.floatValue());
		return bd.setScale(scale, BigDecimal.ROUND_HALF_UP).floatValue();
	}
	
	/**
	 * 解析XML，只支持：<pre><?xml version="1.0" encoding="gb2312" ?><response><code>03</code><message><desmobile>13683211004</desmobile><msgid>20100603152320692610</msgid></message></response></pre>
	 * 最多2层。。
	 * @param xml - 要解析的字符串
	 * @return Map
	 */
	@SuppressWarnings("rawtypes")
	public static Map<String,String> parseXML(String xml) {
		if(xml == null || xml.length() == 0) return null;
		InputStream in = null;
		Map<String,String> map = null;
		try {
			in = new ByteArrayInputStream(xml.getBytes("utf-8"));
			SAXReader reader = new SAXReader();
			Document doc = reader.read(in);
			Element root = doc.getRootElement();
			Iterator nodeIter = root.nodeIterator();
			map = new HashMap<String,String>();
			while(nodeIter.hasNext()) {
				Element element = (Element)nodeIter.next();
				if(element.isTextOnly()){
					map.put(element.getName(), element.getText());
					continue;
				}
				Iterator it = element.nodeIterator();
				while(it.hasNext()) {
					element = (Element)it.next();
					if(element.isTextOnly()) map.put(element.getName(), element.getText());
				}
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			try {
				if(in != null) in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	/**
	 * 时间描述 10秒前，1天前 1月前
	 * @param time - 时间
	 * @return String
	 */
	public static String toTime(long time){
		long currentTime = System.currentTimeMillis();
		double mid = currentTime - time;
		if(mid <= 0) return "0秒前";
		if(mid < Tools.MINUTE_MILLIS){
			return (int)Math.floor(mid/1000)+"秒前";
		}
		if(mid < Tools.HOUR_MILLIS){
			return (int)Math.floor(mid/Tools.MINUTE_MILLIS)+"分钟前";
		}
		if(mid < Tools.DAY_MILLIS){
			return (int)Math.floor(mid/Tools.HOUR_MILLIS)+"小时前";
		}
		if(mid < Tools.MONTH_MILLIS){
			return (int)Math.floor(mid/Tools.DAY_MILLIS)+"天前";
		}
		if(mid < Tools.YEAR_MILLIS){
			return (int)Math.floor(mid/Tools.MONTH_MILLIS)+"月前";
		}
		return (int)Math.floor(mid/Tools.YEAR_MILLIS)+"年前";
	}
	
	/**
	 * 随机生成length位的字母和数字的组合
	 * @param length - 位数
	 * @return String
	 */
	public static String getCharAndNumr(int length){
	    String val = "";
	    Random random = new Random();
	    String charOrNum = null;
	    for(int i = 0; i < length; i++){
	        charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num"; // 输出字母还是数字
	        if("char".equalsIgnoreCase(charOrNum)){ // 字符串
	            int choice = random.nextInt(2) % 2 == 0 ? 65 : 97; //取得大写字母还是小写字母
	            val += (char) (choice + random.nextInt(26));
	        }else if("num".equalsIgnoreCase(charOrNum)){ // 数字
	            val += String.valueOf(random.nextInt(10));
	        }
	    }
	    return val;
	}
	
	/**
     * 字符串不能为空
     * @param str - 字符串
     * @param defaultStr - 字符串为空显示的字符
     * @return 不为空的字符串
     */
	public static String formatString(String str , String defaultStr){
		if(Tools.isNull(str)) return defaultStr;
		return str;
	}
	
	/**
     * 字符串不能为空
     * @param str - 字符串
     * @return 不为空的字符串
     */
	public static String formatString(String str){
		return formatString(str,"");
	}
	
	/**
	 * 返回一个字符串是否为空，如果字符串为""或者为空格也为true
	 * @param str - String
	 * @return true false
	 */
	public static boolean isNull(String str){
		if(str == null || str.trim().length()==0) return true;
		return false;
	}
	
	/**
	 * 判断字符串是否为浮点型数字
	 * @param str - String
	 * @return true or false
	 */
	public static boolean isDouble(String str){
		if(str == null || str.length() == 0) return false;
		return Pattern.matches("^[-]?[\\d]+([.]?[\\d]+)$", str);
	}
	
	/**
	 * 判断是否是手机号码
	 * @param str - String
	 * @return true or false
	 */
	public static boolean isMobile(String str){
		if(str == null || str.length()!=11) return false;
		return Pattern.matches("^1[0-9]{10}$", str);
	}
	
	/**
	 * 判断是否是身份证号，【不准确】
	 * @param str - String
	 * @return true or false
	 */
	public static boolean isIdcard(String str){
		if(str == null) return false;
		return Pattern.matches("\\d{15}|\\d{18}|\\d{17}[a-z]{1}", str);
	}
	
	/**
	 * 判断是否是钱的格式，如12或12.12
	 * @param str - String
	 * @return True or False
	 */
	public static boolean isMoney(String str){
		if(str == null || str.length() == 0) return false;
		return Pattern.matches("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){1,2})?$", str);
	}
	
	/**
	 * 返回一个Cookie的值
	 * @param request - 页面
	 * @param name - Cookie的名字
	 * @return Value - String
	 */
	public static String getCookie(HttpServletRequest request , String name){
		if(request == null || name == null) return null;
		Cookie [] cookieArr = request.getCookies();
		if(cookieArr == null || cookieArr.length==0) return null;
	    String s = null;
	    for (int i=0;i<cookieArr.length;i++) {
	    	Cookie c = cookieArr[i];
	        if (name.equals(c.getName())) {
				s = c.getValue();
	            break;
	        }
	    }
	    return s;
	}
	
	/**
	 * 写入Cookie
	 * @param response - HttpServletResponse
	 * @param name - Cookie的名字
	 * @param value - Cookie的值
	 * @param expireTime - 过期时间，秒
	 */
	public static void setCookie(HttpServletResponse response , String name , String value , int expireTime){
		Cookie userIdCookie = new Cookie(name, value);
		userIdCookie.setPath("/");
		userIdCookie.setDomain("d1.com.cn");
		userIdCookie.setMaxAge(expireTime);
		response.addCookie(userIdCookie);
	}
	
	/**
	 * 删除Cookie
	 * @param response - HttpServletResponse
	 * @param name - cookie的名字
	 */
	public static void removeCookie(HttpServletResponse response , String name){
		Cookie userIdCookie = new Cookie(name, null);
		userIdCookie.setPath("/");
		userIdCookie.setDomain("d1.com.cn");
		userIdCookie.setMaxAge(0);//直接过期
		response.addCookie(userIdCookie);
	}
	
	/**
	 * 在页面输出一个JS弹出框，并且跳转到某个页面
	 * @param out - JspWriter
	 * @param mess - 弹出框信息
	 * @param url - 跳转页面，字符back代表返回一页面，其它为跳转页面。
	 * @return String
	 * @throws IOException 
	 */
	public static void outJs(JspWriter out , String mess , String url) throws IOException{
		out.print("<script type=\"text/javascript\">alert(\""+mess+"！\");"+("back".equals(url)?"window.history.back();":"top.location.href=\""+url+"\";")+"</script>");
	}
	
	/**
	 * 数组转换成a,b,c格式的字符串
	 * @param array - String[]
	 * @return String
	 */
	public static String joinString(String[] array){
		if(array == null || array.length==0) return "";
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<array.length;i++){
			sb.append(array[i]);
			if(i<array.length-1) sb.append(",");
		}
		return sb.toString();
	}
	
	/**
	 * 列表转换成a,b,c格式的字符串
	 * @param list - List<String>
	 * @return String
	 */
	public static String joinString(List<String> list){
		if(list == null || list.isEmpty()) return "";
		int size = list.size();
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<size;i++){
			sb.append(list.get(i));
			if(i<size-1) sb.append(",");
		}
		return sb.toString();
	}
	
	/**
	 * map的key转换成a,b,c格式的字符串
	 * @param map - HashMap<String,Object>
	 * @return String
	 */
	public static String joinString(HashMap<String,Object> map){
		if(map == null || map.isEmpty()) return "";
		Iterator<String> keyIt = map.keySet().iterator();
		StringBuilder sb = new StringBuilder();
		int size = map.size();
		int i = 0;
		while(keyIt.hasNext()){
			sb.append(keyIt.next());
			if(i<size-1) sb.append(",");
		}
		return sb.toString();
	}
	
	/**
	 * 基类列表转换成a,b,c格式的字符串。
	 * 传入的list必须是BaseEntity的泛型，否则将报错。这里不检查错误。
	 * @param list - List<BaseEntity>
	 * @return String
	 */
	@SuppressWarnings("rawtypes")
	public static String joinStringEntity(List list){
		if(list == null || list.isEmpty()) return "";
		int size = list.size();
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<size;i++){
			BaseEntity en = (BaseEntity)list.get(i);
			sb.append(en.getId());
			if(i<size-1) sb.append(",");
		}
		return sb.toString();
	}
	
	/**
	 * 取得图片的地址
	 * @param photo - 图片全路径
	 * @param prefix - 后缀
	 * @return String
	 */
	public static String getPhoto(String photo , String prefix){
		return ImageUtil.getPrefixImage(photo, prefix);
	}
	
	/**
	 * 获得省市
	 * @param areacode1 - 省代码
	 * @param areacode2 - 市代码
	 * @return String 江苏省 南通市
	 */
	public static String getCityName(String areacode1 , String areacode2){
		String citycode = "86";
		if(areacode1!=null){
			citycode+=areacode1;
			
			if(areacode2 != null) citycode+=areacode2;
		}
		return UserCityPools.getCityName2(citycode);
	}
	
	/**
	 * 编码URL字符串
	 * @param str - 字符串
	 * @return String
	 * @throws UnsupportedEncodingException
	 */
	public static String encoder(String str) throws UnsupportedEncodingException{
		if(isNull(str)) return "";
		return URLEncoder.encode(str, "GBK");
	}
	
	/**
	 * 替换字符显示在网页中，主要跟网页编辑器一起使用。
	 * @param str - 要替换的字符
	 * @return String
	 */
	public static String repstr(String str)	{
		if(str==null || str.length()==0)return "";
		str=str.replaceAll("<", "&lt;");
		str=str.replaceAll(">", "&gt;");
		str=str.replaceAll("\"", "&quot;");
		return str;
	}
	
	/**
	 * 去掉串中的html标签
	 * @param str - 要替换的字符
	 * @return String
	 */
	public static String clearHTML(String str){
		if(Tools.isNull(str)) return "";
		try{
			String x= str.replaceAll("<.+?>", "");
			x = x.replaceAll("\"", "");
			x = x.replaceAll("'", "");
			x = x.replaceAll("<", "");
			x = x.replaceAll(">", "");
			return x ;
		} catch(Exception e){
			return repstr(str);
		}
	}
	
	/**
	 * 去掉字符串头尾的空格
	 * @param str - 要替换的字符串
	 * @return String
	 */
	public static String trim(String str){
		return trim(str," ");
	}
	
	/**
	 * 去掉字符串头尾的字符
	 * @param str - 要替换的字符串
	 * @param s - 要去掉的头尾字符
	 * @return String
	 */
	public static String trim(String str , String s){
		if(Tools.isNull(str)) return "";
		return str.replaceAll("^"+s+"+|"+s+"+$", "");
	}
	
	/**
	 * 字符串全角转半角
	 * @param str - 要替换的字符串
	 * @return String
	 */
	public static String convertToBanJiao(String str){
		if(Tools.isNull(str)) return null;
		char[] chArray = str.toCharArray();
		for (int i = 0; i < chArray.length; i++){
			if (chArray[i] == '　'){
				chArray[i] = ' ';
			}else if ((chArray[i] > 0xff00) && (chArray[i] < 0xff5f)){
				chArray[i] = (char)(chArray[i] - 0xfee0);
			}
		}
		return new String(chArray);
	}
	
	/**
	 * 特殊字符转换
	 * @param str - 要替换的字符串
	 * @return String
	 */
	public static String simpleCharReplace(String str){
		try{
			if(Tools.isNull(str)) return null;
			str = str.replace('\0', ' ');
			str = convertToBanJiao(str);
			StringBuilder builder = new StringBuilder();
			int length = str.length();
			for (int i = 0; i < length; i++){
				char c = str.charAt(i);
				switch (c){
					case '#':
						builder.append("＃");
						break;
					case '%':
						builder.append("％");
						break;
					case '&':
						builder.append("＆");
						break;
					case '\'':
						builder.append("''");
						break;
					case '(':
						builder.append("（");
						break;
					case ')':
						builder.append("）");
						break;
					case ';':
						builder.append("；");
						break;
					case '<':
						builder.append("&lt;");
						break;
					case '>':
						builder.append("&gt;");
						break;
					default:
						builder.append(c);
				}
			}
			return builder.toString().trim();
		} catch(Exception e){
			return null;
		}
	}
	
	/**
	 * 字符串转换成int型,默认值返回0
	 * @param s - String
	 * @return int
	 */
	public static int parseInt(String s){
		return parseInt(s , 0);
	}
	
	/**
	 * 字符串转换成int型
	 * @param s - String
	 * @param defaultValue - 如果转换错误，则返回defaultValue
	 * @return int
	 */
	public static int parseInt(String s , int defaultValue){
		try{
			return Integer.parseInt(s);
		}catch(NumberFormatException e){
			return defaultValue;
		}
	}
	
	/**
	 * 字符串转换long型,默认值返回0
	 * @param s - String
	 * @return long
	 */
	public static long parseLong(String s){
		return parseLong(s , 0);
	}
	
	/**
	 * 字符串转换成long型
	 * @param s - String
	 * @param defaultValue - 如果转换错误，则返回defaultValue
	 * @return long
	 */
	public static long parseLong(String s , long defaultValue){
		try{
			return Long.parseLong(s);
		}catch(NumberFormatException e){
			return defaultValue;
		}
	}
	
	/**
	 * 字符串抓换成float型，默认值返回0
	 * @param s - String
	 * @return float
	 */
	public static float parseFloat(String s){
		return parseFloat(s , 0f);
	}
	
	/**
	 * 字符串抓换成float型
	 * @param s - String
	 * @param defaultValue - 如果转换错误，则返回defaultValue
	 * @return float
	 */
	public static float parseFloat(String s , float defaultValue){
		try{
			return Float.parseFloat(s);
		}catch(NumberFormatException e){
			return defaultValue;
		}
	}
	
	/**
	 * 字符串转换成double型，默认值返回0
	 * @param s - String
	 * @return double
	 */
	public static double parseDouble(String s){
		return parseDouble(s , 0d);
	}
	
	/**
	 * 字符串抓换成double型
	 * @param s - String
	 * @param defaultValue - 如果转换错误，则返回defaultValue
	 * @return double
	 */
	public static double parseDouble(String s , double defaultValue){
		try{
			return Double.parseDouble(s);
		}catch(NumberFormatException e){
			return defaultValue;
		}
	}
	
	/**
	 * 字符串转换成boolean型，默认值返回false
	 * @param s - String
	 * @return boolean
	 */
	public static boolean parseBoolean(String s){
		return parseBoolean(s , false);
	}
	
	/**
	 * 字符串抓换成boolean型
	 * @param s - String
	 * @param defaultValue - 如果转换错误，则返回defaultValue
	 * @return boolean
	 */
	public static boolean parseBoolean(String s , boolean defaultValue){
		try{
			return Boolean.parseBoolean(s);
		}catch(NumberFormatException e){
			return defaultValue;
		}
	}
	
	/**
	 * Long转换成long
	 * @param l - Long
	 * @param defaultValue - 默认显示值
	 * @return long
	 */
	public static long longValue(Long l , long defaultValue){
		if(l == null) return defaultValue;
		return l.longValue();
	}
	
	/**
	 * Long转换成long，如果为null，则显示0
	 * @param l - Long
	 * @return long
	 */
	public static long longValue(Long l){
		return longValue(l , 0);
	}
	
	/**
	 * Integer转换成int
	 * @param i - Integer
	 * @param defaultValue - 默认显示值
	 * @return int
	 */
	public static int intValue(Integer i , int defaultValue){
		if(i == null) return defaultValue;
		return i.intValue();
	}
	
	/**
	 * Integer转换成int，如果为null，则显示0
	 * @param i - Integer
	 * @return int
	 */
	public static int intValue(Integer i){
		return intValue(i , 0);
	}
	
	/**
	 * Float转换成float
	 * @param f - Float
	 * @param defaultValue - 默认显示值
	 * @return float
	 */
	public static float floatValue(Float f , float defaultValue){
		if(f == null) return defaultValue;
		return f.floatValue();
	}
	
	/**
	 * Float转换成float，如果为null，则显示0
	 * @param f - Float
	 * @return float
	 */
	public static float floatValue(Float f){
		return floatValue(f,0f);
	}
	
	/**
	 * Double转换成double
	 * @param d - Double
	 * @param defaultValue - 默认显示值
	 * @return double
	 */
	public static double doubleValue(Double d , double defaultValue){
		if(d == null) return defaultValue;
		return d.doubleValue();
	}
	
	/**
	 * Double转换成double，如果为null，则显示0
	 * @param d - Double
	 * @return double
	 */
	public static double doubleValue(Double d){
		return doubleValue(d , 0d);
	}
	
	/**
	 * Boolean转换成Boolean
	 * @param b - Boolean
	 * @param defaultValue - 默认显示值
	 * @return boolean
	 */
	public static boolean booleanValue(Boolean b , boolean defaultValue){
		if(b == null) return defaultValue;
		return b.booleanValue();
	}
	
	/**
	 * Boolean转换成Boolean，如果为null，则显示false
	 * @param b - Boolean
	 * @return boolean
	 */
	public static boolean booleanValue(Boolean b){
		return booleanValue(b);
	}
	
	/**
	 * Date转换成long型
	 * @param date - 时间
	 * @return long
	 */
	public static long dateValue(Date date){
		if(date == null) return 0;
		return date.getTime();
	}
	
	/**
	 * 获得格式化金钱，防止出现精度丢失问题。
	 * @param value - 金钱
	 * @return float
	 */
	public static float getRoundPrice(float value){
		return NumberUtils.round(value, 2,BigDecimal.ROUND_HALF_UP);
	}
	
	/**
	 * 格式化成金钱
	 * @param d - double
	 * @return String 0.12
	 */
	public static String getFormatMoney(double d){
		String r = NumberUtils.getMinPrice(d);
		int loc = r.length();
		
		if(r!=null&&r.indexOf(".")>-1){
			String r0 = r.substring(r.indexOf("."));
			
			for(int i=r0.length()-1;i>=0;i--){
				if(r0.charAt(i)=='0'||r0.charAt(i)=='.'){
					loc--;
				}else{
					break;
				}
			}
			
			return r.substring(0,loc);
		}
		
		return r;
	}
	
	/**
	 * 格式化money
	 * @param f
	 * @return
	 */
	public static String getFormatMoney(Float f){
		if(f==null)return "0";
		else return getFormatMoney(f.doubleValue());
	}
	
	/**
	 * 格式化重量
	 * @param weight - 重量，单位克
	 * @return String 0.123
	 */
	public static String getFormatWeight(long weight){
		return NumberUtils.getMaxWeight((double)weight/1000);
	}
	
	/**
	 * 格式化百分比
	 * @param d - double
	 * @return String 99.92%
	 */
	public static String getFormatPercent(double d){
		return NumberUtils.getPercent(d);
	}
	
	//////////////////////////////////////////////////////////////
	
	public static final float EPS = 0.00000001f; 
	
	/**
	 * 两个浮点数比较
	 * @param a - 第一个浮点数
	 * @param b - 第二个浮点数
	 * @return 1：a大于b,-1：a小于b,0：相等
	 */
	public static int floatCompare(double a , double b){
		double dblDelta = a - b;
		if (dblDelta > EPS){//a>b
			return 1;
		}else if (dblDelta < -EPS){
			return -1;
		}
		return 0;
	}
	
	//////////////////////////////////////////////////////////////
	
	/**
	 * 往request里加入一个参数或者更新一个参数，组成参数形式c.jsp?g=23434&pg=10
	 * @param request
	 * @param pName - 名字
	 * @param pValue - 值
	 * @return String
	 */
	public static String addOrUpdateParameter(HttpServletRequest request,String pName,String pValue){
		@SuppressWarnings("rawtypes")
		Enumeration en = request.getParameterNames();
		Map<String,String> pMap = new HashMap<String,String>();
		while(en.hasMoreElements()){
			String k = en.nextElement().toString();
			if(k.equals("display")&&"true".equals(request.getParameter(k)))continue;
			pMap.put(k,request.getParameter(k));
		}
		
		if(pName!=null&&pValue!=null)pMap.put(pName, pValue);
		Iterator<String> it = pMap.keySet().iterator();
		String res="";
		while(it.hasNext()){
			String k = it.next();
			res+=k;
			res+="=";
			res+=pMap.get(k);
			res+="&";
		}
		if(res.endsWith("&"))res = res.substring(0,res.length()-1);
		String uri = request.getRequestURI();
		
		res = uri+"?"+res;
		
		Pattern pattern = Pattern.compile("[\u4e00-\u9fa5]+");
		Matcher matcher = pattern.matcher(res);
	    
		//把汉字换掉
		try{
		    ArrayList<String> list = new ArrayList<String>();
		    while(matcher.find()){
		    	String d = matcher.group();
		    	list.add(URLEncoder.encode(d,"UTF-8"));
			}
		    
		    Matcher mMatcher2 = null ;
		    for(int i=0;i<list.size();i++){
		    	mMatcher2 = pattern.matcher(res);
		    	res = mMatcher2.replaceFirst(list.get(i));
		    }
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return res;
	}
	
	//////////////////////////////////////////////////////////////
	
	/**
	 * ajax弹出框里面的提示信息
	 * @param out - JspWriter
	 * @param tips - 提示
	 * @param desc - 提示的描述
	 * @throws IOException
	 */
	public static void ajaxTips(JspWriter out , String tips , String desc) throws IOException{
		out.print("<div class=\"dialogdiv01\">");
		out.print("<div class=\"lll font14\" style=\"width:100%;\"><strong>");
		out.print(tips);
		out.print("</strong></div>");
		out.print("<div class=\"layer_msg mar10\" style=\"width:100%;\"><span class=\"cjgm_img\"></span>");
		out.print(desc);
		out.print("</div></div>");
	}
	
	//////////////////////////////////////////////////////////////
	
	public static void main(String[] args)throws Exception{
		/*String str = "<?xml version=\"1.0\" encoding=\"gb2312\" ?><response><code>03</code><message><desmobile>13683211004</desmobile><msgid>20100603152320692610</msgid></message></response>";
		Map<String,String> map = Tools.parseXML(str);
		System.err.println(map.get("msgid"));*/
		//System.out.println(Tools.trim("wsksksksssw", "w"));
		//String sss = "<font>asdasdasdasd</font>";
		//System.err.println(sss.replaceAll("<.+?>", ""));
		/*String url="http://www.d1.com.cn/result.jsp?productsort=014&productbrand=水宝宝";
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<url.length();i++){
			if(StringUtils.getCnLength(""+url.charAt(i))==2){
				sb.append(java.net.URLEncoder.encode(url.charAt(i)+"","utf-8"));
			}else{
				sb.append(url.charAt(i));
			}
		}*/
		System.out.println(Tools.isEmail("ak.liu@staff.d1.com.cn"));
		System.out.println(Tools.isEmail("liu-ak.liu@staff.d1.org.cn.com"));
		System.out.println(Tools.isEmail("zhyun@public.bta.net.cn"));
	}
}