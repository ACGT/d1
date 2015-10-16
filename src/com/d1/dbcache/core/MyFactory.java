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
 * 制造Manager的工厂，数据库manager统一要从这个工厂创建!!!<br/>
 * 
 * @author kk
 * 
 */
public class MyFactory {
	
	/**
	 * 配置对象，对应的配置文件是db-cache-managers.xml
	 */
	private static Configuration configuration = null ;
	
	/**
	 * 管理manager的HashMap，key=类名 value=BaseManager
	 */
	private static Map<String,BaseManager> MANAGER_MAP = Collections.synchronizedMap(new HashMap<String,BaseManager>()); 
	
	/**
	 * 放helper的HashMap
	 */
	private static Map<String,Object> SERVICE_MAP = Collections.synchronizedMap(new HashMap<String,Object>());

	/**
	 * 构造函数，读取配置文件，并把所有manager给new出来
	 */
	static{
		DefaultConfigurationBuilder   builder = new DefaultConfigurationBuilder();   
        try {
        	configuration = builder.build(new FileInputStream(new File(Const.PROJECT_PATH+"WEB-INF/classes/db-cache-managers.xml")));
        	
        	String defaultHibernateFile = configuration.getChild("default-hibernate-file").getValue();
        	String defaultmanagerClass = configuration.getChild("default-manager-class").getValue();
        	
        	//配置所有manager...
        	for(int i=0;i<configuration.getChildren("manager").length;i++){
        		Configuration child = configuration.getChildren("manager")[i];
        		
        		String beanClassName = child.getChild("bean-class").getValue();//必选项
        		
        		String managerClassName,hibernateFile,hashFields;//可选项
        		
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
        		
        		//BaseManager只有一个构造方法
        		Constructor<?> con = managerClass.getConstructors()[0];
        		
        		Object[] objs = new Object[]{beanClass,hibernateFile,hashFields};
        		BaseManager manager = (BaseManager)con.newInstance(objs);
        		
        		//放入hashmap中
        		MANAGER_MAP.put(beanClass.getName(), manager);
        		
        	}//end for
		} catch(Exception ex) {
        	ex.printStackTrace();
        }
	}

	/**
	 * 根据className得到一个数据库管理类，必须是BaseManager的子类
	 */
	public static BaseManager getManager(Class<?> classname) {
		return MANAGER_MAP.get(classname.getName());
	}
	
	//锁
	private static final Object LOCK = new Object();
	
	/**
	 * 得到一个service的组件。凡是要实现事务安全的都可以通过service实现！<br/>
	 * 通过MyFactory.getService创建出来，就自动实现了事务和缓存。<br/>
	 * 支持多个库的分布式事务。<br/>
	 * 注意：自己写的Service里面所有方法都只能用BaseManager以tx开头的方法，并且不要自己抓异常。<br/>
	 * @param classname Helper的类名
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
	 * 创建代理
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
