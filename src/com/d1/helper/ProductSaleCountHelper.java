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
 * 商品销量工具类
 * @author zpp
 *
 */
public class ProductSaleCountHelper {
	/**
	 * 商品id商品信息列表
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
	 * 得到商品销量记录
	 * @param product
	 * @return
	 */
	public static List<ProductSaleCount> getAllProductSaleCount(Product product){
		ProductSaleCountManager manager = (ProductSaleCountManager)Tools.getManager(ProductSaleCount.class);
		return manager.getTotalProductSaleCountList(product.getId());
		
	}
	
	/**
	 * 得到商品总销量
	 * @return
	 */
	public static int getProductSalesCount(Product product){
		if(product==null)return 0;
		int sales = 0 ;
		
		//由于销量分了sku，这里把所有sku的销量加起来
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
	 * 得到商品周销量
	 * @param product
	 * @return
	 */
	public static int getProductWeekSalesCount(Product product){
		if(product==null)return 0;
		int sales = 0 ;
		
		//由于销量分了sku，这里把所有sku的销量加起来
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
