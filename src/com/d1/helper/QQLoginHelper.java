package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.QQLogin;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * qq登录辅助类
 * @author chengang
 * @createTime 2011年11月13日21:24:30
 *
 */
public class QQLoginHelper {
	
	public static final BaseManager manager = Tools.getManager(QQLogin.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return QQLogin
	 */
	public static QQLogin getById(String id){
		if(Tools.isNull(id)) return null;
		return (QQLogin)manager.get(id);
	}
	
	/**
	 * 根据qqloginmbr_uid 获得对象
	 * @param uid - qqloginmbr_uid
	 * @return QQLogin
	 */
	public static QQLogin getByUid(String uid){
		if(Tools.isNull(uid)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("qqloginmbr_uid", uid));
		
		List list = manager.getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		
		return (QQLogin)list.get(0);
	}
	/**
	 * 根据mbrmst_mbrid 获得对象
	 * @param mbrid
	 * @return
	 */
	public static QQLogin getByMbrid(Long mbrid){
		if(mbrid<=0) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("qqloginmbr_mbrid", mbrid));
		
		List list = manager.getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		
		return (QQLogin)list.get(0);
	}

}
