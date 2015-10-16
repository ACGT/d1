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
@Table(name="weibombr")
public class WeiboUser extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="weibombr_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long weibombr_mbrid;
	private String weibombr_uid;
	private String weibombr_name;
	private String weibombr_flag;
	private Date weibombr_createdate;
	private Long weibombr_regflag;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getWeibombr_mbrid() {
		return weibombr_mbrid;
	}
	public void setWeibombr_mbrid(Long weibombr_mbrid) {
		this.weibombr_mbrid = weibombr_mbrid;
	}
	public String getWeibombr_uid() {
		return weibombr_uid;
	}
	public void setWeibombr_uid(String weibombr_uid) {
		this.weibombr_uid = weibombr_uid;
	}
	public String getWeibombr_name() {
		return weibombr_name;
	}
	public void setWeibombr_name(String weibombr_name) {
		this.weibombr_name = weibombr_name;
	}
	public String getWeibombr_flag() {
		return weibombr_flag;
	}
	public void setWeibombr_flag(String weibombr_flag) {
		this.weibombr_flag = weibombr_flag;
	}
	public Date getWeibombr_createdate() {
		return weibombr_createdate;
	}
	public void setWeibombr_createdate(Date weibombr_createdate) {
		this.weibombr_createdate = weibombr_createdate;
	}
	public Long getWeibombr_regflag() {
		return weibombr_regflag;
	}
	public void setWeibombr_regflag(Long weibombr_regflag) {
		this.weibombr_regflag = weibombr_regflag;
	}
}
