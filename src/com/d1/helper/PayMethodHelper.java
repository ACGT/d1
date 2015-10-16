package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.PayMethod;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * ֧����ʽ��������
 * @author chengang
 * @createTime 2011��10��14��16:27:42
 * @see PayMethod
 *
 */
public class PayMethodHelper {
	
	public static final BaseManager manager = Tools.getManager(PayMethod.class);
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return PayMethod
	 */
	public static PayMethod getById(String id) {
		if(!Tools.isMath(id)) return null;
		return (PayMethod)manager.get(id);
	}
	
	/**
	 * �������֧����ʽ
	 * @return List<PayMethod>
	 */
	public static List<BaseEntity> getPayNet(){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("paymst_type", new Long(4)));
		listRes.add(Restrictions.eq("paymst_valid", new Long(1)));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.asc("paymst_seq"));
		listOrder.add(Order.asc("id"));
		
		return manager.getList(listRes, listOrder, 0, 100);
	}
	/**
	 * �������֧����ʽ
	 * @return List<PayMethod>
	 */
	public static List<BaseEntity> getPaylist(Long type){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("paymst_type", type));
		listRes.add(Restrictions.eq("paymst_valid", new Long(1)));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.asc("paymst_seq"));
		listOrder.add(Order.asc("id"));
		
		return manager.getList(listRes, listOrder, 0, 100);
	}
	
	/**
	 * ������е��֧����ʽ
	 * @return List<PayMethod>
	 */
	public static List<BaseEntity> getPayBlank(){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("paymst_type", new Long(3)));
		listRes.add(Restrictions.eq("paymst_valid", new Long(1)));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.asc("id"));
		
		return manager.getList(listRes, listOrder, 0, 100);
	}
	
	/**
	 * ��û�������ʾֻ��֧����ʽ
	 * @return List<PayMethod>
	 */
	public static List<BaseEntity> getPayKind(){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.lt("paymst_type", new Long(3)));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.asc("id"));
		
		return manager.getList(listRes, listOrder, 0, 100);
	}

}
