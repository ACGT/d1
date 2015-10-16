package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;

/**
 * 按照销量比较商品，销量是计算出来的，系统加<br/>
 * 载时从数据库读取，也可以隔一段时间更新一次销量<br/>
 * @author kk
 *
 */
public class SalesComparator implements Comparator<Product>{

	@Override
	public int compare(Product p0, Product p1) {	
		
		if(p0.getGdsmst_salecount()>p1.getGdsmst_salecount()){
			return 1 ;
		}else if(p0.getGdsmst_salecount()==p1.getGdsmst_salecount()){
			return 0 ;
		}else{
			return -1 ;
		}
	}
}
