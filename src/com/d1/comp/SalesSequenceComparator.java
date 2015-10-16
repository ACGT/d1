package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;

/**
 * 根据市场价排序，此为市场价<b>倒序</b>。。。
 * @author chengang
 * @createTime 2011-11-18 22:13:23
 *
 */
public class SalesSequenceComparator implements Comparator<Product> {

	@Override
	public int compare(Product p0, Product p1) {
		//先按照是否缺货排序
		if(p0.getSequence()>p1.getSequence()){
			return 1;
		}else if(p0.getSequence()<p1.getSequence()){
			return -1;
		}
		
		if(p0.getGdsmst_updatedate()!=null&&p1.getGdsmst_updatedate()!=null){
			if(p0.getGdsmst_updatedate().getTime()>p1.getGdsmst_updatedate().getTime()){
				return 1 ;
			}else if(p0.getGdsmst_updatedate().getTime()==p1.getGdsmst_updatedate().getTime()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}
	
}
