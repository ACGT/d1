package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import org.hibernate.criterion.Order;

import com.d1.bean.MyShow;
import com.d1.bean.MyShowCom;
import com.d1.bean.OrderScore;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

public class ShowOrderHelper {
//获取商品的晒单数
	public static int getSdLenByGdsid(String gdsid){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("myshow_gdsid", gdsid));
		clist.add(Restrictions.eq("myshow_status", new Long(1)));
		clist.add(Restrictions.eq("myshow_show", new Long(1)));
		return Tools.getManager(MyShow.class).getLength(clist);
	}
//获取该商品的晒单
public static ArrayList<MyShow> getAllShowByGdsid(String gdsid){
		
		ArrayList<MyShow> list=new ArrayList<MyShow>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("myshow_gdsid", gdsid));
		listRes.add(Restrictions.eq("myshow_show", new Long(1)));
		listRes.add(Restrictions.eq("myshow_status", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("myshow_createdate"));
		List<BaseEntity> b_list = Tools.getManager(MyShow.class).getList(listRes, olist, 0, 1000);
		if(b_list==null || b_list.size()==0) return null;

			for(BaseEntity be:b_list){
				list.add((MyShow)be);
			}
		return list;
	}
//获取已晒单
public static ArrayList<MyShow> getAllMyShow(String mbrid){
	
	ArrayList<MyShow> list=new ArrayList<MyShow>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("myshow_mbrid", new Long(mbrid)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("myshow_createdate"));
	List<BaseEntity> b_list = Tools.getManager(MyShow.class).getList(listRes, olist, 0, 1000);
	if(b_list==null || b_list.size()==0) return null;

		for(BaseEntity be:b_list){
			list.add((MyShow)be);
		}
	return list;
}

//获取晒单的商品图
public static ArrayList<MyShow> getMyShowDetail(String gdsid,String orderid,String odtlid){	
	ArrayList<MyShow> list=new ArrayList<MyShow>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("myshow_gdsid", gdsid));
	listRes.add(Restrictions.eq("myshow_odrid", orderid));
	listRes.add(Restrictions.eq("myshow_subodrid", odtlid));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("myshow_createdate"));
	List<BaseEntity> b_list = Tools.getManager(MyShow.class).getList(listRes, olist, 0, 1000);
	if(b_list==null || b_list.size()==0) return null;

		for(BaseEntity be:b_list){
			list.add((MyShow)be);
		}
	return list;
}
//获取我的晒单
public static ArrayList<MyShow> getMyShow(String mbrid,int start,int end){	
	ArrayList<MyShow> list=new ArrayList<MyShow>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("myshow_mbrid", new Long(mbrid)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("myshow_createdate"));
	List<BaseEntity> b_list = Tools.getManager(MyShow.class).getList(listRes, olist, start, end);
	if(b_list==null || b_list.size()==0) return null;

		for(BaseEntity be:b_list){
			list.add((MyShow)be);
		}
	return list;
}
public static ArrayList<MyShow> getSdScoresBymbridAnddate(String mbrid,Date date,Date predate)
{
	ArrayList<MyShow> rlist=new ArrayList<MyShow>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("myshow_mbrid",Tools.parseLong(mbrid)));
	listRes.add(Restrictions.gt("myshow_score", new Long(0)));
	listRes.add(Restrictions.ge("myshow_createdate",predate));
	listRes.add(Restrictions.le("myshow_createdate", date));
	
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("myshow_createdate"));
	
	List<BaseEntity> list = Tools.getManager(MyShow.class).getList(listRes, olist, 0, 1000);
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((MyShow)be);
	}
	
	return rlist ;
}
}

