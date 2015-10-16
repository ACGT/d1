package com.d1.helper;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.ProductResult;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

public class ProductResultHelper {

	public static ArrayList<ProductResult> getTodayOtherProductGroups(){
		ArrayList<ProductResult> rlist = new ArrayList<ProductResult>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		
		clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));

		List<BaseEntity> list = Tools.getManager(ProductResult.class).getList(clist, null, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ProductResult)be);
		}
		return rlist ;
	}
}
