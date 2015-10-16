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
@Table(name="tuandhgroup")
public class TuandhGroup extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="tuandhgroup_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;
	private String tuandhgroup_title;
	private Long tuandhgroup_checkcode;
	private String tuandhgroup_gdsid;
	private Long tuandhgroup_num;
	private Date tuandhgroup_createdate;
	private Date tuandhgroup_validates;
	private Date tuandhgroup_validatee;
	private String tuandhgroup_memo;
	private String tuandhgroup_memo2;
	private Long tuandhgroup_mid;
	private Float tuandhgroup_dhprice;
	private Long tuandhgroup_shipfee;
	private Long tuandhgroup_fee=new Long(0);
	private Long tuandhgroup_maxbuycount;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTuandhgroup_title() {
		return tuandhgroup_title;
	}
	public void setTuandhgroup_title(String tuandhgroup_title) {
		this.tuandhgroup_title = tuandhgroup_title;
	}
	public Long getTuandhgroup_checkcode() {
		return tuandhgroup_checkcode;
	}
	public void setTuandhgroup_checkcode(Long tuandhgroup_checkcode) {
		this.tuandhgroup_checkcode = tuandhgroup_checkcode;
	}
	public String getTuandhgroup_gdsid() {
		return tuandhgroup_gdsid;
	}
	public void setTuandhgroup_gdsid(String tuandhgroup_gdsid) {
		this.tuandhgroup_gdsid = tuandhgroup_gdsid;
	}
	public Long getTuandhgroup_num() {
		return tuandhgroup_num;
	}
	public void setTuandhgroup_num(Long tuandhgroup_num) {
		this.tuandhgroup_num = tuandhgroup_num;
	}
	public Date getTuandhgroup_createdate() {
		return tuandhgroup_createdate;
	}
	public void setTuandhgroup_createdate(Date tuandhgroup_createdate) {
		this.tuandhgroup_createdate = tuandhgroup_createdate;
	}
	public Date getTuandhgroup_validates() {
		return tuandhgroup_validates;
	}
	public void setTuandhgroup_validates(Date tuandhgroup_validates) {
		this.tuandhgroup_validates = tuandhgroup_validates;
	}
	public Date getTuandhgroup_validatee() {
		return tuandhgroup_validatee;
	}
	public void setTuandhgroup_validatee(Date tuandhgroup_validatee) {
		this.tuandhgroup_validatee = tuandhgroup_validatee;
	}
	public String getTuandhgroup_memo() {
		return tuandhgroup_memo;
	}
	public void setTuandhgroup_memo(String tuandhgroup_memo) {
		this.tuandhgroup_memo = tuandhgroup_memo;
	}
	public Long getTuandhgroup_mid() {
		return tuandhgroup_mid;
	}
	public void setTuandhgroup_mid(Long tuandhgroup_mid) {
		this.tuandhgroup_mid = tuandhgroup_mid;
	}
	public String getTuandhgroup_memo2() {
		return tuandhgroup_memo2;
	}
	public void setTuandhgroup_memo2(String tuandhgroup_memo2) {
		this.tuandhgroup_memo2 = tuandhgroup_memo2;
	}
	public Float getTuandhgroup_dhprice() {
		return tuandhgroup_dhprice;
	}
	public void setTuandhgroup_dhprice(Float tuandhgroup_dhprice) {
		this.tuandhgroup_dhprice = tuandhgroup_dhprice;
	}
	public Long getTuandhgroup_shipfee() {
		return tuandhgroup_shipfee;
	}
	public void setTuandhgroup_shipfee(Long tuandhgroup_shipfee) {
		this.tuandhgroup_shipfee = tuandhgroup_shipfee;
	}
	public Long getTuandhgroup_fee() {
		return tuandhgroup_fee;
	}
	public void setTuandhgroup_fee(Long tuandhgroup_fee) {
		this.tuandhgroup_fee = tuandhgroup_fee;
	}
	public Long getTuandhgroup_maxbuycount() {
		return tuandhgroup_maxbuycount;
	}
	public void setTuandhgroup_maxbuycount(Long tuandhgroup_maxbuycount) {
		this.tuandhgroup_maxbuycount = tuandhgroup_maxbuycount;
	}
	
}
