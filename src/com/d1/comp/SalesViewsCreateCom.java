package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Product;

public class SalesViewsCreateCom  implements Comparator<Product>{
	public int compare(Product p0, Product p1) {
		//�Ȱ����Ƿ�ȱ������
		if(p0.getGdsmst_createdate()!=null&&p1.getGdsmst_createdate()!=null){
			if(p0.getGdsmst_createdate().getTime()>p1.getGdsmst_createdate().getTime()){
				return 1 ;
			}else if(p0.getGdsmst_createdate().getTime()==p1.getGdsmst_createdate().getTime()){
				
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
