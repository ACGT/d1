package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.OrderItemBase;


public class OrderItemTimeComparator implements Comparator<OrderItemBase>{
	@Override
	public int compare(OrderItemBase p0, OrderItemBase p1) {
		if(p0.getOdrdtl_creatdate()!=null&&p1.getOdrdtl_creatdate()!=null){
			if(p0.getOdrdtl_creatdate().getTime()<p1.getOdrdtl_creatdate().getTime()){
				return 1 ;
			}else if(p0.getOdrdtl_creatdate().getTime()==p1.getOdrdtl_creatdate().getTime()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}
