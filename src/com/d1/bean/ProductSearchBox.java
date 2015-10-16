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
@Table(name="gdsmst_searchbox",catalog="dba")
public class ProductSearchBox extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsmst_searchbox_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id ;
	private String gdsmst_gdsid;
	private String gdsmst_brandname;
	private String gdsmst_smallimg;
	private String rakmst_rackname;
	private String rakmst_rackname2;
	private String gdsmst_imgurl;
	private String gdsmst_gdsname;
	private String gdsmst_rackcode;
	private Float gdsmst_memberprice;
	private String gdsmst_briefintrduce;
	private Date gdsmst_updatedate;
	private String gdsmst_keyword;
	private Long gdsmst_ifhavegds;
	private String gdsmst_skuname1;
	private String gdsmst_skuname2;
	private Date gdsmst_discountenddate;
	private String gdsmst_bigimg;
	private Float gdsmst_oldmemberprice;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsmst_gdsid() {
		return gdsmst_gdsid;
	}
	public void setGdsmst_gdsid(String gdsmst_gdsid) {
		this.gdsmst_gdsid = gdsmst_gdsid;
	}
	public String getGdsmst_brandname() {
		return gdsmst_brandname;
	}
	public void setGdsmst_brandname(String gdsmst_brandname) {
		this.gdsmst_brandname = gdsmst_brandname;
	}
	public String getGdsmst_smallimg() {
		return gdsmst_smallimg;
	}
	public void setGdsmst_smallimg(String gdsmst_smallimg) {
		this.gdsmst_smallimg = gdsmst_smallimg;
	}
	public String getRakmst_rackname() {
		return rakmst_rackname;
	}
	public void setRakmst_rackname(String rakmst_rackname) {
		this.rakmst_rackname = rakmst_rackname;
	}
	public String getRakmst_rackname2() {
		return rakmst_rackname2;
	}
	public void setRakmst_rackname2(String rakmst_rackname2) {
		this.rakmst_rackname2 = rakmst_rackname2;
	}
	public String getGdsmst_imgurl() {
		return gdsmst_imgurl;
	}
	public void setGdsmst_imgurl(String gdsmst_imgurl) {
		this.gdsmst_imgurl = gdsmst_imgurl;
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
	public Float getGdsmst_memberprice() {
		return gdsmst_memberprice;
	}
	public void setGdsmst_memberprice(Float gdsmst_memberprice) {
		this.gdsmst_memberprice = gdsmst_memberprice;
	}
	public String getGdsmst_briefintrduce() {
		return gdsmst_briefintrduce;
	}
	public void setGdsmst_briefintrduce(String gdsmst_briefintrduce) {
		this.gdsmst_briefintrduce = gdsmst_briefintrduce;
	}
	public Date getGdsmst_updatedate() {
		return gdsmst_updatedate;
	}
	public void setGdsmst_updatedate(Date gdsmst_updatedate) {
		this.gdsmst_updatedate = gdsmst_updatedate;
	}
	public String getGdsmst_keyword() {
		return gdsmst_keyword;
	}
	public void setGdsmst_keyword(String gdsmst_keyword) {
		this.gdsmst_keyword = gdsmst_keyword;
	}
	public Long getGdsmst_ifhavegds() {
		return gdsmst_ifhavegds;
	}
	public void setGdsmst_ifhavegds(Long gdsmst_ifhavegds) {
		this.gdsmst_ifhavegds = gdsmst_ifhavegds;
	}
	public String getGdsmst_skuname1() {
		return gdsmst_skuname1;
	}
	public void setGdsmst_skuname1(String gdsmst_skuname1) {
		this.gdsmst_skuname1 = gdsmst_skuname1;
	}
	public String getGdsmst_skuname2() {
		return gdsmst_skuname2;
	}
	public void setGdsmst_skuname2(String gdsmst_skuname2) {
		this.gdsmst_skuname2 = gdsmst_skuname2;
	}
	public Date getGdsmst_discountenddate() {
		return gdsmst_discountenddate;
	}
	public void setGdsmst_discountenddate(Date gdsmst_discountenddate) {
		this.gdsmst_discountenddate = gdsmst_discountenddate;
	}
	public String getGdsmst_bigimg() {
		return gdsmst_bigimg;
	}
	public void setGdsmst_bigimg(String gdsmst_bigimg) {
		this.gdsmst_bigimg = gdsmst_bigimg;
	}
	public Float getGdsmst_oldmemberprice() {
		return gdsmst_oldmemberprice;
	}
	public void setGdsmst_oldmemberprice(Float gdsmst_oldmemberprice) {
		this.gdsmst_oldmemberprice = gdsmst_oldmemberprice;
	}
}
