package com.d1.helper;

import com.d1.bean.FindPassword;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * �һ����븨����
 * @author chengang
 * @createTime 2011��12��9��4:18:25
 *
 */
public class FindPasswordHelper {
	
	public static final BaseManager manager = Tools.getManager(FindPassword.class);
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return FindPassword
	 */
	public static FindPassword getById(String id) {
		if(Tools.isNull(id)) return null;
		return (FindPassword)manager.get(id);
	}

}
