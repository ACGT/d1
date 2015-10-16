package com.d1.dbcache.core;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.danga.MemCached.MemCachedClient;

/**
 * 数据库操作的基本工具类，提供了增删改查的基本方法，实现了分布式缓存和事务。可以轻易扩种到多台应用服务器！<br/>
 * 分布式缓存采用memcached来实现，列表缓存和对象缓存思路不一样，要特别注意。<br/>
 * 要实现事务包装也很简单，写一个XxService，然后通过<br/>
 * XxService xs = (XxService)MyFactory.getService(XxService.class)创建出来，不能自己new出来用！！！<br/>
 * XxService里的方法不要在操作了数据库后return，如果需要结束操作，用抛出异常来结束方法！！！<br/>
 * 那么XxService里的所有方法都实现了事务包装，这种方式支持分布式事务。注意，XxService里面只能BaseManager里tx开头的数据库操作方法！<br/>
 * 为了防止并发修改产生覆盖，根据特定的情况用分布式锁zookeeper实现<br/>
 * 如果开启分布式缓存，注意，每次get出来的对象不是同一个句柄，这个和本地缓存不一样，修改时要注意！！！！！！！<br/>
 * 事务操作方法，或者说tx开头的方法没有用缓存，但是事务提交后，对应的缓存和列表缓存会自动清除，保证其他缓存读取依然正确，并且只能读到提交后的数据。<br/>
 * @author kk
 * @version 5.0
 */
public class BaseManager {
	
	/**
	 * 记录日志的logger，记录数据的变化，log4j配置中必须包含一个dblogger
	 */
	protected static Logger logger = MyLoggerUtil.getDbLogger();
	
	/**
	 * hibernate配置文件，通过配置不同的hibernate文件可以实现数据库的按表拆分，只能通过db-cache-managers.xml配置，不能修改！
	 */
	protected String hibernateFile ;
	
	/**
	 * bean class，对应的hibernate类，不同的bean有不同的manager来管理数据库，只能通过db-cache-managers.xml配置，不能修改！
	 */
	protected Class<?> beanClass = null ;
	
	/**
	 * 二级散列缓存的字段列表，只能通过db-cache-managers.xml配置，不能修改！
	 */
	protected String[] hashFields = null ;
	
	/**
	 * 用于存放所有该manager管理om的对象缓存 key=value,key都是Long对象,value是BaseRecord对象
	 */
	protected Map<String,BaseEntity> RECORDS_CACHE = Collections.synchronizedMap(new MyLruCache<String,BaseEntity>(50000));
	
	/**
	 * 公用列表的cache,key=value,key是字符串，value是id组成的List。
	 */
	protected Map<String,List<String>> RECORDS_LIST_CACHE = Collections.synchronizedMap(new MyLruCache<String,List<String>>(1000));
	
	/**
	 * 用于存放recordset长度的cache，key=value,value存放Integer对象
	 */
	protected Map<String,Integer> RECORDS_LENGTH_CACHE = Collections.synchronizedMap(new MyLruCache<String,Integer>(1000));
	
	/**
	 * 二级缓存，根据applicationContext.xml指定的字段来做二级散列缓存。<br/>
	 * 这里的key是包含hashFieldsList里字段的string，value是一个java.util.HashMap<String,ArrayList>！！！<br/>
	 */
	protected Map<String,Map<String,List<String>>> HASH_LIST_CACHE = Collections.synchronizedMap(new MyLruCache<String,Map<String,List<String>>>(20000));
	
	/**
	 * 二级长度缓存，根据applicationContext.xml指定的字段来做二级缓存。<br/>
	 * 这里的key是包含hashFieldsList里字段的string，value是一个java.util.HashMap<String,Integer>！！！<br/>
	 */
	protected Map<String,Map<String,Integer>> HASH_LENGTH_CACHE = Collections.synchronizedMap(new MyLruCache<String,Map<String,Integer>>(20000));
	
	/**
	 * memcache 客户端，用于做分布式缓存
	 */
	protected static MemCachedClient memcachedClient = MyMemcachedUtil.getMemCachedClient() ;
	
	/**
	 * 只保留一个构造方法，免得参数被人修改！！！！！
	 * @param beanClass 该helper管理的class
	 * @param hibernateFile 对应的hibernate配置文件
	 * @param hashFieldsStr 散列字段，多个散列字段用分号隔开
	 */
	public BaseManager(Class<?> beanClass,String hibernateFile,String hashFieldsStr){
		this.beanClass = beanClass;
		this.hibernateFile = hibernateFile;
		
		if(hashFieldsStr!=null&&hashFieldsStr.length()>0){
			this.hashFields = hashFieldsStr.split(";");
		}
	}
	
	/**
	 * 得到Hibernate配置文件名，同一个配置文件连同一个数据库
	 * @return
	 */
	public String getHibernateFile(){
		return this.hibernateFile;
	}
	
	/**
	 * 从数据库把所有数据一次性读入到缓存，系统初始化的时候调用，其他地方别调用！！！
	 */
	public void loadAllData(){
		org.hibernate.Session s = null ;
		try{
			s = MyHibernateUtil.currentSession(this.hibernateFile);
			System.out.println("读取全部数据"+beanClass.getName()+"开始...");
			@SuppressWarnings("rawtypes")
			List list = s.createCriteria(beanClass).setFirstResult(0).setMaxResults(50000).list();
			int count = 0 ;
			if(list!=null&&list.size()>0){
				count = list.size();
				for(int i=0;i<list.size();i++){
					BaseEntity b = (BaseEntity)list.get(i);
					this.RECORDS_CACHE.put(b.getId(), b);
				}
			}
			
			System.out.println("读取全部数据"+beanClass.getName()+"完成!!!总长度="+count);
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			MyHibernateUtil.closeSession(this.hibernateFile);
		}
	}
	
	/**
	 * 检查该manager是不是操作了其他的bean
	 * @param record
	 * @throws MyException
	 */
	private void checkBeanClass(BaseEntity record) throws MyException{
		if(!record.getClass().getName().equals(beanClass.getName())){
			throw new MyException("本manager不支持对"+record.getClass().getName()+"的操作， 期待"+beanClass.getName());
		}
	}
	
	/**
	 * 返回散列fields
	 * @return
	 */
	public String[] getHashFields(){
		return this.hashFields;
	}
	
	/**
	 * 事务方法，仅供Service调用，根据id找对象
	 * @param id 对象的id
	 * @return  BaseEntity
	 * @throws HibernateException
	 */
	public BaseEntity txGet(String id) throws HibernateException {
	    //直接从数据库中查找....
		if(isNull(id))return null ;
		
		//如果缓存里有，直接返回
		if(MyConfig.enableLocalCache()){
			if(RECORDS_CACHE.containsKey(id)){
				BaseEntity br = RECORDS_CACHE.get(id);
				return br;
			}
		}else{
			String key = getBeanVersion()+beanClass.getName()+"#"+id ;//memcached 对象的key
			if(memcachedClient!=null){
				if(memcachedClient.keyExists(key)){
					Object ret = memcachedClient.get(key);
					return (BaseEntity)ret;
				}
			}
		}
		
		//把manager放入线程变量，便于统一提交、回滚和closeSession
		MyInterceptor.addManager(this);
		
	    Session s = currentSession();
	    BaseEntity br = (BaseEntity)s.get(beanClass, id);
	    
		return br;
	}
	
	/**
	 * 得到当前version，修改版本相当于清除改class所有缓存，bean的版本<br/>
	 * 在db-cache-conf.properties配置文件中配置！分布式缓存清除某个表的缓存时需要。<br/>
	 * 不是分布式缓存，调用clearAllLocalCache方法即可清除所有本地缓存。<br/>
	 * @return 版本号,在db-cache-conf.properties中配置
	 */
	protected String getBeanVersion(){
		return MyConfig.getBeanVersion(beanClass.getName());
	}
	
	/**
	 * 根据id获取对象，若启用分布式缓存，每次get出来的不是同一个实例，这和本地缓存不一样，要注意，特别在修改时！！！<br/>
	 * 第一步：先从缓存中获取；<br/>
	 * 第二步：如果缓存中没有就从数据库中获取；<br/>
	 * 第三步：把从数据库读出的对象放入缓存中；<br/>
	 * memcached缓存中存key是类名和id拼起来的字符串，避免和其他bean的id冲突。<br/>
	 * @param id 记录的id
	 * @return BaseEntity 对象
	 * @throws HibernateException
	 */
	public BaseEntity get(String id) throws HibernateException {

		if(isNull(id))return null ;
		
		BaseEntity br = null;
		
		//第一步：去缓存中查找
		if(MyConfig.enableLocalCache()){
			if(RECORDS_CACHE.containsKey(id)){
				br = RECORDS_CACHE.get(id);
				return br;
			}
		}else{
			String key = getBeanVersion()+beanClass.getName()+"#"+id ;//memcached 对象的key
			if(memcachedClient!=null){
				if(memcachedClient.keyExists(key)){
					Object ret = memcachedClient.get(key);
					return (BaseEntity)ret;
				}
			}
		}
    	
	    //第二步：从数据库中查找
	    Session s = null ;
	    try {
	    	s = currentSession() ;
	    	br = (BaseEntity)s.get(beanClass, id);
		}catch(HibernateException he){
	       	throw he;
		}finally{
	       	closeSession();
		}
	       
	    //第三步：把对象放入缓存中
    	if(MyConfig.enableLocalCache()){
    		RECORDS_CACHE.put(id, br);
    	}else{
    		String key = getBeanVersion()+beanClass.getName()+"#"+id ;//memcached 对象的key
    		if(memcachedClient!=null){
    			memcachedClient.set(key,
    					br,new java.util.Date(MyConfig.getMemCachedExpire()));
    		}
    	}

		return br;
	}
	
	/**
	 * 直接从数据库读取对象，不走缓存！某些特定的场合需要用到！
	 * @param id
	 * @return
	 * @throws HibernateException
	 */
	public BaseEntity getWithoutCache(String id) throws HibernateException {

		if(isNull(id))return null ;
		
		BaseEntity br = null;
		
	    //直接从数据库中查找
	    Session s = null ;
	    try {
	    	s = currentSession() ;
	    	br = (BaseEntity)s.get(beanClass, id);
		}catch(HibernateException he){
	       	throw he;
		}finally{
	       	closeSession();
		}
	       
	    return br;
	}
	
	/**
	 * 根据某一个字段的值来获取对象，这个字段应该是唯一的，也就是只返回一行。比如根据手机号查询用户。<br/>
	 * @param fieldName 字段对应的属性名，不是表的字段名，注意！
	 * @param value 属性的值，注意value的类型必须和bean对应，Long就是Long，String就是String！
	 * @return BaseEntity 返回对象
	 * @throws HibernateException
	 */
	public BaseEntity findByProperty(String fieldName,Object value) throws HibernateException {
		
		ArrayList<SimpleExpression> list = new ArrayList<SimpleExpression>();
		list.add(Restrictions.eq(fieldName,value));
		
		List<BaseEntity> list2 = getList(list, null, 0, 1);
		if(list2==null || list2.size()==0) return null;
		return list2.get(0);
	}
	
	/**
	 * 根据属性获取一个记录，供事务使用。直接读数据库。
	 * @param fieldName 字段对应的属性名
	 * @param value 属性的值，注意value的类型必须和bean对应，Long就是Long，String就是String
	 * @return BaseEntity
	 * @throws HibernateException
	 */
	public BaseEntity txFindByProperty(String fieldName,Object value) throws HibernateException {
		
		ArrayList<SimpleExpression> list = new ArrayList<SimpleExpression>(1);
		list.add(Restrictions.eq(fieldName,value));
		
		List<BaseEntity> list2 = txGetList(list, null, 0, 1);
		if(list2==null || list2.size()==0) return null;
		return list2.get(0);
	}
	
	/**
	 * 根据id从数据库中删除数据
	 * @param id 数据库行的id
	 * @return boolean 
	 * @throws HibernateException
	 */
	public boolean delete(String id) throws HibernateException {
		if(isNull(id))return false ;
		BaseEntity b = get(id);
		return delete(b);
	}
	
	/**
	 * 从数据库中删除数据，并从缓存中也删除
	 * @param br BaseEntity 要删除的对象
	 * @return boolean
	 * @throws HibernateException
	 */
	public boolean delete(BaseEntity br) throws HibernateException , MyException {

		if(br==null||br.getId()==null||get(br.getId())==null){
			return false;
		}
		
		checkBeanClass(br);
		
		String id = br.getId();
		boolean ret = true;
				
		//第一步：从数据库删除
		Session s = null ;
		Transaction tx = null ;
		try {
			s = currentSession();
			tx = s.beginTransaction();
			s.delete(br);
			tx.commit();
		} catch (HibernateException e) {
			if(tx!=null)tx.rollback();
			throw e;
		} finally {
			closeSession();
		}
		
		//第二步：从缓存中删除
        if(MyConfig.enableLocalCache()){
        	RECORDS_CACHE.remove(br.getId());
        }else{
        	String key = getBeanVersion()+beanClass.getName()+"#"+id ;//memcached 对象的key
        	if(memcachedClient!=null)memcachedClient.delete(key);
        }

		//第三步：删除列表缓存，让缓存相关的列表缓存失效
        clearListCache(br);
		
        return ret;
	}
	
	/**
	 * 删除对象，不提交，供事务中使用！
	 * @param br 记录
	 * @return 成功返回true
	 * @throws HibernateException
	 */
	public boolean txDelete(BaseEntity br) throws HibernateException ,MyException {
		if(br==null){
			return false;
		}
		
		checkBeanClass(br);
		
		//把manager放入线程变量，便于统一提交、回滚和closeSession
		MyInterceptor.addManager(this);
		
		boolean ret = true;
		
		//从数据库删除
		currentSession().delete(br);
       
        //把删除的对象放入线程变量，便于统一删除缓存
		MyInterceptor.addBean(br);
	    
        return ret;
	}
	
	/**
	 * 通过sql修改对象，修改后自己要知道清除什么对象和缓存，否者别用！！！！！<br/>
	 * 用sql修改是防止并发的时候数据错误，比如修改库存，如果用update sku set stock=stock-1即使并发也不会错，<br/>
	 * 但是如果用s.setStock(s.getStock()-1)，并发时数据可能会出错。尤其前后台没有统一锁的情况！<br/>
	 * 这个方法是tx开头的方法，只能在Service中用！！！<br/>
	 * @param sql 普通的udpate sql
	 */
	public void txUpdateViaSql(String sql)throws HibernateException{
		currentSession().createSQLQuery(sql).executeUpdate();
	}
	
	/**
	 * 更新一个数据库对象。注意clearListCache参数，true表示需要清除列表缓存，false表示不需要。<br/>
	 * 1：凡是修改的字段影响一个排序，如把一个帖子置顶，clearListCache必须为true；<br/>
	 * 2：若修改不影响任何排序，比如修改商品的标题，clearListCache为false，表示不清列表缓存，提高缓存命中率；<br/>
	 * 3：若修改影响两个排序，比如审核帖子，帖子的state由0变为1，那么在setState之前还要调用一次clearListCache()方法，clearListCache用true，相当于清两次列表缓存。<br/>
	 * @param record 要更新的对象,
	 * @param clearListCache true表示需要清除列表缓存，false表示不需要
	 * @return boolean
	 * @throws HibernateException
	 */
	public boolean update(BaseEntity record,boolean clearListCache) throws HibernateException ,MyException {		
		if(record==null||record.getId()==null){
			return false;
		}
		
		checkBeanClass(record);

        //第一步：修改数据库
		Session s = null ;
        Transaction tx = null;
        try {
        	s = currentSession();
        	tx = s.beginTransaction();
        	s.update(record);
        	tx.commit();
        } catch (HibernateException e) {
        	//如果修改数据库抛出异常，要清除本地对象缓存
        	if(MyConfig.enableLocalCache()){
        		RECORDS_CACHE.remove(record.getId());
        	}
        	if(tx!=null)tx.rollback();
        	throw e;
        } finally {
        	closeSession();
        }
	       
	    //第二步：更新memcached中的记录，本地缓存不需要更新，因为都是同一个对象
	    if(!MyConfig.enableLocalCache()){
	    	String key = getBeanVersion()+beanClass.getName()+"#"+record.getId() ;//memcached 对象的key
    		if(memcachedClient!=null){
    			memcachedClient.set(key,
    					record,new java.util.Date(MyConfig.getMemCachedExpire()));
    		}
	    }
		       
		//第三步：删除缓存列表缓存，让对应的列表失效
		if(clearListCache){
		  	clearListCache(record);
		}
        
        return true ;
	}
	
	/**
	 * 修改一个对象若要想两个排序，比如state从0修改到1，那么set值之前要调用这个方法，方便最后提交的时候清除缓存<br/>
	 * 这个方法专门给Service用的，若是非事务方法，修改之前直接调用clearListCache方法！！！！！！！<br/>
	 * @param bt
	 */
	public void txBeforeUpdate(BaseEntity bt) throws MyException{
		//这个地方必须clone一个对象出来，保存修改之前的值
		checkBeanClass(bt);
		MyInterceptor.addBean((BaseEntity)bt.clone());
	}
	
	/**
	 * 修改不提交，给Service用的方法
	 * @param record 记录
	 * @return 修改成功返回true
	 * @throws HibernateException
	 */
	public boolean txUpdate(BaseEntity record,boolean clearListCache) throws HibernateException ,MyException {		
		if(record==null){
			return false;
		}
		
		checkBeanClass(record);
		
		//把manager放入线程变量，便于统一、回滚和closeSession
		MyInterceptor.addManager(this);
		
       	//修改数据库       	
      	currentSession().update(record);
        
 	    //把修改的对象也放入线程变量，便于统一删除缓存
        MyInterceptor.addBean(record);
 	    
        return true ;
	}
	
	/**
	 * 创建一个数据库记录，并把对象放入缓存。
	 * @param record BaseEntity
	 * @return BaseEntity 返回数据库中的对象，
	 * @throws HibernateException
	 */
	public BaseEntity create(BaseEntity record) throws HibernateException , MyException {
		
		checkBeanClass(record);
		
		//第一步：在数据库中创建记录
		Session s = null ;
		Transaction tx= null ;
		try{
			s = currentSession();
			tx = s.beginTransaction();
			s.save(record);
			tx.commit();
		} catch (HibernateException e) {
			if(tx!=null)tx.rollback();
			throw e;
		} finally {
			closeSession();
		}
		
		//第二步：把对象放入缓存中
		if(MyConfig.enableLocalCache()){
			RECORDS_CACHE.put(record.getId(), record);
		}else{
			String key = getBeanVersion()+beanClass.getName()+"#"+record.getId() ;//memcached 对象的key
    		if(memcachedClient!=null){
    			memcachedClient.set(key,
    					record,new java.util.Date(MyConfig.getMemCachedExpire()));
    		}
		}
	
		//第三步：删除列表缓存
		clearListCache(record);

		return record;
	}
	
	/**
	 * 放在事务中创建！
	 * @param record 记录
	 * @return 创建的记录
	 * @throws HibernateException
	 */
	public BaseEntity txCreate(BaseEntity record) throws HibernateException , MyException {
		
		checkBeanClass(record);
		
		//把manager放入线程变量，便于统一、回滚和closeSession
		MyInterceptor.addManager(this);
		
		//在数据库中创建记录
		currentSession().save(record);
		
		//把创建的对象放入线程变量，便于统一删除缓存
		MyInterceptor.addBean(record);

		return record;
	}
	
	/**
	 * 返回一级缓存前缀，拼一个比较特殊的字符串，其他应用别乱设置这个key的值
	 * @return 很独特的一串字符
	 */
	protected String getFirstKeyName(){
		return "!@#"+beanClass.getName()+"!@#";
	}
	
	/**
	 * 直接从数据库查询list，不用缓存，一般不建议用，除非特殊需求
	 * @param expList 条件
	 * @param orders 排序
	 * @param start 开始位置
	 * @param length 获取长度
	 * @return 对象List
	 * @throws HibernateException
	 */
	@SuppressWarnings("unchecked")
	public List<BaseEntity> getListWithoutCache(List<SimpleExpression> expList,List<Order> orders,int start,int length) throws HibernateException {
		
		Session s = null ;
		try{
			s =  currentSession();
			//这个地方不是取id，而是直接select * from ...
			Criteria ct = s.createCriteria(beanClass);
			 
			if(expList!=null&&expList.size()>0){
				for(int i=0;i<expList.size();i++)
					ct.add(expList.get(i)); //加入查询条件
			}
			if(orders!=null&&orders.size()>0){
				for(int i=0;i<orders.size();i++)
					ct.addOrder(orders.get(i)); //加入排序字段
			}
			ct.setFirstResult(start).setMaxResults(length);
			 
			return (List<BaseEntity>)ct.list();
		} catch (HibernateException e) {
			throw e;
		} finally {
			closeSession();
		}
	}
	
	/**
	 * 在后台要获得统计数据时使用
	 * @param hql
	  * @param start 开始位置
	 * @param length 获取长度
	 * @return 对象List
	 * @throws HibernateException
	 */
	@SuppressWarnings("rawtypes")
	public List getListWithoutCache(String hql,int start,int length)throws HibernateException{
		if(hql==null||"".equals(hql))return null;
		Session s = null ;
		try{
			s = currentSession();
			Query query=s.createQuery(hql); 
			query.setFirstResult(start);
			query.setMaxResults(length);
			return query.list();  
		} catch (HibernateException e) {
			throw e;
		} finally {
			closeSession();
		}
	}
	
	/**
	 * 事务中使用的方法，获取列表。直接读数据库。
	 * @param expList 条件
	 * @param orders 排序
	 * @param start 开始位置
	 * @param length 获取长度
	 * @return list
	 * @throws HibernateException
	 */
	@SuppressWarnings("unchecked")
	public List<BaseEntity> txGetList(List<SimpleExpression> expList,List<Order> orders,int start,int length) throws HibernateException {
		 //把manager放入线程变量，便于统一、回滚和closeSession
		 MyInterceptor.addManager(this);
		
		 //这个地方不是取id，而是直接select * from ...
		 Criteria ct = currentSession().createCriteria(beanClass);
		 
		 if(expList!=null&&expList.size()>0){
			 for(int i=0;i<expList.size();i++)
			 ct.add(expList.get(i)); //加入查询条件
		 }
		 if(orders!=null&&orders.size()>0){
			 for(int i=0;i<orders.size();i++)
				 ct.addOrder(orders.get(i)); //加入排序字段
		 }
		 ct.setFirstResult(start).setMaxResults(length);
		 
		 return (List<BaseEntity>)ct.list();
	}
	
	/**
	 * 获取列表，先获取id列表，然后获取对象，有缓存的直接从缓存中读取。<br/>
	 * 每个表必须有id这个字段，并且比如是主键！每个类必须有id这个field。自定义条件查询列表,特别注意列表缓存key的拼法！！！！！<br>
	 * 在memcached缓存上存的则不是List而是由分号分开的id列表，如：13;14;25;256;887;987;<br/>
	 * key是象s10l20,createTime desc$age<90#age>80#userId=12343#这样的字符串，最后拼成md5串<br>
	 * @param expList 查询条件
	 * @param orders 排序条件
	 * @param start 开始位置
	 * @param length 获取长度
	 * @return List 数据库记录，里面放的是抽象的BaseEntity对象，可以转换成对应的对象
	 * @throws HibernateException
	 */
	@SuppressWarnings("unchecked")
	public List<BaseEntity> getList(List<SimpleExpression> expList,List<Order> orders,int start,int length) throws HibernateException {
		List<String> fList = new ArrayList<String>();//field set
		if(expList!=null){
			for(int i=0;i<expList.size();i++){
				SimpleExpression s1 = (SimpleExpression)expList.get(i);
				fList.add(s1.toString());
			}
		}
		Collections.sort(fList);//排序是为了让一样的条件组可以得到同一个key
		StringBuffer keyBuffer = new StringBuffer();
		
		//加入classname，免得和其他表的查询字段冲突
		keyBuffer.append(beanClass.getName()).append("$");
		
		keyBuffer.append("s").append(start).append("l").append(length).append(",");
		
		if(orders!=null){
			for(int i=0;i<orders.size();i++){
				keyBuffer.append(orders.get(i).toString()).append(",");
			}
		}
		//注意，$之前的字符都不需要参与到清除缓存的计算，清除缓存只需要计算$后面的条件！！！
		keyBuffer.append("$");
		
		//二级缓存的key,如userId=78998
		String secondaryCacheKey = null ;
		
		for(int i=0;i<fList.size();i++){
			String condition = (String)fList.get(i);
			keyBuffer.append(condition).append(",");
		}
		
		if(hashFields!=null&&hashFields.length>0){
			for(int j=0;j<hashFields.length;j++){
				if(secondaryCacheKey==null){
					for(int i=0;i<fList.size();i++){
						String condition = (String)fList.get(i);
						if(condition.startsWith(hashFields[j]+"=")){//条件包含二级缓存的字段则用二级缓存
							secondaryCacheKey=condition;//userId=78998
							break;
						}
					}
				}else{
					break;
				}
			}//end for
		}
		
		String key = keyBuffer.toString() ;//这就是列表的缓存key
		
		try {
			//转一下可以避免中文md5的问题
			key = java.net.URLEncoder.encode(key,"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		key = MyMd5Util.toMD5(key);//md5加密一下可以减小长度，节省网路传输时间
		
		//第一步：从缓存中查找
		if(MyConfig.enableLocalCache()){
			if(secondaryCacheKey==null){//从公用缓存中查找
				if(RECORDS_LIST_CACHE.containsKey(key)){
					List<String> list = RECORDS_LIST_CACHE.get(key);//id List
					ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
					for(int i=0;i<list.size();i++){
						BaseEntity br = get(list.get(i)+"");
						if(br!=null)oList.add(br);
					}
					return oList;
				}
			}else{//从二级散列缓存种查找
				Map<String,List<String>> secondaryMap = HASH_LIST_CACHE.get(secondaryCacheKey);
				if(secondaryMap!=null&&secondaryMap.containsKey(key)){//二级散列缓存里面找到了
					List<String> list = secondaryMap.get(key);
					ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
					for(int i=0;i<list.size();i++){
						BaseEntity br = get(list.get(i)+"");
						if(br!=null)oList.add(br);
					}
					return oList;
				}
			}
		}else{
			if(secondaryCacheKey==null){
				//从一级缓存中查找
				String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
				
				if(firstKeyPrefix!=null&&firstKeyPrefix.length()>0){
					String resultKeys = (String)memcachedClient.get(getBeanVersion()+firstKeyPrefix+"#"+key);
					if(resultKeys!=null){
						String[] resultKeysArray = resultKeys.split(";");
						ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
						if(resultKeysArray!=null&&resultKeysArray.length>0){
							for(int i=0;i<resultKeysArray.length;i++){
								BaseEntity br = get(resultKeysArray[i]);
								if(br!=null)oList.add(br);
							}
						}
						return oList;
					}
				}
			}else{
				//从二级散列缓存中查找,注意key的变化
				String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//二级key的前缀
			
				if(secondKeyPrefix!=null&&secondKeyPrefix.length()>0){
					//把prefix拼在前面...
					String resultKeys = (String)memcachedClient.get(getBeanVersion()+secondKeyPrefix+"#"+key);
					if(resultKeys!=null){
						String[] resultKeysArray = resultKeys.split(";");
						ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
						if(resultKeysArray!=null&&resultKeysArray.length>0){
							for(int i=0;i<resultKeysArray.length;i++){
								BaseEntity br = get(resultKeysArray[i]);
								if(br!=null)oList.add(br);
							}
						}
						return oList;
					}
				}
			}
		}
		
		Session s = null ;
		try{
			 s = currentSession();
			 //第二步 从数据库中查找，这个地方是取id，select id from ...，先取id，然后取对象
			 Criteria ct = s.createCriteria(beanClass).setProjection(Projections.property("id"));
			
			 if(expList!=null&&expList.size()>0){
				for(int i=0;i<expList.size();i++)
					ct.add(expList.get(i)); //加入查询条件
			 }
			 if(orders!=null&&orders.size()>0){
				 for(int i=0;i<orders.size();i++)
					 ct.addOrder(orders.get(i)); //加入排序字段
			 }
			 ct.setFirstResult(start).setMaxResults(length);
			 
			 List<String> list = (List<String>)ct.list();
			 
			 if(MyConfig.enableLocalCache()){
				 if(secondaryCacheKey==null){
					 RECORDS_LIST_CACHE.put(key, list);//放入List缓存...
				 }else{
					 Map<String,List<String>> secondaryMap = HASH_LIST_CACHE.get(secondaryCacheKey);
					 if(secondaryMap!=null){//放入二级散列缓存
						 secondaryMap.put(key, list);
					 }else{
						 secondaryMap = Collections.synchronizedMap(new HashMap<String,List<String>>());
						 secondaryMap.put(key, list);
						 HASH_LIST_CACHE.put(secondaryCacheKey, secondaryMap);
					 }
				 }
			 }else{
				 if(secondaryCacheKey==null){
					 //把id列表放入memcached中
					 String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
					 
					 if(firstKeyPrefix==null||firstKeyPrefix.length()==0){
						 //拼一个一级缓存前缀
						 firstKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());					 
						 //放入前缀
						 memcachedClient.set(getBeanVersion()+getFirstKeyName(),firstKeyPrefix);	
					 }
					 //放入查询结果
					 memcachedClient.set(getBeanVersion()+firstKeyPrefix+"#"+key, list2String(list));
				 }else{
					 String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//二级key的前缀
					 
					 if(secondKeyPrefix==null||secondKeyPrefix.length()==0){
						 //重新拼一个二级散列key
						 secondKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());	 
						 //放入前缀
						 memcachedClient.set(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey,secondKeyPrefix);
					 }
					 //然后把id列表放入缓存中，注意key的变化
					 memcachedClient.set(getBeanVersion()+secondKeyPrefix+"#"+key,list2String(list));				 
				 }
			 }
			 
			 ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
			 for(int i=0;i<list.size();i++){
				 BaseEntity br = get(list.get(i)+"");
				 if(br!=null)oList.add(br);
			 }
			 return oList;
		} catch (HibernateException e) {
			throw e;
		} finally{
			closeSession();
		}
	}
	
	public List<BaseEntity> getListCriterion(List<Criterion> expList,List<Order> orders,int start,int length) throws HibernateException {
		List<String> fList = new ArrayList<String>();//field set
		if(expList!=null){
			for(int i=0;i<expList.size();i++){
				Criterion s1 = (Criterion)expList.get(i);
				fList.add(s1.toString());
			}
		}
		Collections.sort(fList);//排序是为了让一样的条件组可以得到同一个key
		StringBuffer keyBuffer = new StringBuffer();
		
		//加入classname，免得和其他表的查询字段冲突
		keyBuffer.append(beanClass.getName()).append("$");
		
		keyBuffer.append("s").append(start).append("l").append(length).append(",");
		
		if(orders!=null){
			for(int i=0;i<orders.size();i++){
				keyBuffer.append(orders.get(i).toString()).append(",");
			}
		}
		//注意，$之前的字符都不需要参与到清除缓存的计算，清除缓存只需要计算$后面的条件！！！
		keyBuffer.append("$");
		
		//二级缓存的key,如userId=78998
		String secondaryCacheKey = null ;
		
		for(int i=0;i<fList.size();i++){
			String condition = (String)fList.get(i);
			keyBuffer.append(condition).append(",");
		}
		
		if(hashFields!=null&&hashFields.length>0){
			for(int j=0;j<hashFields.length;j++){
				if(secondaryCacheKey==null){
					for(int i=0;i<fList.size();i++){
						String condition = (String)fList.get(i);
						if(condition.startsWith(hashFields[j]+"=")){//条件包含二级缓存的字段则用二级缓存
							secondaryCacheKey=condition;//userId=78998
							break;
						}
					}
				}else{
					break;
				}
			}//end for
		}
		
		String key = keyBuffer.toString() ;//这就是列表的缓存key
		
		try {
			//转一下可以避免中文md5的问题
			key = java.net.URLEncoder.encode(key,"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		key = MyMd5Util.toMD5(key);//md5加密一下可以减小长度，节省网路传输时间
		
		//第一步：从缓存中查找
		if(MyConfig.enableLocalCache()){
			if(secondaryCacheKey==null){//从公用缓存中查找
				if(RECORDS_LIST_CACHE.containsKey(key)){
					List<String> list = RECORDS_LIST_CACHE.get(key);//id List
					ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
					for(int i=0;i<list.size();i++){
						BaseEntity br = get(list.get(i)+"");
						if(br!=null)oList.add(br);
					}
					return oList;
				}
			}else{//从二级散列缓存种查找
				Map<String,List<String>> secondaryMap = HASH_LIST_CACHE.get(secondaryCacheKey);
				if(secondaryMap!=null&&secondaryMap.containsKey(key)){//二级散列缓存里面找到了
					List<String> list = secondaryMap.get(key);
					ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
					for(int i=0;i<list.size();i++){
						BaseEntity br = get(list.get(i)+"");
						if(br!=null)oList.add(br);
					}
					return oList;
				}
			}
		}else{
			if(secondaryCacheKey==null){
				//从一级缓存中查找
				String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
				
				if(firstKeyPrefix!=null&&firstKeyPrefix.length()>0){
					String resultKeys = (String)memcachedClient.get(getBeanVersion()+firstKeyPrefix+"#"+key);
					if(resultKeys!=null){
						String[] resultKeysArray = resultKeys.split(";");
						ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
						if(resultKeysArray!=null&&resultKeysArray.length>0){
							for(int i=0;i<resultKeysArray.length;i++){
								BaseEntity br = get(resultKeysArray[i]);
								if(br!=null)oList.add(br);
							}
						}
						return oList;
					}
				}
			}else{
				//从二级散列缓存中查找,注意key的变化
				String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//二级key的前缀
			
				if(secondKeyPrefix!=null&&secondKeyPrefix.length()>0){
					//把prefix拼在前面...
					String resultKeys = (String)memcachedClient.get(getBeanVersion()+secondKeyPrefix+"#"+key);
					if(resultKeys!=null){
						String[] resultKeysArray = resultKeys.split(";");
						ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
						if(resultKeysArray!=null&&resultKeysArray.length>0){
							for(int i=0;i<resultKeysArray.length;i++){
								BaseEntity br = get(resultKeysArray[i]);
								if(br!=null)oList.add(br);
							}
						}
						return oList;
					}
				}
			}
		}
		
		Session s = null ;
		try{
			 s = currentSession();
			 //第二步 从数据库中查找，这个地方是取id，select id from ...，先取id，然后取对象
			 Criteria ct = s.createCriteria(beanClass).setProjection(Projections.property("id"));
			
			 if(expList!=null&&expList.size()>0){
				for(int i=0;i<expList.size();i++)
					ct.add(expList.get(i)); //加入查询条件
			 }
			 if(orders!=null&&orders.size()>0){
				 for(int i=0;i<orders.size();i++)
					 ct.addOrder(orders.get(i)); //加入排序字段
			 }
			 ct.setFirstResult(start).setMaxResults(length);
			 
			 List<String> list = (List<String>)ct.list();
			 
			 if(MyConfig.enableLocalCache()){
				 if(secondaryCacheKey==null){
					 RECORDS_LIST_CACHE.put(key, list);//放入List缓存...
				 }else{
					 Map<String,List<String>> secondaryMap = HASH_LIST_CACHE.get(secondaryCacheKey);
					 if(secondaryMap!=null){//放入二级散列缓存
						 secondaryMap.put(key, list);
					 }else{
						 secondaryMap = Collections.synchronizedMap(new HashMap<String,List<String>>());
						 secondaryMap.put(key, list);
						 HASH_LIST_CACHE.put(secondaryCacheKey, secondaryMap);
					 }
				 }
			 }else{
				 if(secondaryCacheKey==null){
					 //把id列表放入memcached中
					 String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
					 
					 if(firstKeyPrefix==null||firstKeyPrefix.length()==0){
						 //拼一个一级缓存前缀
						 firstKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());					 
						 //放入前缀
						 memcachedClient.set(getBeanVersion()+getFirstKeyName(),firstKeyPrefix);	
					 }
					 //放入查询结果
					 memcachedClient.set(getBeanVersion()+firstKeyPrefix+"#"+key, list2String(list));
				 }else{
					 String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//二级key的前缀
					 
					 if(secondKeyPrefix==null||secondKeyPrefix.length()==0){
						 //重新拼一个二级散列key
						 secondKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());	 
						 //放入前缀
						 memcachedClient.set(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey,secondKeyPrefix);
					 }
					 //然后把id列表放入缓存中，注意key的变化
					 memcachedClient.set(getBeanVersion()+secondKeyPrefix+"#"+key,list2String(list));				 
				 }
			 }
			 
			 ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
			 for(int i=0;i<list.size();i++){
				 BaseEntity br = get(list.get(i)+"");
				 if(br!=null)oList.add(br);
			 }
			 return oList;
		} catch (HibernateException e) {
			throw e;
		} finally{
			closeSession();
		}
	}
	
	/**
	 * 把list里面的id列表拼成以分好分割的字符串
	 * @param list
	 * @return 用分号隔开的字符串
	 */
	protected String list2String(List<String> list){
		//这里别返回null，空字符串不是null，存入memcached后可以减少数据库查询
		if(list==null)return ";";
		StringBuffer sb = new StringBuffer();
		sb.append(";");
		for(int i=0;i<list.size();i++){
			sb.append(list.get(i)).append(";");
		}
		return sb.toString();
	}
	
	/**
	 * 直接从数据库取长度，特殊场合使用，一般不用这个方法
	 * @param expList 条件
	 * @closeSession 是否关闭session
	 * @return 返回长度
	 * @throws HibernateException
	 */
	public int getLengthWithoutCache(List<SimpleExpression> expList) throws HibernateException {

		Session s = null ;
		try {
			s = currentSession();
			Criteria ct = s.createCriteria(beanClass).setProjection(Projections.rowCount());
			 
			if(expList!=null&&expList.size()>0){
				for(int i=0;i<expList.size();i++)
					ct.add(expList.get(i)); //加入查询条件
			}
			Long len = (Long)ct.uniqueResult();
			
			return (int)len.longValue();
		} catch (HibernateException e){
			throw e;
		}finally{
			closeSession();
		}
	}
	
	/**
	 * 后台有组合统计时候使用，只能用于统计长度！！！！！！
	 * @param hql
	 * @return
	 * @throws HibernateException
	 */
	@SuppressWarnings("rawtypes")
	public int getHqlLengthWithoutCache(String hql) throws HibernateException {
		if(hql==null||"".equals(hql))return 0;
		Session s = null ;
		try{
			s = currentSession();
			Query query=s.createQuery(hql); 
			List list=query.list();
			return list.size();  
		} catch (HibernateException e) {
			throw e;
		} finally {
			closeSession();
		}
	}
	
	/**
	 * 提供给事务方法
	 * @param expList 条件
	 * @return
	 * @throws HibernateException
	 */
	public int txGetLength(List<SimpleExpression> expList) throws HibernateException {
		//把manager放入线程变量，便于统一、回滚和closeSession
		MyInterceptor.addManager(this);
		
		Criteria ct = currentSession().createCriteria(beanClass).setProjection(Projections.rowCount());
		 
		if(expList!=null&&expList.size()>0){
			for(int i=0;i<expList.size();i++)
				ct.add(expList.get(i)); //加入查询条件
		}
		Long len = (Long)ct.uniqueResult();
		
		return (int)len.longValue();
	}
	
	/**
	 * 根据条件得到数据库记录的长度，Integer对象可以直接存在memcached缓存中，所以没有必要序列化！
	 * @param expList 查询条件
	 * @return 长度
	 */
	public int getLength(List<SimpleExpression> expList) throws HibernateException {
		List<String> fList = new ArrayList<String>();
		if(expList!=null){
			for(int i=0;i<expList.size();i++){
				SimpleExpression s1 = (SimpleExpression)expList.get(i);
				fList.add(s1.toString());
			}
		}
		Collections.sort(fList);
		StringBuffer keyBuffer = new StringBuffer();
		
		//加入class名，避免和其他class的key发生冲突，加入了一个%，避免和getList的key发生冲突
		keyBuffer.append(beanClass.getName()).append("%$");	
		
		//二级缓存的key,如userId=78998
		String secondaryCacheKey = null ;
		
		for(int i=0;i<fList.size();i++){
			String condition = (String)fList.get(i);
			keyBuffer.append(condition).append("#");
		}
		
		if(hashFields!=null&&hashFields.length>0){
			for(int j=0;j<hashFields.length;j++){
				if(secondaryCacheKey==null){
					for(int i=0;i<fList.size();i++){
						String condition = (String)fList.get(i);
						if(condition.startsWith(hashFields[j]+"=")){//条件包含二级缓存的字段则用二级缓存
							secondaryCacheKey=condition;
							break;
						}
					}
				}else{
					break;
				}
			}
		}
		
		String key = keyBuffer.toString();
		
		try {
			key = java.net.URLEncoder.encode(key,"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		key = MyMd5Util.toMD5(key);
		
		
		//第一步 从缓存里查找
		if(MyConfig.enableLocalCache()){
			if(secondaryCacheKey==null){//公用部分查找
				if(RECORDS_LENGTH_CACHE.containsKey(key)){
					Integer res = RECORDS_LENGTH_CACHE.get(key);//id List
					return res.intValue();
				}
			}else{//二级散列缓存查找
				Map<String,Integer> secondaryMap = HASH_LENGTH_CACHE.get(secondaryCacheKey);
				if(secondaryMap!=null&&secondaryMap.containsKey(key)){//在二级缓存里找到了
					Integer res = secondaryMap.get(key);
					return res.intValue();
				}
			}
		}else{
			if(secondaryCacheKey==null){//公用部分查找
				String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
				if(firstKeyPrefix!=null&&firstKeyPrefix.length()>0){
					String resultKeys = memcachedClient.get(getBeanVersion()+firstKeyPrefix+"#"+key)+"";
					if(resultKeys!=null){
						if(isDigits(resultKeys)){
							return Integer.parseInt(resultKeys);
						}
					}
				}
			}else{//二级散列缓存查找
				String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//二级key的前缀
				if(secondKeyPrefix!=null&&secondKeyPrefix.length()>0){
					String resultKeys = memcachedClient.get(getBeanVersion()+secondKeyPrefix+"#"+key)+"";
					if(resultKeys!=null){
						if(isDigits(resultKeys)){
							return Integer.parseInt(resultKeys);
						}
					}
				}
			}
		}
		

		//第二步 从数据库中获取
		int len = getLengthWithoutCache(expList);
			
		//注意：相同条件的查询长度和列表的key prefix是一样的
		if(MyConfig.enableLocalCache()){
			if(secondaryCacheKey==null){
				RECORDS_LENGTH_CACHE.put(key, new Integer(len));//放入List缓存
			}else{
				Map<String,Integer> secondaryMap = HASH_LENGTH_CACHE.get(secondaryCacheKey);
				if(secondaryMap!=null){
					secondaryMap.put(key, new Integer(len));
				}else{
					secondaryMap = Collections.synchronizedMap(new HashMap<String,Integer>());
					secondaryMap.put(key, new Integer(len));
					HASH_LENGTH_CACHE.put(secondaryCacheKey, secondaryMap);
				}
			}
		}else{
			if(secondaryCacheKey==null){
				String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
				
				if(firstKeyPrefix==null||firstKeyPrefix.length()==0){
					//拼一个前缀
					firstKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());
					//放入前缀
					memcachedClient.set(getBeanVersion()+getFirstKeyName(),firstKeyPrefix);
				}
				//放入结果
				memcachedClient.set(getBeanVersion()+firstKeyPrefix+"#"+key,len);
			}else{
				 String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//二级key的前缀
				 
				 if(secondKeyPrefix==null||secondKeyPrefix.length()==0){
					 //要重新拼一个二级散列key
					 secondKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random()); 
					 //放入前缀
					 memcachedClient.set(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey,secondKeyPrefix);
				 }
		 
			 	//然后把id列表放入缓存中，注意key的变化
			 	memcachedClient.set(getBeanVersion()+secondKeyPrefix+"#"+key,len);
			}
		}
			
		return len;
		
	}
	
	/**
	 * 删除对象缓存
	 * @param id
	 */
	public void clearOmCache(String id){
		if(MyConfig.enableLocalCache()){
        	RECORDS_CACHE.remove(id);
        }else{
        	memcachedClient.delete(getBeanVersion()+beanClass+"#"+id);
        }
	}

	/**
	 * 删除一个对象缓存
	 * @param be
	 */
	public void clearOmCache(BaseEntity be){
		if(MyConfig.enableLocalCache()){
        	RECORDS_CACHE.remove(be.getId());
        }else{
        	memcachedClient.delete(getBeanVersion()+beanClass+"#"+be.getId());
        }
	}
	
	/**
	 * 删除所有本地缓存！分布式时这个方法不管用！！！<br/>
	 * 分布式缓存若要删除一个bean的所有缓存需要修改bean版本<br/>
	 */
	public void clearAllLocalCache(){
		clearAllLocalOmCache();
		clearAllLocalListCache();
	}
	
	/**
	 * 清除所有本地列表缓存！
	 */
	public void clearAllLocalListCache(){
		RECORDS_LIST_CACHE.clear();
		RECORDS_LENGTH_CACHE.clear();
		HASH_LIST_CACHE.clear();
		HASH_LENGTH_CACHE.clear();
	}
	
	/**
	 * 删除所有本地对象缓存
	 */
	public void clearAllLocalOmCache(){
		RECORDS_CACHE.clear();
	}
	
	/**
	 * 清除列表缓存。<br/>
	 * 1：如果修改的字段影响了两种排序，典型的像state由0改为1，那么修改之前也要调用一下该方法。<br/>
	 * 2：如果修改了字段只影响一个排序，如修改了帖子的优先级，那么修改之前不要调用该方法，直接用update(BaseEntity,true)修改对象即可。<br/>
	 * 3：如果修改的字段不影响排序，典型的像修改物品的标题，那么用update(BaseEntity,false)即可,即不需要清除列表缓存。<br/>
	 * @param bt 操作的对象
	 */
	public void clearListCache(BaseEntity bt) throws MyException {
		
		if(bt==null)return;
		
		checkBeanClass(bt);
		
		HashMap<String, String> fieldMap = new HashMap<String, String>();
		
		//把对象的域值转换到一个hashmap里
		Object[] args = null ;
		Method[] ms = bt.getClass().getMethods();

		try{
			for(int i=0;i<ms.length;i++){
				if(ms[i].getName().startsWith("get")&&!ms[i].getName().equals("getClass")){
					String fieldName = ms[i].getName().substring(3);//3 是 get的长度
					fieldName = Character.toLowerCase(fieldName.charAt(0))+fieldName.substring(1);
					String fieldValue = ms[i].invoke(bt, args)+"" ;
					fieldMap.put(fieldName, fieldValue);
					
					//看看哪些域需要删除散列缓存
					if(hashFields!=null&&hashFields.length>0){
						for(int j=0;j<hashFields.length;j++){
							if(fieldName.equals(hashFields[j])){
								String secondaryKey = fieldName+"="+fieldValue ; 
								
								//重置二级列表缓存的前缀，相当于让原来的二级列表失效
								if(MyConfig.enableLocalCache()){
									HASH_LIST_CACHE.remove(secondaryKey);
									HASH_LENGTH_CACHE.remove(secondaryKey);
								}else{
									String prefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());
									memcachedClient.set(getBeanVersion()+beanClass.getName()+"#"+secondaryKey, prefix);
								}
							}
						}
					}
				}
			}//end for
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		if(MyConfig.enableLocalCache()){
			RECORDS_LENGTH_CACHE.clear();
			RECORDS_LIST_CACHE.clear();
		}else{
			String firstKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());
			//重置一级缓存前缀，相当于让全部一级列表缓存失效
			memcachedClient.set(getBeanVersion()+getFirstKeyName(),firstKeyPrefix);
		}
	}
	
	/**
	 * 开始事务
	 */
	public void beginTransaction(){
		Session s = currentSession();
		s.beginTransaction();
	}
	
	/**
	 * 提交事务
	 */
	public void commit(){
		Session s = currentSession();
		Transaction tx = s.getTransaction();
		tx.commit();
	}
	
	/**
	 * 回滚事务，并把该事务中记录的缓存对象也回滚，保证缓存和数据库一致
	 */
	public void rollback(){
		Session s = currentSession();
		Transaction tx = s.getTransaction();
		tx.rollback();
	}
	
	/**
	 * 当前线程的session
	 * @return Session
	 */
	public Session currentSession(){
		return MyHibernateUtil.currentSession(hibernateFile);
	}
	
	/**
	 * 关闭当前线程session，事务结束后必须调用这个方法
	 */
	public void closeSession(){
		MyHibernateUtil.closeSession(hibernateFile);
	}
	
	/**
	 * 判断一个字符串是不是数字组成
	 * @param s 字符。
	 * @return
	 */
	private static boolean isDigits(String s){
		if(s==null||s.length()==0)return false;
		s=s.startsWith("-")?s.substring(1):s;//判断是否是负数
		for(int i=0;i<s.length();i++){
			if(!Character.isDigit(s.charAt(i)))return false;
		}
		return true;
	}

	
	/**
	 * 是否是空
	 * @param str
	 * @return
	 */
	private static boolean isNull(String str){
		if(str == null || str.trim().length()==0) return true;
		return false;
	}
}
