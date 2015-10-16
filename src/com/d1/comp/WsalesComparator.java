package com.d1.comp;
import java.util.Comparator;

import com.d1.bean.Product;
/**
 * �����������Ƚ���Ʒ��gdsmst_wsalecount�ֶ�
 * @author wdx
 *
 */
public class WsalesComparator implements Comparator<Product>{
	@Override
	public int compare(Product p0, Product p1) {
		
		if(p0.getGdsmst_wsalecount()>p1.getGdsmst_wsalecount()){
			return 1 ;
		}else if(p0.getGdsmst_wsalecount()==p1.getGdsmst_wsalecount()){
			return 0 ;
		}else{
			return -1 ;
		}
	}
}



