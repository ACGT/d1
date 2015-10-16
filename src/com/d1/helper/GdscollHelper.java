package com.d1.helper;


import java.util.ArrayList;
import java.util.List;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import org.hibernate.criterion.Order;

import com.d1.bean.Gdscoll;
import com.d1.bean.Gdscolldetail;
import com.d1.bean.Product;

import com.d1.dbcache.core.BaseEntity;

import com.d1.util.Tools;

public class GdscollHelper {

	public static ArrayList<Gdscoll> getGdscollBysceneid(String sid)
	{
		
		ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		if(sid!=null&&sid.length()>0&&Tools.isNumber(sid))
		{
		  clist.add(Restrictions.eq("gdscoll_serid",new Long(Tools.parseLong(sid))));
		}
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscoll_sort"));
		olist.add(Order.desc("gdscoll_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		return list;
		
	}
	public static ArrayList<Gdscolldetail> getGdscolldetailBygdsid(String gdsid)
	{
	   if (Tools.isNull(gdsid))	return null;
	   
		ArrayList<Gdscolldetail> list=new ArrayList<Gdscolldetail>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	  clist.add(Restrictions.eq("gdscolldetail_gdsid",gdsid));
	  clist.add(Restrictions.eq("gdscolldetail_flag",new Long(1)));
		List<BaseEntity> blist=Tools.getManager(Gdscolldetail.class).getList(clist, null, 0, 6);
		
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscolldetail)b);
				}
			}
		}
		return list;
		
	}
	
	public static ArrayList<Gdscoll> getGdscollBySerid(String sid,Long sex)
	{
		
		ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		if(sid!=null&&sid.length()>0&&Tools.isNumber(sid))
		{
		  clist.add(Restrictions.eq("gdscoll_serid",new Long(Tools.parseLong(sid))));
		}
		clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
		 clist.add(Restrictions.eq("gdscoll_cate",sex));
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscoll_sort"));
		olist.add(Order.desc("gdscoll_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		return list;
		
	}
	public static ArrayList<Gdscolldetail> getGdscollBycollid(String sid)
	{
		
		ArrayList<Gdscolldetail> list=new ArrayList<Gdscolldetail>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		if(sid!=null&&sid.length()>0&&Tools.isNumber(sid))
		{
		  clist.add(Restrictions.eq("gdscolldetail_gdscrollid",new Long(Tools.parseLong(sid))));
		}
		clist.add(Restrictions.eq("gdscolldetail_flag",new Long(1)));
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscolldetail_sort"));
		olist.add(Order.desc("gdscolldetail_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscolldetail.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscolldetail)b);
				}
			}
		}
		return list;
		
	}
	
	
	public static ArrayList<Gdscolldetail> getGdscollBycollid1(String sid)
	{
		
		ArrayList<Gdscolldetail> list=new ArrayList<Gdscolldetail>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		if(sid!=null&&sid.length()>0&&Tools.isNumber(sid))
		{
		  clist.add(Restrictions.eq("gdscolldetail_gdscrollid",new Long(Tools.parseLong(sid))));
		}
		
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscolldetail_sort"));
		olist.add(Order.desc("gdscolldetail_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscolldetail.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscolldetail)b);
				}
			}
		}
		return list;
		
	}
	
	/*
	 * 
	 * 根据场景id获取所有搭配
	 */
	public static ArrayList<Gdscoll> getGdscollByseceid(String sid)
	{
		
		ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		if(sid!=null&&sid.length()>0&&Tools.isNumber(sid))
		{
		  clist.add(Restrictions.eq("gdscoll_sceneid",new Long(Tools.parseLong(sid))));
		}
		clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscoll_sort"));
		olist.add(Order.desc("gdscoll_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		return list;
		
	}
	//情侣搭配
	public static ArrayList<Gdscoll> getGdscollForLover()
	{
		ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		clist.add(Restrictions.ge("gdscoll_cate",new Long(3)));
		clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
		
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("gdscoll_bgid"));
		olist.add(Order.asc("gdscoll_cate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		return list;
		
	}
	//根据搭配获取系列
	public static ArrayList<Gdscolldetail> getScoll(String productid){
		
		ArrayList<Gdscolldetail> list=new ArrayList<Gdscolldetail>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		
		clist.add(Restrictions.eq("gdscolldetail_gdsid",productid));
		
		List<BaseEntity> blist=Tools.getManager(Gdscolldetail.class).getList(clist, null, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscolldetail)b);
				}
			}
		}
		return list;
		
	}
	
	//根据商品编号获取搭配（如果商品编号为空，获取全部搭配）
	public static ArrayList<Gdscoll>  getGdscollByGdsid(String gdsid)
	{
		  boolean flag=false;
		  int count=0;
		  ArrayList<Gdscoll> result=new ArrayList<Gdscoll>();
		  ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
		  ArrayList<Gdscolldetail> dlist=new ArrayList<Gdscolldetail>();
		
			List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdscolldetail_gdsid",gdsid));
			clist.add(Restrictions.eq("gdscolldetail_flag",new Long(1)));
			
			List<BaseEntity> blist=Tools.getManager(Gdscolldetail.class).getList(clist, null, 0, 10000);
			if(blist!=null&&blist.size()>0)
			{
				for(BaseEntity b:blist)
				{
					if(b!=null)
					{
						dlist.add((Gdscolldetail)b);
					}
				}
			}
			
			if(dlist!=null&&dlist.size()>0)
			{
				for(Gdscolldetail gd:dlist)
				{
					if(gd!=null&&gd.getGdscolldetail_gdscrollid()!=null&&Tools.isNumber(gd.getGdscolldetail_gdscrollid().toString()))
					{
						Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).findByProperty("id",gd.getGdscolldetail_gdscrollid().toString());
					    if(gdscoll!=null&&gdscoll.getGdscoll_flag()!=null&&gdscoll.getGdscoll_flag().longValue()==1)
					    {
					    	list.add(gdscoll);
					    }
					}
				}	
				if(gdsid.length()==0)
				{
					result=list;
				}
				else
				{
					for(Gdscoll gdscoll:list)
					{
						if(gdscoll!=null)
						{
							ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
							if(gdlist!=null)
							{
								for(Gdscolldetail gd:gdlist)
								{
									if(gd.getGdscolldetail_gdsid().equals(gdsid))
									{
										flag=true;
									}
									Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
									if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1){
										count++;
									}
								}
							}
							if(flag&&count>1)
							{
								result.add(gdscoll);
							}
							flag=false;
							count=0;
						}
						
					}
					return result;
				}
			}
			return result;
	}
	
	
}
