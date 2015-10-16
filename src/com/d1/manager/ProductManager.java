package com.d1.manager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.hibernate.HibernateException;
import org.hibernate.criterion.Restrictions;

import com.d1.bean.Brand;
import com.d1.bean.Product;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.dbcache.core.MyException;
import com.d1.dbcache.core.MyHibernateUtil;
import com.d1.helper.ProductSaleCountHelper;
import com.d1.util.Tools;

/**
 * ��Ʒmanager
 * @author kk
 *
 */
public class ProductManager extends BaseManager{

	/**
	 * �����ϼ����췽��
	 * @param beanClass
	 * @param hibernateFile
	 * @param hashFieldsStr
	 */
	public ProductManager(Class<?> beanClass, String hibernateFile,
			String hashFieldsStr) {
		super(beanClass, hibernateFile, hashFieldsStr);
	}

	/**
	 * ��¼�������ϼ���Ʒid��map���б���ʾ��ʱ��Ͳ��ö����ݿ���
	 */
	private static Map<String,Product> PRODUCT_MAP = new ConcurrentHashMap<String,Product>();
	
	/**
	 * ��¼���೤�ȵ�Map
	 */
	private static Map<String,Integer> PRODUCT_LENGTH_MAP = Collections.synchronizedMap(new HashMap<String,Integer>());
	
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
				.add(Restrictions.eq("gdsmst_validflag", new Long(1)))  //ֻȡ�ϼܵ���Ʒ
				.setFirstResult(0).setMaxResults(50000).list();
			int count = 0 ;
			if(list!=null&&list.size()>0){
				count = list.size();
				for(int i=0;i<list.size();i++){
					BaseEntity b = (BaseEntity)list.get(i);
					RECORDS_CACHE.put(b.getId(), b);
					
					//���ϼܵ���Ʒid����Map
					Product p = (Product)b ;
					if(Tools.longValue(p.getGdsmst_validflag())==1){
						PRODUCT_MAP.put(p.getId(), p);
					}
				}
			}
			
			loadLength();//���س���
			System.out.println("��ȡȫ������"+beanClass.getName()+"���!!!�ܳ���="+count);
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			MyHibernateUtil.closeSession(this.hibernateFile);
		}
	}
	
	/**
	 * ���һ����������������Ʒ�ĳ���
	 * @param rackcode
	 */
	public int getRackcodeProductLength(String rackcode){
		if(PRODUCT_LENGTH_MAP.containsKey(rackcode)){
			return PRODUCT_LENGTH_MAP.get(rackcode).intValue();
		}else{
			return 0;
		}
	}
	
	/**
	 * ���ط��೤�ȵķ���
	 */
	private void loadLength(){
		Iterator<Product> it = PRODUCT_MAP.values().iterator();
		while(it.hasNext()){
			Product p = it.next();
			String rackcode = p.getGdsmst_rackcode();
			if(!Tools.isNull(rackcode)&&rackcode.length()%3==0){//���೤�ȱ�����3�ı���
				for(int i=0;i<(int)(rackcode.length()/3);i++){
					String rk = rackcode.substring(0,3*(i+1));
					if(PRODUCT_LENGTH_MAP.containsKey(rk)){
						Integer ix = PRODUCT_LENGTH_MAP.get(rk);
						PRODUCT_LENGTH_MAP.put(rk, new Integer(ix+1));
					}else{
						PRODUCT_LENGTH_MAP.put(rk, new Integer(1));
					}
				}
			}
		}
	}
	
	/**
	 * �õ������ϼ���Ʒ
	 * @return
	 */
	public List<Product> getTotalProductList(){
		List<Product> rlist = new ArrayList<Product>();
		Iterator<Product> it = PRODUCT_MAP.values().iterator();
		while(it.hasNext()){
			Product p = it.next();
			if(Tools.longValue(p.getGdsmst_validflag())==1&&Tools.longValue(p.getGdsmst_ifhavegds())==0){
				rlist.add(p);
			}
		}
		return rlist ;
	}
	
	/**
	 * ���ݷ����ø÷����µ���Ʒ����
	 * @param rackcode - ��Ʒ����
	 * @return List<Product>
	 */
	public List<Product> getProductListByRackcode(String rackcode){
		if(rackcode == null) return null;
		
		List<Product> rlist = new ArrayList<Product>();
		Iterator<Product> it = PRODUCT_MAP.values().iterator();
		while(it.hasNext()){
			Product p = it.next();
			if(Tools.longValue(p.getGdsmst_validflag())==1){
				if(p.getGdsmst_rackcode()!=null&&p.getGdsmst_rackcode().startsWith(rackcode)){
					rlist.add(p);
				}
			}
		}
		return rlist ;
		
	}

	/**
	 * ����Ʒ������ȡ��Ʒ�б�
	 * @param brandname
	 * @return
	 */
	public ArrayList<Product> getProductListByBrand(String brandname){
		if(brandname == null) return null;
		
		ArrayList<Product> rlist = new ArrayList<Product>();
		Iterator<Product> it = PRODUCT_MAP.values().iterator();
		while(it.hasNext()){
			Product p = it.next();
			if(Tools.longValue(p.getGdsmst_validflag())==1){
				if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().equals(brandname)){
					rlist.add(p);
				}
			}
		}
		return rlist ;
	}
	
	/**
	 * ����Ʒ�ƻ�ø�Ʒ���µ���Ʒ���� 
	 * @param rackcode ����
	 * @param barndname - ��ƷƷ��
	 * @return List<Product>
	 */
	public List<Product> getProductListByBrand(String rackcode,String brandname){
		if(brandname == null) return null;
		
		List<Product> rlist = new ArrayList<Product>();
		Iterator<Product> it = PRODUCT_MAP.values().iterator();
		while(it.hasNext()){
			Product p = it.next();
			if(Tools.longValue(p.getGdsmst_validflag())==1){
				if(p.getGdsmst_rackcode()!=null&&p.getGdsmst_rackcode().startsWith(rackcode)&&brandname.equals(p.getGdsmst_brandname())){
					rlist.add(p);
				}
			}
		}
		return rlist ;
	}
	
	/**
	 * ���ݷ����ø÷����µ�����Ʒ��
	 * @param rackcode - ����
	 * @return List<Brand>
	 */
	public List<Brand> getBrandListByRackcode(String rackcode){
		if(rackcode == null) return null;
		HashMap<String,String> brandMap = new HashMap<String,String>();
		Iterator<Product> it = PRODUCT_MAP.values().iterator();
		while(it.hasNext()){
			Product p = it.next();
			if(p.getGdsmst_rackcode().startsWith(rackcode)){
				brandMap.put(p.getGdsmst_brand(), "");
			}
		}
		List<Brand> rlist = new ArrayList<Brand>();
		Iterator<String> it123 = brandMap.keySet().iterator();
		while(it123.hasNext()){
			Brand br = (Brand)Tools.getManager(Brand.class).get(it123.next());
			rlist.add(br);
		}
		return rlist;
	}
	
	/**
	 * ����һ���ϼ���Ʒid���建��ĳ����õ��������ط����ã�����
	 * @param pid
	 */
	public void addProductId(String productId){
		if(!Tools.isNull(productId)){
			Product p = (Product)get(productId);
			if(p!=null&&Tools.longValue(p.getGdsmst_validflag())==1){
				PRODUCT_MAP.put(p.getId(), p);
			
				//�޸ķ�������ĳ���
				String rackcode = p.getGdsmst_rackcode();
				if(!Tools.isNull(rackcode)&&rackcode.length()%3==0){//���೤�ȱ�����3�ı���
					for(int i=0;i<(int)(rackcode.length()/3);i++){
						String rk = rackcode.substring(0,3*(i+1));
						if(PRODUCT_LENGTH_MAP.containsKey(rk)){
							Integer ix = PRODUCT_LENGTH_MAP.get(rk);
							PRODUCT_LENGTH_MAP.put(rk, new Integer(ix.intValue()+1));
						}else{
							PRODUCT_LENGTH_MAP.put(rk, new Integer(1));
						}
					}
				}
			}
		}
	}
	
	/**
	 * ɾ��һ����Ʒid���建��ĳ����õ��������ط����ã�����
	 * @param pid
	 */
	public void removeProductId(String productId){
		if(Tools.isNull(productId))return;
		
		Product p = PRODUCT_MAP.get(productId);
		PRODUCT_MAP.remove(productId);
		
		if(p!=null){
			String rackcode = p.getGdsmst_rackcode();
			if(!Tools.isNull(rackcode)&&rackcode.length()%3==0){//���೤�ȱ�����3�ı���
				for(int i=0;i<(int)(rackcode.length()/3);i++){
					String rk = rackcode.substring(0,3*(i+1));
					if(PRODUCT_LENGTH_MAP.containsKey(rk)){
						Integer ix = PRODUCT_LENGTH_MAP.get(rk);
						if(ix.intValue()>0){
							PRODUCT_LENGTH_MAP.put(rk, new Integer(ix-1));
						}
					}else{
						PRODUCT_LENGTH_MAP.put(rk, new Integer(0));
					}
				}
			}
		}
	}
	
	/**
	 * ����Ʒ�������뵽�ڴ��У�һ��loadһ�αȽϺ��ʣ�
	 */
	public void loadProductSales(){
		Iterator<Product> it = PRODUCT_MAP.values().iterator();
		while(it.hasNext()){
			Product product = it.next();
			
			int sales = ProductSaleCountHelper.getProductWeekSalesCount(product);
			product.setTotal_sales(sales);
		}
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
