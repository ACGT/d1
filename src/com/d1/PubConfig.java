package com.d1;

import java.util.HashMap;
import java.util.Map;

import org.apache.avalon.framework.configuration.Configuration;
import org.apache.avalon.framework.configuration.DefaultConfigurationBuilder;

/**
 * ϵͳ���õ�һЩ�������ݣ������ļ���confĿ¼�µ�system.conf,�������û������Ļ�������
 * 
 */
public class PubConfig {
	
	//�洢public.Config.xml�ļ�ֵ
	private static Map<String,String> map = new HashMap<String,String>();
	
	/**
	 * ���캯��
	 *
	 */
	private PubConfig(){}
	
	static{
		reload();
	}
	
	/**
	 * ���¼��������ļ�
	 *
	 */
	public static void reload(){
		System.err.println("��ȡ�����ļ�public.Config.xml...");
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
        	System.err.println("��ȡ�����ļ�public.Config.xml��ϣ�");
		} catch(Exception ex){
        	ex.printStackTrace();
        	System.err.println("��ȡ�����ļ�public.Config.xml����");
        }
	}
	
	/**
	 * ���ֵ
	 * @param key - ��
	 * @return String
	 */
	public static String get(String key){
		return map.get(key);
	}
	
	/**
	 * ���ֵ
	 * @param key - ��
	 * @param defaultValue - ���Ϊnull�򷵻ش�Ĭ��ֵ
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
