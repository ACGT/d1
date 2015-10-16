package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="qqmbr")
public class QQUser extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="qqmbr_id")
	private String id;//done
	private Long qqmbr_mbrid;
	private String qqmbr_truename;
	private String qqmbr_credid;
	private Float qqmbr_balance;
	private String qqmbr_mobile;
	private String qqmbr_email;
	private String qqmbr_qq;
	private Long qqmbr_tenpayuserflag;
	private String qqmbr_addressXML;
	private Date qqmbr_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getQqmbr_mbrid() {
		return qqmbr_mbrid;
	}
	public void setQqmbr_mbrid(Long qqmbr_mbrid) {
		this.qqmbr_mbrid = qqmbr_mbrid;
	}
	public String getQqmbr_truename() {
		return qqmbr_truename;
	}
	public void setQqmbr_truename(String qqmbr_truename) {
		this.qqmbr_truename = qqmbr_truename;
	}
	public String getQqmbr_credid() {
		return qqmbr_credid;
	}
	public void setQqmbr_credid(String qqmbr_credid) {
		this.qqmbr_credid = qqmbr_credid;
	}
	public Float getQqmbr_balance() {
		return qqmbr_balance;
	}
	public void setQqmbr_balance(Float qqmbr_balance) {
		this.qqmbr_balance = qqmbr_balance;
	}
	public String getQqmbr_mobile() {
		return qqmbr_mobile;
	}
	public void setQqmbr_mobile(String qqmbr_mobile) {
		this.qqmbr_mobile = qqmbr_mobile;
	}
	public String getQqmbr_email() {
		return qqmbr_email;
	}
	public void setQqmbr_email(String qqmbr_email) {
		this.qqmbr_email = qqmbr_email;
	}
	public String getQqmbr_qq() {
		return qqmbr_qq;
	}
	public void setQqmbr_qq(String qqmbr_qq) {
		this.qqmbr_qq = qqmbr_qq;
	}
	public Long getQqmbr_tenpayuserflag() {
		return qqmbr_tenpayuserflag;
	}
	public void setQqmbr_tenpayuserflag(Long qqmbr_tenpayuserflag) {
		this.qqmbr_tenpayuserflag = qqmbr_tenpayuserflag;
	}
	public String getQqmbr_addressXML() {
		return qqmbr_addressXML;
	}
	public void setQqmbr_addressXML(String qqmbr_addressXML) {
		this.qqmbr_addressXML = qqmbr_addressXML;
	}
	public Date getQqmbr_createdate() {
		return qqmbr_createdate;
	}
	public void setQqmbr_createdate(Date qqmbr_createdate) {
		this.qqmbr_createdate = qqmbr_createdate;
	}
}
