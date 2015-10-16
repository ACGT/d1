package com.d1.helper;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import org.hibernate.criterion.Order;

import com.d1.bean.Gdsser;

import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;


/**
 * 商品尺寸对照表
 * @author 
 *
 */
public class GdsserHelper {
	
	public static Gdsser getById(String id) {
		if(Tools.isNull(id)) return null;
		return (Gdsser)Tools.getManager(Gdsser.class).get(id);
	}
	
	public static ArrayList<Gdsser> getGdsserByBrandid(String brandid)
	{
		
		ArrayList<Gdsser> list=new ArrayList<Gdsser>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		if(brandid!=null&&brandid.length()>0&&Tools.isNumber(brandid))
		{
		  clist.add(Restrictions.eq("gdsser_brandid",brandid));
		}
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdsser_sort"));
		olist.add(Order.desc("gdsser_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdsser.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdsser)b);
				}
			}
		}
		return list;
		
	}
	
	public static Gdsser getGdsserByName(String name)
	{
		
		ArrayList<Gdsser> list=new ArrayList<Gdsser>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		if(name!=null&&name.length()>0)
		{
		  clist.add(Restrictions.eq("gdsser_title",name));
		}
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdsser_sort"));
		olist.add(Order.desc("gdsser_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdsser.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdsser)b);
				}
			}
		}
		if(list!=null&&list.size()>0&&list.get(0)!=null){
		    return list.get(0);
		}
		else return null;
		
	}
	
}
