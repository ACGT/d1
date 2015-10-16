package com.d1.helper;

import com.d1.bean.FindPassword;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 找回密码辅助类
 * @author chengang
 * @createTime 2011年12月9日4:18:25
 *
 */
public class FindPasswordHelper {
	
	public static final BaseManager manager = Tools.getManager(FindPassword.class);
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return FindPassword
	 */
	public static FindPassword getById(String id) {
		if(Tools.isNull(id)) return null;
		return (FindPassword)manager.get(id);
	}

}
