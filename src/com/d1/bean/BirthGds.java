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
@Table(name="birthgds")
public class BirthGds extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="birthgds_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private Long birthgds_mbrid;
	private String birthgds_odrid;
	private String birthgds_gdsid;
	private Long birthgds_status;
	private String birthgds_memo;
    private Date birthgds_update;
    

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getBirthgds_mbrid() {
		return birthgds_mbrid;
	}
	public void setBirthgds_mbrid(Long birthgds_mbrid) {
		this.birthgds_mbrid = birthgds_mbrid;
	}
	public String getBirthgds_odrid() {
		return birthgds_odrid;
	}
	public void setBirthgds_odrid(String birthgds_odrid) {
		this.birthgds_odrid = birthgds_odrid;
	}
	public String getBirthgds_gdsid() {
		return birthgds_gdsid;
	}
	public void setBirthgds_gdsid(String birthgds_gdsid) {
		this.birthgds_gdsid = birthgds_gdsid;
	}
	public Long getBirthgds_status() {
		return birthgds_status;
	}
	public void setBirthgds_status(Long birthgds_status) {
		this.birthgds_status = birthgds_status;
	}
	public String getBirthgds_memo() {
		return birthgds_memo;
	}
	public void setBirthgds_memo(String birthgds_memo) {
		this.birthgds_memo = birthgds_memo;
	}
	public Date getBirthgds_update() {
		return birthgds_update;
	}
	public void setBirthgds_update(Date birthgds_update) {
		this.birthgds_update = birthgds_update;
	}

}
