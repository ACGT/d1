package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;

/**
 * ���������Ƚ���Ʒ�������Ǽ�������ģ�ϵͳ��<br/>
 * ��ʱ�����ݿ��ȡ��Ҳ���Ը�һ��ʱ�����һ������<br/>
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
