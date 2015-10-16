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
@Table(name="d1tgts",catalog="dbo")
public class D1tgts extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="d1tgts_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long d1tgts_mbrid;
	private String d1tgts_content;
	private Date d1tgts_addtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getD1tgts_mbrid() {
		return d1tgts_mbrid;
	}
	public void setD1tgts_mbrid(Long d1tgts_mbrid) {
		this.d1tgts_mbrid = d1tgts_mbrid;
	}
	public String getD1tgts_content() {
		return d1tgts_content;
	}
	public void setD1tgts_content(String d1tgts_content) {
		this.d1tgts_content = d1tgts_content;
	}
	public Date getD1tgts_addtime() {
		return d1tgts_addtime;
	}
	public void setD1tgts_addtime(Date d1tgts_addtime) {
		this.d1tgts_addtime = d1tgts_addtime;
	}
}
