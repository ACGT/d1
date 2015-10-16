package com.d1.helper;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Hitlogindex;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;
import org.hibernate.criterion.Order;

import java.util.*;
public class HitlogindexHelper {
	//获取全部首页点击数据
	public	static ArrayList<Hitlogindex> getHitlogindexList(){
			
			ArrayList<Hitlogindex> rlist = new ArrayList<Hitlogindex>();
			
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			List<BaseEntity> list = Tools.getManager(Hitlogindex.class).getList(null, null, 0, 100);
			if(list==null||list.size()==0)return null;
			for(BaseEntity be:list){
				rlist.add((Hitlogindex)be);
			}
			return rlist ;
		}

	//获取全部首页点击数据
		public	static ArrayList<Hitlogindex> getHitlogindexListByDate(Date s,Date e){
				
				ArrayList<Hitlogindex> rlist = new ArrayList<Hitlogindex>();				
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.ge("createdate",s));
				clist.add(Restrictions.le("createdate",e));
				List<Order> olist = new ArrayList<Order>();
                olist.add(Order.desc("hits"));
				List<BaseEntity> list = Tools.getManager(Hitlogindex.class).getList(clist, olist, 0, 210);
				if(list==null||list.size()==0)return null;
				for(BaseEntity be:list){
					rlist.add((Hitlogindex)be);
				}
				return rlist ;
			}

	
}
