package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 省份城市表，前台只读
 * @author kk
 */
@Entity
@Table(name="ctymst")
public class City extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="ctymst_cityid")
	private String id;//done
	private Long ctymst_provinceid;
	private Long ctymst_countryid;
	private String ctymst_name;
	private String ctymst_memo;
	private String ctymst_postcode;
	private Long ctymst_type;
	private Long ctymst_ifcanhf;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getCtymst_provinceid() {
		return ctymst_provinceid;
	}
	public void setCtymst_provinceid(Long ctymst_provinceid) {
		this.ctymst_provinceid = ctymst_provinceid;
	}
	public Long getCtymst_countryid() {
		return ctymst_countryid;
	}
	public void setCtymst_countryid(Long ctymst_countryid) {
		this.ctymst_countryid = ctymst_countryid;
	}
	public String getCtymst_name() {
		return ctymst_name;
	}
	public void setCtymst_name(String ctymst_name) {
		this.ctymst_name = ctymst_name;
	}
	public String getCtymst_memo() {
		return ctymst_memo;
	}
	public void setCtymst_memo(String ctymst_memo) {
		this.ctymst_memo = ctymst_memo;
	}
	public String getCtymst_postcode() {
		return ctymst_postcode;
	}
	public void setCtymst_postcode(String ctymst_postcode) {
		this.ctymst_postcode = ctymst_postcode;
	}
	public Long getCtymst_type() {
		return ctymst_type;
	}
	public void setCtymst_type(Long ctymst_type) {
		this.ctymst_type = ctymst_type;
	}
	public Long getCtymst_ifcanhf() {
		return ctymst_ifcanhf;
	}
	public void setCtymst_ifcanhf(Long ctymst_ifcanhf) {
		this.ctymst_ifcanhf = ctymst_ifcanhf;
	}
}
