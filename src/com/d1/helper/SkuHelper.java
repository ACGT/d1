package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Product;
import com.d1.bean.Sku;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * ��Ʒ��sku���õĹ�����
 * @author chengang
 *
 */
public class SkuHelper {
	
	public static final BaseManager manager = Tools.getManager(Sku.class);
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return Sku
	 */
	public static Sku getById(String id) {
		if(Tools.isNull(id)) return null;
		return (Sku)manager.get(id);
	}
	
	/**
	 * ȡsku�б�ֻȡ�п��ġ��ϼܵ���Ʒ���޸Ŀ��ʱҪ����б�
	 * @param productId
	 * @return
	 */
	public static ArrayList<Sku> getSkuListViaProductId(String productId){
		
		if(Tools.isNull(productId)||!hasSku(productId))return null;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("skumst_gdsid", productId));
		clist.add(Restrictions.eq("skumst_validflag", new Long(1)));//�ϼ�
		//clist.add(Restrictions.gt("skumst_stock", new Long(0)));//�п��
		
		List<BaseEntity> list = manager.getList(clist, null, 0, 100);
		
		ArrayList<Sku> rlist = new ArrayList<Sku>();
		if(list!=null&&list.size()>0){
			for(BaseEntity sku:list){
				rlist.add((Sku)sku);
			}
		}
		return rlist ;
	}
	/**
	 * ȡsku�б�ֻȡ�п��ġ��ϼܵ���Ʒ���޸Ŀ��ʱҪ����б�
	 * @param productId
	 * @return
	 */
	public static ArrayList<Sku> getSkuListViaProductIdO(String productId,int show){
		
		if(Tools.isNull(productId)||!hasSku(productId))return null;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("skumst_gdsid", productId));
		clist.add(Restrictions.eq("skumst_validflag", new Long(1)));//�ϼ�
		if (show==1){
		clist.add(Restrictions.gt("skumst_stock", new Long(0)));//�п��
		}
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("skumst_sku1"));
		List<BaseEntity> list = manager.getList(clist, olist, 0, 100);
		
		ArrayList<Sku> rlist = new ArrayList<Sku>();
		if(list!=null&&list.size()>0){
			for(BaseEntity sku:list){
				rlist.add((Sku)sku);
			}
		}
		return rlist ;
	}
	
	/**
	 * �ж�һ����Ʒ�Ƿ���sku
	 * @param productId ��Ʒ id
	 */
	public static boolean hasSku(String productId){
		Product p = (Product)Tools.getManager(Product.class).get(productId);
		return hasSku(p);
	}
	
	/**
	 * �ж�һ����Ʒ�Ƿ���sku���еĻ���getSkuListViaProductId��ȡ�б�
	 */
	public static boolean hasSku(Product product){
		if(product==null)return false;
		if(Tools.isNull(product.getGdsmst_skuname1()))return false;
		return true ;
	}
	
	/**
	 * ����productId��sku1�õ�Sku����
	 * @param productId
	 * @param sku1
	 * @return
	 */
	public static Sku getSku(String productId,String sku1){
		Product p = (Product)Tools.getManager(Product.class).get(productId);
		if(p==null)return null;
		
		if(hasSku(p)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("skumst_gdsid", productId));
			clist.add(Restrictions.eq("skumst_sku1", sku1));
			
			List<BaseEntity> list = manager.getList(clist, null, 0, 1);
			if(list==null||list.size()==0)return null ;
			
			return (Sku)list.get(0);
		}
		return null;
	}
	
	/**
	 * �õ���Ʒ�������棬�Ա����ͬ����Ҫ�õ�
	 * @param productId
	 * @param sku1 �������
	 * @return
	 */
	public static long getVirtualStock(String productId,String sku1){
		Product p = (Product)Tools.getManager(Product.class).get(productId);
		if(p==null)return 0l;
		if(hasSku(p)){
			Sku sku = getSku(productId,sku1);
			return sku.getSkumst_vstock().longValue();
		}else{
			return p.getGdsmst_virtualstock().longValue();
		}
	}
	
	/**
	 * �ж�sku�Ƿ����
	 * @param product - ��Ʒ����
	 * @param skuId - skuId
	 * @return True or False
	 */
	public static boolean hasInSkuList(Product product , String skuId){
		if(skuId == null) return false;
		List<Sku> skuList = SkuHelper.getSkuListViaProductId(product.getId());
		if(skuList != null && !skuList.isEmpty()){
			for(Sku sku : skuList){
				if(skuId.equals(sku.getId())){
					return true;
				}
			}
		}
		return false;
	}
	
}
