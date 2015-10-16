package com.d1.dbcache.core;

import java.io.File;
import java.io.FileInputStream;
import java.lang.reflect.Constructor;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import net.sf.cglib.proxy.Enhancer;

import org.apache.avalon.framework.configuration.Configuration;
import org.apache.avalon.framework.configuration.DefaultConfigurationBuilder;

import com.d1.Const;

/**
 * ����Manager�Ĺ��������ݿ�managerͳһҪ�������������!!!<br/>
 * 
 * @author kk
 * 
 */
public class MyFactory {
	
	/**
	 * ���ö��󣬶�Ӧ�������ļ���db-cache-managers.xml
	 */
	private static Configuration configuration = null ;
	
	/**
	 * ����manager��HashMap��key=���� value=BaseManager
	 */
	private static Map<String,BaseManager> MANAGER_MAP = Collections.synchronizedMap(new HashMap<String,BaseManager>()); 
	
	/**
	 * ��helper��HashMap
	 */
	private static Map<String,Object> SERVICE_MAP = Collections.synchronizedMap(new HashMap<String,Object>());

	/**
	 * ���캯������ȡ�����ļ�����������manager��new����
	 */
	static{
		DefaultConfigurationBuilder   builder = new DefaultConfigurationBuilder();   
        try {
        	configuration = builder.build(new FileInputStream(new File(Const.PROJECT_PATH+"WEB-INF/classes/db-cache-managers.xml")));
        	
        	String defaultHibernateFile = configuration.getChild("default-hibernate-file").getValue();
        	String defaultmanagerClass = configuration.getChild("default-manager-class").getValue();
        	
        	//��������manager...
        	for(int i=0;i<configuration.getChildren("manager").length;i++){
        		Configuration child = configuration.getChildren("manager")[i];
        		
        		String beanClassName = child.getChild("bean-class").getValue();//��ѡ��
        		
        		String managerClassName,hibernateFile,hashFields;//��ѡ��
        		
        		if(child.getChild("manager-class",false)==null){
        			managerClassName = defaultmanagerClass;
        		}else{
        			managerClassName =  child.getChild("manager-class").getValue();
        		}
        		
        		if(child.getChild("hibernate-file",false)==null){
        			hibernateFile = defaultHibernateFile;
        		}else{
        			hibernateFile =  child.getChild("hibernate-file").getValue();
        		}
        		
        		if(child.getChild("cache-hash-fields",false)==null){
        			hashFields = null;
        		}else{
        			hashFields =  child.getChild("cache-hash-fields").getValue();
        		}
        		
        		Class<?> beanClass = Class.forName(beanClassName);//bean class
        		Class<?> managerClass = Class.forName(managerClassName);//manager class
        		
        		//BaseManagerֻ��һ�����췽��
        		Constructor<?> con = managerClass.getConstructors()[0];
        		
        		Object[] objs = new Object[]{beanClass,hibernateFile,hashFields};
        		BaseManager manager = (BaseManager)con.newInstance(objs);
        		
        		//����hashmap��
        		MANAGER_MAP.put(beanClass.getName(), manager);
        		
        	}//end for
		} catch(Exception ex) {
        	ex.printStackTrace();
        }
	}

	/**
	 * ����className�õ�һ�����ݿ�����࣬������BaseManager������
	 */
	public static BaseManager getManager(Class<?> classname) {
		return MANAGER_MAP.get(classname.getName());
	}
	
	//��
	private static final Object LOCK = new Object();
	
	/**
	 * �õ�һ��service�����������Ҫʵ������ȫ�Ķ�����ͨ��serviceʵ�֣�<br/>
	 * ͨ��MyFactory.getService�������������Զ�ʵ��������ͻ��档<br/>
	 * ֧�ֶ����ķֲ�ʽ����<br/>
	 * ע�⣺�Լ�д��Service�������з�����ֻ����BaseManager��tx��ͷ�ķ��������Ҳ�Ҫ�Լ�ץ�쳣��<br/>
	 * @param classname Helper������
	 * @return
	 */
	public static Object getService(Class<?> classname){
		if(SERVICE_MAP.containsKey(classname.getName())){
			return SERVICE_MAP.get(classname.getName());
		}else{
			synchronized(LOCK){
				if(SERVICE_MAP.containsKey(classname.getName())){
					return SERVICE_MAP.get(classname.getName());
				}
				
				Object bh = createProxy(classname);
				SERVICE_MAP.put(classname.getName(), bh);
				return bh;
			}
		}
	}
	
	/**
	 * ��������
	 * @param targetClass
	 * @return
	 */
	private static Object createProxy(Class<?> targetClass){
        Enhancer enhancer = new Enhancer();
        enhancer.setSuperclass(targetClass);
        enhancer.setCallback(new MyInterceptor());
        return enhancer.create();
    }
}
