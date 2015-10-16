package com.d1.dbcache.core;

/**
 * 不支持bean操作抛出的异常，当manager操作不是自己负责的bean时抛出！
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