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

import com.d1.bean.Gdsscene;

import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;


/**
 * ³¡¾°
 * @author 
 *
 */
public class GdssceneHelper {
	
	public static ArrayList<Gdsscene> getGdsserByBrandid(String sid)
	{
		
		ArrayList<Gdsscene> list=new ArrayList<Gdsscene>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		if(sid!=null&&sid.length()>0&&Tools.isNumber(sid))
		{
		  clist.add(Restrictions.eq("gdsscene_gdserid",new Long(Tools.parseLong(sid))));
		}
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdsscene_sort"));
		olist.add(Order.desc("gdsscene_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdsscene.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdsscene)b);
				}
			}
		}
		return list;
		
	}
	
}
