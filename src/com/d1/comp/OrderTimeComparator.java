package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.OrderBase;

public class OrderTimeComparator implements Comparator<OrderBase>{
	@Override
	public int compare(OrderBase p0, OrderBase p1) {
		if(p0.getOdrmst_orderdate()!=null&&p1.getOdrmst_orderdate()!=null){
			if(p0.getOdrmst_orderdate().getTime()>p1.getOdrmst_orderdate().getTime()){
				return 1 ;
			}else if(p0.getOdrmst_orderdate().getTime()==p1.getOdrmst_orderdate().getTime()){
				return 0 ;
			}else{
				return -1 ;
			}
		}
		return 0;
	}
}
