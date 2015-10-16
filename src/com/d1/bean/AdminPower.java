package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;
@Entity
@Table(name="rgtusr")
public class AdminPower extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="id")
	private String id;//done
	private String rgtusr_usrid;
	private String rgtusr_rgtname;
	private Date rgtusr_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRgtusr_usrid() {
		return rgtusr_usrid;
	}
	public void setRgtusr_usrid(String rgtusr_usrid) {
		this.rgtusr_usrid = rgtusr_usrid;
	}
	public String getRgtusr_rgtname() {
		return rgtusr_rgtname;
	}
	public void setRgtusr_rgtname(String rgtusr_rgtname) {
		this.rgtusr_rgtname = rgtusr_rgtname;
	}
	public Date getRgtusr_createdate() {
		return rgtusr_createdate;
	}
	public void setRgtusr_createdate(Date rgtusr_createdate) {
		this.rgtusr_createdate = rgtusr_createdate;
	}
	
}
