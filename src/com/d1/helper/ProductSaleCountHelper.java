package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Product;
import com.d1.bean.ProductSaleCount;
import com.d1.dbcache.core.BaseEntity;
import com.d1.manager.ProductSaleCountManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;
/**
 * ��Ʒ����������
 * @author zpp
 *
 */
public class ProductSaleCountHelper {
	/**
	 * ��Ʒid��Ʒ��Ϣ�б�
	 * @param p
	 * @return
	 */
	public static ArrayList<ProductSaleCount> getProductSaleCountById(ArrayList<String> gdslist){
		ArrayList<ProductSaleCount> list=new ArrayList<ProductSaleCount>();
		for(int i=0;i<gdslist.size();i++){
			if(!StringUtils.isDigits(gdslist.get(i)))continue;
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("id", gdslist.get(i)));
			
			List<BaseEntity> b_list = Tools.getManager(ProductSaleCount.class).getList(clist, null, 0, 1000);
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((ProductSaleCount)be);
				}
			}
			
		}
		return list;
	}
	
	/**
	 * �õ���Ʒ������¼
	 * @param product
	 * @return
	 */
	public static List<ProductSaleCount> getAllProductSaleCount(Product product){
		ProductSaleCountManager manager = (ProductSaleCountManager)Tools.getManager(ProductSaleCount.class);
		return manager.getTotalProductSaleCountList(product.getId());
		
	}
	
	/**
	 * �õ���Ʒ������
	 * @return
	 */
	public static int getProductSalesCount(Product product){
		if(product==null)return 0;
		int sales = 0 ;
		
		//������������sku�����������sku������������
		List<ProductSaleCount> slist = getAllProductSaleCount(product);
		if(slist!=null&&slist.size()>0){
			for(ProductSaleCount ps:slist){
				if(ps.getGdssale_salecount()!=null){
					sales+=ps.getGdssale_salecount().longValue();
				}
			}
		}
		return sales ;
	}
	
	/**
	 * �õ���Ʒ������
	 * @param product
	 * @return
	 */
	public static int getProductWeekSalesCount(Product product){
		if(product==null)return 0;
		int sales = 0 ;
		
		//������������sku�����������sku������������
		List<ProductSaleCount> slist = getAllProductSaleCount(product);
		if(slist!=null&&slist.size()>0){
			for(ProductSaleCount ps:slist){
				if(ps.getGdssale_weeksalecount()!=null){
					sales+=ps.getGdssale_weeksalecount().longValue();
				}
			}
		}
		return sales ;
	}
}
