package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品推荐表
 * @author kk
 *
 */
@Entity
@Table(name="spgdsrcm")
public class PromotionProduct extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="spgdsrcm_id")
	private String id ;//done
	
	private Long spgdsrcm_code;
	private String spgdsrcm_gdsid;
	private String spgdsrcm_rackcode;
	private Long spgdsrcm_seq;
	private Date spgdsrcm_begindate;
	private Date spgdsrcm_enddate;
	private String spgdsrcm_specialtxt;
	private Date spgdsrcm_dtcrt;
	private Date spgdsrcm_dtupd;
	private String spgdsrcm_gdsname;
	private String spgdsrcm_briefintrduce;
	private Float spgdsrcm_refprice;
	private String spgdsrcm_otherlink;
	private String spgdsrcm_otherimg;
	private String spgdsrcm_layertype;
	private String spgdsrcm_layertitle;
	private Float spgdsrcm_tjprice;
	private Long spgdsrcm_tghit;
	private Long spgdsrcm_areaid;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getSpgdsrcm_code() {
		return spgdsrcm_code;
	}
	public void setSpgdsrcm_code(Long spgdsrcm_code) {
		this.spgdsrcm_code = spgdsrcm_code;
	}
	public String getSpgdsrcm_gdsid() {
		return spgdsrcm_gdsid;
	}
	public void setSpgdsrcm_gdsid(String spgdsrcm_gdsid) {
		this.spgdsrcm_gdsid = spgdsrcm_gdsid;
	}
	public String getSpgdsrcm_rackcode() {
		return spgdsrcm_rackcode;
	}
	public void setSpgdsrcm_rackcode(String spgdsrcm_rackcode) {
		this.spgdsrcm_rackcode = spgdsrcm_rackcode;
	}
	public Long getSpgdsrcm_seq() {
		return spgdsrcm_seq;
	}
	public void setSpgdsrcm_seq(Long spgdsrcm_seq) {
		this.spgdsrcm_seq = spgdsrcm_seq;
	}
	public Date getSpgdsrcm_begindate() {
		return spgdsrcm_begindate;
	}
	public void setSpgdsrcm_begindate(Date spgdsrcm_begindate) {
		this.spgdsrcm_begindate = spgdsrcm_begindate;
	}
	public Date getSpgdsrcm_enddate() {
		return spgdsrcm_enddate;
	}
	public void setSpgdsrcm_enddate(Date spgdsrcm_enddate) {
		this.spgdsrcm_enddate = spgdsrcm_enddate;
	}
	public String getSpgdsrcm_specialtxt() {
		return spgdsrcm_specialtxt;
	}
	public void setSpgdsrcm_specialtxt(String spgdsrcm_specialtxt) {
		this.spgdsrcm_specialtxt = spgdsrcm_specialtxt;
	}
	public Date getSpgdsrcm_dtcrt() {
		return spgdsrcm_dtcrt;
	}
	public void setSpgdsrcm_dtcrt(Date spgdsrcm_dtcrt) {
		this.spgdsrcm_dtcrt = spgdsrcm_dtcrt;
	}
	public Date getSpgdsrcm_dtupd() {
		return spgdsrcm_dtupd;
	}
	public void setSpgdsrcm_dtupd(Date spgdsrcm_dtupd) {
		this.spgdsrcm_dtupd = spgdsrcm_dtupd;
	}
	public String getSpgdsrcm_gdsname() {
		return spgdsrcm_gdsname;
	}
	public void setSpgdsrcm_gdsname(String spgdsrcm_gdsname) {
		this.spgdsrcm_gdsname = spgdsrcm_gdsname;
	}
	public String getSpgdsrcm_briefintrduce() {
		return spgdsrcm_briefintrduce;
	}
	public void setSpgdsrcm_briefintrduce(String spgdsrcm_briefintrduce) {
		this.spgdsrcm_briefintrduce = spgdsrcm_briefintrduce;
	}
	public Float getSpgdsrcm_refprice() {
		return spgdsrcm_refprice;
	}
	public void setSpgdsrcm_refprice(Float spgdsrcm_refprice) {
		this.spgdsrcm_refprice = spgdsrcm_refprice;
	}
	public String getSpgdsrcm_otherlink() {
		return spgdsrcm_otherlink;
	}
	public void setSpgdsrcm_otherlink(String spgdsrcm_otherlink) {
		this.spgdsrcm_otherlink = spgdsrcm_otherlink;
	}
	public String getSpgdsrcm_otherimg() {
		return spgdsrcm_otherimg;
	}
	public void setSpgdsrcm_otherimg(String spgdsrcm_otherimg) {
		this.spgdsrcm_otherimg = spgdsrcm_otherimg;
	}
	public String getSpgdsrcm_layertype() {
		return spgdsrcm_layertype;
	}
	public void setSpgdsrcm_layertype(String spgdsrcm_layertype) {
		this.spgdsrcm_layertype = spgdsrcm_layertype;
	}
	public String getSpgdsrcm_layertitle() {
		return spgdsrcm_layertitle;
	}
	public void setSpgdsrcm_layertitle(String spgdsrcm_layertitle) {
		this.spgdsrcm_layertitle = spgdsrcm_layertitle;
	}
	public Float getSpgdsrcm_tjprice() {
		return spgdsrcm_tjprice;
	}
	public void setSpgdsrcm_tjprice(Float spgdsrcm_tjprice) {
		this.spgdsrcm_tjprice = spgdsrcm_tjprice;
	}
	public Long getSpgdsrcm_tghit() {
		return spgdsrcm_tghit;
	}
	public void setSpgdsrcm_tghit(Long spgdsrcm_tghit) {
		this.spgdsrcm_tghit = spgdsrcm_tghit;
	}
	public Long getSpgdsrcm_areaid() {
		return spgdsrcm_areaid;
	}
	public void setSpgdsrcm_areaid(Long spgdsrcm_areaid) {
		this.spgdsrcm_areaid = spgdsrcm_areaid;
	}
	
}
