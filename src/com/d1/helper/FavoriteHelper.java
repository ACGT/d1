package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Favorite;
import com.d1.bean.Product;
import com.d1.bean.User;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * �ղص���Ʒ������
 * @author chengang
 *
 */
public class FavoriteHelper {
	
	public static final BaseManager manager = Tools.getManager(Favorite.class);
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return Favorite
	 */
	public static Favorite getById(String id) {
		if(Tools.isNull(id)) return null;
		return (Favorite)manager.get(id);
	}
	
	/**
	 * ����û��ղص���Ʒ
	 * @param userId - �û�ID
	 * @param start - ��ʼλ��
	 * @param length - ����
	 * @return List ��Ҫǰ̨ǰ������ת��
	 */
	public static List<BaseEntity> getByUserId(String userId , int start , int length){
		if(!Tools.isMath(userId)) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdswil_mbrid", new Long(userId)));
		
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("gdswil_applytime"));
		
		return manager.getList(listRes, listOrder, start, length);
	}
	
	/**
	 * ����û��ղص���Ʒ����
	 * @param userId - �û�ID
	 * @return int
	 */
	public static int getLengtByUserId(String userId){
		if(Tools.isNull(userId)) return 0;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdswil_mbrid",new Long(userId)));
		
		return manager.getLength(listRes);
	}
	
	/**
	 * ����Ʒ�����ղ�
	 * @param user - ��ǰ��¼�û�����
	 * @param product - ��Ʒ����
	 * @return Favorite
	 */
	public static Favorite addFavorite(User user , Product product){
		if(user == null || product == null) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdswil_mbrid", new Long(user.getId())));
		listRes.add(Restrictions.eq("gdswil_gdsid", product.getId()));
		
		List list = manager.getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()){
			Favorite fa = new Favorite();
			fa.setGdswil_applytime(new Date());
			fa.setGdswil_count(new Long(1));
			fa.setGdswil_gdsid(product.getId());
			fa.setGdswil_gdsname(product.getGdsmst_gdsname());
			fa.setGdswil_mbrid(new Long(user.getId()));
			fa.setGdswil_shopcode(product.getGdsmst_shopcode());
			return (Favorite) manager.create(fa);
		}
		
		return (Favorite)list.get(0);
	}

}
