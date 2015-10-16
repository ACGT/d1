package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.OrderBase;

public class OrderIdComparator implements Comparator<OrderBase>{

	@Override
	public int compare(OrderBase p0, OrderBase p1) {
		if(p0.getId()!=null&&p1.getId()!=null){
			return p0.getId().compareToIgnoreCase(p1.getId());
		}
		return 0;
	}

}