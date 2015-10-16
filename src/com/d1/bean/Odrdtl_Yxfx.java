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
 * ÓªÏú·ÖÎöÏêÏ¸
 * 
 * @author wdx
 *
 */

@Entity
@Table(name="odrdtl_yxfx")
public class Odrdtl_Yxfx extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;
	private String odrdtl_odrid;
	private String odrdtl_gdsid;
	private String odrdtl_gdsname;
	private String odrdtl_rackcode;
	private Float odrdtl_finalprice;
	private Long odrdtl_gdscount;
	private Date odrdtl_creatdate;
	private String odrdtl_gifttype;
	private Float odrdtl_purprice;
	private Date gdsmst_createdate;
	private String gdsmst_brandname;
	private String gdsmst_gdsname;
	private String gdsmst_brand;
	private Long odrdtl_purtype;
	private Date odrdtl_phtime;
	private Long odrdtl_sendcount;
	private Float odrdtl_totalmoney;
	private String odrdtl_purshopcode;
	private Date odrdtl_purvaliddate;
	private Long odrdtl_shipstatus;
	private Long odrdtl_servicerack;
	private Date odrdtl_purcreatedate;
	private Date odrdtl_purenddate;
	private String odrdtl_temp;
	private Float odrdtl_eyuan;
	private Float odrdtl_totalincomevalue;
	private Float gdsmst_othercost;
	private String gdsmst_provide;
	private String gdsmst_buyer;
	private String odrdtl_tuancardno;
	private Long gdsmst_validflag;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOdrdtl_odrid() {
		return odrdtl_odrid;
	}
	public void setOdrdtl_odrid(String odrdtl_odrid) {
		this.odrdtl_odrid = odrdtl_odrid;
	}
	public String getOdrdtl_gdsid() {
		return odrdtl_gdsid;
	}
	public void setOdrdtl_gdsid(String odrdtl_gdsid) {
		this.odrdtl_gdsid = odrdtl_gdsid;
	}
	public String getOdrdtl_gdsname() {
		return odrdtl_gdsname;
	}
	public void setOdrdtl_gdsname(String odrdtl_gdsname) {
		this.odrdtl_gdsname = odrdtl_gdsname;
	}
	public String getOdrdtl_rackcode() {
		return odrdtl_rackcode;
	}
	public void setOdrdtl_rackcode(String odrdtl_rackcode) {
		this.odrdtl_rackcode = odrdtl_rackcode;
	}
	public Float getOdrdtl_finalprice() {
		return odrdtl_finalprice;
	}
	public void setOdrdtl_finalprice(Float odrdtl_finalprice) {
		this.odrdtl_finalprice = odrdtl_finalprice;
	}
	public Long getOdrdtl_gdscount() {
		return odrdtl_gdscount;
	}
	public void setOdrdtl_gdscount(Long odrdtl_gdscount) {
		this.odrdtl_gdscount = odrdtl_gdscount;
	}
	public Date getOdrdtl_creatdate() {
		return odrdtl_creatdate;
	}
	public void setOdrdtl_creatdate(Date odrdtl_creatdate) {
		this.odrdtl_creatdate = odrdtl_creatdate;
	}
	public String getOdrdtl_gifttype() {
		return odrdtl_gifttype;
	}
	public void setOdrdtl_gifttype(String odrdtl_gifttype) {
		this.odrdtl_gifttype = odrdtl_gifttype;
	}
	public Float getOdrdtl_purprice() {
		return odrdtl_purprice;
	}
	public void setOdrdtl_purprice(Float odrdtl_purprice) {
		this.odrdtl_purprice = odrdtl_purprice;
	}
	public Date getGdsmst_createdate() {
		return gdsmst_createdate;
	}
	public void setGdsmst_createdate(Date gdsmst_createdate) {
		this.gdsmst_createdate = gdsmst_createdate;
	}
	public String getGdsmst_brandname() {
		return gdsmst_brandname;
	}
	public void setGdsmst_brandname(String gdsmst_brandname) {
		this.gdsmst_brandname = gdsmst_brandname;
	}
	public String getGdsmst_gdsname() {
		return gdsmst_gdsname;
	}
	public void setGdsmst_gdsname(String gdsmst_gdsname) {
		this.gdsmst_gdsname = gdsmst_gdsname;
	}
	public String getGdsmst_brand() {
		return gdsmst_brand;
	}
	public void setGdsmst_brand(String gdsmst_brand) {
		this.gdsmst_brand = gdsmst_brand;
	}
	public Long getOdrdtl_purtype() {
		return odrdtl_purtype;
	}
	public void setOdrdtl_purtype(Long odrdtl_purtype) {
		this.odrdtl_purtype = odrdtl_purtype;
	}
	public Date getOdrdtl_phtime() {
		return odrdtl_phtime;
	}
	public void setOdrdtl_phtime(Date odrdtl_phtime) {
		this.odrdtl_phtime = odrdtl_phtime;
	}
	public Long getOdrdtl_sendcount() {
		return odrdtl_sendcount;
	}
	public void setOdrdtl_sendcount(Long odrdtl_sendcount) {
		this.odrdtl_sendcount = odrdtl_sendcount;
	}
	public Float getOdrdtl_totalmoney() {
		return odrdtl_totalmoney;
	}
	public void setOdrdtl_totalmoney(Float odrdtl_totalmoney) {
		this.odrdtl_totalmoney = odrdtl_totalmoney;
	}
	public String getOdrdtl_purshopcode() {
		return odrdtl_purshopcode;
	}
	public void setOdrdtl_purshopcode(String odrdtl_purshopcode) {
		this.odrdtl_purshopcode = odrdtl_purshopcode;
	}
	public Date getOdrdtl_purvaliddate() {
		return odrdtl_purvaliddate;
	}
	public void setOdrdtl_purvaliddate(Date odrdtl_purvaliddate) {
		this.odrdtl_purvaliddate = odrdtl_purvaliddate;
	}
	public Long getOdrdtl_shipstatus() {
		return odrdtl_shipstatus;
	}
	public void setOdrdtl_shipstatus(Long odrdtl_shipstatus) {
		this.odrdtl_shipstatus = odrdtl_shipstatus;
	}
	public Long getOdrdtl_servicerack() {
		return odrdtl_servicerack;
	}
	public void setOdrdtl_servicerack(Long odrdtl_servicerack) {
		this.odrdtl_servicerack = odrdtl_servicerack;
	}
	public Date getOdrdtl_purcreatedate() {
		return odrdtl_purcreatedate;
	}
	public void setOdrdtl_purcreatedate(Date odrdtl_purcreatedate) {
		this.odrdtl_purcreatedate = odrdtl_purcreatedate;
	}
	public Date getOdrdtl_purenddate() {
		return odrdtl_purenddate;
	}
	public void setOdrdtl_purenddate(Date odrdtl_purenddate) {
		this.odrdtl_purenddate = odrdtl_purenddate;
	}
	public String getOdrdtl_temp() {
		return odrdtl_temp;
	}
	public void setOdrdtl_temp(String odrdtl_temp) {
		this.odrdtl_temp = odrdtl_temp;
	}
	public Float getOdrdtl_eyuan() {
		return odrdtl_eyuan;
	}
	public void setOdrdtl_eyuan(Float odrdtl_eyuan) {
		this.odrdtl_eyuan = odrdtl_eyuan;
	}
	public Float getOdrdtl_totalincomevalue() {
		return odrdtl_totalincomevalue;
	}
	public void setOdrdtl_totalincomevalue(Float odrdtl_totalincomevalue) {
		this.odrdtl_totalincomevalue = odrdtl_totalincomevalue;
	}
	public Float getGdsmst_othercost() {
		return gdsmst_othercost;
	}
	public void setGdsmst_othercost(Float gdsmst_othercost) {
		this.gdsmst_othercost = gdsmst_othercost;
	}
	public String getGdsmst_provide() {
		return gdsmst_provide;
	}
	public void setGdsmst_provide(String gdsmst_provide) {
		this.gdsmst_provide = gdsmst_provide;
	}
	public String getGdsmst_buyer() {
		return gdsmst_buyer;
	}
	public void setGdsmst_buyer(String gdsmst_buyer) {
		this.gdsmst_buyer = gdsmst_buyer;
	}
	public String getOdrdtl_tuancardno() {
		return odrdtl_tuancardno;
	}
	public void setOdrdtl_tuancardno(String odrdtl_tuancardno) {
		this.odrdtl_tuancardno = odrdtl_tuancardno;
	}
	public Long getGdsmst_validflag() {
		return gdsmst_validflag;
	}
	public void setGdsmst_validflag(Long gdsmst_validflag) {
		this.gdsmst_validflag = gdsmst_validflag;
	}
	
}
