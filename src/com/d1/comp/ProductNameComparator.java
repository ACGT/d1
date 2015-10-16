package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;

/**
 * 按照商品名比较商品
 * @author kk
 *
 */
public class ProductNameComparator implements Comparator<Product>{

	@Override
	public int compare(Product p0, Product p1) {
		//先按照是否缺货排序
		if(p0.getGdsmst_ifhavegds()!=null&&p1.getGdsmst_ifhavegds()!=null){
			if(p0.getGdsmst_ifhavegds().longValue()>p1.getGdsmst_ifhavegds().longValue()){
				return -1;
			}else if(p0.getGdsmst_ifhavegds().longValue()<p1.getGdsmst_ifhavegds().longValue()){
				return 1;
			}
		}
		
		if(p0.getGdsmst_gdsname()!=null&&p1.getGdsmst_gdsname()!=null){
			if(p0.getGdsmst_gdsname().hashCode()>p1.getGdsmst_gdsname().hashCode()){
				return 1 ;
			}else if(p0.getGdsmst_gdsname().hashCode()==p1.getGdsmst_gdsname().hashCode()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}
