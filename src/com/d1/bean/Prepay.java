package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 预存款
 * @author kk
 *
 */
@Entity
@Table(name="prepay")
public class Prepay extends BaseEntity implements java.io.Serializable {

	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="prepay_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	/**
	 * 会员id
	 */
	private Long prepay_mbrid;
	private String prepay_odrid;
	
	/**
	 * 预存款
	 */
	private Float prepay_value;
	private Long prepay_type;
	
	/**
	 * 0正常
	 */
	private Long prepay_status;
	private Date prepay_createdate;
	private String propay_operator;
	private String prepay_log;
	private String prepay_memo;
	
	public Long getPrepay_mbrid() {
		return prepay_mbrid;
	}
	public void setPrepay_mbrid(Long prepay_mbrid) {
		this.prepay_mbrid = prepay_mbrid;
	}
	public String getPrepay_odrid() {
		return prepay_odrid;
	}
	public void setPrepay_odrid(String prepay_odrid) {
		this.prepay_odrid = prepay_odrid;
	}
	public Float getPrepay_value() {
		return prepay_value;
	}
	public void setPrepay_value(Float prepay_value) {
		this.prepay_value = prepay_value;
	}
	public Long getPrepay_type() {
		return prepay_type;
	}
	public void setPrepay_type(Long prepay_type) {
		this.prepay_type = prepay_type;
	}
	public Long getPrepay_status() {
		return prepay_status;
	}
	public void setPrepay_status(Long prepay_status) {
		this.prepay_status = prepay_status;
	}
	public Date getPrepay_createdate() {
		return prepay_createdate;
	}
	public void setPrepay_createdate(Date prepay_createdate) {
		this.prepay_createdate = prepay_createdate;
	}
	public String getPropay_operator() {
		return propay_operator;
	}
	public void setPropay_operator(String propay_operator) {
		this.propay_operator = propay_operator;
	}
	public String getPrepay_log() {
		return prepay_log;
	}
	public void setPrepay_log(String prepay_log) {
		this.prepay_log = prepay_log;
	}
	public String getPrepay_memo() {
		return prepay_memo;
	}
	public void setPrepay_memo(String prepay_memo) {
		this.prepay_memo = prepay_memo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
