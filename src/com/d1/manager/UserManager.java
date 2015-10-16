package com.d1.manager;

import org.hibernate.HibernateException;

import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.dbcache.core.MyException;

/**
 * UserManager£¬½ûÖ¹delete·½·¨
 * @author kk
 *
 */
public class UserManager extends BaseManager{

	public UserManager(Class<?> beanClass, String hibernateFile,
			String hashFieldsStr) {
		super(beanClass, hibernateFile, hashFieldsStr);
	}
	
	@Override
	public boolean delete(BaseEntity br) throws HibernateException , MyException {
		return false;
	}

}
