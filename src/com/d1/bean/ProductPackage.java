package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品组合表
 * @author kk
 *
 */
@Entity
@Table(name="gdspkt")
public class ProductPackage extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdspkt_id")
	private String id;//done

	private String gdspkt_title;
	private String gdspkt_inf;
	private Float gdspkt_savemoney;
	private Date gdspkt_createdate;
	private String gdspkt_addusr;
	private Long gdspkt_status;
	private Date gdspkt_startdate;
	private Date gdspkt_enddate;
	private String gdspkt_gdsid;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdspkt_title() {
		return gdspkt_title;
	}
	public void setGdspkt_title(String gdspkt_title) {
		this.gdspkt_title = gdspkt_title;
	}
	public String getGdspkt_inf() {
		return gdspkt_inf;
	}
	public void setGdspkt_inf(String gdspkt_inf) {
		this.gdspkt_inf = gdspkt_inf;
	}
	public Float getGdspkt_savemoney() {
		return gdspkt_savemoney;
	}
	public void setGdspkt_savemoney(Float gdspkt_savemoney) {
		this.gdspkt_savemoney = gdspkt_savemoney;
	}
	public Date getGdspkt_createdate() {
		return gdspkt_createdate;
	}
	public void setGdspkt_createdate(Date gdspkt_createdate) {
		this.gdspkt_createdate = gdspkt_createdate;
	}
	public String getGdspkt_addusr() {
		return gdspkt_addusr;
	}
	public void setGdspkt_addusr(String gdspkt_addusr) {
		this.gdspkt_addusr = gdspkt_addusr;
	}
	public Long getGdspkt_status() {
		return gdspkt_status;
	}
	public void setGdspkt_status(Long gdspkt_status) {
		this.gdspkt_status = gdspkt_status;
	}
	public Date getGdspkt_startdate() {
		return gdspkt_startdate;
	}
	public void setGdspkt_startdate(Date gdspkt_startdate) {
		this.gdspkt_startdate = gdspkt_startdate;
	}
	public Date getGdspkt_enddate() {
		return gdspkt_enddate;
	}
	public void setGdspkt_enddate(Date gdspkt_enddate) {
		this.gdspkt_enddate = gdspkt_enddate;
	}
	public String getGdspkt_gdsid() {
		return gdspkt_gdsid;
	}
	public void setGdspkt_gdsid(String gdspkt_gdsid) {
		this.gdspkt_gdsid = gdspkt_gdsid;
	}

}
