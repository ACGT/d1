package com.d1.comp;

import java.util.Comparator;


import com.d1.bean.Product;

public class ProductColorCompartor  implements Comparator<Product>{

	@Override
	public int compare(Product p0, Product p1) {
		if(p0.getGdsmst_stdvalue2()!=null&&p1.getGdsmst_stdvalue2()!=null){
			return p0.getGdsmst_stdvalue2().compareToIgnoreCase(p1.getGdsmst_stdvalue2());
		}
		return 0;
	}

}