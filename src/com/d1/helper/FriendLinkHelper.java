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

import com.d1.bean.FriendLink;

import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;
import com.taobao.api.domain.Order;

/**
 * 友情链接
 * @author 
 *
 */
public class FriendLinkHelper {
	/*
	 * 获取所有友情链接
	 */
	public static ArrayList<FriendLink> getFriendLinkList()
	{
		
		ArrayList<FriendLink> list=new ArrayList<FriendLink>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("friendlink_type", new Long(0)));
		List<BaseEntity> blist=Tools.getManager(FriendLink.class).getList(clist, null, 0, 1000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((FriendLink)b);
				}
			}
		}
		return list;
		
	}
	
   /*
    * 根据id获取对象
    */
	public static FriendLink getFrindLinkByid(String id)
	{
		if(Tools.isNull(id)) return null;
		if(Tools.isNumber(id)) return null;
		return (FriendLink)Tools.getManager(FriendLink.class).get(id);
	}
}
