package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.SearchList;
import com.d1.bean.SearchListItem;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 获取搜索条件的工具类
 * @author kk
 */
public class SearchListHelper {
	/**
	 * 根据分类编号获取搜索条件分组。得到如“像素”“价格”“内存大小”这些搜索基本单位！
	 * @param rackcode
	 * @return
	 */
	public static ArrayList<SearchList> getSearchList(String rackcode){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("searchlist_rackcode", rackcode));
		clist.add(Restrictions.eq("searchlist_showflag", new Long(1)));
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("searchlist_seq"));
		
		List<BaseEntity> list = Tools.getManager(SearchList.class).getList(clist, olist, 0, 100);
		if(list==null||list.size()==0)return null;
		
		ArrayList<SearchList> rlist = new ArrayList<SearchList>();
		for(BaseEntity b:list){
			rlist.add((SearchList)b);
		}
		
		return rlist ;
	}
	
	/**
	 * 根据分类和制定的搜索名称（如像素、价格、材质）获取搜索条件明细列表，参看searchdtl表
	 * @param rackcode
	 * @param searchlist_name
	 * @return
	 */
	public static ArrayList<SearchListItem> getSearchListItems(String rackcode,String searchlist_name){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("searchdtl_rackcode", rackcode));
		clist.add(Restrictions.eq("searchdtl_searchlist_name", searchlist_name));
		clist.add(Restrictions.eq("searchdtl_showflag", new Long(1)));
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("id"));
		
		List<BaseEntity> list = Tools.getManager(SearchListItem.class).getList(clist, olist, 0, 100);
		if(list==null||list.size()==0)return null;
		
		ArrayList<SearchListItem> rlist = new ArrayList<SearchListItem>();
		for(BaseEntity b:list){
			rlist.add((SearchListItem)b);
		}
		
		return rlist ;
	}
	
	/**
	 * 根据分类号获取价格规格的值
	 * @param code
	 * @return
	 */
	public static ArrayList<SearchList> getSearchList_price(String code)
	{
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("searchlist_rackcode", code));
		clist.add(Restrictions.eq("searchlist_showflag", new Long(1)));
		clist.add(Restrictions.like("searchlist_name", "%价格%"));
		clist.add(Restrictions.ne("searchlist_context", ""));
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("searchlist_seq"));
		
		List<BaseEntity> list = Tools.getManager(SearchList.class).getList(clist, olist, 0, 100);
		if(list==null||list.size()==0)return null;
		
		ArrayList<SearchList> rlist = new ArrayList<SearchList>();
		for(BaseEntity b:list){
			rlist.add((SearchList)b);
		}
		
		return rlist ;
		
	}
}
