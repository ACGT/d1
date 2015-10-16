package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="tenpayfee")
public class TenpayFee extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="tenpayfee_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String tenpayfee_gdsid;
	private Date tenpayfee_sdate;
	private Date tenpayfee_edate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTenpayfee_gdsid() {
		return tenpayfee_gdsid;
	}
	public void setTenpayfee_gdsid(String tenpayfee_gdsid) {
		this.tenpayfee_gdsid = tenpayfee_gdsid;
	}
	public Date getTenpayfee_sdate() {
		return tenpayfee_sdate;
	}
	public void setTenpayfee_sdate(Date tenpayfee_sdate) {
		this.tenpayfee_sdate = tenpayfee_sdate;
	}
	public Date getTenpayfee_edate() {
		return tenpayfee_edate;
	}
	public void setTenpayfee_edate(Date tenpayfee_edate) {
		this.tenpayfee_edate = tenpayfee_edate;
	}


}
