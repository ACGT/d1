package com.d1.helper;

import java.util.Date;

import com.d1.bean.LoginLog;
import com.d1.bean.User;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * �û��ĵ�¼��Ϣ��¼
 * @author chengang
 * @createTime 2011-11-9 11:19:38
 *
 */
public class LoginLogHelper {
	
	public static final BaseManager manager = Tools.getManager(LoginLog.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return LoginLog
	 */
	public static LoginLog getById(String id){
		if(Tools.isNull(id)) return null;
		return (LoginLog)manager.get(id);
	}
	
	/**
	 * ����һ����¼�ռ�
	 * @param user - �û�����
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
