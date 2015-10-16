package com.d1.bean;

import java.util.Date;

import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import com.d1.dbcache.core.BaseEntity;

/**
 * 订单商户表，没有用，但是后台有关联，所以要写数据！！<br/>
 * 这里的id设置是有问题的，odrshp_odrid并不是唯一索引，但由于前台无读取，只有插入操作，所以可以这样设置。
 * @author kk
 *
 */
@MappedSuperclass
public abstract class OrderShopBase extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	private String odrshp_odrid;
	private String odrshp_shopcode;
	private String odrshp_sndshopcode;
	private Date odrshp_orderdate;
	private String odrshp_shopname;
	private String odrshp_country;
	private String odrshp_province;
	private String odrshp_city="";
	private Float odrshp_gdsmoney;
	private Float odrshp_shipfee;
	private Float odrshp_centerfee;
	private Float odrshp_ordermoney;
	private Float odrshp_payshopmoney;
	private Float odrshp_incomevalue;
	private Float odrshp_realincome;
	private Date odrshp_shipdate;
	private Long odrshp_shoptsmstatus;
	private Date odrshp_shoptsmtime;
	private String odrshp_shopmemo;
	private Long odrshp_blsstatus;
	private Date odrshp_blstime;
	private String odrshp_blsid;
	private Long odrshp_giftid;
	private Float odrshp_giftfee;
	private Long odrshp_downflag;
	
	public String getOdrshp_odrid() {
		return odrshp_odrid;
	}
	public void setOdrshp_odrid(String odrshp_odrid) {
		this.odrshp_odrid = odrshp_odrid;
	}
	public String getOdrshp_shopcode() {
		return odrshp_shopcode;
	}
	public void setOdrshp_shopcode(String odrshp_shopcode) {
		this.odrshp_shopcode = odrshp_shopcode;
	}
	public String getOdrshp_sndshopcode() {
		return odrshp_sndshopcode;
	}
	public void setOdrshp_sndshopcode(String odrshp_sndshopcode) {
		this.odrshp_sndshopcode = odrshp_sndshopcode;
	}
	public Date getOdrshp_orderdate() {
		return odrshp_orderdate;
	}
	public void setOdrshp_orderdate(Date odrshp_orderdate) {
		this.odrshp_orderdate = odrshp_orderdate;
	}
	public String getOdrshp_shopname() {
		return odrshp_shopname;
	}
	public void setOdrshp_shopname(String odrshp_shopname) {
		this.odrshp_shopname = odrshp_shopname;
	}
	public String getOdrshp_country() {
		return odrshp_country;
	}
	public void setOdrshp_country(String odrshp_country) {
		this.odrshp_country = odrshp_country;
	}
	public String getOdrshp_province() {
		return odrshp_province;
	}
	public void setOdrshp_province(String odrshp_province) {
		this.odrshp_province = odrshp_province;
	}
	public String getOdrshp_city() {
		return odrshp_city;
	}
	public void setOdrshp_city(String odrshp_city) {
		this.odrshp_city = odrshp_city;
	}
	public Float getOdrshp_gdsmoney() {
		return odrshp_gdsmoney;
	}
	public void setOdrshp_gdsmoney(Float odrshp_gdsmoney) {
		this.odrshp_gdsmoney = odrshp_gdsmoney;
	}
	public Float getOdrshp_shipfee() {
		return odrshp_shipfee;
	}
	public void setOdrshp_shipfee(Float odrshp_shipfee) {
		this.odrshp_shipfee = odrshp_shipfee;
	}
	public Float getOdrshp_centerfee() {
		return odrshp_centerfee;
	}
	public void setOdrshp_centerfee(Float odrshp_centerfee) {
		this.odrshp_centerfee = odrshp_centerfee;
	}
	public Float getOdrshp_ordermoney() {
		return odrshp_ordermoney;
	}
	public void setOdrshp_ordermoney(Float odrshp_ordermoney) {
		this.odrshp_ordermoney = odrshp_ordermoney;
	}
	public Float getOdrshp_payshopmoney() {
		return odrshp_payshopmoney;
	}
	public void setOdrshp_payshopmoney(Float odrshp_payshopmoney) {
		this.odrshp_payshopmoney = odrshp_payshopmoney;
	}
	public Float getOdrshp_incomevalue() {
		return odrshp_incomevalue;
	}
	public void setOdrshp_incomevalue(Float odrshp_incomevalue) {
		this.odrshp_incomevalue = odrshp_incomevalue;
	}
	public Float getOdrshp_realincome() {
		return odrshp_realincome;
	}
	public void setOdrshp_realincome(Float odrshp_realincome) {
		this.odrshp_realincome = odrshp_realincome;
	}
	public Date getOdrshp_shipdate() {
		return odrshp_shipdate;
	}
	public void setOdrshp_shipdate(Date odrshp_shipdate) {
		this.odrshp_shipdate = odrshp_shipdate;
	}
	public Long getOdrshp_shoptsmstatus() {
		return odrshp_shoptsmstatus;
	}
	public void setOdrshp_shoptsmstatus(Long odrshp_shoptsmstatus) {
		this.odrshp_shoptsmstatus = odrshp_shoptsmstatus;
	}
	public Date getOdrshp_shoptsmtime() {
		return odrshp_shoptsmtime;
	}
	public void setOdrshp_shoptsmtime(Date odrshp_shoptsmtime) {
		this.odrshp_shoptsmtime = odrshp_shoptsmtime;
	}
	public String getOdrshp_shopmemo() {
		return odrshp_shopmemo;
	}
	public void setOdrshp_shopmemo(String odrshp_shopmemo) {
		this.odrshp_shopmemo = odrshp_shopmemo;
	}
	public Long getOdrshp_blsstatus() {
		return odrshp_blsstatus;
	}
	public void setOdrshp_blsstatus(Long odrshp_blsstatus) {
		this.odrshp_blsstatus = odrshp_blsstatus;
	}
	public Date getOdrshp_blstime() {
		return odrshp_blstime;
	}
	public void setOdrshp_blstime(Date odrshp_blstime) {
		this.odrshp_blstime = odrshp_blstime;
	}
	public String getOdrshp_blsid() {
		return odrshp_blsid;
	}
	public void setOdrshp_blsid(String odrshp_blsid) {
		this.odrshp_blsid = odrshp_blsid;
	}
	public Long getOdrshp_giftid() {
		return odrshp_giftid;
	}
	public void setOdrshp_giftid(Long odrshp_giftid) {
		this.odrshp_giftid = odrshp_giftid;
	}
	public Float getOdrshp_giftfee() {
		return odrshp_giftfee;
	}
	public void setOdrshp_giftfee(Float odrshp_giftfee) {
		this.odrshp_giftfee = odrshp_giftfee;
	}
	public Long getOdrshp_downflag() {
		return odrshp_downflag;
	}
	public void setOdrshp_downflag(Long odrshp_downflag) {
		this.odrshp_downflag = odrshp_downflag;
	}
	
}
