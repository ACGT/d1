package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;

public class SalesViewPNameCom implements Comparator<Product>{
	public int compare(Product p0, Product p1) {
		//先按照是否缺货排序
		if(p0.getGdsmst_gdsname()!=null&&p1.getGdsmst_gdsname()!=null){
			if(p0.getGdsmst_gdsname().hashCode()>p1.getGdsmst_gdsname().hashCode()){
				return 1 ;
			}else if(p0.getGdsmst_gdsname().hashCode()==p1.getGdsmst_gdsname().hashCode()){
				
				if(p0.getGdsmst_updatedate()!=null&&p1.getGdsmst_updatedate()!=null){
					if(p0.getGdsmst_updatedate().getTime()>p1.getGdsmst_updatedate().getTime()){
						return 1;
					}else if(p0.getGdsmst_updatedate().getTime()<p1.getGdsmst_updatedate().getTime()){
						return -1;
					}
				}
				
				return 0 ;
				
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}
