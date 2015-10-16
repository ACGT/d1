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
@Table(name="gdsbuyonemst")
public class BuyLimit extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsbuyonemst_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;
	private String gdsbuyonemst_gdsid;
	private Long gdsbuyonemst_count;
	private Date gdsbuyonemst_starttime;
	private Date gdsbuyonemst_endtime;
	private String gdsbuyonemst_memo;
	private Date gdsbuyonemst_createtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsbuyonemst_gdsid() {
		return gdsbuyonemst_gdsid;
	}
	public void setGdsbuyonemst_gdsid(String gdsbuyonemst_gdsid) {
		this.gdsbuyonemst_gdsid = gdsbuyonemst_gdsid;
	}
	public Long getGdsbuyonemst_count() {
		return gdsbuyonemst_count;
	}
	public void setGdsbuyonemst_count(Long gdsbuyonemst_count) {
		this.gdsbuyonemst_count = gdsbuyonemst_count;
	}
	public Date getGdsbuyonemst_starttime() {
		return gdsbuyonemst_starttime;
	}
	public void setGdsbuyonemst_starttime(Date gdsbuyonemst_starttime) {
		this.gdsbuyonemst_starttime = gdsbuyonemst_starttime;
	}
	public Date getGdsbuyonemst_endtime() {
		return gdsbuyonemst_endtime;
	}
	public void setGdsbuyonemst_endtime(Date gdsbuyonemst_endtime) {
		this.gdsbuyonemst_endtime = gdsbuyonemst_endtime;
	}
	public String getGdsbuyonemst_memo() {
		return gdsbuyonemst_memo;
	}
	public void setGdsbuyonemst_memo(String gdsbuyonemst_memo) {
		this.gdsbuyonemst_memo = gdsbuyonemst_memo;
	}
	public Date getGdsbuyonemst_createtime() {
		return gdsbuyonemst_createtime;
	}
	public void setGdsbuyonemst_createtime(Date gdsbuyonemst_createtime) {
		this.gdsbuyonemst_createtime = gdsbuyonemst_createtime;
	}
}
