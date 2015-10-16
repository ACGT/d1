package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="lmusr")
public class LmUser extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="lmusr_id")
	private String id;
	private Long lmusr_mbrid;
	private String lmusr_url1;
	private String lmusr_url2;
	private String lmusr_url3;
	private String lmusr_type;
	private String lmusr_context;
	private Long lmusr_pmtype;
	private String lmusr_cardcode;
	private String lmusr_rname;
	private String lmusr_addr;
	private Long lmusr_hitcount;
	private Long lmusr_flag;
	private Date lmusr_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getLmusr_mbrid() {
		return lmusr_mbrid;
	}
	public void setLmusr_mbrid(Long lmusr_mbrid) {
		this.lmusr_mbrid = lmusr_mbrid;
	}
	public String getLmusr_url1() {
		return lmusr_url1;
	}
	public void setLmusr_url1(String lmusr_url1) {
		this.lmusr_url1 = lmusr_url1;
	}
	public String getLmusr_url2() {
		return lmusr_url2;
	}
	public void setLmusr_url2(String lmusr_url2) {
		this.lmusr_url2 = lmusr_url2;
	}
	public String getLmusr_url3() {
		return lmusr_url3;
	}
	public void setLmusr_url3(String lmusr_url3) {
		this.lmusr_url3 = lmusr_url3;
	}
	public String getLmusr_type() {
		return lmusr_type;
	}
	public void setLmusr_type(String lmusr_type) {
		this.lmusr_type = lmusr_type;
	}
	public String getLmusr_context() {
		return lmusr_context;
	}
	public void setLmusr_context(String lmusr_context) {
		this.lmusr_context = lmusr_context;
	}
	public Long getLmusr_pmtype() {
		return lmusr_pmtype;
	}
	public void setLmusr_pmtype(Long lmusr_pmtype) {
		this.lmusr_pmtype = lmusr_pmtype;
	}
	public String getLmusr_cardcode() {
		return lmusr_cardcode;
	}
	public void setLmusr_cardcode(String lmusr_cardcode) {
		this.lmusr_cardcode = lmusr_cardcode;
	}
	public String getLmusr_rname() {
		return lmusr_rname;
	}
	public void setLmusr_rname(String lmusr_rname) {
		this.lmusr_rname = lmusr_rname;
	}
	public String getLmusr_addr() {
		return lmusr_addr;
	}
	public void setLmusr_addr(String lmusr_addr) {
		this.lmusr_addr = lmusr_addr;
	}
	public Long getLmusr_hitcount() {
		return lmusr_hitcount;
	}
	public void setLmusr_hitcount(Long lmusr_hitcount) {
		this.lmusr_hitcount = lmusr_hitcount;
	}
	public Long getLmusr_flag() {
		return lmusr_flag;
	}
	public void setLmusr_flag(Long lmusr_flag) {
		this.lmusr_flag = lmusr_flag;
	}
	public Date getLmusr_createdate() {
		return lmusr_createdate;
	}
	public void setLmusr_createdate(Date lmusr_createdate) {
		this.lmusr_createdate = lmusr_createdate;
	}
}
