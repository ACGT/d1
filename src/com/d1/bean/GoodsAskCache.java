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
@Table(name="gdsask_cache",catalog="dba")
public class GoodsAskCache extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdsask_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id; //done
	private Long gdsask_mbrid;
	private String gdsask_uid;
	private String gdsask_gdsid;
	private String gdsask_gdsname;
	private Long gdsask_type;
	private String gdsask_content;
	private Long gdsask_status;
	private Date gdsask_createdate;
	private Date gdsask_replydate;
	private String gdsask_operator;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdsask_mbrid() {
		return gdsask_mbrid;
	}
	public void setGdsask_mbrid(Long gdsask_mbrid) {
		this.gdsask_mbrid = gdsask_mbrid;
	}
	public String getGdsask_uid() {
		return gdsask_uid;
	}
	public void setGdsask_uid(String gdsask_uid) {
		this.gdsask_uid = gdsask_uid;
	}
	public String getGdsask_gdsid() {
		return gdsask_gdsid;
	}
	public void setGdsask_gdsid(String gdsask_gdsid) {
		this.gdsask_gdsid = gdsask_gdsid;
	}
	public String getGdsask_gdsname() {
		return gdsask_gdsname;
	}
	public void setGdsask_gdsname(String gdsask_gdsname) {
		this.gdsask_gdsname = gdsask_gdsname;
	}
	public Long getGdsask_type() {
		return gdsask_type;
	}
	public void setGdsask_type(Long gdsask_type) {
		this.gdsask_type = gdsask_type;
	}
	public String getGdsask_content() {
		return gdsask_content;
	}
	public void setGdsask_content(String gdsask_content) {
		this.gdsask_content = gdsask_content;
	}
	public Long getGdsask_status() {
		return gdsask_status;
	}
	public void setGdsask_status(Long gdsask_status) {
		this.gdsask_status = gdsask_status;
	}
	public Date getGdsask_createdate() {
		return gdsask_createdate;
	}
	public void setGdsask_createdate(Date gdsask_createdate) {
		this.gdsask_createdate = gdsask_createdate;
	}
	public Date getGdsask_replydate() {
		return gdsask_replydate;
	}
	public void setGdsask_replydate(Date gdsask_replydate) {
		this.gdsask_replydate = gdsask_replydate;
	}
	public String getGdsask_operator() {
		return gdsask_operator;
	}
	public void setGdsask_operator(String gdsask_operator) {
		this.gdsask_operator = gdsask_operator;
	}
}
