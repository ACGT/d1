package com.d1.helper;

import com.d1.bean.QQUser;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 财付通联合登录记录信息
 * @author chengang
 * @createTime 2011-11-14 22:47:07
 *
 */
public class QQUserHelper {
	
	public static final BaseManager manager = Tools.getManager(QQUser.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return QQUser
	 */
	public static QQUser getById(String id){
		if(Tools.isNull(id)) return null;
		return (QQUser)manager.get(id);
	}

}
