package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.UserScore;
import com.d1.bean.UsrPoint;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 用户积分工具类
 * @author zpp
 *
 */
public class UsrPointHelper {
	public static BaseEntity insertUsrPoint(UsrPoint usrpoint) {
		//type 1:订单金额积分2:评价积分
		return Tools.getManager(UsrPoint.class).create(usrpoint);
	}
	
	public static long getUseScore(String mbrid) {
		ArrayList<UsrPoint> list = getUserScoreInfo(mbrid);
		long realsocre=0;
		if(list!=null){
			for(UsrPoint userScore:list){
				if(userScore.getUsrpoint_score()!=null && (userScore.getUsrpoint_score().longValue() != 0)){
					realsocre+=userScore.getUsrpoint_score().longValue();
				}
			}
			
		}
		return realsocre;
	}
	public static long getUseScoreshop(String mbrid,String shopcode) {
		ArrayList<UsrPoint> list = getUserScoreInfoshop(mbrid,shopcode);
		long realsocre=0;
		if(list!=null){
			for(UsrPoint userScore:list){
				if(userScore.getUsrpoint_score()!=null && (userScore.getUsrpoint_score().longValue() != 0)){
					realsocre+=userScore.getUsrpoint_score().longValue();
				}
			}
			
		}
		return realsocre;
	}
	public static ArrayList<UsrPoint> getUserScoreInfoshop(String mbrid,String shopcode){
		ArrayList<UsrPoint> rlist = new ArrayList<UsrPoint>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("usrpoint_mbrid", new Long(mbrid)));
		clist.add(Restrictions.eq("usrpoint_shopcode","shopcode"));
		List<Order> olist= new ArrayList<Order>();
		olist.add(Order.desc("usrpoint_createdate"));
		List<BaseEntity> list = Tools.getManager(UsrPoint.class).getList(clist, olist, 0, 1000);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((UsrPoint)be);
		}
		return rlist ;
	}
	public static ArrayList<UsrPoint> getUserScoreInfo(String mbrid){
		ArrayList<UsrPoint> rlist = new ArrayList<UsrPoint>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("usrpoint_mbrid", new Long(mbrid)));
		
		List<Order> olist= new ArrayList<Order>();
		olist.add(Order.desc("usrpoint_createdate"));
		List<BaseEntity> list = Tools.getManager(UsrPoint.class).getList(clist, olist, 0, 1000);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((UsrPoint)be);
		}
		return rlist ;
	}
	
	public static UsrPoint getUserPJScore(String mbrid, String orderid){
		ArrayList<UsrPoint> rlist = new ArrayList<UsrPoint>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("usrpoint_mbrid", new Long(mbrid)));
		clist.add(Restrictions.eq("usrpoint_odrid", orderid));
		clist.add(Restrictions.eq("usrpoint_type", new Long(3)));
		List<Order> olist= new ArrayList<Order>();
		olist.add(Order.desc("usrpoint_createdate"));
		List<BaseEntity> list = Tools.getManager(UsrPoint.class).getList(clist, olist, 0, 1000);
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			return (UsrPoint)be;
		}
		return null;
	}
	
	public static Long getRealScore(String mbrid) {
		List<UsrPoint> usrpoints = getUserScoreInfo(mbrid);
		long sum_points = 0;
		if(usrpoints != null && usrpoints.size() > 0) {
			for(UsrPoint up:usrpoints) {
				sum_points += up.getUsrpoint_score();
			}
		}
		return Long.valueOf(sum_points);
	}
}
