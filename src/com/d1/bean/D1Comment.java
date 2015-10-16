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
@Table(name="d1comment",catalog="dba")
public class D1Comment extends BaseEntity implements java.io.Serializable {
	/**
	 * vision id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="commentid")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String sessionid;
	private String gdscom_odrid;
	private Long gdscom_mbrid;
	private String gdscom_uid;
	private String gdscom_base;
	private String gdscom_speed;
	private String gdscom_service;
	private String gdscom_msn;
	private String gdscom_other;
	private Date commenttime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	public String getGdscom_odrid() {
		return gdscom_odrid;
	}
	public void setGdscom_odrid(String gdscom_odrid) {
		this.gdscom_odrid = gdscom_odrid;
	}
	public Long getGdscom_mbrid() {
		return gdscom_mbrid;
	}
	public void setGdscom_mbrid(Long gdscom_mbrid) {
		this.gdscom_mbrid = gdscom_mbrid;
	}
	public String getGdscom_uid() {
		return gdscom_uid;
	}
	public void setGdscom_uid(String gdscom_uid) {
		this.gdscom_uid = gdscom_uid;
	}
	public String getGdscom_base() {
		return gdscom_base;
	}
	public void setGdscom_base(String gdscom_base) {
		this.gdscom_base = gdscom_base;
	}
	public String getGdscom_speed() {
		return gdscom_speed;
	}
	public void setGdscom_speed(String gdscom_speed) {
		this.gdscom_speed = gdscom_speed;
	}
	public String getGdscom_service() {
		return gdscom_service;
	}
	public void setGdscom_service(String gdscom_service) {
		this.gdscom_service = gdscom_service;
	}
	public String getGdscom_msn() {
		return gdscom_msn;
	}
	public void setGdscom_msn(String gdscom_msn) {
		this.gdscom_msn = gdscom_msn;
	}
	public String getGdscom_other() {
		return gdscom_other;
	}
	public void setGdscom_other(String gdscom_other) {
		this.gdscom_other = gdscom_other;
	}
	public Date getCommenttime() {
		return commenttime;
	}
	public void setCommenttime(Date commenttime) {
		this.commenttime = commenttime;
	}
}
