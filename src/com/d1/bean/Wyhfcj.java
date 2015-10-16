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
@Table(name="wycjinfo")
public class Wyhfcj extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="wycjinfo_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private String wycjinfo_mbrid;
	private String wycjinfo_cardno;
	private String wycjinfo_gdsid;
	private Long wycjinfo_flag;
	private Date wycjinfo_date;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWycjinfo_mbrid() {
		return wycjinfo_mbrid;
	}
	public void setWycjinfo_mbrid(String wycjinfo_mbrid) {
		this.wycjinfo_mbrid = wycjinfo_mbrid;
	}
	public String getWycjinfo_cardno() {
		return wycjinfo_cardno;
	}
	public void setWycjinfo_cardno(String wycjinfo_cardno) {
		this.wycjinfo_cardno = wycjinfo_cardno;
	}
	public String getWycjinfo_gdsid() {
		return wycjinfo_gdsid;
	}
	public void setWycjinfo_gdsid(String wycjinfo_gdsid) {
		this.wycjinfo_gdsid = wycjinfo_gdsid;
	}
	
	public Long getWycjinfo_flag() {
		return wycjinfo_flag;
	}
	public void setWycjinfo_flag(Long wycjinfo_flag) {
		this.wycjinfo_flag = wycjinfo_flag;
	}
	public Date getWycjinfo_date() {
		return wycjinfo_date;
	}
	public void setWycjinfo_date(Date wycjinfo_date) {
		this.wycjinfo_date = wycjinfo_date;
	}
	
}
