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
 * 优惠券主表
 * @author kk
 *
 */
@Entity
@Table(name="tktmst")
public class Ticket extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="tktmst_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done

	/**
	 * 减多少
	 */
	private Float tktmst_value;
	private String tktmst_type;
	private String tktmst_sodrid;
	private Long tktmst_mbrid;
	
	/**
	 * 是否已经用过，0未使用，1使用过
	 */
	private Long tktmst_validflag;
	
	/**
	 * 券用于的订单号
	 */
	private String tktmst_uodrid;
	private Date tktmst_createdate;
	private Date tktmst_validates;
	private Date tktmst_validatee;
	private Long tktmst_downflag = new Long(0);
	private String tktmst_rackcode;
	
	/**
	 * 满多少
	 */
	private Float tktmst_gdsvalue;
	private String tktmst_cardno = "";
	private String Tktmst_sprckcodeStr = "";
	private Long tktmst_baihuo = new Long(0);
	private String tktmst_memo;
	private Long tktmst_payid;
	private String tktmst_shopcodes="00000000";
	
	/**
	 * tktmst_ifcrd	等于1为从tktcrd中生成的百分比减免金额
	 */
	private Long tktmst_ifcrd;
	
	/**
	 * 品牌名限制
	 */
	private String tktmst_brandname ;
	
	public String getTktmst_brandname() {
		return tktmst_brandname;
	}
	public void setTktmst_brandname(String tktmst_brandname) {
		this.tktmst_brandname = tktmst_brandname;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Float getTktmst_value() {
		return tktmst_value;
	}
	public void setTktmst_value(Float tktmst_value) {
		this.tktmst_value = tktmst_value;
	}
	public String getTktmst_type() {
		return tktmst_type;
	}
	public void setTktmst_type(String tktmst_type) {
		this.tktmst_type = tktmst_type;
	}
	public String getTktmst_sodrid() {
		return tktmst_sodrid;
	}
	public void setTktmst_sodrid(String tktmst_sodrid) {
		this.tktmst_sodrid = tktmst_sodrid;
	}
	public Long getTktmst_mbrid() {
		return tktmst_mbrid;
	}
	public void setTktmst_mbrid(Long tktmst_mbrid) {
		this.tktmst_mbrid = tktmst_mbrid;
	}
	public Long getTktmst_validflag() {
		return tktmst_validflag;
	}
	public void setTktmst_validflag(Long tktmst_validflag) {
		this.tktmst_validflag = tktmst_validflag;
	}
	public String getTktmst_uodrid() {
		return tktmst_uodrid;
	}
	public void setTktmst_uodrid(String tktmst_uodrid) {
		this.tktmst_uodrid = tktmst_uodrid;
	}
	public Date getTktmst_createdate() {
		return tktmst_createdate;
	}
	public void setTktmst_createdate(Date tktmst_createdate) {
		this.tktmst_createdate = tktmst_createdate;
	}
	public Date getTktmst_validates() {
		return tktmst_validates;
	}
	public void setTktmst_validates(Date tktmst_validates) {
		this.tktmst_validates = tktmst_validates;
	}
	public Date getTktmst_validatee() {
		return tktmst_validatee;
	}
	public void setTktmst_validatee(Date tktmst_validatee) {
		this.tktmst_validatee = tktmst_validatee;
	}
	public Long getTktmst_downflag() {
		return tktmst_downflag;
	}
	public void setTktmst_downflag(Long tktmst_downflag) {
		this.tktmst_downflag = tktmst_downflag;
	}
	public String getTktmst_rackcode() {
		return tktmst_rackcode;
	}
	public void setTktmst_rackcode(String tktmst_rackcode) {
		this.tktmst_rackcode = tktmst_rackcode;
	}
	public Float getTktmst_gdsvalue() {
		return tktmst_gdsvalue;
	}
	public void setTktmst_gdsvalue(Float tktmst_gdsvalue) {
		this.tktmst_gdsvalue = tktmst_gdsvalue;
	}
	public String getTktmst_cardno() {
		return tktmst_cardno;
	}
	public void setTktmst_cardno(String tktmst_cardno) {
		this.tktmst_cardno = tktmst_cardno;
	}
	public String getTktmst_sprckcodeStr() {
		return Tktmst_sprckcodeStr;
	}
	public void setTktmst_sprckcodeStr(String tktmst_sprckcodeStr) {
		Tktmst_sprckcodeStr = tktmst_sprckcodeStr;
	}
	public Long getTktmst_baihuo() {
		return tktmst_baihuo;
	}
	public void setTktmst_baihuo(Long tktmst_baihuo) {
		this.tktmst_baihuo = tktmst_baihuo;
	}
	public String getTktmst_memo() {
		return tktmst_memo;
	}
	public void setTktmst_memo(String tktmst_memo) {
		this.tktmst_memo = tktmst_memo;
	}
	public Long getTktmst_payid() {
		return tktmst_payid;
	}
	public void setTktmst_payid(Long tktmst_payid) {
		this.tktmst_payid = tktmst_payid;
	}
	public Long getTktmst_ifcrd() {
		return tktmst_ifcrd;
	}
	public void setTktmst_ifcrd(Long tktmst_ifcrd) {
		this.tktmst_ifcrd = tktmst_ifcrd;
	}
	public String getTktmst_shopcodes() {
		return tktmst_shopcodes;
	}
	public void setTktmst_shopcodes(String tktmst_shopcodes) {
		this.tktmst_shopcodes = tktmst_shopcodes;
	}
}
