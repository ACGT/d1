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
 * 记录淘宝商城订单状态（是否同步过库存，是否同步过订单等）
 * @author kk
 *
 */
@Entity
@Table(name="odr360buy")
public class Order360buy extends BaseEntity implements java.io.Serializable {

	/**
	 * searial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	/**
	 * 主键id
	 */
	@Column(name="odr360buy_id")
	private String id;//done
	
	private String odr360buy_360odrid;
	private String odr360buy_d1odrid;
	private String odr360buy_name;
	private String odr360buy_phone;
	private String odr360buy_email;
	private Long odr360buy_status;
	private Date odr360buy_createdate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOdr360buy_360odrid() {
		return odr360buy_360odrid;
	}
	public void setOdr360buy_360odrid(String odr360buy_360odrid) {
		this.odr360buy_360odrid = odr360buy_360odrid;
	}
	public String getOdr360buy_d1odrid() {
		return odr360buy_d1odrid;
	}
	public void setOdr360buy_d1odrid(String odr360buy_d1odrid) {
		this.odr360buy_d1odrid = odr360buy_d1odrid;
	}
	public String getOdr360buy_name() {
		return odr360buy_name;
	}
	public void setOdr360buy_name(String odr360buy_name) {
		this.odr360buy_name = odr360buy_name;
	}
	public String getOdr360buy_phone() {
		return odr360buy_phone;
	}
	public void setOdr360buy_phone(String odr360buy_phone) {
		this.odr360buy_phone = odr360buy_phone;
	}
	public String getOdr360buy_email() {
		return odr360buy_email;
	}
	public void setOdr360buy_email(String odr360buy_email) {
		this.odr360buy_email = odr360buy_email;
	}
	public Long getOdr360buy_status() {
		return odr360buy_status;
	}
	public void setOdr360buy_status(Long odr360buy_status) {
		this.odr360buy_status = odr360buy_status;
	}
	public Date getOdr360buy_createdate() {
		return odr360buy_createdate;
	}
	public void setOdr360buy_createdate(Date odr360buy_createdate) {
		this.odr360buy_createdate = odr360buy_createdate;
	}


}
