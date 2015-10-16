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
@Table(name="wangyi_user")
public class User163 extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="wangyi_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String wangyi_userid;
	private String wangyi_unionid;
	private Long wangyi_mbrid;
	private Date wangyi_regDate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWangyi_userid() {
		return wangyi_userid;
	}
	public void setWangyi_userid(String wangyi_userid) {
		this.wangyi_userid = wangyi_userid;
	}
	public String getWangyi_unionid() {
		return wangyi_unionid;
	}
	public void setWangyi_unionid(String wangyi_unionid) {
		this.wangyi_unionid = wangyi_unionid;
	}
	public Long getWangyi_mbrid() {
		return wangyi_mbrid;
	}
	public void setWangyi_mbrid(Long wangyi_mbrid) {
		this.wangyi_mbrid = wangyi_mbrid;
	}
	public Date getWangyi_regDate() {
		return wangyi_regDate;
	}
	public void setWangyi_regDate(Date wangyi_regDate) {
		this.wangyi_regDate = wangyi_regDate;
	}
	
}
