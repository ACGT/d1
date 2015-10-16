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
@Table(name="odrtmlog",catalog="dba")
public class OdrTmLog extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="odrtmlog_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String odrtmlog_odrid;//订单号
	private String odrtmlog_user;//操作员
	private String odrtmlog_type;//日志操作类型 
	private String odrtmlog_oldtxt;//历史记录
	private String odrtmlog_ntxt;//修改记录
	private Date odrtmlog_createdate=new Date();//创建时间
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOdrtmlog_odrid() {
		return odrtmlog_odrid;
	}
	public void setOdrtmlog_odrid(String odrtmlog_odrid) {
		this.odrtmlog_odrid = odrtmlog_odrid;
	}
	public String getOdrtmlog_user() {
		return odrtmlog_user;
	}
	public void setOdrtmlog_user(String odrtmlog_user) {
		this.odrtmlog_user = odrtmlog_user;
	}
	public String getOdrtmlog_type() {
		return odrtmlog_type;
	}
	public void setOdrtmlog_type(String odrtmlog_type) {
		this.odrtmlog_type = odrtmlog_type;
	}
	public String getOdrtmlog_oldtxt() {
		return odrtmlog_oldtxt;
	}
	public void setOdrtmlog_oldtxt(String odrtmlog_oldtxt) {
		this.odrtmlog_oldtxt = odrtmlog_oldtxt;
	}
	public String getOdrtmlog_ntxt() {
		return odrtmlog_ntxt;
	}
	public void setOdrtmlog_ntxt(String odrtmlog_ntxt) {
		this.odrtmlog_ntxt = odrtmlog_ntxt;
	}
	public Date getOdrtmlog_createdate() {
		return odrtmlog_createdate;
	}
	public void setOdrtmlog_createdate(Date odrtmlog_createdate) {
		this.odrtmlog_createdate = odrtmlog_createdate;
	}
	
	/*
	 *  create table odrtmlog(odrtmlog_id int identity(1,1),odrtmlog_odrid char(12),odrtmlog_user varchar(50)
 ,odrtmlog_type varchar(50),odrtmlog_oldtxt varchar(500),odrtmlog_ntxt varchar(500) ,odrtmlog_createdate datetime default(getdate())
 )
	 * */
}
