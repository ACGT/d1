package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Product;
import com.d1.bean.ProductPackageItem;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * �����Ʒ������
 * @author chengang
 * @createTime 2011-10-31 22:33:06
 *
 */
public class ProductPackageItemHelper {
	
	/**
	 * ProductPackageItem
	 */
	public static final BaseManager manager = Tools.getManager(ProductPackageItem.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return ProductPackageItem
	 */
	public static ProductPackageItem getById(String id){
		if(Tools.isNull(id)) return null;
		return (ProductPackageItem)manager.get(id);
	}
	
	/**
	 * ������е������Ʒ��ֻȡ�ϼܵ���Ʒ
	 * @param gdspkd - ���ID
	 * @return List<ProductPackageItem>
	 */
	public static List<BaseEntity> getGdsmstByGdspid(String gdspkd){
		if(Tools.isNull(gdspkd)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdspktdtl_pktid", new Long(gdspkd)));
		
		List<BaseEntity> list1 = manager.getList(listRes, null, 0, 100);
		
		if(list1==null||list1.size()==0)return null;
		
		List<BaseEntity> rlist = new ArrayList<BaseEntity>();
		
		for(BaseEntity b:list1){
			ProductPackageItem ppi = (ProductPackageItem)b;
			Product p = (Product)Tools.getManager(Product.class).get(ppi.getGdspktdtl_gdsid());
			if(ProductHelper.isShow(p)&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0){
				rlist.add(ppi);
			}
		}
		return rlist;
	}
	
	/**
	 * �������ID����Ʒ��ID��ø���Ʒ�������ϸ
	 * @param gdspkdId - ���ID
	 * @param productId - ��ƷID
	 * @return ProductPackageItem
	 */
	public static ProductPackageItem getProductPackageItem(String gdspkdId , String productId){
		if(Tools.isNull(gdspkdId) || Tools.isNull(productId)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdspktdtl_pktid", new Long(gdspkdId)));
		listRes.add(Restrictions.eq("gdspktdtl_gdsid", new Long(productId)));
		
		List list = manager.getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		
		return (ProductPackageItem)list.get(0);
	}

}
