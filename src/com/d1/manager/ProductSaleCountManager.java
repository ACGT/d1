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
 * 商品销量manager
 * @author kk
 *
 */
public class ProductSaleCountManager extends BaseManager{

	/**
	 * 覆盖上级构造方法
	 * @param beanClass
	 * @param hibernateFile
	 * @param hashFieldsStr
	 */
	public ProductSaleCountManager(Class<?> beanClass, String hibernateFile,
			String hashFieldsStr) {
		super(beanClass, hibernateFile, hashFieldsStr);
	}

	/**
	 * 记录所有已销量id的map
	 */
	private static Map<String,ProductSaleCount> SALES_MAP = new ConcurrentHashMap<String,ProductSaleCount>();
	
	/**
	 * 从数据库把所有数据一次性读入到缓存，系统初始化的时候调用，其他地方别调用！！！
	 */
	@Override
	public void loadAllData(){
		
		org.hibernate.Session s = null ;
		try{
			s = MyHibernateUtil.currentSession(this.hibernateFile);
			System.out.println("读取全部数据"+beanClass.getName()+"开始...");
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
			
			System.out.println("读取全部数据"+beanClass.getName()+"完成!!!总长度="+count);
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			MyHibernateUtil.closeSession(this.hibernateFile);
		}
	}
	
	/**
	 * 得到所有销量list，该list不要进行写操作
	 * @param pid 商品id
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
	 * 加入一个销量id，清缓存的程序用到，其他地方别用！！！
	 * @param pid
	 */
	public void addProductSaleCountId(String id){
		if(!Tools.isNull(id)){
			ProductSaleCount p = (ProductSaleCount)get(id);
			SALES_MAP.put(id, p);
		}
	}
	
	/**
	 * 删除一个销量id
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
