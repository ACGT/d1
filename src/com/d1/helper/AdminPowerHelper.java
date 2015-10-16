package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.AdminPower;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

public class AdminPowerHelper {
public	static ArrayList<AdminPower> getAwardByGdsid(String userid,String powername){
		
		ArrayList<AdminPower> rlist = new ArrayList<AdminPower>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rgtusr_usrid", userid));
		clist.add(Restrictions.eq("rgtusr_rgtname", powername));

		List<BaseEntity> list = Tools.getManager(AdminPower.class).getList(clist, null, 0, 10);
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((AdminPower)be);
		}
		//System.out.print(rlist.size());
		return rlist ;
	}
}
