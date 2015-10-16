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
 * ÓÃ»§±í
 * @author kk
 */
@Entity
@Table(name="mbrmstfanli")
public class UserFanLi extends BaseEntity implements java.io.Serializable {
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="mbrmstfanli_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	
	private Long mbrmstfanli_mbrid;
	private String mbrmstfanli_uid;
	private String mbrmstfanli_username;
	private String mbrmstfanli_usersafekey;
	private String mbrmstfanli_email;
	private String mbrmstfanli_name;
	private String mbrmstfanli_province;
	private String mbrmstfanli_city;
	private String mbrmstfanli_area;
	private String mbrmstfanli_address;
	private String mbrmstfanli_zip;
	private String mbrmstfanli_phone;
	private String mbrmstfanli_mobile;
	private Date mbrmstfanli_createdate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMbrmstfanli_mbrid() {
		return mbrmstfanli_mbrid;
	}
	public void setMbrmstfanli_mbrid(Long mbrmstfanli_mbrid) {
		this.mbrmstfanli_mbrid = mbrmstfanli_mbrid;
	}
	public String getMbrmstfanli_uid() {
		return mbrmstfanli_uid;
	}
	public void setMbrmstfanli_uid(String mbrmstfanli_uid) {
		this.mbrmstfanli_uid = mbrmstfanli_uid;
	}
	public String getMbrmstfanli_username() {
		return mbrmstfanli_username;
	}
	public void setMbrmstfanli_username(String mbrmstfanli_username) {
		this.mbrmstfanli_username = mbrmstfanli_username;
	}
	public String getMbrmstfanli_usersafekey() {
		return mbrmstfanli_usersafekey;
	}
	public void setMbrmstfanli_usersafekey(String mbrmstfanli_usersafekey) {
		this.mbrmstfanli_usersafekey = mbrmstfanli_usersafekey;
	}
	public String getMbrmstfanli_email() {
		return mbrmstfanli_email;
	}
	public void setMbrmstfanli_email(String mbrmstfanli_email) {
		this.mbrmstfanli_email = mbrmstfanli_email;
	}
	public String getMbrmstfanli_name() {
		return mbrmstfanli_name;
	}
	public void setMbrmstfanli_name(String mbrmstfanli_name) {
		this.mbrmstfanli_name = mbrmstfanli_name;
	}
	public String getMbrmstfanli_province() {
		return mbrmstfanli_province;
	}
	public void setMbrmstfanli_province(String mbrmstfanli_province) {
		this.mbrmstfanli_province = mbrmstfanli_province;
	}
	public String getMbrmstfanli_city() {
		return mbrmstfanli_city;
	}
	public void setMbrmstfanli_city(String mbrmstfanli_city) {
		this.mbrmstfanli_city = mbrmstfanli_city;
	}
	public String getMbrmstfanli_area() {
		return mbrmstfanli_area;
	}
	public void setMbrmstfanli_area(String mbrmstfanli_area) {
		this.mbrmstfanli_area = mbrmstfanli_area;
	}
	public String getMbrmstfanli_address() {
		return mbrmstfanli_address;
	}
	public void setMbrmstfanli_address(String mbrmstfanli_address) {
		this.mbrmstfanli_address = mbrmstfanli_address;
	}
	public String getMbrmstfanli_zip() {
		return mbrmstfanli_zip;
	}
	public void setMbrmstfanli_zip(String mbrmstfanli_zip) {
		this.mbrmstfanli_zip = mbrmstfanli_zip;
	}
	public String getMbrmstfanli_phone() {
		return mbrmstfanli_phone;
	}
	public void setMbrmstfanli_phone(String mbrmstfanli_phone) {
		this.mbrmstfanli_phone = mbrmstfanli_phone;
	}
	public String getMbrmstfanli_mobile() {
		return mbrmstfanli_mobile;
	}
	public void setMbrmstfanli_mobile(String mbrmstfanli_mobile) {
		this.mbrmstfanli_mobile = mbrmstfanli_mobile;
	}
	public Date getMbrmstfanli_createdate() {
		return mbrmstfanli_createdate;
	}
	public void setMbrmstfanli_createdate(Date mbrmstfanli_createdate) {
		this.mbrmstfanli_createdate = mbrmstfanli_createdate;
	}
}
