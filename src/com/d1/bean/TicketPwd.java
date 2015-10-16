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
 * ÓÅ»ÝÈ¯×é
 * @author kk
 *
 */
@Entity
@Table(name="tktpwd")
public class TicketPwd extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="tktpwd_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done

	private String tktpwd_cardno;
	private String tktpwd_pwd;
	private Long tktpwd_value;
	private Date tktpwd_enddate;
	private Long tktpwd_gdsvalue;
	private String tktpwd_rackcode;
	private Long tktpwd_sendcount;
	private Long tktpwd_maxcount;
	private Long tktpwd_everymaxcount;
	private Date tktpwd_createdate;
	private Date tktpwd_tktstartdate;
	private Date tktpwd_tktenddate;
	private Long tktpwd_mbrid;
	private Long tktpwd_ifvip;
	private String tktpwd_sprckcodeStr;
	private Long tktpwd_baihuo;
	private Long tktpwd_payid;
	private String tktpwd_memo;
	private String tktpwd_brandname;
	private String tktpwd_shopcodes;
	
	
	public String getTktpwd_brandname() {
		return tktpwd_brandname;
	}
	public void setTktpwd_brandname(String tktpwd_brandname) {
		this.tktpwd_brandname = tktpwd_brandname;
	}
	public String getTktpwd_cardno() {
		return tktpwd_cardno;
	}
	public void setTktpwd_cardno(String tktpwd_cardno) {
		this.tktpwd_cardno = tktpwd_cardno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTktpwd_pwd() {
		return tktpwd_pwd;
	}
	public void setTktpwd_pwd(String tktpwd_pwd) {
		this.tktpwd_pwd = tktpwd_pwd;
	}
	public Long getTktpwd_value() {
		return tktpwd_value;
	}
	public void setTktpwd_value(Long tktpwd_value) {
		this.tktpwd_value = tktpwd_value;
	}
	public Date getTktpwd_enddate() {
		return tktpwd_enddate;
	}
	public void setTktpwd_enddate(Date tktpwd_enddate) {
		this.tktpwd_enddate = tktpwd_enddate;
	}
	public Long getTktpwd_gdsvalue() {
		return tktpwd_gdsvalue;
	}
	public void setTktpwd_gdsvalue(Long tktpwd_gdsvalue) {
		this.tktpwd_gdsvalue = tktpwd_gdsvalue;
	}
	public String getTktpwd_rackcode() {
		return tktpwd_rackcode;
	}
	public void setTktpwd_rackcode(String tktpwd_rackcode) {
		this.tktpwd_rackcode = tktpwd_rackcode;
	}
	public Long getTktpwd_sendcount() {
		return tktpwd_sendcount;
	}
	public void setTktpwd_sendcount(Long tktpwd_sendcount) {
		this.tktpwd_sendcount = tktpwd_sendcount;
	}
	public Long getTktpwd_maxcount() {
		return tktpwd_maxcount;
	}
	public void setTktpwd_maxcount(Long tktpwd_maxcount) {
		this.tktpwd_maxcount = tktpwd_maxcount;
	}
	public Long getTktpwd_everymaxcount() {
		return tktpwd_everymaxcount;
	}
	public void setTktpwd_everymaxcount(Long tktpwd_everymaxcount) {
		this.tktpwd_everymaxcount = tktpwd_everymaxcount;
	}
	public Date getTktpwd_createdate() {
		return tktpwd_createdate;
	}
	public void setTktpwd_createdate(Date tktpwd_createdate) {
		this.tktpwd_createdate = tktpwd_createdate;
	}
	public Date getTktpwd_tktstartdate() {
		return tktpwd_tktstartdate;
	}
	public void setTktpwd_tktstartdate(Date tktpwd_tktstartdate) {
		this.tktpwd_tktstartdate = tktpwd_tktstartdate;
	}
	public Date getTktpwd_tktenddate() {
		return tktpwd_tktenddate;
	}
	public void setTktpwd_tktenddate(Date tktpwd_tktenddate) {
		this.tktpwd_tktenddate = tktpwd_tktenddate;
	}
	public Long getTktpwd_mbrid() {
		return tktpwd_mbrid;
	}
	public void setTktpwd_mbrid(Long tktpwd_mbrid) {
		this.tktpwd_mbrid = tktpwd_mbrid;
	}
	public Long getTktpwd_ifvip() {
		return tktpwd_ifvip;
	}
	public void setTktpwd_ifvip(Long tktpwd_ifvip) {
		this.tktpwd_ifvip = tktpwd_ifvip;
	}
	public String getTktpwd_sprckcodeStr() {
		return tktpwd_sprckcodeStr;
	}
	public void setTktpwd_sprckcodeStr(String tktpwd_sprckcodeStr) {
		this.tktpwd_sprckcodeStr = tktpwd_sprckcodeStr;
	}
	public Long getTktpwd_baihuo() {
		return tktpwd_baihuo;
	}
	public void setTktpwd_baihuo(Long tktpwd_baihuo) {
		this.tktpwd_baihuo = tktpwd_baihuo;
	}
	public Long getTktpwd_payid() {
		return tktpwd_payid;
	}
	public void setTktpwd_payid(Long tktpwd_payid) {
		this.tktpwd_payid = tktpwd_payid;
	}
	public String getTktpwd_memo() {
		return tktpwd_memo;
	}
	public void setTktpwd_memo(String tktpwd_memo) {
		this.tktpwd_memo = tktpwd_memo;
	}
	public String getTktpwd_shopcodes() {
		return tktpwd_shopcodes;
	}
	public void setTktpwd_shopcodes(String tktpwd_shopcodes) {
		this.tktpwd_shopcodes = tktpwd_shopcodes;
	}
}
