package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Product;
import com.d1.bean.ProductPackage;
import com.d1.bean.ProductPackageItem;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * ��Ʒ��ϱ�����
 * @author chengang
 * @createTime 2011��11��16��14:17:47
 *
 */
public class ProductPackageHelper {
	
	/**
	 * ProductPackage
	 */
	public static final BaseManager manager = Tools.getManager(ProductPackage.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return ProductPackage
	 */
	public static ProductPackage getById(String id){
		if(Tools.isNull(id)) return null;
		return (ProductPackage)manager.get(id);
	}
	

	
	/**
	 * �õ������Ʒ�ļ���
	 * @param productId - ��ƷID
	 * @param count - ��ȡ��ϵ�����
	 * @return List<ProductPackage>
	 */
	public static List getGdspktByGdsid(String productId , int count){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdspktdtl_gdsid", productId));
		
		int length = ProductPackageItemHelper.manager.getLength(listRes);
		
		if(length <= 0) return null;
		List list = ProductPackageItemHelper.manager.getList(listRes, null, 0, length);
		
		List<ProductPackage> pktIdList = new ArrayList<ProductPackage>();
		
		int num = 0;
		
		int size = list.size();
		for(int i=0;i<size;i++){
			ProductPackageItem ppi = (ProductPackageItem)list.get(i);
			
			Long pktLong = ppi.getGdspktdtl_pktid();
			
			ProductPackage pp = getById(String.valueOf(pktLong));
			
			if(pp != null){
				Product product = (Product)Tools.getManager(Product.class).get(ppi.getGdspktdtl_gdsid());
				long currentTime = System.currentTimeMillis();
				//ֻȡ�ϼܵ���Ʒ
				if(ProductHelper.isShow(product)&&Tools.longValue(pp.getGdspkt_status())==1 && Tools.isNull(pp.getGdspkt_gdsid()) && (currentTime > Tools.dateValue(pp.getGdspkt_startdate()) && currentTime < Tools.dateValue(pp.getGdspkt_enddate()))){
					long pktid = Tools.longValue(pktLong);
					//�����ID 634 - 639�����
					if(pktid >0 && (pktid > 639 || pktid<634)){
						
						List<BaseEntity> listItem = ProductPackageItemHelper.getGdsmstByGdspid(pp.getId());
						if(listItem!=null&&listItem.size()>1){
							pktIdList.add(pp);
							num++;
							if(num >= count) break;
						}
					}
				}
			}
		}
		
		return pktIdList;
	}

}
