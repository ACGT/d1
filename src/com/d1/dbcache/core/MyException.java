package com.d1.dbcache.core;

/**
 * ��֧��bean�����׳����쳣����manager���������Լ������beanʱ�׳���
 * @author kk
 *
 */
public class MyException extends RuntimeException {
    /**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	public MyException (String message){
        super(message);
    }
}