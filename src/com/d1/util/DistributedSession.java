package com.d1.util;

import javax.servlet.http.HttpSession;

import com.d1.dbcache.core.MyMemcachedUtil;
import com.danga.MemCached.MemCachedClient;

/**
 * 实现分布式session<br/>
 * 如果要使用分布式session,必须开启memcached server<br/>
 * 放入远程的session的对象必须实现序列化。！！！！
 * @author kk
 */
public class DistributedSession {
	/**
	 * 分布式往session里放入一个对象，远程服务器的id是sessionId#key组合而成
	 * @param session HttpSession
	 * @param key 
	 * @param value 比如是实现序列化的对象
	 * @return true 如果操作成功返回true
	 */
	public static boolean setAttribute(HttpSession session,String key,Object value)	{
		MemCachedClient mCachedClient = MyMemcachedUtil.getMemCachedClient();
		if(mCachedClient==null||key==null||value==null)return false;

		//session过期时间为24小时
		return mCachedClient.set(session.getId()+"#"+key, value,new java.util.Date(1440*60*1000));
	}
	
	/**
	 * 删除远程session数据
	 * @param session
	 * @param key
	 * @return
	 */
	public static boolean removeAttribute(HttpSession session,String key){
		MemCachedClient mCachedClient = MyMemcachedUtil.getMemCachedClient();
		if(mCachedClient==null||key==null)return false;
		
		return mCachedClient.delete(session.getId()+"#"+key);
	}
	
	/**
	 * 从远程session里获取一个对象
	 * @param session HttpSession
	 * @return 返回分布式session里的对象
	 */
	public static Object getAttribute(HttpSession session,String key){
		MemCachedClient mCachedClient = MyMemcachedUtil.getMemCachedClient();
		if(mCachedClient!=null){
			Object obj = mCachedClient.get(session.getId()+"#"+key);
			return obj;
		}
		return null;
	}
}
