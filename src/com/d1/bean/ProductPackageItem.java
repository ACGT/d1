package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品组合明细表
 * @author kk
 *
 */
@Entity
@Table(name="gdspktdtl")
public class ProductPackageItem extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdspktdtl_id")
	private String id;//done

	private Long gdspktdtl_pktid;
	private String gdspktdtl_gdsid;
	private Float gdspktdtl_pktprice;
	private String gdspktdtl_gdsname;
	private String gdspktdtl_addusr;
	private Date gdspktdtl_createdate;
	private Long gdspktdtl_seq;
	private Long gdspktdtl_ifshow;
	private Float gdspktdtl_savemoney;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdspktdtl_pktid() {
		return gdspktdtl_pktid;
	}
	public void setGdspktdtl_pktid(Long gdspktdtl_pktid) {
		this.gdspktdtl_pktid = gdspktdtl_pktid;
	}
	public String getGdspktdtl_gdsid() {
		return gdspktdtl_gdsid;
	}
	public void setGdspktdtl_gdsid(String gdspktdtl_gdsid) {
		this.gdspktdtl_gdsid = gdspktdtl_gdsid;
	}
	public Float getGdspktdtl_pktprice() {
		return gdspktdtl_pktprice;
	}
	public void setGdspktdtl_pktprice(Float gdspktdtl_pktprice) {
		this.gdspktdtl_pktprice = gdspktdtl_pktprice;
	}
	public String getGdspktdtl_gdsname() {
		return gdspktdtl_gdsname;
	}
	public void setGdspktdtl_gdsname(String gdspktdtl_gdsname) {
		this.gdspktdtl_gdsname = gdspktdtl_gdsname;
	}
	public String getGdspktdtl_addusr() {
		return gdspktdtl_addusr;
	}
	public void setGdspktdtl_addusr(String gdspktdtl_addusr) {
		this.gdspktdtl_addusr = gdspktdtl_addusr;
	}
	public Date getGdspktdtl_createdate() {
		return gdspktdtl_createdate;
	}
	public void setGdspktdtl_createdate(Date gdspktdtl_createdate) {
		this.gdspktdtl_createdate = gdspktdtl_createdate;
	}
	public Long getGdspktdtl_seq() {
		return gdspktdtl_seq;
	}
	public void setGdspktdtl_seq(Long gdspktdtl_seq) {
		this.gdspktdtl_seq = gdspktdtl_seq;
	}
	public Long getGdspktdtl_ifshow() {
		return gdspktdtl_ifshow;
	}
	public void setGdspktdtl_ifshow(Long gdspktdtl_ifshow) {
		this.gdspktdtl_ifshow = gdspktdtl_ifshow;
	}
	public Float getGdspktdtl_savemoney() {
		return gdspktdtl_savemoney;
	}
	public void setGdspktdtl_savemoney(Float gdspktdtl_savemoney) {
		this.gdspktdtl_savemoney = gdspktdtl_savemoney;
	}
}
