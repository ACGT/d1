package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;
import com.d1.util.Tools;

/**
 * 根据市场价排序，此为市场价<b>倒序</b>。。。
 * @author chengang
 * @createTime 2011-11-18 22:13:23
 *
 */
public class SalePriceComparator implements Comparator<Product> {

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
		
		float salePrice0 = Tools.floatValue(p0.getGdsmst_saleprice());
		float salePrice1 = Tools.floatValue(p1.getGdsmst_saleprice());
		if(salePrice0>salePrice1){
			return -1;
		}else if(salePrice0==salePrice1){
			return 0 ;
		}else{
			return 1;
		}
	}
	
}
