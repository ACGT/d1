package com.d1.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Gdscoll_rackcode;
import com.d1.bean.PromotionProduct;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

public class Gdscoll_rackcodeHelper {
	/**
	 * 根据类别号和盒子号获取分类号
	 * 
	 * @param category 类别号
	 * @param box 盒子号
	 * @return 获取满足调价的列表
	 */
	public static ArrayList<Gdscoll_rackcode> getGdsAttByGdsid(String category,String box)
	{
	    if(category==null||box==null||!Tools.isNumber(box)||!Tools.isNumber(category)) return null;	
		ArrayList<Gdscoll_rackcode> list=new ArrayList<Gdscoll_rackcode>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gr_box",new Long(box)));
		clist.add(Restrictions.eq("gr_category", new Long(category)));
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gr_order"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll_rackcode.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll_rackcode)b);
				}
			}
		}
		return list;
		
	}
	
	/**
	 * 根据分类号和盒子号获取对象
	 * 
	 * @param category 分类号号
	 * @param box 盒子号
	 * @return 获取满足调价的列表
	 */
	public static Gdscoll_rackcode getGdsAttByGdsids(String code,int box)
	{
	    if(code==null||!Tools.isNumber(code)||box<=0||box>9) return null;	
		ArrayList<Gdscoll_rackcode> list=new ArrayList<Gdscoll_rackcode>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gr_box",new Long(box)));
		clist.add(Restrictions.eq("gr_code", code));
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gr_order"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll_rackcode.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll_rackcode)b);
				}
			}
		}
		if(list!=null&&list.size()>0){
		   return list.get(0);
		}
		else {
			return null;
		}
		
	}
}
