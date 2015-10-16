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
 * 商品manager
 * @author kk
 *
 */
public class ProductManager extends BaseManager{

	/**
	 * 覆盖上级构造方法
	 * @param beanClass
	 * @param hibernateFile
	 * @param hashFieldsStr
	 */
	public ProductManager(Class<?> beanClass, String hibernateFile,
			String hashFieldsStr) {
		super(beanClass, hibernateFile, hashFieldsStr);
	}

	/**
	 * 记录所有已上架商品id的map，列表显示的时候就不用读数据库了
	 */
	private static Map<String,Product> PRODUCT_MAP = new ConcurrentHashMap<String,Product>();
	
	/**
	 * 记录分类长度的Map
	 */
	private static Map<String,Integer> PRODUCT_LENGTH_MAP = Collections.synchronizedMap(new HashMap<String,Integer>());
	
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
				.add(Restrictions.eq("gdsmst_validflag", new Long(1)))  //只取上架的商品
				.setFirstResult(0).setMaxResults(50000).list();
			int count = 0 ;
			if(list!=null&&list.size()>0){
				count = list.size();
				for(int i=0;i<list.size();i++){
					BaseEntity b = (BaseEntity)list.get(i);
					RECORDS_CACHE.put(b.getId(), b);
					
					//把上架的商品id存入Map
					Product p = (Product)b ;
					if(Tools.longValue(p.getGdsmst_validflag())==1){
						PRODUCT_MAP.put(p.getId(), p);
					}
				}
			}
			
			loadLength();//加载长度
			System.out.println("读取全部数据"+beanClass.getName()+"完成!!!总长度="+count);
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			MyHibernateUtil.closeSession(this.hibernateFile);
		}
	}
	
	/**
	 * 获得一个分类下面所有商品的长度
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
	 * 加载分类长度的方法
	 */
	private void loadLength(){
		Iterator<Product> it = PRODUCT_MAP.values().iterator();
		while(it.hasNext()){
			Product p = it.next();
			String rackcode = p.getGdsmst_rackcode();
			if(!Tools.isNull(rackcode)&&rackcode.length()%3==0){//分类长度必须是3的倍数
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
	 * 得到所有上架商品
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
	 * 根据分类获得该分类下的物品集合
	 * @param rackcode - 物品分类
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
	 * 根据品牌名获取商品列表
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
	 * 根据品牌获得改品牌下的物品集合 
	 * @param rackcode 分类
	 * @param barndname - 物品品牌
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
	 * 根据分类获得该分类下的所有品牌
	 * @param rackcode - 分类
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
	 * 加入一个上架商品id，清缓存的程序用到，其他地方别用！！！
	 * @param pid
	 */
	public void addProductId(String productId){
		if(!Tools.isNull(productId)){
			Product p = (Product)get(productId);
			if(p!=null&&Tools.longValue(p.getGdsmst_validflag())==1){
				PRODUCT_MAP.put(p.getId(), p);
			
				//修改分类里面的长度
				String rackcode = p.getGdsmst_rackcode();
				if(!Tools.isNull(rackcode)&&rackcode.length()%3==0){//分类长度必须是3的倍数
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
	 * 删除一个商品id，清缓存的程序用到，其他地方别用！！！
	 * @param pid
	 */
	public void removeProductId(String productId){
		if(Tools.isNull(productId))return;
		
		Product p = PRODUCT_MAP.get(productId);
		PRODUCT_MAP.remove(productId);
		
		if(p!=null){
			String rackcode = p.getGdsmst_rackcode();
			if(!Tools.isNull(rackcode)&&rackcode.length()%3==0){//分类长度必须是3的倍数
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
	 * 把商品销量载入到内存中，一天load一次比较合适！
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
