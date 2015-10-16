package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;
/*
 * ÉÌÆ·Âë¶Ò»»±í
 */
@Entity
@Table(name="tuandh")
public class Tuandh extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="tuandh_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;
	private Long tuandh_mid;
	private String tuandh_title;
	private String tuandh_cardno;
	private String tuandh_gdsid;
	private Date tuandh_endtime;
	private Long tuandh_status;
	private Date tuandh_createtime;
	private Date tuandh_yztime;
	private Date tuandh_dhtime;
	private Long tuandh_mbrid;
	private String tuandh_odrid;
	private String tuandh_memo;
	private Float tuandh_dhprice;
	private Long tuandh_shipfee;
	private Long tuandh_fee=new Long(0);
	private Long tuandh_maxbuycount;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getTuandh_mid() {
		return tuandh_mid;
	}
	public void setTuandh_mid(Long tuandh_mid) {
		this.tuandh_mid = tuandh_mid;
	}
	public String getTuandh_title() {
		return tuandh_title;
	}
	public void setTuandh_title(String tuandh_title) {
		this.tuandh_title = tuandh_title;
	}
	public String getTuandh_cardno() {
		return tuandh_cardno;
	}
	public void setTuandh_cardno(String tuandh_cardno) {
		this.tuandh_cardno = tuandh_cardno;
	}
	public String getTuandh_gdsid() {
		return tuandh_gdsid;
	}
	public void setTuandh_gdsid(String tuandh_gdsid) {
		this.tuandh_gdsid = tuandh_gdsid;
	}
	public Date getTuandh_endtime() {
		return tuandh_endtime;
	}
	public void setTuandh_endtime(Date tuandh_endtime) {
		this.tuandh_endtime = tuandh_endtime;
	}
	public Long getTuandh_status() {
		return tuandh_status;
	}
	public void setTuandh_status(Long tuandh_status) {
		this.tuandh_status = tuandh_status;
	}
	public Date getTuandh_createtime() {
		return tuandh_createtime;
	}
	public void setTuandh_createtime(Date tuandh_createtime) {
		this.tuandh_createtime = tuandh_createtime;
	}
	public Date getTuandh_yztime() {
		return tuandh_yztime;
	}
	public void setTuandh_yztime(Date tuandh_yztime) {
		this.tuandh_yztime = tuandh_yztime;
	}
	public Date getTuandh_dhtime() {
		return tuandh_dhtime;
	}
	public void setTuandh_dhtime(Date tuandh_dhtime) {
		this.tuandh_dhtime = tuandh_dhtime;
	}
	public Long getTuandh_mbrid() {
		return tuandh_mbrid;
	}
	public void setTuandh_mbrid(Long tuandh_mbrid) {
		this.tuandh_mbrid = tuandh_mbrid;
	}
	public String getTuandh_odrid() {
		return tuandh_odrid;
	}
	public void setTuandh_odrid(String tuandh_odrid) {
		this.tuandh_odrid = tuandh_odrid;
	}
	public String getTuandh_memo() {
		return tuandh_memo;
	}
	public void setTuandh_memo(String tuandh_memo) {
		this.tuandh_memo = tuandh_memo;
	}
	public Float getTuandh_dhprice() {
		return tuandh_dhprice;
	}
	public void setTuandh_dhprice(Float tuandh_dhprice) {
		this.tuandh_dhprice = tuandh_dhprice;
	}
	public Long getTuandh_shipfee() {
		return tuandh_shipfee;
	}
	public void setTuandh_shipfee(Long tuandh_shipfee) {
		this.tuandh_shipfee = tuandh_shipfee;
	}
	public Long getTuandh_fee() {
		return tuandh_fee;
	}
	public void setTuandh_fee(Long tuandh_fee) {
		this.tuandh_fee = tuandh_fee;
	}
	public Long getTuandh_maxbuycount() {
		return tuandh_maxbuycount;
	}
	public void setTuandh_maxbuycount(Long tuandh_maxbuycount) {
		this.tuandh_maxbuycount = tuandh_maxbuycount;
	}
	
}
