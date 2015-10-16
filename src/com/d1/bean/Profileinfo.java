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
@Table(name="profileinfo")
public class Profileinfo  extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="profile_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String profile_mbrid;
	private String profile_height;
	private String profile_weight;
	private String profile_color;
	private String profile_category;
	private String profile_brand;
	private String profile_money;
	private Date profile_date;
	private String profile_xw;
	private String profile_yw;
	private String profile_shoesize;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProfile_mbrid() {
		return profile_mbrid;
	}
	public void setProfile_mbrid(String profile_mbrid) {
		this.profile_mbrid = profile_mbrid;
	}
	public String getProfile_height() {
		return profile_height;
	}
	public void setProfile_height(String profile_height) {
		this.profile_height = profile_height;
	}
	public String getProfile_weight() {
		return profile_weight;
	}
	public void setProfile_weight(String profile_weight) {
		this.profile_weight = profile_weight;
	}
	public String getProfile_color() {
		return profile_color;
	}
	public void setProfile_color(String profile_color) {
		this.profile_color = profile_color;
	}
	public String getProfile_category() {
		return profile_category;
	}
	public void setProfile_category(String profile_category) {
		this.profile_category = profile_category;
	}
	public String getProfile_brand() {
		return profile_brand;
	}
	public void setProfile_brand(String profile_brand) {
		this.profile_brand = profile_brand;
	}
	public String getProfile_money() {
		return profile_money;
	}
	public void setProfile_money(String profile_money) {
		this.profile_money = profile_money;
	}
	public Date getProfile_date() {
		return profile_date;
	}
	public void setProfile_date(Date profile_date) {
		this.profile_date = profile_date;
	}
	public String getProfile_xw() {
		return profile_xw;
	}
	public void setProfile_xw(String profile_xw) {
		this.profile_xw = profile_xw;
	}
	public String getProfile_yw() {
		return profile_yw;
	}
	public void setProfile_yw(String profile_yw) {
		this.profile_yw = profile_yw;
	}
	public String getProfile_shoesize() {
		return profile_shoesize;
	}
	public void setProfile_shoesize(String profile_shoesize) {
		this.profile_shoesize = profile_shoesize;
	}
	
}
