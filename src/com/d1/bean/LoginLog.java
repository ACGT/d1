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
@Table(name="mbrlog")
public class LoginLog extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="mbrlog_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long mbrlog_mbrid;
	private Date mbrlog_logintime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMbrlog_mbrid() {
		return mbrlog_mbrid;
	}
	public void setMbrlog_mbrid(Long mbrlog_mbrid) {
		this.mbrlog_mbrid = mbrlog_mbrid;
	}
	public Date getMbrlog_logintime() {
		return mbrlog_logintime;
	}
	public void setMbrlog_logintime(Date mbrlog_logintime) {
		this.mbrlog_logintime = mbrlog_logintime;
	}
}
