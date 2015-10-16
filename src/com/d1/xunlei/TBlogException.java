package com.d1.xunlei;

public class TBlogException extends Exception {
	
	private static final long serialVersionUID = -2623309261327598087L;

	private int statusCode = -1;

    public TBlogException(String msg) {
        super(msg);
    }

    public TBlogException(Exception cause) {
        super(cause);
    }

    public TBlogException(String msg, int statusCode) {
        super(msg);
        this.statusCode = statusCode;

    }

    public TBlogException(String msg, Exception cause) {
        super(msg, cause);
    }

    public TBlogException(String msg, Exception cause, int statusCode) {
        super(msg, cause);
        this.statusCode = statusCode;

    }

    public int getStatusCode() {
        return this.statusCode;
    }
}

