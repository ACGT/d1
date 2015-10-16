package com.d1.bean;

import java.util.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.d1.dbcache.core.*;

/**
 * 营销分析主表
 * 
 * @author wdx
 *
 */

@Entity
@Table(name="odrmst_yxfx")
public class Odrmst_Yxfx extends BaseEntity implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;
    private Long odrmst_mbrid;
    private Float odrmst_gdsmoney;
    private Float odrmst_tktvalue;
    private String odrmst_pprovince;
    private Long odrmst_orderstatus;
    private String odrmst_temp;
    private Date odrmst_orderdate;
    private String odrmst_rsex;
    private Long odrmst_specialmbr;
    private String odrmst_subad;
    private String odrmst_odrid;
    private String odrmst_srcurl;
    private String Odrmst_cardmemo;
    private String odrmst_remail;
    private Float odrmst_shipfee;
    private String odrmst_rprovince;
    private String odrmst_sndshopcode;
    private Float odrmst_d1fee;
    private String odrmst_paymethod;
    private Date odrmst_validdate;
    private Long odrmst_tktid;
    private Date odrmst_shipdate;
    private Long odrmst_taxflag;
    private String odrmst_seokeyword;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getOdrmst_mbrid() {
		return odrmst_mbrid;
	}
	public void setOdrmst_mbrid(Long odrmst_mbrid) {
		this.odrmst_mbrid = odrmst_mbrid;
	}
	public Float getOdrmst_gdsmoney() {
		return odrmst_gdsmoney;
	}
	public void setOdrmst_gdsmoney(Float odrmst_gdsmoney) {
		this.odrmst_gdsmoney = odrmst_gdsmoney;
	}
	public Float getOdrmst_tktvalue() {
		return odrmst_tktvalue;
	}
	public void setOdrmst_tktvalue(Float odrmst_tktvalue) {
		this.odrmst_tktvalue = odrmst_tktvalue;
	}
	public String getOdrmst_pprovince() {
		return odrmst_pprovince;
	}
	public void setOdrmst_pprovince(String odrmst_pprovince) {
		this.odrmst_pprovince = odrmst_pprovince;
	}
	public Long getOdrmst_orderstatus() {
		return odrmst_orderstatus;
	}
	public void setOdrmst_orderstatus(Long odrmst_orderstatus) {
		this.odrmst_orderstatus = odrmst_orderstatus;
	}
	public String getOdrmst_temp() {
		return odrmst_temp;
	}
	public void setOdrmst_temp(String odrmst_temp) {
		this.odrmst_temp = odrmst_temp;
	}
	public Date getOdrmst_orderdate() {
		return odrmst_orderdate;
	}
	public void setOdrmst_orderdate(Date odrmst_orderdate) {
		this.odrmst_orderdate = odrmst_orderdate;
	}
	public String getOdrmst_rsex() {
		return odrmst_rsex;
	}
	public void setOdrmst_rsex(String odrmst_rsex) {
		this.odrmst_rsex = odrmst_rsex;
	}
	public Long getOdrmst_specialmbr() {
		return odrmst_specialmbr;
	}
	public void setOdrmst_specialmbr(Long odrmst_specialmbr) {
		this.odrmst_specialmbr = odrmst_specialmbr;
	}
	public String getOdrmst_subad() {
		return odrmst_subad;
	}
	public void setOdrmst_subad(String odrmst_subad) {
		this.odrmst_subad = odrmst_subad;
	}
	public String getOdrmst_odrid() {
		return odrmst_odrid;
	}
	public void setOdrmst_odrid(String odrmst_odrid) {
		this.odrmst_odrid = odrmst_odrid;
	}
	public String getOdrmst_srcurl() {
		return odrmst_srcurl;
	}
	public void setOdrmst_srcurl(String odrmst_srcurl) {
		this.odrmst_srcurl = odrmst_srcurl;
	}
	public String getOdrmst_cardmemo() {
		return Odrmst_cardmemo;
	}
	public void setOdrmst_cardmemo(String odrmst_cardmemo) {
		Odrmst_cardmemo = odrmst_cardmemo;
	}
	public String getOdrmst_remail() {
		return odrmst_remail;
	}
	public void setOdrmst_remail(String odrmst_remail) {
		this.odrmst_remail = odrmst_remail;
	}
	public Float getOdrmst_shipfee() {
		return odrmst_shipfee;
	}
	public void setOdrmst_shipfee(Float odrmst_shipfee) {
		this.odrmst_shipfee = odrmst_shipfee;
	}
	public String getOdrmst_rprovince() {
		return odrmst_rprovince;
	}
	public void setOdrmst_rprovince(String odrmst_rprovince) {
		this.odrmst_rprovince = odrmst_rprovince;
	}
	public String getOdrmst_sndshopcode() {
		return odrmst_sndshopcode;
	}
	public void setOdrmst_sndshopcode(String odrmst_sndshopcode) {
		this.odrmst_sndshopcode = odrmst_sndshopcode;
	}
	public Float getOdrmst_d1fee() {
		return odrmst_d1fee;
	}
	public void setOdrmst_d1fee(Float odrmst_d1fee) {
		this.odrmst_d1fee = odrmst_d1fee;
	}
	public String getOdrmst_paymethod() {
		return odrmst_paymethod;
	}
	public void setOdrmst_paymethod(String odrmst_paymethod) {
		this.odrmst_paymethod = odrmst_paymethod;
	}
	public Date getOdrmst_validdate() {
		return odrmst_validdate;
	}
	public void setOdrmst_validdate(Date odrmst_validdate) {
		this.odrmst_validdate = odrmst_validdate;
	}
	public Long getOdrmst_tktid() {
		return odrmst_tktid;
	}
	public void setOdrmst_tktid(Long odrmst_tktid) {
		this.odrmst_tktid = odrmst_tktid;
	}
	public Date getOdrmst_shipdate() {
		return odrmst_shipdate;
	}
	public void setOdrmst_shipdate(Date odrmst_shipdate) {
		this.odrmst_shipdate = odrmst_shipdate;
	}
	public Long getOdrmst_taxflag() {
		return odrmst_taxflag;
	}
	public void setOdrmst_taxflag(Long odrmst_taxflag) {
		this.odrmst_taxflag = odrmst_taxflag;
	}
	public String getOdrmst_seokeyword() {
		return odrmst_seokeyword;
	}
	public void setOdrmst_seokeyword(String odrmst_seokeyword) {
		this.odrmst_seokeyword = odrmst_seokeyword;
	}
    
    
    
}
