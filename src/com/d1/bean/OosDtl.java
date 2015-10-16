package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 到货通知
 * @author kk
 *
 */
@Entity
@Table(name="oosdtl")
public class OosDtl extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="oosdtl_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String oosdtl_gdsid;
	private String oosdtl_email;
	private Long oosdtl_status;
	private Date oosdtl_createdate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOosdtl_gdsid() {
		return oosdtl_gdsid;
	}
	public void setOosdtl_gdsid(String oosdtl_gdsid) {
		this.oosdtl_gdsid = oosdtl_gdsid;
	}
	public String getOosdtl_email() {
		return oosdtl_email;
	}
	public void setOosdtl_email(String oosdtl_email) {
		this.oosdtl_email = oosdtl_email;
	}
	public Long getOosdtl_status() {
		return oosdtl_status;
	}
	public void setOosdtl_status(Long oosdtl_status) {
		this.oosdtl_status = oosdtl_status;
	}
	public Date getOosdtl_createdate() {
		return oosdtl_createdate;
	}
	public void setOosdtl_createdate(Date oosdtl_createdate) {
		this.oosdtl_createdate = oosdtl_createdate;
	}
}
