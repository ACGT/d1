package com.d1.util;

import javax.servlet.http.HttpSession;

import com.d1.dbcache.core.MyMemcachedUtil;
import com.danga.MemCached.MemCachedClient;

/**
 * ʵ�ֲַ�ʽsession<br/>
 * ���Ҫʹ�÷ֲ�ʽsession,���뿪��memcached server<br/>
 * ����Զ�̵�session�Ķ������ʵ�����л�����������
 * @author kk
 */
public class DistributedSession {
	/**
	 * �ֲ�ʽ��session�����һ������Զ�̷�������id��sessionId#key��϶���
	 * @param session HttpSession
	 * @param key 
	 * @param value ������ʵ�����л��Ķ���
	 * @return true ��������ɹ�����true
	 */
	public static boolean setAttribute(HttpSession session,String key,Object value)	{
		MemCachedClient mCachedClient = MyMemcachedUtil.getMemCachedClient();
		if(mCachedClient==null||key==null||value==null)return false;

		//session����ʱ��Ϊ24Сʱ
		return mCachedClient.set(session.getId()+"#"+key, value,new java.util.Date(1440*60*1000));
	}
	
	/**
	 * ɾ��Զ��session����
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
	 * ��Զ��session���ȡһ������
	 * @param session HttpSession
	 * @return ���طֲ�ʽsession��Ķ���
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
