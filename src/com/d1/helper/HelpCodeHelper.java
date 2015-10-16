package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.HelpCode;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 帮助主题常用工具类
 * @author zpp
 *
 */
public class HelpCodeHelper {

	/**
	 * 获得帮助大主题
	 * @return
	 */
	public static ArrayList<HelpCode> getHelpTheme(){
		ArrayList<HelpCode> rlist = new ArrayList<HelpCode>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("helpcode_typeid", new Long(1)));
		clist.add(Restrictions.ne("id", "90"));
		
		//加入排序条件
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("id"));
		
		List<BaseEntity> list = Tools.getManager(HelpCode.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((HelpCode)be);
		}
		return rlist ;
	}
	/**
	 * 获得帮助主题
	 * @return
	 */
	public static ArrayList<HelpCode> getHelpObject(String code){
		ArrayList<HelpCode> rlist = new ArrayList<HelpCode>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.ne("helpcode_typeid", new Long(1)));
		clist.add(Restrictions.like("id", code+"%"));

		//加入排序条件
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("id"));
		
		List<BaseEntity> list = Tools.getManager(HelpCode.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((HelpCode)be);
		}
		return rlist ;
	}

	/**
	 * 获得帮助大主题
	 * @return
	 */
	public static HelpCode getHelpThemeByCode(String code){
		
		/*ArrayList<HelpCode> rlist = new ArrayList<HelpCode>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("id", code));
		
		//加入排序条件
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("id"));
		
		List<BaseEntity> list = Tools.getManager(HelpCode.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((HelpCode)be);
		}
		return rlist ;*/
		
		return (HelpCode)Tools.getManager(HelpCode.class).get(code);
	}
}
