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
 * ���ݿ�����Ļ��������࣬�ṩ����ɾ�Ĳ�Ļ���������ʵ���˷ֲ�ʽ��������񡣿����������ֵ���̨Ӧ�÷�������<br/>
 * �ֲ�ʽ�������memcached��ʵ�֣��б���Ͷ��󻺴�˼·��һ����Ҫ�ر�ע�⡣<br/>
 * Ҫʵ�������װҲ�ܼ򵥣�дһ��XxService��Ȼ��ͨ��<br/>
 * XxService xs = (XxService)MyFactory.getService(XxService.class)���������������Լ�new�����ã�����<br/>
 * XxService��ķ�����Ҫ�ڲ��������ݿ��return�������Ҫ�������������׳��쳣����������������<br/>
 * ��ôXxService������з�����ʵ���������װ�����ַ�ʽ֧�ֲַ�ʽ����ע�⣬XxService����ֻ��BaseManager��tx��ͷ�����ݿ����������<br/>
 * Ϊ�˷�ֹ�����޸Ĳ������ǣ������ض�������÷ֲ�ʽ��zookeeperʵ��<br/>
 * ��������ֲ�ʽ���棬ע�⣬ÿ��get�����Ķ�����ͬһ�����������ͱ��ػ��治һ�����޸�ʱҪע�⣡������������<br/>
 * �����������������˵tx��ͷ�ķ���û���û��棬���������ύ�󣬶�Ӧ�Ļ�����б�����Զ��������֤���������ȡ��Ȼ��ȷ������ֻ�ܶ����ύ������ݡ�<br/>
 * @author kk
 * @version 5.0
 */
public class BaseManager {
	
	/**
	 * ��¼��־��logger����¼���ݵı仯��log4j�����б������һ��dblogger
	 */
	protected static Logger logger = MyLoggerUtil.getDbLogger();
	
	/**
	 * hibernate�����ļ���ͨ�����ò�ͬ��hibernate�ļ�����ʵ�����ݿ�İ����֣�ֻ��ͨ��db-cache-managers.xml���ã������޸ģ�
	 */
	protected String hibernateFile ;
	
	/**
	 * bean class����Ӧ��hibernate�࣬��ͬ��bean�в�ͬ��manager���������ݿ⣬ֻ��ͨ��db-cache-managers.xml���ã������޸ģ�
	 */
	protected Class<?> beanClass = null ;
	
	/**
	 * ����ɢ�л�����ֶ��б�ֻ��ͨ��db-cache-managers.xml���ã������޸ģ�
	 */
	protected String[] hashFields = null ;
	
	/**
	 * ���ڴ�����и�manager����om�Ķ��󻺴� key=value,key����Long����,value��BaseRecord����
	 */
	protected Map<String,BaseEntity> RECORDS_CACHE = Collections.synchronizedMap(new MyLruCache<String,BaseEntity>(50000));
	
	/**
	 * �����б��cache,key=value,key���ַ�����value��id��ɵ�List��
	 */
	protected Map<String,List<String>> RECORDS_LIST_CACHE = Collections.synchronizedMap(new MyLruCache<String,List<String>>(1000));
	
	/**
	 * ���ڴ��recordset���ȵ�cache��key=value,value���Integer����
	 */
	protected Map<String,Integer> RECORDS_LENGTH_CACHE = Collections.synchronizedMap(new MyLruCache<String,Integer>(1000));
	
	/**
	 * �������棬����applicationContext.xmlָ�����ֶ���������ɢ�л��档<br/>
	 * �����key�ǰ���hashFieldsList���ֶε�string��value��һ��java.util.HashMap<String,ArrayList>������<br/>
	 */
	protected Map<String,Map<String,List<String>>> HASH_LIST_CACHE = Collections.synchronizedMap(new MyLruCache<String,Map<String,List<String>>>(20000));
	
	/**
	 * �������Ȼ��棬����applicationContext.xmlָ�����ֶ������������档<br/>
	 * �����key�ǰ���hashFieldsList���ֶε�string��value��һ��java.util.HashMap<String,Integer>������<br/>
	 */
	protected Map<String,Map<String,Integer>> HASH_LENGTH_CACHE = Collections.synchronizedMap(new MyLruCache<String,Map<String,Integer>>(20000));
	
	/**
	 * memcache �ͻ��ˣ��������ֲ�ʽ����
	 */
	protected static MemCachedClient memcachedClient = MyMemcachedUtil.getMemCachedClient() ;
	
	/**
	 * ֻ����һ�����췽������ò��������޸ģ���������
	 * @param beanClass ��helper�����class
	 * @param hibernateFile ��Ӧ��hibernate�����ļ�
	 * @param hashFieldsStr ɢ���ֶΣ����ɢ���ֶ��÷ֺŸ���
	 */
	public BaseManager(Class<?> beanClass,String hibernateFile,String hashFieldsStr){
		this.beanClass = beanClass;
		this.hibernateFile = hibernateFile;
		
		if(hashFieldsStr!=null&&hashFieldsStr.length()>0){
			this.hashFields = hashFieldsStr.split(";");
		}
	}
	
	/**
	 * �õ�Hibernate�����ļ�����ͬһ�������ļ���ͬһ�����ݿ�
	 * @return
	 */
	public String getHibernateFile(){
		return this.hibernateFile;
	}
	
	/**
	 * �����ݿ����������һ���Զ��뵽���棬ϵͳ��ʼ����ʱ����ã������ط�����ã�����
	 */
	public void loadAllData(){
		org.hibernate.Session s = null ;
		try{
			s = MyHibernateUtil.currentSession(this.hibernateFile);
			System.out.println("��ȡȫ������"+beanClass.getName()+"��ʼ...");
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
			
			System.out.println("��ȡȫ������"+beanClass.getName()+"���!!!�ܳ���="+count);
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			MyHibernateUtil.closeSession(this.hibernateFile);
		}
	}
	
	/**
	 * ����manager�ǲ��ǲ�����������bean
	 * @param record
	 * @throws MyException
	 */
	private void checkBeanClass(BaseEntity record) throws MyException{
		if(!record.getClass().getName().equals(beanClass.getName())){
			throw new MyException("��manager��֧�ֶ�"+record.getClass().getName()+"�Ĳ����� �ڴ�"+beanClass.getName());
		}
	}
	
	/**
	 * ����ɢ��fields
	 * @return
	 */
	public String[] getHashFields(){
		return this.hashFields;
	}
	
	/**
	 * ���񷽷�������Service���ã�����id�Ҷ���
	 * @param id �����id
	 * @return  BaseEntity
	 * @throws HibernateException
	 */
	public BaseEntity txGet(String id) throws HibernateException {
	    //ֱ�Ӵ����ݿ��в���....
		if(isNull(id))return null ;
		
		//����������У�ֱ�ӷ���
		if(MyConfig.enableLocalCache()){
			if(RECORDS_CACHE.containsKey(id)){
				BaseEntity br = RECORDS_CACHE.get(id);
				return br;
			}
		}else{
			String key = getBeanVersion()+beanClass.getName()+"#"+id ;//memcached �����key
			if(memcachedClient!=null){
				if(memcachedClient.keyExists(key)){
					Object ret = memcachedClient.get(key);
					return (BaseEntity)ret;
				}
			}
		}
		
		//��manager�����̱߳���������ͳһ�ύ���ع���closeSession
		MyInterceptor.addManager(this);
		
	    Session s = currentSession();
	    BaseEntity br = (BaseEntity)s.get(beanClass, id);
	    
		return br;
	}
	
	/**
	 * �õ���ǰversion���޸İ汾�൱�������class���л��棬bean�İ汾<br/>
	 * ��db-cache-conf.properties�����ļ������ã��ֲ�ʽ�������ĳ����Ļ���ʱ��Ҫ��<br/>
	 * ���Ƿֲ�ʽ���棬����clearAllLocalCache��������������б��ػ��档<br/>
	 * @return �汾��,��db-cache-conf.properties������
	 */
	protected String getBeanVersion(){
		return MyConfig.getBeanVersion(beanClass.getName());
	}
	
	/**
	 * ����id��ȡ���������÷ֲ�ʽ���棬ÿ��get�����Ĳ���ͬһ��ʵ������ͱ��ػ��治һ����Ҫע�⣬�ر����޸�ʱ������<br/>
	 * ��һ�����ȴӻ����л�ȡ��<br/>
	 * �ڶ��������������û�оʹ����ݿ��л�ȡ��<br/>
	 * ���������Ѵ����ݿ�����Ķ�����뻺���У�<br/>
	 * memcached�����д�key��������idƴ�������ַ��������������bean��id��ͻ��<br/>
	 * @param id ��¼��id
	 * @return BaseEntity ����
	 * @throws HibernateException
	 */
	public BaseEntity get(String id) throws HibernateException {

		if(isNull(id))return null ;
		
		BaseEntity br = null;
		
		//��һ����ȥ�����в���
		if(MyConfig.enableLocalCache()){
			if(RECORDS_CACHE.containsKey(id)){
				br = RECORDS_CACHE.get(id);
				return br;
			}
		}else{
			String key = getBeanVersion()+beanClass.getName()+"#"+id ;//memcached �����key
			if(memcachedClient!=null){
				if(memcachedClient.keyExists(key)){
					Object ret = memcachedClient.get(key);
					return (BaseEntity)ret;
				}
			}
		}
    	
	    //�ڶ����������ݿ��в���
	    Session s = null ;
	    try {
	    	s = currentSession() ;
	    	br = (BaseEntity)s.get(beanClass, id);
		}catch(HibernateException he){
	       	throw he;
		}finally{
	       	closeSession();
		}
	       
	    //���������Ѷ�����뻺����
    	if(MyConfig.enableLocalCache()){
    		RECORDS_CACHE.put(id, br);
    	}else{
    		String key = getBeanVersion()+beanClass.getName()+"#"+id ;//memcached �����key
    		if(memcachedClient!=null){
    			memcachedClient.set(key,
    					br,new java.util.Date(MyConfig.getMemCachedExpire()));
    		}
    	}

		return br;
	}
	
	/**
	 * ֱ�Ӵ����ݿ��ȡ���󣬲��߻��棡ĳЩ�ض��ĳ�����Ҫ�õ���
	 * @param id
	 * @return
	 * @throws HibernateException
	 */
	public BaseEntity getWithoutCache(String id) throws HibernateException {

		if(isNull(id))return null ;
		
		BaseEntity br = null;
		
	    //ֱ�Ӵ����ݿ��в���
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
	 * ����ĳһ���ֶε�ֵ����ȡ��������ֶ�Ӧ����Ψһ�ģ�Ҳ����ֻ����һ�С���������ֻ��Ų�ѯ�û���<br/>
	 * @param fieldName �ֶζ�Ӧ�������������Ǳ���ֶ�����ע�⣡
	 * @param value ���Ե�ֵ��ע��value�����ͱ����bean��Ӧ��Long����Long��String����String��
	 * @return BaseEntity ���ض���
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
	 * �������Ի�ȡһ����¼��������ʹ�á�ֱ�Ӷ����ݿ⡣
	 * @param fieldName �ֶζ�Ӧ��������
	 * @param value ���Ե�ֵ��ע��value�����ͱ����bean��Ӧ��Long����Long��String����String
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
	 * ����id�����ݿ���ɾ������
	 * @param id ���ݿ��е�id
	 * @return boolean 
	 * @throws HibernateException
	 */
	public boolean delete(String id) throws HibernateException {
		if(isNull(id))return false ;
		BaseEntity b = get(id);
		return delete(b);
	}
	
	/**
	 * �����ݿ���ɾ�����ݣ����ӻ�����Ҳɾ��
	 * @param br BaseEntity Ҫɾ���Ķ���
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
				
		//��һ���������ݿ�ɾ��
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
		
		//�ڶ������ӻ�����ɾ��
        if(MyConfig.enableLocalCache()){
        	RECORDS_CACHE.remove(br.getId());
        }else{
        	String key = getBeanVersion()+beanClass.getName()+"#"+id ;//memcached �����key
        	if(memcachedClient!=null)memcachedClient.delete(key);
        }

		//��������ɾ���б��棬�û�����ص��б���ʧЧ
        clearListCache(br);
		
        return ret;
	}
	
	/**
	 * ɾ�����󣬲��ύ����������ʹ�ã�
	 * @param br ��¼
	 * @return �ɹ�����true
	 * @throws HibernateException
	 */
	public boolean txDelete(BaseEntity br) throws HibernateException ,MyException {
		if(br==null){
			return false;
		}
		
		checkBeanClass(br);
		
		//��manager�����̱߳���������ͳһ�ύ���ع���closeSession
		MyInterceptor.addManager(this);
		
		boolean ret = true;
		
		//�����ݿ�ɾ��
		currentSession().delete(br);
       
        //��ɾ���Ķ�������̱߳���������ͳһɾ������
		MyInterceptor.addBean(br);
	    
        return ret;
	}
	
	/**
	 * ͨ��sql�޸Ķ����޸ĺ��Լ�Ҫ֪�����ʲô����ͻ��棬���߱��ã���������<br/>
	 * ��sql�޸��Ƿ�ֹ������ʱ�����ݴ��󣬱����޸Ŀ�棬�����update sku set stock=stock-1��ʹ����Ҳ�����<br/>
	 * ���������s.setStock(s.getStock()-1)������ʱ���ݿ��ܻ��������ǰ��̨û��ͳһ���������<br/>
	 * ���������tx��ͷ�ķ�����ֻ����Service���ã�����<br/>
	 * @param sql ��ͨ��udpate sql
	 */
	public void txUpdateViaSql(String sql)throws HibernateException{
		currentSession().createSQLQuery(sql).executeUpdate();
	}
	
	/**
	 * ����һ�����ݿ����ע��clearListCache������true��ʾ��Ҫ����б��棬false��ʾ����Ҫ��<br/>
	 * 1�������޸ĵ��ֶ�Ӱ��һ���������һ�������ö���clearListCache����Ϊtrue��<br/>
	 * 2�����޸Ĳ�Ӱ���κ����򣬱����޸���Ʒ�ı��⣬clearListCacheΪfalse����ʾ�����б��棬��߻��������ʣ�<br/>
	 * 3�����޸�Ӱ���������򣬱���������ӣ����ӵ�state��0��Ϊ1����ô��setState֮ǰ��Ҫ����һ��clearListCache()������clearListCache��true���൱���������б��档<br/>
	 * @param record Ҫ���µĶ���,
	 * @param clearListCache true��ʾ��Ҫ����б��棬false��ʾ����Ҫ
	 * @return boolean
	 * @throws HibernateException
	 */
	public boolean update(BaseEntity record,boolean clearListCache) throws HibernateException ,MyException {		
		if(record==null||record.getId()==null){
			return false;
		}
		
		checkBeanClass(record);

        //��һ�����޸����ݿ�
		Session s = null ;
        Transaction tx = null;
        try {
        	s = currentSession();
        	tx = s.beginTransaction();
        	s.update(record);
        	tx.commit();
        } catch (HibernateException e) {
        	//����޸����ݿ��׳��쳣��Ҫ������ض��󻺴�
        	if(MyConfig.enableLocalCache()){
        		RECORDS_CACHE.remove(record.getId());
        	}
        	if(tx!=null)tx.rollback();
        	throw e;
        } finally {
        	closeSession();
        }
	       
	    //�ڶ���������memcached�еļ�¼�����ػ��治��Ҫ���£���Ϊ����ͬһ������
	    if(!MyConfig.enableLocalCache()){
	    	String key = getBeanVersion()+beanClass.getName()+"#"+record.getId() ;//memcached �����key
    		if(memcachedClient!=null){
    			memcachedClient.set(key,
    					record,new java.util.Date(MyConfig.getMemCachedExpire()));
    		}
	    }
		       
		//��������ɾ�������б��棬�ö�Ӧ���б�ʧЧ
		if(clearListCache){
		  	clearListCache(record);
		}
        
        return true ;
	}
	
	/**
	 * �޸�һ��������Ҫ���������򣬱���state��0�޸ĵ�1����ôsetֵ֮ǰҪ���������������������ύ��ʱ���������<br/>
	 * �������ר�Ÿ�Service�õģ����Ƿ����񷽷����޸�֮ǰֱ�ӵ���clearListCache������������������<br/>
	 * @param bt
	 */
	public void txBeforeUpdate(BaseEntity bt) throws MyException{
		//����ط�����cloneһ����������������޸�֮ǰ��ֵ
		checkBeanClass(bt);
		MyInterceptor.addBean((BaseEntity)bt.clone());
	}
	
	/**
	 * �޸Ĳ��ύ����Service�õķ���
	 * @param record ��¼
	 * @return �޸ĳɹ�����true
	 * @throws HibernateException
	 */
	public boolean txUpdate(BaseEntity record,boolean clearListCache) throws HibernateException ,MyException {		
		if(record==null){
			return false;
		}
		
		checkBeanClass(record);
		
		//��manager�����̱߳���������ͳһ���ع���closeSession
		MyInterceptor.addManager(this);
		
       	//�޸����ݿ�       	
      	currentSession().update(record);
        
 	    //���޸ĵĶ���Ҳ�����̱߳���������ͳһɾ������
        MyInterceptor.addBean(record);
 	    
        return true ;
	}
	
	/**
	 * ����һ�����ݿ��¼�����Ѷ�����뻺�档
	 * @param record BaseEntity
	 * @return BaseEntity �������ݿ��еĶ���
	 * @throws HibernateException
	 */
	public BaseEntity create(BaseEntity record) throws HibernateException , MyException {
		
		checkBeanClass(record);
		
		//��һ���������ݿ��д�����¼
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
		
		//�ڶ������Ѷ�����뻺����
		if(MyConfig.enableLocalCache()){
			RECORDS_CACHE.put(record.getId(), record);
		}else{
			String key = getBeanVersion()+beanClass.getName()+"#"+record.getId() ;//memcached �����key
    		if(memcachedClient!=null){
    			memcachedClient.set(key,
    					record,new java.util.Date(MyConfig.getMemCachedExpire()));
    		}
		}
	
		//��������ɾ���б���
		clearListCache(record);

		return record;
	}
	
	/**
	 * ���������д�����
	 * @param record ��¼
	 * @return �����ļ�¼
	 * @throws HibernateException
	 */
	public BaseEntity txCreate(BaseEntity record) throws HibernateException , MyException {
		
		checkBeanClass(record);
		
		//��manager�����̱߳���������ͳһ���ع���closeSession
		MyInterceptor.addManager(this);
		
		//�����ݿ��д�����¼
		currentSession().save(record);
		
		//�Ѵ����Ķ�������̱߳���������ͳһɾ������
		MyInterceptor.addBean(record);

		return record;
	}
	
	/**
	 * ����һ������ǰ׺��ƴһ���Ƚ�������ַ���������Ӧ�ñ����������key��ֵ
	 * @return �ܶ��ص�һ���ַ�
	 */
	protected String getFirstKeyName(){
		return "!@#"+beanClass.getName()+"!@#";
	}
	
	/**
	 * ֱ�Ӵ����ݿ��ѯlist�����û��棬һ�㲻�����ã�������������
	 * @param expList ����
	 * @param orders ����
	 * @param start ��ʼλ��
	 * @param length ��ȡ����
	 * @return ����List
	 * @throws HibernateException
	 */
	@SuppressWarnings("unchecked")
	public List<BaseEntity> getListWithoutCache(List<SimpleExpression> expList,List<Order> orders,int start,int length) throws HibernateException {
		
		Session s = null ;
		try{
			s =  currentSession();
			//����ط�����ȡid������ֱ��select * from ...
			Criteria ct = s.createCriteria(beanClass);
			 
			if(expList!=null&&expList.size()>0){
				for(int i=0;i<expList.size();i++)
					ct.add(expList.get(i)); //�����ѯ����
			}
			if(orders!=null&&orders.size()>0){
				for(int i=0;i<orders.size();i++)
					ct.addOrder(orders.get(i)); //���������ֶ�
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
	 * �ں�̨Ҫ���ͳ������ʱʹ��
	 * @param hql
	  * @param start ��ʼλ��
	 * @param length ��ȡ����
	 * @return ����List
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
	 * ������ʹ�õķ�������ȡ�б�ֱ�Ӷ����ݿ⡣
	 * @param expList ����
	 * @param orders ����
	 * @param start ��ʼλ��
	 * @param length ��ȡ����
	 * @return list
	 * @throws HibernateException
	 */
	@SuppressWarnings("unchecked")
	public List<BaseEntity> txGetList(List<SimpleExpression> expList,List<Order> orders,int start,int length) throws HibernateException {
		 //��manager�����̱߳���������ͳһ���ع���closeSession
		 MyInterceptor.addManager(this);
		
		 //����ط�����ȡid������ֱ��select * from ...
		 Criteria ct = currentSession().createCriteria(beanClass);
		 
		 if(expList!=null&&expList.size()>0){
			 for(int i=0;i<expList.size();i++)
			 ct.add(expList.get(i)); //�����ѯ����
		 }
		 if(orders!=null&&orders.size()>0){
			 for(int i=0;i<orders.size();i++)
				 ct.addOrder(orders.get(i)); //���������ֶ�
		 }
		 ct.setFirstResult(start).setMaxResults(length);
		 
		 return (List<BaseEntity>)ct.list();
	}
	
	/**
	 * ��ȡ�б��Ȼ�ȡid�б�Ȼ���ȡ�����л����ֱ�Ӵӻ����ж�ȡ��<br/>
	 * ÿ���������id����ֶΣ����ұ�����������ÿ���������id���field���Զ���������ѯ�б�,�ر�ע���б���key��ƴ������������<br>
	 * ��memcached�����ϴ������List�����ɷֺŷֿ���id�б��磺13;14;25;256;887;987;<br/>
	 * key����s10l20,createTime desc$age<90#age>80#userId=12343#�������ַ��������ƴ��md5��<br>
	 * @param expList ��ѯ����
	 * @param orders ��������
	 * @param start ��ʼλ��
	 * @param length ��ȡ����
	 * @return List ���ݿ��¼������ŵ��ǳ����BaseEntity���󣬿���ת���ɶ�Ӧ�Ķ���
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
		Collections.sort(fList);//������Ϊ����һ������������Եõ�ͬһ��key
		StringBuffer keyBuffer = new StringBuffer();
		
		//����classname����ú�������Ĳ�ѯ�ֶγ�ͻ
		keyBuffer.append(beanClass.getName()).append("$");
		
		keyBuffer.append("s").append(start).append("l").append(length).append(",");
		
		if(orders!=null){
			for(int i=0;i<orders.size();i++){
				keyBuffer.append(orders.get(i).toString()).append(",");
			}
		}
		//ע�⣬$֮ǰ���ַ�������Ҫ���뵽�������ļ��㣬�������ֻ��Ҫ����$���������������
		keyBuffer.append("$");
		
		//���������key,��userId=78998
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
						if(condition.startsWith(hashFields[j]+"=")){//������������������ֶ����ö�������
							secondaryCacheKey=condition;//userId=78998
							break;
						}
					}
				}else{
					break;
				}
			}//end for
		}
		
		String key = keyBuffer.toString() ;//������б�Ļ���key
		
		try {
			//תһ�¿��Ա�������md5������
			key = java.net.URLEncoder.encode(key,"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		key = MyMd5Util.toMD5(key);//md5����һ�¿��Լ�С���ȣ���ʡ��·����ʱ��
		
		//��һ�����ӻ����в���
		if(MyConfig.enableLocalCache()){
			if(secondaryCacheKey==null){//�ӹ��û����в���
				if(RECORDS_LIST_CACHE.containsKey(key)){
					List<String> list = RECORDS_LIST_CACHE.get(key);//id List
					ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
					for(int i=0;i<list.size();i++){
						BaseEntity br = get(list.get(i)+"");
						if(br!=null)oList.add(br);
					}
					return oList;
				}
			}else{//�Ӷ���ɢ�л����ֲ���
				Map<String,List<String>> secondaryMap = HASH_LIST_CACHE.get(secondaryCacheKey);
				if(secondaryMap!=null&&secondaryMap.containsKey(key)){//����ɢ�л��������ҵ���
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
				//��һ�������в���
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
				//�Ӷ���ɢ�л����в���,ע��key�ı仯
				String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//����key��ǰ׺
			
				if(secondKeyPrefix!=null&&secondKeyPrefix.length()>0){
					//��prefixƴ��ǰ��...
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
			 //�ڶ��� �����ݿ��в��ң�����ط���ȡid��select id from ...����ȡid��Ȼ��ȡ����
			 Criteria ct = s.createCriteria(beanClass).setProjection(Projections.property("id"));
			
			 if(expList!=null&&expList.size()>0){
				for(int i=0;i<expList.size();i++)
					ct.add(expList.get(i)); //�����ѯ����
			 }
			 if(orders!=null&&orders.size()>0){
				 for(int i=0;i<orders.size();i++)
					 ct.addOrder(orders.get(i)); //���������ֶ�
			 }
			 ct.setFirstResult(start).setMaxResults(length);
			 
			 List<String> list = (List<String>)ct.list();
			 
			 if(MyConfig.enableLocalCache()){
				 if(secondaryCacheKey==null){
					 RECORDS_LIST_CACHE.put(key, list);//����List����...
				 }else{
					 Map<String,List<String>> secondaryMap = HASH_LIST_CACHE.get(secondaryCacheKey);
					 if(secondaryMap!=null){//�������ɢ�л���
						 secondaryMap.put(key, list);
					 }else{
						 secondaryMap = Collections.synchronizedMap(new HashMap<String,List<String>>());
						 secondaryMap.put(key, list);
						 HASH_LIST_CACHE.put(secondaryCacheKey, secondaryMap);
					 }
				 }
			 }else{
				 if(secondaryCacheKey==null){
					 //��id�б����memcached��
					 String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
					 
					 if(firstKeyPrefix==null||firstKeyPrefix.length()==0){
						 //ƴһ��һ������ǰ׺
						 firstKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());					 
						 //����ǰ׺
						 memcachedClient.set(getBeanVersion()+getFirstKeyName(),firstKeyPrefix);	
					 }
					 //�����ѯ���
					 memcachedClient.set(getBeanVersion()+firstKeyPrefix+"#"+key, list2String(list));
				 }else{
					 String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//����key��ǰ׺
					 
					 if(secondKeyPrefix==null||secondKeyPrefix.length()==0){
						 //����ƴһ������ɢ��key
						 secondKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());	 
						 //����ǰ׺
						 memcachedClient.set(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey,secondKeyPrefix);
					 }
					 //Ȼ���id�б���뻺���У�ע��key�ı仯
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
		Collections.sort(fList);//������Ϊ����һ������������Եõ�ͬһ��key
		StringBuffer keyBuffer = new StringBuffer();
		
		//����classname����ú�������Ĳ�ѯ�ֶγ�ͻ
		keyBuffer.append(beanClass.getName()).append("$");
		
		keyBuffer.append("s").append(start).append("l").append(length).append(",");
		
		if(orders!=null){
			for(int i=0;i<orders.size();i++){
				keyBuffer.append(orders.get(i).toString()).append(",");
			}
		}
		//ע�⣬$֮ǰ���ַ�������Ҫ���뵽�������ļ��㣬�������ֻ��Ҫ����$���������������
		keyBuffer.append("$");
		
		//���������key,��userId=78998
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
						if(condition.startsWith(hashFields[j]+"=")){//������������������ֶ����ö�������
							secondaryCacheKey=condition;//userId=78998
							break;
						}
					}
				}else{
					break;
				}
			}//end for
		}
		
		String key = keyBuffer.toString() ;//������б�Ļ���key
		
		try {
			//תһ�¿��Ա�������md5������
			key = java.net.URLEncoder.encode(key,"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		key = MyMd5Util.toMD5(key);//md5����һ�¿��Լ�С���ȣ���ʡ��·����ʱ��
		
		//��һ�����ӻ����в���
		if(MyConfig.enableLocalCache()){
			if(secondaryCacheKey==null){//�ӹ��û����в���
				if(RECORDS_LIST_CACHE.containsKey(key)){
					List<String> list = RECORDS_LIST_CACHE.get(key);//id List
					ArrayList<BaseEntity> oList = new ArrayList<BaseEntity>();
					for(int i=0;i<list.size();i++){
						BaseEntity br = get(list.get(i)+"");
						if(br!=null)oList.add(br);
					}
					return oList;
				}
			}else{//�Ӷ���ɢ�л����ֲ���
				Map<String,List<String>> secondaryMap = HASH_LIST_CACHE.get(secondaryCacheKey);
				if(secondaryMap!=null&&secondaryMap.containsKey(key)){//����ɢ�л��������ҵ���
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
				//��һ�������в���
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
				//�Ӷ���ɢ�л����в���,ע��key�ı仯
				String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//����key��ǰ׺
			
				if(secondKeyPrefix!=null&&secondKeyPrefix.length()>0){
					//��prefixƴ��ǰ��...
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
			 //�ڶ��� �����ݿ��в��ң�����ط���ȡid��select id from ...����ȡid��Ȼ��ȡ����
			 Criteria ct = s.createCriteria(beanClass).setProjection(Projections.property("id"));
			
			 if(expList!=null&&expList.size()>0){
				for(int i=0;i<expList.size();i++)
					ct.add(expList.get(i)); //�����ѯ����
			 }
			 if(orders!=null&&orders.size()>0){
				 for(int i=0;i<orders.size();i++)
					 ct.addOrder(orders.get(i)); //���������ֶ�
			 }
			 ct.setFirstResult(start).setMaxResults(length);
			 
			 List<String> list = (List<String>)ct.list();
			 
			 if(MyConfig.enableLocalCache()){
				 if(secondaryCacheKey==null){
					 RECORDS_LIST_CACHE.put(key, list);//����List����...
				 }else{
					 Map<String,List<String>> secondaryMap = HASH_LIST_CACHE.get(secondaryCacheKey);
					 if(secondaryMap!=null){//�������ɢ�л���
						 secondaryMap.put(key, list);
					 }else{
						 secondaryMap = Collections.synchronizedMap(new HashMap<String,List<String>>());
						 secondaryMap.put(key, list);
						 HASH_LIST_CACHE.put(secondaryCacheKey, secondaryMap);
					 }
				 }
			 }else{
				 if(secondaryCacheKey==null){
					 //��id�б����memcached��
					 String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
					 
					 if(firstKeyPrefix==null||firstKeyPrefix.length()==0){
						 //ƴһ��һ������ǰ׺
						 firstKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());					 
						 //����ǰ׺
						 memcachedClient.set(getBeanVersion()+getFirstKeyName(),firstKeyPrefix);	
					 }
					 //�����ѯ���
					 memcachedClient.set(getBeanVersion()+firstKeyPrefix+"#"+key, list2String(list));
				 }else{
					 String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//����key��ǰ׺
					 
					 if(secondKeyPrefix==null||secondKeyPrefix.length()==0){
						 //����ƴһ������ɢ��key
						 secondKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());	 
						 //����ǰ׺
						 memcachedClient.set(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey,secondKeyPrefix);
					 }
					 //Ȼ���id�б���뻺���У�ע��key�ı仯
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
	 * ��list�����id�б�ƴ���Էֺ÷ָ���ַ���
	 * @param list
	 * @return �÷ֺŸ������ַ���
	 */
	protected String list2String(List<String> list){
		//����𷵻�null�����ַ�������null������memcached����Լ������ݿ��ѯ
		if(list==null)return ";";
		StringBuffer sb = new StringBuffer();
		sb.append(";");
		for(int i=0;i<list.size();i++){
			sb.append(list.get(i)).append(";");
		}
		return sb.toString();
	}
	
	/**
	 * ֱ�Ӵ����ݿ�ȡ���ȣ����ⳡ��ʹ�ã�һ�㲻���������
	 * @param expList ����
	 * @closeSession �Ƿ�ر�session
	 * @return ���س���
	 * @throws HibernateException
	 */
	public int getLengthWithoutCache(List<SimpleExpression> expList) throws HibernateException {

		Session s = null ;
		try {
			s = currentSession();
			Criteria ct = s.createCriteria(beanClass).setProjection(Projections.rowCount());
			 
			if(expList!=null&&expList.size()>0){
				for(int i=0;i<expList.size();i++)
					ct.add(expList.get(i)); //�����ѯ����
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
	 * ��̨�����ͳ��ʱ��ʹ�ã�ֻ������ͳ�Ƴ��ȣ�����������
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
	 * �ṩ�����񷽷�
	 * @param expList ����
	 * @return
	 * @throws HibernateException
	 */
	public int txGetLength(List<SimpleExpression> expList) throws HibernateException {
		//��manager�����̱߳���������ͳһ���ع���closeSession
		MyInterceptor.addManager(this);
		
		Criteria ct = currentSession().createCriteria(beanClass).setProjection(Projections.rowCount());
		 
		if(expList!=null&&expList.size()>0){
			for(int i=0;i<expList.size();i++)
				ct.add(expList.get(i)); //�����ѯ����
		}
		Long len = (Long)ct.uniqueResult();
		
		return (int)len.longValue();
	}
	
	/**
	 * ���������õ����ݿ��¼�ĳ��ȣ�Integer�������ֱ�Ӵ���memcached�����У�����û�б�Ҫ���л���
	 * @param expList ��ѯ����
	 * @return ����
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
		
		//����class�������������class��key������ͻ��������һ��%�������getList��key������ͻ
		keyBuffer.append(beanClass.getName()).append("%$");	
		
		//���������key,��userId=78998
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
						if(condition.startsWith(hashFields[j]+"=")){//������������������ֶ����ö�������
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
		
		
		//��һ�� �ӻ��������
		if(MyConfig.enableLocalCache()){
			if(secondaryCacheKey==null){//���ò��ֲ���
				if(RECORDS_LENGTH_CACHE.containsKey(key)){
					Integer res = RECORDS_LENGTH_CACHE.get(key);//id List
					return res.intValue();
				}
			}else{//����ɢ�л������
				Map<String,Integer> secondaryMap = HASH_LENGTH_CACHE.get(secondaryCacheKey);
				if(secondaryMap!=null&&secondaryMap.containsKey(key)){//�ڶ����������ҵ���
					Integer res = secondaryMap.get(key);
					return res.intValue();
				}
			}
		}else{
			if(secondaryCacheKey==null){//���ò��ֲ���
				String firstKeyPrefix = (String)memcachedClient.get(getBeanVersion()+getFirstKeyName());
				if(firstKeyPrefix!=null&&firstKeyPrefix.length()>0){
					String resultKeys = memcachedClient.get(getBeanVersion()+firstKeyPrefix+"#"+key)+"";
					if(resultKeys!=null){
						if(isDigits(resultKeys)){
							return Integer.parseInt(resultKeys);
						}
					}
				}
			}else{//����ɢ�л������
				String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//����key��ǰ׺
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
		

		//�ڶ��� �����ݿ��л�ȡ
		int len = getLengthWithoutCache(expList);
			
		//ע�⣺��ͬ�����Ĳ�ѯ���Ⱥ��б��key prefix��һ����
		if(MyConfig.enableLocalCache()){
			if(secondaryCacheKey==null){
				RECORDS_LENGTH_CACHE.put(key, new Integer(len));//����List����
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
					//ƴһ��ǰ׺
					firstKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random());
					//����ǰ׺
					memcachedClient.set(getBeanVersion()+getFirstKeyName(),firstKeyPrefix);
				}
				//������
				memcachedClient.set(getBeanVersion()+firstKeyPrefix+"#"+key,len);
			}else{
				 String secondKeyPrefix = (String)memcachedClient.get(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey);//����key��ǰ׺
				 
				 if(secondKeyPrefix==null||secondKeyPrefix.length()==0){
					 //Ҫ����ƴһ������ɢ��key
					 secondKeyPrefix = MyMd5Util.toMD5(System.currentTimeMillis()+"#"+Math.random()); 
					 //����ǰ׺
					 memcachedClient.set(getBeanVersion()+beanClass.getName()+"#"+secondaryCacheKey,secondKeyPrefix);
				 }
		 
			 	//Ȼ���id�б���뻺���У�ע��key�ı仯
			 	memcachedClient.set(getBeanVersion()+secondKeyPrefix+"#"+key,len);
			}
		}
			
		return len;
		
	}
	
	/**
	 * ɾ�����󻺴�
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
	 * ɾ��һ�����󻺴�
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
	 * ɾ�����б��ػ��棡�ֲ�ʽʱ������������ã�����<br/>
	 * �ֲ�ʽ������Ҫɾ��һ��bean�����л�����Ҫ�޸�bean�汾<br/>
	 */
	public void clearAllLocalCache(){
		clearAllLocalOmCache();
		clearAllLocalListCache();
	}
	
	/**
	 * ������б����б��棡
	 */
	public void clearAllLocalListCache(){
		RECORDS_LIST_CACHE.clear();
		RECORDS_LENGTH_CACHE.clear();
		HASH_LIST_CACHE.clear();
		HASH_LENGTH_CACHE.clear();
	}
	
	/**
	 * ɾ�����б��ض��󻺴�
	 */
	public void clearAllLocalOmCache(){
		RECORDS_CACHE.clear();
	}
	
	/**
	 * ����б��档<br/>
	 * 1������޸ĵ��ֶ�Ӱ�����������򣬵��͵���state��0��Ϊ1����ô�޸�֮ǰҲҪ����һ�¸÷�����<br/>
	 * 2������޸����ֶ�ֻӰ��һ���������޸������ӵ����ȼ�����ô�޸�֮ǰ��Ҫ���ø÷�����ֱ����update(BaseEntity,true)�޸Ķ��󼴿ɡ�<br/>
	 * 3������޸ĵ��ֶβ�Ӱ�����򣬵��͵����޸���Ʒ�ı��⣬��ô��update(BaseEntity,false)����,������Ҫ����б��档<br/>
	 * @param bt �����Ķ���
	 */
	public void clearListCache(BaseEntity bt) throws MyException {
		
		if(bt==null)return;
		
		checkBeanClass(bt);
		
		HashMap<String, String> fieldMap = new HashMap<String, String>();
		
		//�Ѷ������ֵת����һ��hashmap��
		Object[] args = null ;
		Method[] ms = bt.getClass().getMethods();

		try{
			for(int i=0;i<ms.length;i++){
				if(ms[i].getName().startsWith("get")&&!ms[i].getName().equals("getClass")){
					String fieldName = ms[i].getName().substring(3);//3 �� get�ĳ���
					fieldName = Character.toLowerCase(fieldName.charAt(0))+fieldName.substring(1);
					String fieldValue = ms[i].invoke(bt, args)+"" ;
					fieldMap.put(fieldName, fieldValue);
					
					//������Щ����Ҫɾ��ɢ�л���
					if(hashFields!=null&&hashFields.length>0){
						for(int j=0;j<hashFields.length;j++){
							if(fieldName.equals(hashFields[j])){
								String secondaryKey = fieldName+"="+fieldValue ; 
								
								//���ö����б����ǰ׺���൱����ԭ���Ķ����б�ʧЧ
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
			//����һ������ǰ׺���൱����ȫ��һ���б���ʧЧ
			memcachedClient.set(getBeanVersion()+getFirstKeyName(),firstKeyPrefix);
		}
	}
	
	/**
	 * ��ʼ����
	 */
	public void beginTransaction(){
		Session s = currentSession();
		s.beginTransaction();
	}
	
	/**
	 * �ύ����
	 */
	public void commit(){
		Session s = currentSession();
		Transaction tx = s.getTransaction();
		tx.commit();
	}
	
	/**
	 * �ع����񣬲��Ѹ������м�¼�Ļ������Ҳ�ع�����֤��������ݿ�һ��
	 */
	public void rollback(){
		Session s = currentSession();
		Transaction tx = s.getTransaction();
		tx.rollback();
	}
	
	/**
	 * ��ǰ�̵߳�session
	 * @return Session
	 */
	public Session currentSession(){
		return MyHibernateUtil.currentSession(hibernateFile);
	}
	
	/**
	 * �رյ�ǰ�߳�session������������������������
	 */
	public void closeSession(){
		MyHibernateUtil.closeSession(hibernateFile);
	}
	
	/**
	 * �ж�һ���ַ����ǲ����������
	 * @param s �ַ���
	 * @return
	 */
	private static boolean isDigits(String s){
		if(s==null||s.length()==0)return false;
		s=s.startsWith("-")?s.substring(1):s;//�ж��Ƿ��Ǹ���
		for(int i=0;i<s.length();i++){
			if(!Character.isDigit(s.charAt(i)))return false;
		}
		return true;
	}

	
	/**
	 * �Ƿ��ǿ�
	 * @param str
	 * @return
	 */
	private static boolean isNull(String str){
		if(str == null || str.trim().length()==0) return true;
		return false;
	}
}
