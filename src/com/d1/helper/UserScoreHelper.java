package com.d1.helper;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.UserScore;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 用户积分工具类
 * @author zpp
 *
 */
public class UserScoreHelper {

	/**
	 * 根据用户id获取对应积分信息
	 * @return
	 */
	public static ArrayList<UserScore> getUserScoreInfo(String mbrid){
		ArrayList<UserScore> rlist = new ArrayList<UserScore>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
		
		List<Order> olist= new ArrayList<Order>();
		olist.add(Order.desc("usrscore_createdate"));
		List<BaseEntity> list = Tools.getManager(UserScore.class).getList(clist, olist, 0, 1000);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((UserScore)be);
		}
		return rlist ;
	}
	/**
	 * 根据用户id获取生日赠送积分信息
	 * @return
	 */
	public static ArrayList<UserScore> getUserScoreBirInfo(String mbrid){
		ArrayList<UserScore> rlist = new ArrayList<UserScore>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
		clist.add(Restrictions.eq("usrscore_type", new Long(2)));
		
		List<Order> olist= new ArrayList<Order>();
		olist.add(Order.desc("usrscore_createdate"));
		List<BaseEntity> list = Tools.getManager(UserScore.class).getList(clist, olist, 0, 1000);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((UserScore)be);
		}
		return rlist ;
	}
	/**
	 * 根据用户id得到用户积分
	 * @return
	 */
	public static float getRealScore(String mbrid){
		ArrayList<UserScore> list = getUserScoreInfo(mbrid);
		float realsocre=0f;
		if(list!=null){
			for(UserScore userScore:list){
				if(userScore.getUsrscore_realscr()!=null && (!Tools.isNull(userScore.getUsrscore_realscr().toString()))){
					realsocre+=userScore.getUsrscore_realscr().floatValue();
				}
			}
			
		}
		return realsocre;
	}
	/**
	 * 查询在一个月内是否有评价积分
	 */
	public static ArrayList<UserScore> getUserCommentScore(String mbrid){
		ArrayList<UserScore> rlist = new ArrayList<UserScore>();
		Calendar ca = Calendar.getInstance();
	    int year = ca.get(Calendar.YEAR);//获取年份
	    int month=ca.get(Calendar.MONTH)+1;//获取月份
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("usrscore_mbrid", new Long(mbrid)));
		clist.add(Restrictions.eq("usrscore_type", new Long(4)));
		clist.add(Restrictions.eq("usrscore_year", year+""));
		clist.add(Restrictions.eq("usrscore_month", month+""));
		List<BaseEntity> list = Tools.getManager(UserScore.class).getList(clist, null, 0, 10);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((UserScore)be);
		}
		return rlist ;
	}
}
