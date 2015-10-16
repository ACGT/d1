package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Mail139User;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 139�����û�������
 * @author chengang
 * @createTime 2011��11��14��23:08:25
 *
 */
public class Mail139UserHelper {
	
	public static final BaseManager manager = Tools.getManager(Mail139User.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return Mail139User
	 */
	public static Mail139User getById(String id){
		if(Tools.isNull(id)) return null;
		return (Mail139User)manager.get(id);
	}
	
	/**
	 * ����139������˻���ȡ����
	 * @param account - �˻�����
	 * @return Mail139User
	 */
	public static Mail139User getByAccount(String account){
		if(Tools.isNull(account)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("mbr139_userAccount", account));
		
		List list = manager.getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		
		return (Mail139User)list.get(0);
	}

}
