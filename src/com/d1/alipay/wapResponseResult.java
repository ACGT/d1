package com.d1.alipay;

/**
 * 调用支付宝服务返回的结果
 * 
 * @author 3y
 * @version $Id: wapResponseResult.java,v 1.1 2012/06/14 05:35:05 ysw Exp $
 */
public class wapResponseResult {

	/**
	 * 是否调用成功 默认为false 所以在每次调用都必须设置这个值为true；
	 */
	private boolean isSuccess = false;
	
	/**
	 * 调用的业务成功结果 如果调用失败 这个将是空值
	 */
	private String businessResult;

	/**
	 * 错误信息
	 */
	private wapErrorCode errorMessage;

	/**
	 * @return Returns the errorMessage.
	 */
	public wapErrorCode getErrorMessage() {
		return errorMessage;
	}

	/**
	 * @param errorMessage
	 * The errorMessage to set.
	 */
	public void setErrorMessage(wapErrorCode errorMessage) {
		this.errorMessage = errorMessage;
	}

	/**
	 * @return Returns the businessResult.
	 */
	public String getBusinessResult() {
		return businessResult;
	}

	/**
	 * @param businessResult
	 * The businessResult to set.
	 */
	public void setBusinessResult(String businessResult) {
		this.businessResult = businessResult;
	}

	/**
	 * @return Returns the isSuccess.
	 */
	public boolean isSuccess() {
		return isSuccess;
	}

	/**
	 * @param isSuccess
	 * The isSuccess to set.
	 */
	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
}

