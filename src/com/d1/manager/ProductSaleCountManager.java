package com.d1.manager;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.hibernate.HibernateException;

import com.d1.bean.ProductSaleCount;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.dbcache.core.MyException;
import com.d1.dbcache.core.MyHibernateUtil;
import com.d1.util.Tools;

/**
 * ��Ʒ����manager
 * @author kk
 *
 */
public class ProductSaleCountManager extends BaseManager{

	/**
	 * �����ϼ����췽��
	 * @param beanClass
	 * @param hibernateFile
	 * @param hashFieldsStr
	 */
	public ProductSaleCountManager(Class<?> beanClass, String hibernateFile,
			String hashFieldsStr) {
		super(beanClass, hibernateFile, hashFieldsStr);
	}

	/**
	 * ��¼����������id��map
	 */
	private static Map<String,ProductSaleCount> SALES_MAP = new ConcurrentHashMap<String,ProductSaleCount>();
	
	/**
	 * �����ݿ����������һ���Զ��뵽���棬ϵͳ��ʼ����ʱ����ã������ط�����ã�����
	 */
	@Override
	public void loadAllData(){
		
		org.hibernate.Session s = null ;
		try{
			s = MyHibernateUtil.currentSession(this.hibernateFile);
			System.out.println("��ȡȫ������"+beanClass.getName()+"��ʼ...");
			@SuppressWarnings("rawtypes")
			List list = s.createCriteria(beanClass)
				.setFirstResult(0).setMaxResults(50000).list();
			int count = 0 ;
			if(list!=null&&list.size()>0){
				count = list.size();
				for(int i=0;i<list.size();i++){
					BaseEntity b = (BaseEntity)list.get(i);
					RECORDS_CACHE.put(b.getId(), b);
					
					ProductSaleCount p = (ProductSaleCount)b ;
					SALES_MAP.put(b.getId(), p);
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
	 * �õ���������list����list��Ҫ����д����
	 * @param pid ��Ʒid
	 * @return
	 */
	public List<ProductSaleCount> getTotalProductSaleCountList(String pid){
		if(Tools.isNull(pid))return null;
		List<ProductSaleCount> rlist = new ArrayList<ProductSaleCount>();
		
		Iterator<ProductSaleCount> it = SALES_MAP.values().iterator();
		while(it.hasNext()){
			ProductSaleCount ps = it.next();
			if(pid.equals(ps.getGdssale_gdsid())){
				rlist.add(ps);
			}
		}
		return rlist ;
	}
	
	/**
	 * ����һ������id���建��ĳ����õ��������ط����ã�����
	 * @param pid
	 */
	public void addProductSaleCountId(String id){
		if(!Tools.isNull(id)){
			ProductSaleCount p = (ProductSaleCount)get(id);
			SALES_MAP.put(id, p);
		}
	}
	
	/**
	 * ɾ��һ������id
	 * @param pid
	 */
	public void removeProductSaleCountId(String id){
		SALES_MAP.remove(id);
	}
	
	@Override
	public void clearAllLocalCache(){
		//do nothing
	}
	
	@Override
	public void clearAllLocalOmCache(){
		//do nothing
	}
	
	@Override
	public void clearAllLocalListCache(){
		//do nothing
	}
	
	@Override
	public boolean delete(BaseEntity br) throws HibernateException , MyException {
		return false;
	}
}
