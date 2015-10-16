package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 供应商表
 * @author kk
 *
 */
@Entity
@Table(name="provide")
public class Provider extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="provide_id")
	private String id;//done

	private String provide_shopcode;
	private String provide_name;
	private String provide_Corporate;
	private String provide_url;
	private String provide_info;
	private String provide_license;
	private String provide_Contract;
	private String provide_Contractpath;
	private String provide_level;
	private String provide_oldprovide;
	private Long provide_status;
	private String provide_Ordermodus;
	private String provide_postmodus;
	private Float provide_gdsDiscount;
	private Float provide_gdslowestDiscount;
	private String provide_shipfeeRule;
	private String provide_rule;
	private String provide_service;
	private String provide_address;
	private String provide_rname;
	private String provide_zipcode;
	private String provide_bank;
	private String provide_bankpeople;
	private String provide_bankAccount;
	private Long provide_Btype;
	private String provide_CheckoutCycle;
	private String provide_CheckoutLatest;
	private String provide_Invoice;
	private String provide_contact1;
	private String provide_mp1;
	private String provide_tel1;
	private String provide_email1;
	private String provide_contact2;
	private String provide_mp2;
	private String provide_tel2;
	private String provide_email2;
	private String provide_d1contact;
	private String provide_workscope;
	private Date provide_createdate;
	private Date provide_updatedate;
	private Long provide_gdscount;
	private Long provide_realgdscount;
	private Long provide_fktype;
	private Float provide_fdcount;
	private String provide_fdtype;
	private Long provide_ctlen;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProvide_shopcode() {
		return provide_shopcode;
	}
	public void setProvide_shopcode(String provide_shopcode) {
		this.provide_shopcode = provide_shopcode;
	}
	public String getProvide_name() {
		return provide_name;
	}
	public void setProvide_name(String provide_name) {
		this.provide_name = provide_name;
	}
	public String getProvide_Corporate() {
		return provide_Corporate;
	}
	public void setProvide_Corporate(String provide_Corporate) {
		this.provide_Corporate = provide_Corporate;
	}
	public String getProvide_url() {
		return provide_url;
	}
	public void setProvide_url(String provide_url) {
		this.provide_url = provide_url;
	}
	public String getProvide_info() {
		return provide_info;
	}
	public void setProvide_info(String provide_info) {
		this.provide_info = provide_info;
	}
	public String getProvide_license() {
		return provide_license;
	}
	public void setProvide_license(String provide_license) {
		this.provide_license = provide_license;
	}
	public String getProvide_Contract() {
		return provide_Contract;
	}
	public void setProvide_Contract(String provide_Contract) {
		this.provide_Contract = provide_Contract;
	}
	public String getProvide_Contractpath() {
		return provide_Contractpath;
	}
	public void setProvide_Contractpath(String provide_Contractpath) {
		this.provide_Contractpath = provide_Contractpath;
	}
	public String getProvide_level() {
		return provide_level;
	}
	public void setProvide_level(String provide_level) {
		this.provide_level = provide_level;
	}
	public String getProvide_oldprovide() {
		return provide_oldprovide;
	}
	public void setProvide_oldprovide(String provide_oldprovide) {
		this.provide_oldprovide = provide_oldprovide;
	}
	public Long getProvide_status() {
		return provide_status;
	}
	public void setProvide_status(Long provide_status) {
		this.provide_status = provide_status;
	}
	public String getProvide_Ordermodus() {
		return provide_Ordermodus;
	}
	public void setProvide_Ordermodus(String provide_Ordermodus) {
		this.provide_Ordermodus = provide_Ordermodus;
	}
	public String getProvide_postmodus() {
		return provide_postmodus;
	}
	public void setProvide_postmodus(String provide_postmodus) {
		this.provide_postmodus = provide_postmodus;
	}
	public Float getProvide_gdsDiscount() {
		return provide_gdsDiscount;
	}
	public void setProvide_gdsDiscount(Float provide_gdsDiscount) {
		this.provide_gdsDiscount = provide_gdsDiscount;
	}
	public Float getProvide_gdslowestDiscount() {
		return provide_gdslowestDiscount;
	}
	public void setProvide_gdslowestDiscount(Float provide_gdslowestDiscount) {
		this.provide_gdslowestDiscount = provide_gdslowestDiscount;
	}
	public String getProvide_shipfeeRule() {
		return provide_shipfeeRule;
	}
	public void setProvide_shipfeeRule(String provide_shipfeeRule) {
		this.provide_shipfeeRule = provide_shipfeeRule;
	}
	public String getProvide_rule() {
		return provide_rule;
	}
	public void setProvide_rule(String provide_rule) {
		this.provide_rule = provide_rule;
	}
	public String getProvide_service() {
		return provide_service;
	}
	public void setProvide_service(String provide_service) {
		this.provide_service = provide_service;
	}
	public String getProvide_address() {
		return provide_address;
	}
	public void setProvide_address(String provide_address) {
		this.provide_address = provide_address;
	}
	public String getProvide_rname() {
		return provide_rname;
	}
	public void setProvide_rname(String provide_rname) {
		this.provide_rname = provide_rname;
	}
	public String getProvide_zipcode() {
		return provide_zipcode;
	}
	public void setProvide_zipcode(String provide_zipcode) {
		this.provide_zipcode = provide_zipcode;
	}
	public String getProvide_bank() {
		return provide_bank;
	}
	public void setProvide_bank(String provide_bank) {
		this.provide_bank = provide_bank;
	}
	public String getProvide_bankpeople() {
		return provide_bankpeople;
	}
	public void setProvide_bankpeople(String provide_bankpeople) {
		this.provide_bankpeople = provide_bankpeople;
	}
	public String getProvide_bankAccount() {
		return provide_bankAccount;
	}
	public void setProvide_bankAccount(String provide_bankAccount) {
		this.provide_bankAccount = provide_bankAccount;
	}
	public Long getProvide_Btype() {
		return provide_Btype;
	}
	public void setProvide_Btype(Long provide_Btype) {
		this.provide_Btype = provide_Btype;
	}
	public String getProvide_CheckoutCycle() {
		return provide_CheckoutCycle;
	}
	public void setProvide_CheckoutCycle(String provide_CheckoutCycle) {
		this.provide_CheckoutCycle = provide_CheckoutCycle;
	}
	public String getProvide_CheckoutLatest() {
		return provide_CheckoutLatest;
	}
	public void setProvide_CheckoutLatest(String provide_CheckoutLatest) {
		this.provide_CheckoutLatest = provide_CheckoutLatest;
	}
	public String getProvide_Invoice() {
		return provide_Invoice;
	}
	public void setProvide_Invoice(String provide_Invoice) {
		this.provide_Invoice = provide_Invoice;
	}
	public String getProvide_contact1() {
		return provide_contact1;
	}
	public void setProvide_contact1(String provide_contact1) {
		this.provide_contact1 = provide_contact1;
	}
	public String getProvide_mp1() {
		return provide_mp1;
	}
	public void setProvide_mp1(String provide_mp1) {
		this.provide_mp1 = provide_mp1;
	}
	public String getProvide_tel1() {
		return provide_tel1;
	}
	public void setProvide_tel1(String provide_tel1) {
		this.provide_tel1 = provide_tel1;
	}
	public String getProvide_email1() {
		return provide_email1;
	}
	public void setProvide_email1(String provide_email1) {
		this.provide_email1 = provide_email1;
	}
	public String getProvide_contact2() {
		return provide_contact2;
	}
	public void setProvide_contact2(String provide_contact2) {
		this.provide_contact2 = provide_contact2;
	}
	public String getProvide_mp2() {
		return provide_mp2;
	}
	public void setProvide_mp2(String provide_mp2) {
		this.provide_mp2 = provide_mp2;
	}
	public String getProvide_tel2() {
		return provide_tel2;
	}
	public void setProvide_tel2(String provide_tel2) {
		this.provide_tel2 = provide_tel2;
	}
	public String getProvide_email2() {
		return provide_email2;
	}
	public void setProvide_email2(String provide_email2) {
		this.provide_email2 = provide_email2;
	}
	public String getProvide_d1contact() {
		return provide_d1contact;
	}
	public void setProvide_d1contact(String provide_d1contact) {
		this.provide_d1contact = provide_d1contact;
	}
	public String getProvide_workscope() {
		return provide_workscope;
	}
	public void setProvide_workscope(String provide_workscope) {
		this.provide_workscope = provide_workscope;
	}
	public Date getProvide_createdate() {
		return provide_createdate;
	}
	public void setProvide_createdate(Date provide_createdate) {
		this.provide_createdate = provide_createdate;
	}
	public Date getProvide_updatedate() {
		return provide_updatedate;
	}
	public void setProvide_updatedate(Date provide_updatedate) {
		this.provide_updatedate = provide_updatedate;
	}
	public Long getProvide_gdscount() {
		return provide_gdscount;
	}
	public void setProvide_gdscount(Long provide_gdscount) {
		this.provide_gdscount = provide_gdscount;
	}
	public Long getProvide_realgdscount() {
		return provide_realgdscount;
	}
	public void setProvide_realgdscount(Long provide_realgdscount) {
		this.provide_realgdscount = provide_realgdscount;
	}
	public Long getProvide_fktype() {
		return provide_fktype;
	}
	public void setProvide_fktype(Long provide_fktype) {
		this.provide_fktype = provide_fktype;
	}
	public Float getProvide_fdcount() {
		return provide_fdcount;
	}
	public void setProvide_fdcount(Float provide_fdcount) {
		this.provide_fdcount = provide_fdcount;
	}
	public String getProvide_fdtype() {
		return provide_fdtype;
	}
	public void setProvide_fdtype(String provide_fdtype) {
		this.provide_fdtype = provide_fdtype;
	}
	public Long getProvide_ctlen() {
		return provide_ctlen;
	}
	public void setProvide_ctlen(Long provide_ctlen) {
		this.provide_ctlen = provide_ctlen;
	}
	
	
}
