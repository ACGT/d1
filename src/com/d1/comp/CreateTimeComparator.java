package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;

/**
 * 按照上架时间比较商品
 * @author kk
 *
 */
public class CreateTimeComparator implements Comparator<Product>{

	@Override
	public int compare(Product p0, Product p1) {
		
		if(p0.getGdsmst_autoupdatedate()!=null&&p1.getGdsmst_autoupdatedate()!=null&&p0.getGdsmst_validflag()!=null
				&&p1.getGdsmst_validflag()!=null&&p0.getGdsmst_validflag().longValue()==1&&p1.getGdsmst_validflag()==1){
			if(p0.getGdsmst_autoupdatedate().getTime()>p1.getGdsmst_autoupdatedate().getTime()){
				return 1 ;
			}else if(p0.getGdsmst_autoupdatedate().getTime()==p1.getGdsmst_autoupdatedate().getTime()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
		
	}
}
