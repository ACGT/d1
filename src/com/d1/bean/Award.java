package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 积分换购商品表，前台没有写操作
 * @author kk
 */
@Entity
@Table(name="award",catalog="dba")
public class Award extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="award_id")
	private String id;//done
	
	/**
	 * 换购需要的积分
	 */
	private Long award_value;
	
	/**
	 * 商品id
	 */
	private String award_gdsid;
	private String award_gdsname;
	private String award_detail;
	private String award_smallimg;
	private String award_bigimg;
	private Long award_validflag;
	private Date award_createdate;
	private String award_url;
	private String award_shopcode;
	private Long award_vipflag;
	
	
	/**
	 * 换购需要的钱
	 */
	private Float award_price;
	private Long award_seq;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getAward_value() {
		return award_value;
	}
	public void setAward_value(Long award_value) {
		this.award_value = award_value;
	}
	public String getAward_gdsid() {
		return award_gdsid;
	}
	public void setAward_gdsid(String award_gdsid) {
		this.award_gdsid = award_gdsid;
	}
	public String getAward_gdsname() {
		return award_gdsname;
	}
	public void setAward_gdsname(String award_gdsname) {
		this.award_gdsname = award_gdsname;
	}
	public String getAward_detail() {
		return award_detail;
	}
	public void setAward_detail(String award_detail) {
		this.award_detail = award_detail;
	}
	public String getAward_smallimg() {
		return award_smallimg;
	}
	public void setAward_smallimg(String award_smallimg) {
		this.award_smallimg = award_smallimg;
	}
	public String getAward_bigimg() {
		return award_bigimg;
	}
	public void setAward_bigimg(String award_bigimg) {
		this.award_bigimg = award_bigimg;
	}
	public Long getAward_validflag() {
		return award_validflag;
	}
	public void setAward_validflag(Long award_validflag) {
		this.award_validflag = award_validflag;
	}
	public Date getAward_createdate() {
		return award_createdate;
	}
	public void setAward_createdate(Date award_createdate) {
		this.award_createdate = award_createdate;
	}
	public String getAward_url() {
		return award_url;
	}
	public void setAward_url(String award_url) {
		this.award_url = award_url;
	}
	public Long getAward_vipflag() {
		return award_vipflag;
	}
	public void setAward_vipflag(Long award_vipflag) {
		this.award_vipflag = award_vipflag;
	}
	public Float getAward_price() {
		return award_price;
	}
	public void setAward_price(Float award_price) {
		this.award_price = award_price;
	}
	public String getAward_shopcode() {
		return award_shopcode;
	}
	public void setAward_shopcode(String award_shopcode) {
		this.award_shopcode = award_shopcode;
	}
	public Long getAward_seq() {
		return award_seq;
	}
	public void setAward_seq(Long award_seq) {
		this.award_seq = award_seq;
	}
	
}
