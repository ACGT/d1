package com.d1.helper;

import java.util.Date;

import com.d1.bean.LoginLog;
import com.d1.bean.User;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 用户的登录信息记录
 * @author chengang
 * @createTime 2011-11-9 11:19:38
 *
 */
public class LoginLogHelper {
	
	public static final BaseManager manager = Tools.getManager(LoginLog.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return LoginLog
	 */
	public static LoginLog getById(String id){
		if(Tools.isNull(id)) return null;
		return (LoginLog)manager.get(id);
	}
	
	/**
	 * 创建一条登录日记
	 * @param user - 用户对象
	 * @return LoginLog
	 */
	public static LoginLog createLog(User user){
		if(user == null) return null;
		LoginLog log = new LoginLog();
		log.setMbrlog_logintime(new Date());
		log.setMbrlog_mbrid(new Long(Tools.parseLong(user.getId())));
		return (LoginLog)manager.create(log);
	}

}
