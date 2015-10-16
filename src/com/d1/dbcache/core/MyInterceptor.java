package com.d1.dbcache.core;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import net.sf.cglib.proxy.MethodInterceptor;
import net.sf.cglib.proxy.MethodProxy;

/**
 * ����������������������ʹ��cglib���������أ�ע��ThreadLocal�÷����򵥵���ǿ��<br/>
 * �Ѿ�ʵ���ˡ��ֲ�ʽ�����񣬼�ȫ��ͬʱ�ύ��ͬʱ�ع��������ܱ�֤100%���ύ��ȷ��ع���ȷ��<br/>
 * ���Ծ���������������Ĺ��������һ�����ݿ�������ϡ�<br/>
 * @author kk
 *
 */
public class MyInterceptor implements MethodInterceptor{
	
	/**
	 * һ���߳���ʹ�ù���BaseManager���ϣ�����ͳһcommit��rollback��closeSession
	 */
	private static ThreadLocal<HashMap<String,BaseManager>> localManager = new ThreadLocal<HashMap<String,BaseManager>>();
	
	/**
	 * thread local����¼��ɾ����Щbean�����������Ӧ����
	 */
	private static ThreadLocal<ArrayList<BaseEntity>> localEntity = new ThreadLocal<ArrayList<BaseEntity>>();
	
	/**
	 * �������أ�û�������쳣��ȫ���ύ�������쳣��ȫ���ع���������֧�ֲַ�ʽ����
	 */
	public Object intercept(Object obj, Method method, Object[] args, MethodProxy proxy) throws Throwable {
	    try{
	    	//���ö�ӦService����.......
	    	Object res = proxy.invokeSuper(obj, args);
	    	
	    	//���û�г��쳣��commit����manager����һĳһ��manager�ύ���������manager��������ύ
	    	HashMap<String,BaseManager> map = localManager.get();
	    	if(map!=null){
	    		Iterator<String> it = map.keySet().iterator();
	    		while(it.hasNext()){
	    			BaseManager bm = map.get(it.next());
	    			bm.commit();
	    		}
	    	}
	    	
	    	//����ύ�ɹ���Ӧ�������Ӧ���󻺴���б���
	    	ArrayList<BaseEntity> list = localEntity.get();
	    	if(list!=null){
	    		for(int i=0;i<list.size();i++){
	    			BaseEntity be = list.get(i);
	    			BaseManager bm = MyFactory.getManager(be.getClass());
	    			
	    			//ɾ�����󻺴���б��棬�����ٶ��һ��
	    			bm.clearOmCache(be);
	    			bm.clearListCache(be);
	    		}
	    	}
	    	
	    	return res;
	    	
	    }catch(Exception ex){
	    	//����׳��쳣��rollback����manager����һĳ��rollback���ˣ�������Ҳ�����rollback
	    	HashMap<String,BaseManager> map = localManager.get();
	    	if(map!=null){
	    		Iterator<String> it = map.keySet().iterator();
	    		while(it.hasNext()){
	    			BaseManager bm = map.get(it.next().toString());
	    			try{
	    				bm.rollback();
	    			}catch(Exception e123){
	    				e123.printStackTrace();
	    			}
	    		}
	    	}
	    	
	    	//����ύʧ�ܣ�Ҳ������Щ�������ڴ����޸��ˣ����ݿ�û���޸ģ���ôӦ��������ض��󻺴棬���б�û��Ӱ�죬�������
	    	ArrayList<BaseEntity> list = localEntity.get();
	    	if(list!=null){
	    		for(int i=0;i<list.size();i++){
	    			BaseEntity be = list.get(i);
	    			BaseManager bm = MyFactory.getManager(be.getClass());
	    			
	    			//ɾ�����󻺴�
	    			bm.clearOmCache(be);
	    		}
	    	}
	    	
	    	throw ex;
	    }finally{
	    	//���ر�����session
	    	HashMap<String,BaseManager> map = localManager.get();
	    	if(map!=null){
	    		Iterator<String> it = map.keySet().iterator();
	    		while(it.hasNext()){
	    			BaseManager bm = map.get(it.next().toString());
	    			try{
	    				bm.closeSession();
	    			}catch(Exception e123){
	    				e123.printStackTrace();
	    			}
	    		}
	    	}
	    	
	    	//������commit�˻���rollback�ˣ�������̱߳���������ж���
	    	localManager.remove();
	    	localEntity.remove();
	    }
	}
	
	/**
	 * ��manager����ThreadLocal�У�����ͳһ�ύ�ͻع�
	 * @param bm BaseManager
	 */
	public static void addManager(BaseManager bm){
		HashMap<String,BaseManager> map = localManager.get();
		if(map==null){
			map = new HashMap<String,BaseManager>();
			localManager.set(map);
		}else if(map.containsKey(bm.getHibernateFile())){
			return;
		}
		//ÿ��hibernate�ļ���Ӧһ���⣬ֻҪ����һ�����񼴿�
		map.put(bm.getHibernateFile(), bm);
		bm.beginTransaction();
	}
	
	/**
	 * ��manager���������bean�����̱߳����������ύʱ�����Ӧ����
	 * @param be BaseEntity
	 */
	public static void addBean(BaseEntity be){
		ArrayList<BaseEntity> list = localEntity.get();
		if(list==null){
			list = new ArrayList<BaseEntity>();
			localEntity.set(list);
		}
		list.add(be);
	}
}
