package com.d1.dbcache.core;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import net.sf.cglib.proxy.MethodInterceptor;
import net.sf.cglib.proxy.MethodProxy;

/**
 * 超次轻量级事务拦截器，使用cglib做事务拦截！注意ThreadLocal用法，简单但很强大！<br/>
 * 已经实现了“分布式”事务，即全部同时提交或同时回滚，但不能保证100%都提交正确或回滚正确！<br/>
 * 所以尽量把有事务操作的关联表放在一个数据库服务器上。<br/>
 * @author kk
 *
 */
public class MyInterceptor implements MethodInterceptor{
	
	/**
	 * 一个线程下使用过的BaseManager集合，便于统一commit、rollback和closeSession
	 */
	private static ThreadLocal<HashMap<String,BaseManager>> localManager = new ThreadLocal<HashMap<String,BaseManager>>();
	
	/**
	 * thread local，记录增删改哪些bean，便于清除对应缓存
	 */
	private static ThreadLocal<ArrayList<BaseEntity>> localEntity = new ThreadLocal<ArrayList<BaseEntity>>();
	
	/**
	 * 事务拦截，没有遇到异常就全部提交，遇到异常则全部回滚，理论上支持分布式事务
	 */
	public Object intercept(Object obj, Method method, Object[] args, MethodProxy proxy) throws Throwable {
	    try{
	    	//调用对应Service方法.......
	    	Object res = proxy.invokeSuper(obj, args);
	    	
	    	//如果没有出异常则commit所有manager，万一某一个manager提交报错，其余的manager还会继续提交
	    	HashMap<String,BaseManager> map = localManager.get();
	    	if(map!=null){
	    		Iterator<String> it = map.keySet().iterator();
	    		while(it.hasNext()){
	    			BaseManager bm = map.get(it.next());
	    			bm.commit();
	    		}
	    	}
	    	
	    	//如果提交成功，应该清除对应对象缓存和列表缓存
	    	ArrayList<BaseEntity> list = localEntity.get();
	    	if(list!=null){
	    		for(int i=0;i<list.size();i++){
	    			BaseEntity be = list.get(i);
	    			BaseManager bm = MyFactory.getManager(be.getClass());
	    			
	    			//删除对象缓存和列表缓存，大不了再多读一次
	    			bm.clearOmCache(be);
	    			bm.clearListCache(be);
	    		}
	    	}
	    	
	    	return res;
	    	
	    }catch(Exception ex){
	    	//如果抛出异常则rollback所有manager，万一某个rollback错了，其他的也会继续rollback
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
	    	
	    	//如果提交失败，也就是有些对象在内存中修改了，数据库没有修改，那么应该清除本地对象缓存，但列表没有影响，无须清除
	    	ArrayList<BaseEntity> list = localEntity.get();
	    	if(list!=null){
	    		for(int i=0;i<list.size();i++){
	    			BaseEntity be = list.get(i);
	    			BaseManager bm = MyFactory.getManager(be.getClass());
	    			
	    			//删除对象缓存
	    			bm.clearOmCache(be);
	    		}
	    	}
	    	
	    	throw ex;
	    }finally{
	    	//最后关闭所有session
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
	    	
	    	//不管是commit了还是rollback了，都清除线程变量里的所有东西
	    	localManager.remove();
	    	localEntity.remove();
	    }
	}
	
	/**
	 * 把manager放入ThreadLocal中，便于统一提交和回滚
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
		//每个hibernate文件对应一个库，只要开启一个事务即可
		map.put(bm.getHibernateFile(), bm);
		bm.beginTransaction();
	}
	
	/**
	 * 把manager里操作过的bean放入线程变量，便于提交时清除对应缓存
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
