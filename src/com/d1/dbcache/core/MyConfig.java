package com.d1.dbcache.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import com.d1.Const;

/**
 * 读取配置文件，获取配置，对应的配置文件是db-cache-conf.properties<br/>
 * @author kk
 */
public class MyConfig {
	/**
	 * 配置属性
	 */
	private static Properties props = null ;
	
	static{
		reLoad();
	}
	
	/**
	 * 得到bean的版本，不同版本用不同的缓存，便于清除缓存，可通过reconfigure()动态修改
	 * @param className 类名
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
	 * 重新装载配置文件
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
	 * 数据库的增删改是否记录日志，便于查询
	 * @return
	 */
	public static boolean isDebug(){
		String s = props.getProperty("debug");
		if("true".equalsIgnoreCase(s))return true;
		return false;
	}
	
	/**
	 * 是否用本地cache做缓存，非分布式
	 * @return
	 */
	public static boolean enableLocalCache(){
		String s = props.getProperty("ENABLE_LOCAL_CACHE");
		if("true".equalsIgnoreCase(s))return true;
		return false;
	}
	
	/**
	 * memcached过期时间，默认放3天。
	 * @return
	 */
	public static long getMemCachedExpire(){
		String c = props.getProperty("MEMCACHED_EXPIRE_TIME");
		long ret = 259200000l ;//3天
		try {
			ret = Long.parseLong(c);
		}catch(Exception e){
			e.printStackTrace();
		}
		return ret ;
	}
	
	/**
	 * 得到Memcached列表，多个server用空格隔开
	 * @return
	 */
	public static String[] getMemcachedServers(){
		String c = props.getProperty("MEMCACHED_SERVERS");
		if(c!=null)return c.split(";");
		return null;
	}
}
