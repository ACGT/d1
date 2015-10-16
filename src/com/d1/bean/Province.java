package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 省份表，前台只读
 * @author kk
 */
@Entity
@Table(name="prvmst")
public class Province extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="prvmst_provinceid")
	private String id;
	
	private Long prvmst_countryid;
	/**
	 * 省份名字
	 */
	private String prvmst_name;
	private String prvmst_memo;
	private Date applydate;
	private Long prvmst_areaid;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getPrvmst_countryid() {
		return prvmst_countryid;
	}
	public void setPrvmst_countryid(Long prvmst_countryid) {
		this.prvmst_countryid = prvmst_countryid;
	}
	public String getPrvmst_name() {
		return prvmst_name;
	}
	public void setPrvmst_name(String prvmst_name) {
		this.prvmst_name = prvmst_name;
	}
	public String getPrvmst_memo() {
		return prvmst_memo;
	}
	public void setPrvmst_memo(String prvmst_memo) {
		this.prvmst_memo = prvmst_memo;
	}
	public Date getApplydate() {
		return applydate;
	}
	public void setApplydate(Date applydate) {
		this.applydate = applydate;
	}
	public Long getPrvmst_areaid() {
		return prvmst_areaid;
	}
	public void setPrvmst_areaid(Long prvmst_areaid) {
		this.prvmst_areaid = prvmst_areaid;
	}
}
