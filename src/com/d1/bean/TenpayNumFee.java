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
 * 聚会几个商品大于指定金额包邮
 * @author gjl
 *
 */
@Entity
@Table(name="tenpaynumfee")
public class TenpayNumFee extends BaseEntity implements java.io.Serializable {

	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="tenpaynumfee_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String tenpaynumfee_gdsstr;
	private Float tenpaynumfee_allmoney;
	private Date tenpaynumfee_sdate;
	private Date tenpaynumfee_edate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTenpaynumfee_gdsstr() {
		return tenpaynumfee_gdsstr;
	}
	public void setTenpaynumfee_gdsstr(String tenpaynumfee_gdsstr) {
		this.tenpaynumfee_gdsstr = tenpaynumfee_gdsstr;
	}
	public Float getTenpaynumfee_allmoney() {
		return tenpaynumfee_allmoney;
	}
	public void setTenpaynumfee_allmoney(Float tenpaynumfee_allmoney) {
		this.tenpaynumfee_allmoney = tenpaynumfee_allmoney;
	}
	public Date getTenpaynumfee_sdate() {
		return tenpaynumfee_sdate;
	}
	public void setTenpaynumfee_sdate(Date tenpaynumfee_sdate) {
		this.tenpaynumfee_sdate = tenpaynumfee_sdate;
	}
	public Date getTenpaynumfee_edate() {
		return tenpaynumfee_edate;
	}
	public void setTenpaynumfee_edate(Date tenpaynumfee_edate) {
		this.tenpaynumfee_edate = tenpaynumfee_edate;
	}



}
