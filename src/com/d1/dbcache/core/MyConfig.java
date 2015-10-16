package com.d1.dbcache.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import com.d1.Const;

/**
 * ��ȡ�����ļ�����ȡ���ã���Ӧ�������ļ���db-cache-conf.properties<br/>
 * @author kk
 */
public class MyConfig {
	/**
	 * ��������
	 */
	private static Properties props = null ;
	
	static{
		reLoad();
	}
	
	/**
	 * �õ�bean�İ汾����ͬ�汾�ò�ͬ�Ļ��棬����������棬��ͨ��reconfigure()��̬�޸�
	 * @param className ����
	 * @return
	 */
	public static String getBeanVersion(String className){
		if(props.getProperty(className)==null){
			return "";
		}else{
			return props.getProperty(className);
		}
	}
	
	/**
	 * ����װ�������ļ�
	 */
	public static void reLoad(){
		props = new Properties();
		try {
			props.load(new FileInputStream(new File(Const.PROJECT_PATH+"WEB-INF/classes/db-cache-conf.properties")));
		} 
		catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * ���ݿ����ɾ���Ƿ��¼��־�����ڲ�ѯ
	 * @return
	 */
	public static boolean isDebug(){
		String s = props.getProperty("debug");
		if("true".equalsIgnoreCase(s))return true;
		return false;
	}
	
	/**
	 * �Ƿ��ñ���cache�����棬�Ƿֲ�ʽ
	 * @return
	 */
	public static boolean enableLocalCache(){
		String s = props.getProperty("ENABLE_LOCAL_CACHE");
		if("true".equalsIgnoreCase(s))return true;
		return false;
	}
	
	/**
	 * memcached����ʱ�䣬Ĭ�Ϸ�3�졣
	 * @return
	 */
	public static long getMemCachedExpire(){
		String c = props.getProperty("MEMCACHED_EXPIRE_TIME");
		long ret = 259200000l ;//3��
		try {
			ret = Long.parseLong(c);
		}catch(Exception e){
			e.printStackTrace();
		}
		return ret ;
	}
	
	/**
	 * �õ�Memcached�б����server�ÿո����
	 * @return
	 */
	public static String[] getMemcachedServers(){
		String c = props.getProperty("MEMCACHED_SERVERS");
		if(c!=null)return c.split(";");
		return null;
	}
}
