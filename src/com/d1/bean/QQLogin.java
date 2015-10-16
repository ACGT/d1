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
@Table(name="qqloginmbr")
public class QQLogin extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="qqloginmbr_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private Long qqloginmbr_mbrid;
	private String qqloginmbr_uid;
	private String qqloginmbr_name;
	private Date qqloginmbr_createdate;
	private Long qqloginmbr_regflag;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getQqloginmbr_mbrid() {
		return qqloginmbr_mbrid;
	}
	public void setQqloginmbr_mbrid(Long qqloginmbr_mbrid) {
		this.qqloginmbr_mbrid = qqloginmbr_mbrid;
	}
	public String getQqloginmbr_uid() {
		return qqloginmbr_uid;
	}
	public void setQqloginmbr_uid(String qqloginmbr_uid) {
		this.qqloginmbr_uid = qqloginmbr_uid;
	}
	public String getQqloginmbr_name() {
		return qqloginmbr_name;
	}
	public void setQqloginmbr_name(String qqloginmbr_name) {
		this.qqloginmbr_name = qqloginmbr_name;
	}
	public Date getQqloginmbr_createdate() {
		return qqloginmbr_createdate;
	}
	public void setQqloginmbr_createdate(Date qqloginmbr_createdate) {
		this.qqloginmbr_createdate = qqloginmbr_createdate;
	}
	public Long getQqloginmbr_regflag() {
		return qqloginmbr_regflag;
	}
	public void setQqloginmbr_regflag(Long qqloginmbr_regflag) {
		this.qqloginmbr_regflag = qqloginmbr_regflag;
	}
}
