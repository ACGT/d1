package com.d1.dbcache.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.d1.Const;

/** 
 * 获取logger的工具，对应的配置文件是db-cache-log4j.conf<br/>
 * @author kk
 */
public class MyLoggerUtil
{
    static{
    	Properties props = new Properties();
		try {
			props.load(new FileInputStream(new File(Const.PROJECT_PATH+"WEB-INF/classes/db-cache-log4j.conf")));
		} 
		catch (IOException e) {
			e.printStackTrace();
		}
		PropertyConfigurator.configure(props);
	}
    
    /**
     * 获取一个logger
     * @param loggerName logger名字
     * @return
     */
    public static Logger getLogger(String loggerName){
    	return Logger.getLogger(loggerName);
    }
    
    /**
     * 获得记录数据库的logger，数据的增删改操作都记录在这个logger里面<br/>
     * logger名称为dblogger，一定要在配置文件中配置这个logger！！！<br/>
     * @return
     */
    public static Logger getDbLogger(){
    	return Logger.getLogger("dblogger");
    }
}
