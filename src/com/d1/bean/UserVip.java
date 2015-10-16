package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 白金VIP用户表
 * @author kk
 *
 */
@Entity
@Table(name="bjvip")
public class UserVip extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="bjvip_mbrid")
	private String id;//done
	
	private Float bjvip_allmoney;
	private Date bjvip_createtime;
	private Date bjvip_endtime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Float getBjvip_allmoney() {
		return bjvip_allmoney;
	}

	public void setBjvip_allmoney(Float bjvip_allmoney) {
		this.bjvip_allmoney = bjvip_allmoney;
	}

	public Date getBjvip_createtime() {
		return bjvip_createtime;
	}

	public void setBjvip_createtime(Date bjvip_createtime) {
		this.bjvip_createtime = bjvip_createtime;
	}

	public Date getBjvip_endtime() {
		return bjvip_endtime;
	}

	public void setBjvip_endtime(Date bjvip_endtime) {
		this.bjvip_endtime = bjvip_endtime;
	}

}
