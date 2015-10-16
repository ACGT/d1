package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;
@Entity
@Table(name="odrdtl_zjyx")
public class OdrdtlJZYX  extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="zjyx_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private Long odrmst_mbrid;
	private String odrdtl_gdsid;
	private String gdsmst_gdsname;
	private String gdsmst_rackcode;
	private String gdsmst_brand;
	private String gdsmst_brandname;
	private String gdsmst_gdscoll;
	private Float gdsmst_saleprice;
	private Float gdsmst_memberprice;
	private String gdsmst_fzimg;
	private String gdsmst_recimg;
	private String gdsmst_midimg;
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
	public String getOdrdtl_gdsid() {
		return odrdtl_gdsid;
	}
	public void setOdrdtl_gdsid(String odrdtl_gdsid) {
		this.odrdtl_gdsid = odrdtl_gdsid;
	}
	public String getGdsmst_gdsname() {
		return gdsmst_gdsname;
	}
	public void setGdsmst_gdsname(String gdsmst_gdsname) {
		this.gdsmst_gdsname = gdsmst_gdsname;
	}
	public String getGdsmst_rackcode() {
		return gdsmst_rackcode;
	}
	public void setGdsmst_rackcode(String gdsmst_rackcode) {
		this.gdsmst_rackcode = gdsmst_rackcode;
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
	public Float getGdsmst_saleprice() {
		return gdsmst_saleprice;
	}
	public void setGdsmst_saleprice(Float gdsmst_saleprice) {
		this.gdsmst_saleprice = gdsmst_saleprice;
	}
	public Float getGdsmst_memberprice() {
		return gdsmst_memberprice;
	}
	public void setGdsmst_memberprice(Float gdsmst_memberprice) {
		this.gdsmst_memberprice = gdsmst_memberprice;
	}
	public String getGdsmst_fzimg() {
		return gdsmst_fzimg;
	}
	public void setGdsmst_fzimg(String gdsmst_fzimg) {
		this.gdsmst_fzimg = gdsmst_fzimg;
	}
	public String getGdsmst_recimg() {
		return gdsmst_recimg;
	}
	public void setGdsmst_recimg(String gdsmst_recimg) {
		this.gdsmst_recimg = gdsmst_recimg;
	}
	public String getGdsmst_midimg() {
		return gdsmst_midimg;
	}
	public void setGdsmst_midimg(String gdsmst_midimg) {
		this.gdsmst_midimg = gdsmst_midimg;
	}
	
}
