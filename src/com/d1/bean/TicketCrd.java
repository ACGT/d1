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
 * 优惠券
 * @author kk
 *
 */
@Entity
@Table(name="tktcrd")
public class TicketCrd extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="tktcrd_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done

	private String tktcrd_cardno;
	private Long tktcrd_value;
	
	/**
	 * 剩余多少钱可减
	 */
	private Long tktcrd_realvalue;
	private Float tktcrd_discount;
	private Long tktcrd_mbrid;
	private String tktcrd_type;
	private Long tktcrd_validflag;
	private Date tktcrd_createdate;
	private Date tktcrd_enddate;
	private Date tktcrd_validates;
	private Date tktcrd_validatee;
	private Date tktcrd_getdate;
	private String tktcrd_memo;
	private Long tktcrd_payid;
	private String tktcrd_brandname;
	private String tktcrd_rackcode;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTktcrd_cardno() {
		return tktcrd_cardno;
	}
	public void setTktcrd_cardno(String tktcrd_cardno) {
		this.tktcrd_cardno = tktcrd_cardno;
	}
	public Long getTktcrd_value() {
		return tktcrd_value;
	}
	public void setTktcrd_value(Long tktcrd_value) {
		this.tktcrd_value = tktcrd_value;
	}
	public Long getTktcrd_realvalue() {
		return tktcrd_realvalue;
	}
	public void setTktcrd_realvalue(Long tktcrd_realvalue) {
		this.tktcrd_realvalue = tktcrd_realvalue;
	}
	public Float getTktcrd_discount() {
		return tktcrd_discount;
	}
	public void setTktcrd_discount(Float tktcrd_discount) {
		this.tktcrd_discount = tktcrd_discount;
	}
	public Long getTktcrd_mbrid() {
		return tktcrd_mbrid;
	}
	public void setTktcrd_mbrid(Long tktcrd_mbrid) {
		this.tktcrd_mbrid = tktcrd_mbrid;
	}
	public String getTktcrd_type() {
		return tktcrd_type;
	}
	public void setTktcrd_type(String tktcrd_type) {
		this.tktcrd_type = tktcrd_type;
	}
	public Long getTktcrd_validflag() {
		return tktcrd_validflag;
	}
	public void setTktcrd_validflag(Long tktcrd_validflag) {
		this.tktcrd_validflag = tktcrd_validflag;
	}
	public Date getTktcrd_createdate() {
		return tktcrd_createdate;
	}
	public void setTktcrd_createdate(Date tktcrd_createdate) {
		this.tktcrd_createdate = tktcrd_createdate;
	}
	public Date getTktcrd_enddate() {
		return tktcrd_enddate;
	}
	public void setTktcrd_enddate(Date tktcrd_enddate) {
		this.tktcrd_enddate = tktcrd_enddate;
	}
	public Date getTktcrd_validates() {
		return tktcrd_validates;
	}
	public void setTktcrd_validates(Date tktcrd_validates) {
		this.tktcrd_validates = tktcrd_validates;
	}
	public Date getTktcrd_validatee() {
		return tktcrd_validatee;
	}
	public void setTktcrd_validatee(Date tktcrd_validatee) {
		this.tktcrd_validatee = tktcrd_validatee;
	}
	public Date getTktcrd_getdate() {
		return tktcrd_getdate;
	}
	public void setTktcrd_getdate(Date tktcrd_getdate) {
		this.tktcrd_getdate = tktcrd_getdate;
	}
	public String getTktcrd_memo() {
		return tktcrd_memo;
	}
	public void setTktcrd_memo(String tktcrd_memo) {
		this.tktcrd_memo = tktcrd_memo;
	}
	public Long getTktcrd_payid() {
		return tktcrd_payid;
	}
	public void setTktcrd_payid(Long tktcrd_payid) {
		this.tktcrd_payid = tktcrd_payid;
	}
	public String getTktcrd_brandname() {
		return tktcrd_brandname;
	}
	public void setTktcrd_brandname(String tktcrd_brandname) {
		this.tktcrd_brandname = tktcrd_brandname;
	}
	public String getTktcrd_rackcode() {
		return tktcrd_rackcode;
	}
	public void setTktcrd_rackcode(String tktcrd_rackcode) {
		this.tktcrd_rackcode = tktcrd_rackcode;
	}
}
