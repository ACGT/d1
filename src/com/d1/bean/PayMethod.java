package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 支付方式表，前台只读
 * @author kk
 *
 */
@Entity
@Table(name="paymst")
public class PayMethod extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="paymst_payid")
	private String id;//done
	
	private String paymst_name;
	private String paymst_aliasname;
	private Long paymst_type;
	private String paymst_memo;
	private String paymst_memofee;
	private Long paymst_valid;
	private Long paymst_moneytype;
	private Long paymst_seq;
	private Long paymst_gateid;
	private Long paymst_kind;
	private String paymst_actpay;
	

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPaymst_name() {
		return paymst_name;
	}
	public void setPaymst_name(String paymst_name) {
		this.paymst_name = paymst_name;
	}
	public String getPaymst_aliasname() {
		return paymst_aliasname;
	}
	public void setPaymst_aliasname(String paymst_aliasname) {
		this.paymst_aliasname = paymst_aliasname;
	}
	public Long getPaymst_type() {
		return paymst_type;
	}
	public void setPaymst_type(Long paymst_type) {
		this.paymst_type = paymst_type;
	}
	public String getPaymst_memo() {
		return paymst_memo;
	}
	public void setPaymst_memo(String paymst_memo) {
		this.paymst_memo = paymst_memo;
	}
	public String getPaymst_memofee() {
		return paymst_memofee;
	}
	public void setPaymst_memofee(String paymst_memofee) {
		this.paymst_memofee = paymst_memofee;
	}
	public Long getPaymst_valid() {
		return paymst_valid;
	}
	public void setPaymst_valid(Long paymst_valid) {
		this.paymst_valid = paymst_valid;
	}
	public Long getPaymst_moneytype() {
		return paymst_moneytype;
	}
	public void setPaymst_moneytype(Long paymst_moneytype) {
		this.paymst_moneytype = paymst_moneytype;
	}
	public Long getPaymst_seq() {
		return paymst_seq;
	}
	public void setPaymst_seq(Long paymst_seq) {
		this.paymst_seq = paymst_seq;
	}
	public Long getPaymst_gateid() {
		return paymst_gateid;
	}
	public void setPaymst_gateid(Long paymst_gateid) {
		this.paymst_gateid = paymst_gateid;
	}
	public Long getPaymst_kind() {
		return paymst_kind;
	}
	public void setPaymst_kind(Long paymst_kind) {
		this.paymst_kind = paymst_kind;
	}
	public String getPaymst_actpay() {
		return paymst_actpay;
	}
	public void setPaymst_actpay(String paymst_actpay) {
		this.paymst_actpay = paymst_actpay;
	}
}
