package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 品牌表，前台只读
 * @author kk
 */
@Entity
@Table(name="brand")
public class Brand extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="brand_id")
	private String id;//done
	
	private String brand_rackcode;
	private String brand_code;
	private String brand_name;
	private String brand_ename;
	private String brand_logo;
	private Long brand_showflag;
	private String brand_country;
	private Long brand_gdscount;
	private String brand_url;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBrand_rackcode() {
		return brand_rackcode;
	}
	public void setBrand_rackcode(String brand_rackcode) {
		this.brand_rackcode = brand_rackcode;
	}
	public String getBrand_code() {
		return brand_code;
	}
	public void setBrand_code(String brand_code) {
		this.brand_code = brand_code;
	}
	public String getBrand_name() {
		return brand_name;
	}
	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}
	public String getBrand_ename() {
		return brand_ename;
	}
	public void setBrand_ename(String brand_ename) {
		this.brand_ename = brand_ename;
	}
	public String getBrand_logo() {
		return brand_logo;
	}
	public void setBrand_logo(String brand_logo) {
		this.brand_logo = brand_logo;
	}
	public Long getBrand_showflag() {
		return brand_showflag;
	}
	public void setBrand_showflag(Long brand_showflag) {
		this.brand_showflag = brand_showflag;
	}
	public String getBrand_country() {
		return brand_country;
	}
	public void setBrand_country(String brand_country) {
		this.brand_country = brand_country;
	}
	public Long getBrand_gdscount() {
		return brand_gdscount;
	}
	public void setBrand_gdscount(Long brand_gdscount) {
		this.brand_gdscount = brand_gdscount;
	}
	public String getBrand_url() {
		return brand_url;
	}
	public void setBrand_url(String brand_url) {
		this.brand_url = brand_url;
	}
}
