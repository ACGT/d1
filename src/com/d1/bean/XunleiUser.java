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
@Table(name="xunleimbrst")
public class XunleiUser extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="xunlei_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long xunlei_mbrid;
	private String xunlei_accesstoken;
	private String xunlei_userno;
	private String xunlei_nickname;
	private Long xunlei_uservip;
	private Date xunlei_createtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getXunlei_mbrid() {
		return xunlei_mbrid;
	}
	public void setXunlei_mbrid(Long xunlei_mbrid) {
		this.xunlei_mbrid = xunlei_mbrid;
	}
	public String getXunlei_userno() {
		return xunlei_userno;
	}
	public void setXunlei_userno(String xunlei_userno) {
		this.xunlei_userno = xunlei_userno;
	}
	public String getXunlei_nickname() {
		return xunlei_nickname;
	}
	public void setXunlei_nickname(String xunlei_nickname) {
		this.xunlei_nickname = xunlei_nickname;
	}
	public Long getXunlei_uservip() {
		return xunlei_uservip;
	}
	public void setXunlei_uservip(Long xunlei_uservip) {
		this.xunlei_uservip = xunlei_uservip;
	}
	public Date getXunlei_createtime() {
		return xunlei_createtime;
	}
	public void setXunlei_createtime(Date xunlei_createtime) {
		this.xunlei_createtime = xunlei_createtime;
	}

	public String getXunlei_accesstoken() {
		return xunlei_accesstoken;
	}
	public void setXunlei_accesstoken(String xunlei_accesstoken) {
		this.xunlei_accesstoken = xunlei_accesstoken;
	}
}
