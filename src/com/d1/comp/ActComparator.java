package com.d1.comp;

import java.util.Comparator;

import com.d1.bean.Cart;

public  class ActComparator implements Comparator<Cart>{
	@Override
	public int compare(Cart c0, Cart c1) {	
		
		if(c0.getActid()!=null&&c1.getActid()!=null && c0.getActid().longValue() >c1.getActid().longValue()){
			return 1 ;
		}else if(c0.getActid()!=null&&c1.getActid()!=null && c0.getActid().longValue() >c1.getActid().longValue()){
			return 0 ;
		}else{
			return -1 ;
		}
	}
}
