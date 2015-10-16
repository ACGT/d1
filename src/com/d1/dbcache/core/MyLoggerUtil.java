package com.d1.dbcache.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.d1.Const;

/** 
 * ��ȡlogger�Ĺ��ߣ���Ӧ�������ļ���db-cache-log4j.conf<br/>
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
     * ��ȡһ��logger
     * @param loggerName logger����
     * @return
     */
    public static Logger getLogger(String loggerName){
    	return Logger.getLogger(loggerName);
    }
    
    /**
     * ��ü�¼���ݿ��logger�����ݵ���ɾ�Ĳ�������¼�����logger����<br/>
     * logger����Ϊdblogger��һ��Ҫ�������ļ����������logger������<br/>
     * @return
     */
    public static Logger getDbLogger(){
    	return Logger.getLogger("dblogger");
    }
}
