package com.d1;

import java.util.Collections;
import java.util.Map;

import com.d1.servlet.InitServlet;


public class Const {
	
	public static String PROJECT_PATH = InitServlet.getProjectAbsolutePath() ;
	
	public static final Map<Long,Long> LIMIT_HASH_MAP = Collections.synchronizedMap(new LRUCache<Long,Long>(50000));
	
	public static final int LIMIT_MILLSECONDS = 1000 ;
	
	public static final String LOGIN_USER_ID_PREFIX = "LOGIN_USER_ID" ;
	
	public static final String CART_COOKIE_NAME = "CART_COOKIE_NAME";
	
	public static final String LOGIN_USER_COOKIE_ID = "LOGIN_USER_COOKIE_ID";
	
	public static final float PT_VIP_DISCOUNT = 0.95f ;
	
	public static final float VIP_DISCOUNT = 0.98f ;
	
	public static final String HIBERNATE_CON_FILE = "D:\\hibernate_con.cfg.xml";
	
	public static final String HIBERNATE_FILE = "D:\\hibernate.cfg.xml";
	
}
