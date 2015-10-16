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
	 * һ��ĺ�����1
	 */
	public static final long YEAR_MILLIS = 31104000000l;
	
	/**
	 * һ�µĺ�������30�졣
	 */
	public static final long MONTH_MILLIS = 2592000000l;
	
	/**
	 * һ�ܵĺ�����
	 */
	public static final long WEEK_MILLIS = 604800000l;
	
	/**
	 * һ��ĺ�����
	 */
	public static final long DAY_MILLIS = 86400000l;
	
	/**
	 * һСʱ�ĺ�����
	 */
	public static final long HOUR_MILLIS = 3600000l;
	
	/**
	 * һ���ӵĺ�����
	 */
	public static final long MINUTE_MILLIS = 60000;
	
	/**
	 * ���ݿ�洢ʱ��20001010121212
	 */
	private static final SimpleDateFormat dbFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	
	/**
	 * ���õ�ʱ���ʽ��
	 */
	private static final SimpleDateFormat STOCK_FORMATE = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * ��ʽ�����ڣ�2001-12-12
	 */
	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * �������
	 */
	public static final Random RANDOM = new Random();
	
	/**
	 * ����һ��Class���һ��BaseManager
	 * @param beanClass
	 * @return
	 */
	public static BaseManager getManager(Class<?> beanClass){
		return MyFactory.getManager(beanClass);
	}
	
	/**
	 * �õ�һ��Service��Service��ķ���������һ��������ģ�
	 * @param beanClass
	 * @return
	 */
	public static Object getService(Class<?> beanClass){
		return MyFactory.getService(beanClass);
	}
	
	/**
	 * ���һ������λ���ҵ���
	 * @param size -��õ����ֵ�λ��
	 * @return һ��size���ȵ������ַ���
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
	 * �������ֻ�ȡcookie
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
	 * ��õ�ǰ��һ����ʽ����ʱ��
	 * @param format - ��ʽ���ַ���
	 * @return String
	 */
	public static String getCurrentDate(String format){
		SimpleDateFormat sf = new SimpleDateFormat(format);
		return sf.format(new Date());
	}
	
	/**
	 * ������ݿ�洢ʱ��
	 * @return String 20111111121212
	 */
	public static String getDBDate(){
		return dbFormat.format(new Date());
	}
	
	/**
	 * ��ʽ�����ڣ�����long
	 * @param date - �ַ��� ��ʽ��2011-12-12
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
	* ������� 
	* @param d ������ 
	* @param day ��ӵ����� 
	* @return ��Ӻ������ 
	* @throws ParseException 
	*/ 
	public static Date addDate(Date d,long day) throws ParseException { 

	long time = d.getTime(); 
	day = day*24*60*60*1000; 
	time+=day; 
	return new Date(time); 

	} 
	/**
	 * ��ý�������� 2011-12-12
	 * @return String
	 */
	public static String getDate(){
		return DATE_FORMAT.format(new Date());
	}
	
	/**
	 * ��ý�������� 2011-12-12
	 * @param time - ����
	 * @return String
	 */
	public static String getDate(long time){
		return DATE_FORMAT.format(new Date(time));
	}
	
	/**
	 * ��ý�������� 2011-12-12
	 * @param date - ����
	 * @return String
	 */
	public static String getDate(Date date){
		if(date == null) return "";
		return DATE_FORMAT.format(date);
	}
	/**
	 * �����������֮������� 
	 * @param begin - ��ʼ����
	 * @param end - ��������
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
	 * ��ʱ���STRING��ʽ��һ��
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
	 * ��ȡһ����ʽ����ʱ��
	 * @param time long
	 * @param format ��ʽ���ַ���
	 * @return String
	 */
	public static String getFormatDate(long time , String format){
		SimpleDateFormat sf = new SimpleDateFormat(format);
		Date date = new Date(time);
		return sf.format(date)	;
	}
	
	/**
     * ʱ���ʽ��2011-3-23 13:57:43
     * @param time - ʱ��
     * @return String
     */
    public static String stockFormatDate(long time){
    	return STOCK_FORMATE.format(new Date(time));
    }
    
    /**
    * ʱ���ʽ��2011-3-23 13:57:43
    * @param date - ʱ�����
    * @return String
    */
    public static String stockFormatDate(Date date){
    	if(date == null) return "";
    	return STOCK_FORMATE.format(date);
    }

    
	/**
	 * �ַ�����ȡ
	 * @param str String Ҫ��ȡ���ַ���
	 * @param endIndex int ��ȡ��
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
	 * д�ļ���ÿ��дһ�У���Ҫ������¼��־�������õġ���һ��������Ļ����ÿ����Ŀ���á�|���ָ��������ͳ��
	 * @param filePath �ļ�·����һ��������վ��Ŀ¼��log�ļ�������
	 * @param str ����
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
	 * ��õ�ǰ�����뱾��һ��������
	 * @return int
	 */
    private static int getMondayPlus() {
        Calendar cd = Calendar.getInstance();
        // ��ý�����һ�ܵĵڼ��죬�������ǵ�һ�죬���ڶ��ǵڶ���......
        int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);
        if (dayOfWeek == 1) {
            return 6;
        } else {
            return dayOfWeek - 2;
        }
    }
    
	/**
	 * �����������һ������ʱ��,����long
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
     * ��ñ�������һ��ʱ��,����long
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
     * �õ�����ǰ������賿��ʱ��
     * @param dayBefore - ����ǰ
     * @return long - dayBefore��ǰ�賿��ʱ�䡣
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
     * ��õ�ǰVСʱ�ĺ�����
     * @param v - ��ǰ��Сʱ������Ϊ����
     * @return long - ��ǰVСʱ�ĺ�����
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
	 * ��һ���ַ������Ƿ��Ǻ���
	 * @param str String Ҫ�жϵ��ַ���
	 * @return boolean ����ֵ
	 */
	public static boolean isChinese(String str) {
		if(isNull(str)) return false;
		return Pattern.matches("[\u4e00-\u9fa5]*", str);
	}
	
	/**
	 * ��һ���ַ����Ƿ�����ĸ
	 * @param str String Ҫ�жϵ��ַ���
	 * @return boolean ����ֵ
	 */
	public static boolean isEnglish(String str) {
		if(isNull(str)) return false;
		return Pattern.matches("[a-zA-Z]*" , str);
	}

	/**
	 * �ж�һ���ַ����Ƿ������֣�������ȫ�Ǻ͸�����
	 * @param str String �ַ���
	 * @return boolean ����ֵ
	 * @deprecated ������ʹ���ˡ����Ϊ��<code>Tools.isNumber(java.lang.String)</code>
	 */
	public static boolean isMath(String str) {
		if(isNull(str)) return false;
		return Pattern.matches("\\d*" , str);
	}
	
	/**
	 * �ж��Ƿ������ֵ�������ʽ
	 */
	private static final Pattern Pattern_Number = Pattern.compile("\\d+");
	
	/**
	 * �ж�һ���ַ����Ƿ������֣�������ȫ�Ǻ͸�����
	 * �˷������<code>Tools.isMath(java.lang.String)</code>
	 * @param str - �ַ���
	 * @return boolean ����ֵ
	 */
	public static boolean isNumber(String str){
		if(str == null) return false;
		Matcher m = Pattern_Number.matcher(str);
        return m.matches();
	}
	
	/**
	 * �ж�һ���ַ����Ƿ������ֺ���ĸ���.�ҿ�ͷ��������ĸ
	 * @param str String �ַ���
	 * @return boolean ����ֵ
	 */
	public static boolean isRegString(String str){
		if(isNull(str)) return false;
		return Pattern.matches("[a-zA-Z][0-9a-zA-Z]*" , str);
	}
	
	/**
	 * �ж�һ���ַ����Ƿ���Email
	 * @param str String �ַ���
	 * @return boolean ����ֵ
	 */
	public static boolean isEmail(String str){
		if(isNull(str)) return false;
		return Pattern.matches("^([a-zA-Z0-9_\\-]+\\.*)+@([a-zA-Z0-9_\\-]+\\.*)+(\\.(com|cn|mobi|co|net|so|org|gov|tel|tv|biz|cc|hk|name|info|asia|me)){1,2}+$", str);
	}
	
	/**
	 * ƥ���ַ�
	 * @param regex - ͨ���
	 * @param str - ��Ҫ��֤���ַ�
	 * @return boolean ����ֵ
	 */
	public static boolean matches(String regex , String str) {
		if(str == null) return false;
		return Pattern.matches(regex, str);
	}
	
	/**
	 * �ر����ݿ�����
	 * @param rs - ���ص����ݼ�
	 * @param st - sql���ִ�ж���
	 * @param co - ���ݿ�����
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
	 * ��ȡ�����ļ�
	 * @param filePath - �ļ�·��
	 * @return �������Լ�
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
	 * �����¼���ļ�
	 * @param filePath - �ļ�·��
	 * @param pro - �־����Լ�
	 * @param map - ��ֵ��Ӧ������ 
	 * @param username - �޸��ļ����û�
	 * @param email - �޸��ļ����û�email
	 * @param ip - ip��ַ
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
	 * �Ƿ��ӡ����־
	 * @param command - ����
	 * @param isLog - �Ƿ�������־
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
	 * ���һ��list
	 * @param list - List
	 */
	@SuppressWarnings("rawtypes")
	public static void clearList(List list){
		if(list == null) return;
		list.clear();
		list = null;
	}
	
	/**
	 * ���һ��map
	 * @param map - Map
	 */
	@SuppressWarnings("rawtypes")
	public static void clearMap(Map map) {
		if(map == null) return;
		map.clear();
		map = null;
	}
	
	/**
	 * �������һ��ʱ�䣬����һ��long�͵�ʱ��
	 * @param date - �ַ���ʱ��
	 * @param format - ��ʽ��ʱ��
	 * @return long ��ʱ��
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
	 * �������뷵��һ��С��
	 * @param d - Ҫ��ʽ��������
	 * @param scale - ����С����λ��
	 * @return double
	 */
	public static double getDouble(double d , int scale){
		BigDecimal bd = new BigDecimal(d);
		return bd.setScale(scale, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
	
	/**
	 * ��ȷ��Ԫ������������
	 * @param f
	 * @return
	 */
	public static double getDouble5(float f){
		return (double)((int)f);
	}
	
	/**
	 * ��ȷ��Ԫ������������
	 * @param f
	 * @return
	 */
	public static double getDouble5(Double fl){
		if(fl==null)return 0;
		return (double)((int)fl.doubleValue());
	}
	
	/**
	 * �������뷵��һ��С��
	 * @param f - Ҫ��ʽ��������
	 * @param scale - ����С����λ��
	 * @return float
	 */
	public static float getFloat(float f , int scale){
		BigDecimal bd = new BigDecimal(f);
		return bd.setScale(scale, BigDecimal.ROUND_HALF_UP).floatValue();
	}
	
	/**
	 * �������뷵��һ��С��
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
	 * ����XML��ֻ֧�֣�<pre><?xml version="1.0" encoding="gb2312" ?><response><code>03</code><message><desmobile>13683211004</desmobile><msgid>20100603152320692610</msgid></message></response></pre>
	 * ���2�㡣��
	 * @param xml - Ҫ�������ַ���
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
	 * ʱ������ 10��ǰ��1��ǰ 1��ǰ
	 * @param time - ʱ��
	 * @return String
	 */
	public static String toTime(long time){
		long currentTime = System.currentTimeMillis();
		double mid = currentTime - time;
		if(mid <= 0) return "0��ǰ";
		if(mid < Tools.MINUTE_MILLIS){
			return (int)Math.floor(mid/1000)+"��ǰ";
		}
		if(mid < Tools.HOUR_MILLIS){
			return (int)Math.floor(mid/Tools.MINUTE_MILLIS)+"����ǰ";
		}
		if(mid < Tools.DAY_MILLIS){
			return (int)Math.floor(mid/Tools.HOUR_MILLIS)+"Сʱǰ";
		}
		if(mid < Tools.MONTH_MILLIS){
			return (int)Math.floor(mid/Tools.DAY_MILLIS)+"��ǰ";
		}
		if(mid < Tools.YEAR_MILLIS){
			return (int)Math.floor(mid/Tools.MONTH_MILLIS)+"��ǰ";
		}
		return (int)Math.floor(mid/Tools.YEAR_MILLIS)+"��ǰ";
	}
	
	/**
	 * �������lengthλ����ĸ�����ֵ����
	 * @param length - λ��
	 * @return String
	 */
	public static String getCharAndNumr(int length){
	    String val = "";
	    Random random = new Random();
	    String charOrNum = null;
	    for(int i = 0; i < length; i++){
	        charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num"; // �����ĸ��������
	        if("char".equalsIgnoreCase(charOrNum)){ // �ַ���
	            int choice = random.nextInt(2) % 2 == 0 ? 65 : 97; //ȡ�ô�д��ĸ����Сд��ĸ
	            val += (char) (choice + random.nextInt(26));
	        }else if("num".equalsIgnoreCase(charOrNum)){ // ����
	            val += String.valueOf(random.nextInt(10));
	        }
	    }
	    return val;
	}
	
	/**
     * �ַ�������Ϊ��
     * @param str - �ַ���
     * @param defaultStr - �ַ���Ϊ����ʾ���ַ�
     * @return ��Ϊ�յ��ַ���
     */
	public static String formatString(String str , String defaultStr){
		if(Tools.isNull(str)) return defaultStr;
		return str;
	}
	
	/**
     * �ַ�������Ϊ��
     * @param str - �ַ���
     * @return ��Ϊ�յ��ַ���
     */
	public static String formatString(String str){
		return formatString(str,"");
	}
	
	/**
	 * ����һ���ַ����Ƿ�Ϊ�գ�����ַ���Ϊ""����Ϊ�ո�ҲΪtrue
	 * @param str - String
	 * @return true false
	 */
	public static boolean isNull(String str){
		if(str == null || str.trim().length()==0) return true;
		return false;
	}
	
	/**
	 * �ж��ַ����Ƿ�Ϊ����������
	 * @param str - String
	 * @return true or false
	 */
	public static boolean isDouble(String str){
		if(str == null || str.length() == 0) return false;
		return Pattern.matches("^[-]?[\\d]+([.]?[\\d]+)$", str);
	}
	
	/**
	 * �ж��Ƿ����ֻ�����
	 * @param str - String
	 * @return true or false
	 */
	public static boolean isMobile(String str){
		if(str == null || str.length()!=11) return false;
		return Pattern.matches("^1[0-9]{10}$", str);
	}
	
	/**
	 * �ж��Ƿ������֤�ţ�����׼ȷ��
	 * @param str - String
	 * @return true or false
	 */
	public static boolean isIdcard(String str){
		if(str == null) return false;
		return Pattern.matches("\\d{15}|\\d{18}|\\d{17}[a-z]{1}", str);
	}
	
	/**
	 * �ж��Ƿ���Ǯ�ĸ�ʽ����12��12.12
	 * @param str - String
	 * @return True or False
	 */
	public static boolean isMoney(String str){
		if(str == null || str.length() == 0) return false;
		return Pattern.matches("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){1,2})?$", str);
	}
	
	/**
	 * ����һ��Cookie��ֵ
	 * @param request - ҳ��
	 * @param name - Cookie������
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
	 * д��Cookie
	 * @param response - HttpServletResponse
	 * @param name - Cookie������
	 * @param value - Cookie��ֵ
	 * @param expireTime - ����ʱ�䣬��
	 */
	public static void setCookie(HttpServletResponse response , String name , String value , int expireTime){
		Cookie userIdCookie = new Cookie(name, value);
		userIdCookie.setPath("/");
		userIdCookie.setDomain("d1.com.cn");
		userIdCookie.setMaxAge(expireTime);
		response.addCookie(userIdCookie);
	}
	
	/**
	 * ɾ��Cookie
	 * @param response - HttpServletResponse
	 * @param name - cookie������
	 */
	public static void removeCookie(HttpServletResponse response , String name){
		Cookie userIdCookie = new Cookie(name, null);
		userIdCookie.setPath("/");
		userIdCookie.setDomain("d1.com.cn");
		userIdCookie.setMaxAge(0);//ֱ�ӹ���
		response.addCookie(userIdCookie);
	}
	
	/**
	 * ��ҳ�����һ��JS�����򣬲�����ת��ĳ��ҳ��
	 * @param out - JspWriter
	 * @param mess - ��������Ϣ
	 * @param url - ��תҳ�棬�ַ�back������һҳ�棬����Ϊ��תҳ�档
	 * @return String
	 * @throws IOException 
	 */
	public static void outJs(JspWriter out , String mess , String url) throws IOException{
		out.print("<script type=\"text/javascript\">alert(\""+mess+"��\");"+("back".equals(url)?"window.history.back();":"top.location.href=\""+url+"\";")+"</script>");
	}
	
	/**
	 * ����ת����a,b,c��ʽ���ַ���
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
	 * �б�ת����a,b,c��ʽ���ַ���
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
	 * map��keyת����a,b,c��ʽ���ַ���
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
	 * �����б�ת����a,b,c��ʽ���ַ�����
	 * �����list������BaseEntity�ķ��ͣ����򽫱������ﲻ������
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
	 * ȡ��ͼƬ�ĵ�ַ
	 * @param photo - ͼƬȫ·��
	 * @param prefix - ��׺
	 * @return String
	 */
	public static String getPhoto(String photo , String prefix){
		return ImageUtil.getPrefixImage(photo, prefix);
	}
	
	/**
	 * ���ʡ��
	 * @param areacode1 - ʡ����
	 * @param areacode2 - �д���
	 * @return String ����ʡ ��ͨ��
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
	 * ����URL�ַ���
	 * @param str - �ַ���
	 * @return String
	 * @throws UnsupportedEncodingException
	 */
	public static String encoder(String str) throws UnsupportedEncodingException{
		if(isNull(str)) return "";
		return URLEncoder.encode(str, "GBK");
	}
	
	/**
	 * �滻�ַ���ʾ����ҳ�У���Ҫ����ҳ�༭��һ��ʹ�á�
	 * @param str - Ҫ�滻���ַ�
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
	 * ȥ�����е�html��ǩ
	 * @param str - Ҫ�滻���ַ�
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
	 * ȥ���ַ���ͷβ�Ŀո�
	 * @param str - Ҫ�滻���ַ���
	 * @return String
	 */
	public static String trim(String str){
		return trim(str," ");
	}
	
	/**
	 * ȥ���ַ���ͷβ���ַ�
	 * @param str - Ҫ�滻���ַ���
	 * @param s - Ҫȥ����ͷβ�ַ�
	 * @return String
	 */
	public static String trim(String str , String s){
		if(Tools.isNull(str)) return "";
		return str.replaceAll("^"+s+"+|"+s+"+$", "");
	}
	
	/**
	 * �ַ���ȫ��ת���
	 * @param str - Ҫ�滻���ַ���
	 * @return String
	 */
	public static String convertToBanJiao(String str){
		if(Tools.isNull(str)) return null;
		char[] chArray = str.toCharArray();
		for (int i = 0; i < chArray.length; i++){
			if (chArray[i] == '��'){
				chArray[i] = ' ';
			}else if ((chArray[i] > 0xff00) && (chArray[i] < 0xff5f)){
				chArray[i] = (char)(chArray[i] - 0xfee0);
			}
		}
		return new String(chArray);
	}
	
	/**
	 * �����ַ�ת��
	 * @param str - Ҫ�滻���ַ���
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
						builder.append("��");
						break;
					case '%':
						builder.append("��");
						break;
					case '&':
						builder.append("��");
						break;
					case '\'':
						builder.append("''");
						break;
					case '(':
						builder.append("��");
						break;
					case ')':
						builder.append("��");
						break;
					case ';':
						builder.append("��");
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
	 * �ַ���ת����int��,Ĭ��ֵ����0
	 * @param s - String
	 * @return int
	 */
	public static int parseInt(String s){
		return parseInt(s , 0);
	}
	
	/**
	 * �ַ���ת����int��
	 * @param s - String
	 * @param defaultValue - ���ת�������򷵻�defaultValue
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
	 * �ַ���ת��long��,Ĭ��ֵ����0
	 * @param s - String
	 * @return long
	 */
	public static long parseLong(String s){
		return parseLong(s , 0);
	}
	
	/**
	 * �ַ���ת����long��
	 * @param s - String
	 * @param defaultValue - ���ת�������򷵻�defaultValue
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
	 * �ַ���ץ����float�ͣ�Ĭ��ֵ����0
	 * @param s - String
	 * @return float
	 */
	public static float parseFloat(String s){
		return parseFloat(s , 0f);
	}
	
	/**
	 * �ַ���ץ����float��
	 * @param s - String
	 * @param defaultValue - ���ת�������򷵻�defaultValue
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
	 * �ַ���ת����double�ͣ�Ĭ��ֵ����0
	 * @param s - String
	 * @return double
	 */
	public static double parseDouble(String s){
		return parseDouble(s , 0d);
	}
	
	/**
	 * �ַ���ץ����double��
	 * @param s - String
	 * @param defaultValue - ���ת�������򷵻�defaultValue
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
	 * �ַ���ת����boolean�ͣ�Ĭ��ֵ����false
	 * @param s - String
	 * @return boolean
	 */
	public static boolean parseBoolean(String s){
		return parseBoolean(s , false);
	}
	
	/**
	 * �ַ���ץ����boolean��
	 * @param s - String
	 * @param defaultValue - ���ת�������򷵻�defaultValue
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
	 * Longת����long
	 * @param l - Long
	 * @param defaultValue - Ĭ����ʾֵ
	 * @return long
	 */
	public static long longValue(Long l , long defaultValue){
		if(l == null) return defaultValue;
		return l.longValue();
	}
	
	/**
	 * Longת����long�����Ϊnull������ʾ0
	 * @param l - Long
	 * @return long
	 */
	public static long longValue(Long l){
		return longValue(l , 0);
	}
	
	/**
	 * Integerת����int
	 * @param i - Integer
	 * @param defaultValue - Ĭ����ʾֵ
	 * @return int
	 */
	public static int intValue(Integer i , int defaultValue){
		if(i == null) return defaultValue;
		return i.intValue();
	}
	
	/**
	 * Integerת����int�����Ϊnull������ʾ0
	 * @param i - Integer
	 * @return int
	 */
	public static int intValue(Integer i){
		return intValue(i , 0);
	}
	
	/**
	 * Floatת����float
	 * @param f - Float
	 * @param defaultValue - Ĭ����ʾֵ
	 * @return float
	 */
	public static float floatValue(Float f , float defaultValue){
		if(f == null) return defaultValue;
		return f.floatValue();
	}
	
	/**
	 * Floatת����float�����Ϊnull������ʾ0
	 * @param f - Float
	 * @return float
	 */
	public static float floatValue(Float f){
		return floatValue(f,0f);
	}
	
	/**
	 * Doubleת����double
	 * @param d - Double
	 * @param defaultValue - Ĭ����ʾֵ
	 * @return double
	 */
	public static double doubleValue(Double d , double defaultValue){
		if(d == null) return defaultValue;
		return d.doubleValue();
	}
	
	/**
	 * Doubleת����double�����Ϊnull������ʾ0
	 * @param d - Double
	 * @return double
	 */
	public static double doubleValue(Double d){
		return doubleValue(d , 0d);
	}
	
	/**
	 * Booleanת����Boolean
	 * @param b - Boolean
	 * @param defaultValue - Ĭ����ʾֵ
	 * @return boolean
	 */
	public static boolean booleanValue(Boolean b , boolean defaultValue){
		if(b == null) return defaultValue;
		return b.booleanValue();
	}
	
	/**
	 * Booleanת����Boolean�����Ϊnull������ʾfalse
	 * @param b - Boolean
	 * @return boolean
	 */
	public static boolean booleanValue(Boolean b){
		return booleanValue(b);
	}
	
	/**
	 * Dateת����long��
	 * @param date - ʱ��
	 * @return long
	 */
	public static long dateValue(Date date){
		if(date == null) return 0;
		return date.getTime();
	}
	
	/**
	 * ��ø�ʽ����Ǯ����ֹ���־��ȶ�ʧ���⡣
	 * @param value - ��Ǯ
	 * @return float
	 */
	public static float getRoundPrice(float value){
		return NumberUtils.round(value, 2,BigDecimal.ROUND_HALF_UP);
	}
	
	/**
	 * ��ʽ���ɽ�Ǯ
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
	 * ��ʽ��money
	 * @param f
	 * @return
	 */
	public static String getFormatMoney(Float f){
		if(f==null)return "0";
		else return getFormatMoney(f.doubleValue());
	}
	
	/**
	 * ��ʽ������
	 * @param weight - ��������λ��
	 * @return String 0.123
	 */
	public static String getFormatWeight(long weight){
		return NumberUtils.getMaxWeight((double)weight/1000);
	}
	
	/**
	 * ��ʽ���ٷֱ�
	 * @param d - double
	 * @return String 99.92%
	 */
	public static String getFormatPercent(double d){
		return NumberUtils.getPercent(d);
	}
	
	//////////////////////////////////////////////////////////////
	
	public static final float EPS = 0.00000001f; 
	
	/**
	 * �����������Ƚ�
	 * @param a - ��һ��������
	 * @param b - �ڶ���������
	 * @return 1��a����b,-1��aС��b,0�����
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
	 * ��request�����һ���������߸���һ����������ɲ�����ʽc.jsp?g=23434&pg=10
	 * @param request
	 * @param pName - ����
	 * @param pValue - ֵ
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
	    
		//�Ѻ��ֻ���
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
	 * ajax�������������ʾ��Ϣ
	 * @param out - JspWriter
	 * @param tips - ��ʾ
	 * @param desc - ��ʾ������
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
		/*String url="http://www.d1.com.cn/result.jsp?productsort=014&productbrand=ˮ����";
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