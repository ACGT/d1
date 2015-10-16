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
@Table(name="odrtmtxt",catalog="dba")
public class OdrTmTxt extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="odrtmtxt_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String odrtmtxt_odrid;//订单号
	private String odrtmtxt_taxtitle;//发标抬头
	private String odrtmtxt_taxtxt;//发标内容
	private String odrtmtxt_user;//操作员
	private Date odrtmtxt_update;//更新时间
	private Date odrtmtxt_createdate=new Date();//创建时间
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOdrtmtxt_odrid() {
		return odrtmtxt_odrid;
	}
	public void setOdrtmtxt_odrid(String odrtmtxt_odrid) {
		this.odrtmtxt_odrid = odrtmtxt_odrid;
	}
	public String getOdrtmtxt_taxtitle() {
		return odrtmtxt_taxtitle;
	}
	public void setOdrtmtxt_taxtitle(String odrtmtxt_taxtitle) {
		this.odrtmtxt_taxtitle = odrtmtxt_taxtitle;
	}
	public String getOdrtmtxt_taxtxt() {
		return odrtmtxt_taxtxt;
	}
	public void setOdrtmtxt_taxtxt(String odrtmtxt_taxtxt) {
		this.odrtmtxt_taxtxt = odrtmtxt_taxtxt;
	}

	public String getOdrtmtxt_user() {
		return odrtmtxt_user;
	}
	public void setOdrtmtxt_user(String odrtmtxt_user) {
		this.odrtmtxt_user = odrtmtxt_user;
	}
	public Date getOdrtmtxt_update() {
		return odrtmtxt_update;
	}
	public void setOdrtmtxt_update(Date odrtmtxt_update) {
		this.odrtmtxt_update = odrtmtxt_update;
	}
	public Date getOdrtmtxt_createdate() {
		return odrtmtxt_createdate;
	}
	public void setOdrtmtxt_createdate(Date odrtmtxt_createdate) {
		this.odrtmtxt_createdate = odrtmtxt_createdate;
	}

	
/*
 * create table odrtmtxt (odrtmtxt_id int identity(1,1),odrtmtxt_odrid char(12),odrtmtxt_taxtitle varchar(100),odrtmtxt_taxtxt varchar(300),
 odrtmtxt_tupimg varchar(200),odrtmtxt_user varchar(50),odrtmtxt_update datetime,odrtmtxt_createdate datetime default(getdate()))
 * */
}
