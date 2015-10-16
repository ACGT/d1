package com.d1.bean;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 是否支持货到付款表接口
 * @author kk
 */
@Entity
@Table(name="cityshipfee")
public class CityShipFee extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	private String id ;//done
	
	private Long provinceid;//PK
	private Long cityid;//PK
	private Long ifcanhf;
	private Float hflimitmoney;
	private Float hfshipfee;
	private Float fhflimitmoney;
	private Float fhfshipfee;
	
	public Long getProvinceid() {
		return provinceid;
	}
	public void setProvinceid(Long provinceid) {
		this.provinceid = provinceid;
	}
	public Long getCityid() {
		return cityid;
	}
	public void setCityid(Long cityid) {
		this.cityid = cityid;
	}
	public Long getIfcanhf() {
		return ifcanhf;
	}
	public void setIfcanhf(Long ifcanhf) {
		this.ifcanhf = ifcanhf;
	}
	public Float getHflimitmoney() {
		return hflimitmoney;
	}
	public void setHflimitmoney(Float hflimitmoney) {
		this.hflimitmoney = hflimitmoney;
	}
	public Float getHfshipfee() {
		return hfshipfee;
	}
	public void setHfshipfee(Float hfshipfee) {
		this.hfshipfee = hfshipfee;
	}
	public Float getFhflimitmoney() {
		return fhflimitmoney;
	}
	public void setFhflimitmoney(Float fhflimitmoney) {
		this.fhflimitmoney = fhflimitmoney;
	}
	public Float getFhfshipfee() {
		return fhfshipfee;
	}
	public void setFhfshipfee(Float fhfshipfee) {
		this.fhfshipfee = fhfshipfee;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
