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
@Table(name="gdsbuyonedtl")
public class BuyLimitDtl extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsbuyonedtl_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;
	private Long gdsbuyonedtl_mstid;
	private String gdsbuyonedtl_gdsid;
	private Long gdsbuyonedtl_mbrid;
	private Date gdsbuyonedtl_createtime;
	private String gdsbuyonedtl_odrid;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdsbuyonedtl_mstid() {
		return gdsbuyonedtl_mstid;
	}
	public void setGdsbuyonedtl_mstid(Long gdsbuyonedtl_mstid) {
		this.gdsbuyonedtl_mstid = gdsbuyonedtl_mstid;
	}
	public String getGdsbuyonedtl_gdsid() {
		return gdsbuyonedtl_gdsid;
	}
	public void setGdsbuyonedtl_gdsid(String gdsbuyonedtl_gdsid) {
		this.gdsbuyonedtl_gdsid = gdsbuyonedtl_gdsid;
	}
	public Long getGdsbuyonedtl_mbrid() {
		return gdsbuyonedtl_mbrid;
	}
	public void setGdsbuyonedtl_mbrid(Long gdsbuyonedtl_mbrid) {
		this.gdsbuyonedtl_mbrid = gdsbuyonedtl_mbrid;
	}
	public Date getGdsbuyonedtl_createtime() {
		return gdsbuyonedtl_createtime;
	}
	public void setGdsbuyonedtl_createtime(Date gdsbuyonedtl_createtime) {
		this.gdsbuyonedtl_createtime = gdsbuyonedtl_createtime;
	}
	public String getGdsbuyonedtl_odrid() {
		return gdsbuyonedtl_odrid;
	}
	public void setGdsbuyonedtl_odrid(String gdsbuyonedtl_odrid) {
		this.gdsbuyonedtl_odrid = gdsbuyonedtl_odrid;
	}
}
