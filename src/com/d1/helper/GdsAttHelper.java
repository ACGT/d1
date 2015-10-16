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

import com.d1.bean.GdsAtt;

import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;
import com.taobao.api.domain.Order;

/**
 * 商品尺寸对照表
 * @author 
 *
 */
public class GdsAttHelper {
	
	public static ArrayList<GdsAtt> getGdsAttByGdsid(String gdsid)
	{
		
		ArrayList<GdsAtt> list=new ArrayList<GdsAtt>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsatt_gdsid",gdsid));
		clist.add(Restrictions.eq("gdsatt_type", "skuhelp"));
		List<BaseEntity> blist=Tools.getManager(GdsAtt.class).getList(clist, null, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((GdsAtt)b);
				}
			}
		}
		return list;
		
	}
	
}
