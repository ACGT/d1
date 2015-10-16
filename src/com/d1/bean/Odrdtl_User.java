package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="odrdtl_user")
public class Odrdtl_User extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private Long odrmst_mbrid;
	private String gdsmst_brand;
	private String gdsmst_brandname;
	private String gdsmst_gdscoll;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getOdrmst_mbrid() {
		return odrmst_mbrid;
	}
	public void setOdrmst_mbrid(Long odrmst_mbrid) {
		this.odrmst_mbrid = odrmst_mbrid;
	}
	public String getGdsmst_brand() {
		return gdsmst_brand;
	}
	public void setGdsmst_brand(String gdsmst_brand) {
		this.gdsmst_brand = gdsmst_brand;
	}
	public String getGdsmst_brandname() {
		return gdsmst_brandname;
	}
	public void setGdsmst_brandname(String gdsmst_brandname) {
		this.gdsmst_brandname = gdsmst_brandname;
	}
	public String getGdsmst_gdscoll() {
		return gdsmst_gdscoll;
	}
	public void setGdsmst_gdscoll(String gdsmst_gdscoll) {
		this.gdsmst_gdscoll = gdsmst_gdscoll;
	}
}
