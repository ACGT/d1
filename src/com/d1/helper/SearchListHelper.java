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
 * ��ȡ���������Ĺ�����
 * @author kk
 */
public class SearchListHelper {
	/**
	 * ���ݷ����Ż�ȡ�����������顣�õ��硰���ء����۸񡱡��ڴ��С����Щ����������λ��
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
	 * ���ݷ�����ƶ����������ƣ������ء��۸񡢲��ʣ���ȡ����������ϸ�б��ο�searchdtl��
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
	 * ���ݷ���Ż�ȡ�۸����ֵ
	 * @param code
	 * @return
	 */
	public static ArrayList<SearchList> getSearchList_price(String code)
	{
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("searchlist_rackcode", code));
		clist.add(Restrictions.eq("searchlist_showflag", new Long(1)));
		clist.add(Restrictions.like("searchlist_name", "%�۸�%"));
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
