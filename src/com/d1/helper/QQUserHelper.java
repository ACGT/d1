package com.d1.helper;

import com.d1.bean.QQUser;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * �Ƹ�ͨ���ϵ�¼��¼��Ϣ
 * @author chengang
 * @createTime 2011-11-14 22:47:07
 *
 */
public class QQUserHelper {
	
	public static final BaseManager manager = Tools.getManager(QQUser.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return QQUser
	 */
	public static QQUser getById(String id){
		if(Tools.isNull(id)) return null;
		return (QQUser)manager.get(id);
	}

}
