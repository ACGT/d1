package com.d1.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.*;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;


public class OrderScoreHelper {
	
	/**
	 * 
	 * ���ݻ�Ա�ź�����ʱ���ȡ���۷���
	 * @param mbrid ��Ա��
	 * @param date ����ʱ��
	 * @param predate ��ʼʱ��
	 * @return
	 */
	public static ArrayList<OrderScore> getOrderScoresBymbridAnddate(String mbrid,Date date,Date predate)
	{
		ArrayList<OrderScore> rlist=new ArrayList<OrderScore>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdscomscore_mbrid",Tools.parseLong(mbrid)));
		listRes.add(Restrictions.ge("gdscomscore_createtime",predate));
		listRes.add(Restrictions.le("gdscomscore_createtime", date));
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdscomscore_createtime"));
		
		List<BaseEntity> list = Tools.getManager(OrderScore.class).getList(listRes, olist, 0, 1000);
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((OrderScore)be);
		}
		
		return rlist ;
	}
	
}