package com.d1;

import java.util.HashMap;
import java.util.Map;

import org.apache.avalon.framework.configuration.Configuration;
import org.apache.avalon.framework.configuration.DefaultConfigurationBuilder;

/**
 * 系统配置的一些基本数据，配置文件在conf目录下的system.conf,这里有用户操作的基本数据
 * 
 */
public class PubConfig {
	
	//存储public.Config.xml的键值
	private static Map<String,String> map = new HashMap<String,String>();
	
	/**
	 * 构造函数
	 *
	 */
	private PubConfig(){}
	
	static{
		reload();
	}
	
	/**
	 * 重新加载配置文件
	 *
	 */
	public static void reload(){
		System.err.println("读取配置文件public.Config.xml...");
		DefaultConfigurationBuilder builder = new DefaultConfigurationBuilder();   
        try {
        	Configuration[] conf = builder.buildFromFile(Const.PROJECT_PATH+"conf/public.Config.xml").getChild("appSettings").getChildren();
        	if(conf != null && conf.length>0){
        		for(Configuration c : conf){
        			String key = c.getAttribute("key");
        			String value = c.getAttribute("value");
        			map.put(key, value);
        		}
        	}
        	System.err.println("读取配置文件public.Config.xml完毕！");
		} catch(Exception ex){
        	ex.printStackTrace();
        	System.err.println("读取配置文件public.Config.xml出错！");
        }
	}
	
	/**
	 * 获得值
	 * @param key - 键
	 * @return String
	 */
	public static String get(String key){
		return map.get(key);
	}
	
	/**
	 * 获得值
	 * @param key - 键
	 * @param defaultValue - 如果为null则返回此默认值
	 * @return String
	 */
	public static String get(String key , String defaultValue){
		String value = get(key);
		if(value == null) return defaultValue;
		return value;
	}
	
	public static void main(String[] args)throws Exception{
		System.err.println(PubConfig.get("spellCheck.misspell"));
	}
	
}
