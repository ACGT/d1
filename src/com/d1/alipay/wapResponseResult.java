package com.d1.alipay;

/**
 * ����֧�������񷵻صĽ��
 * 
 * @author 3y
 * @version $Id: wapResponseResult.java,v 1.1 2012/06/14 05:35:05 ysw Exp $
 */
public class wapResponseResult {

	/**
	 * �Ƿ���óɹ� Ĭ��Ϊfalse ������ÿ�ε��ö������������ֵΪtrue��
	 */
	private boolean isSuccess = false;
	
	/**
	 * ���õ�ҵ��ɹ���� �������ʧ�� ������ǿ�ֵ
	 */
	private String businessResult;

	/**
	 * ������Ϣ
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

