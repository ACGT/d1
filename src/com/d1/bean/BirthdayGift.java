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
 * 生日礼物表
 * @author kk
 */
@Entity
@Table(name="btspsdtl",catalog="dba")
public class BirthdayGift extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="btspsdtl_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private Long btspsdtl_mbrid;
	private String btspsdtl_mbruid;
	private Date btspsdtl_crtcptm;
	private Long btspsdtl_sndcpflag;
	private String btspsdtl_gflog;
	private Date btspsdtl_birthS;
	private Date btspsdtl_birthE;
	private Date btspsdtl_birthday;
	private Date btspsdtl_crtdtltm;
	private String btspsdtl_gfgdsid;
	private String btspsdtl_gfgdsname;
	private Long btspsdtl_mbrlevel;
	private String btspsdtl_tktvalue;
	private String btspsdtl_tktvalid;
	private Float btspsdtl_money;
	private String btspsdtl_addgftusr;
	private Date btspsdtl_addgfttime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getBtspsdtl_mbrid() {
		return btspsdtl_mbrid;
	}
	public void setBtspsdtl_mbrid(Long btspsdtl_mbrid) {
		this.btspsdtl_mbrid = btspsdtl_mbrid;
	}
	public String getBtspsdtl_mbruid() {
		return btspsdtl_mbruid;
	}
	public void setBtspsdtl_mbruid(String btspsdtl_mbruid) {
		this.btspsdtl_mbruid = btspsdtl_mbruid;
	}
	public Date getBtspsdtl_crtcptm() {
		return btspsdtl_crtcptm;
	}
	public void setBtspsdtl_crtcptm(Date btspsdtl_crtcptm) {
		this.btspsdtl_crtcptm = btspsdtl_crtcptm;
	}
	public Long getBtspsdtl_sndcpflag() {
		return btspsdtl_sndcpflag;
	}
	public void setBtspsdtl_sndcpflag(Long btspsdtl_sndcpflag) {
		this.btspsdtl_sndcpflag = btspsdtl_sndcpflag;
	}
	public String getBtspsdtl_gflog() {
		return btspsdtl_gflog;
	}
	public void setBtspsdtl_gflog(String btspsdtl_gflog) {
		this.btspsdtl_gflog = btspsdtl_gflog;
	}
	public Date getBtspsdtl_birthS() {
		return btspsdtl_birthS;
	}
	public void setBtspsdtl_birthS(Date btspsdtl_birthS) {
		this.btspsdtl_birthS = btspsdtl_birthS;
	}
	public Date getBtspsdtl_birthE() {
		return btspsdtl_birthE;
	}
	public void setBtspsdtl_birthE(Date btspsdtl_birthE) {
		this.btspsdtl_birthE = btspsdtl_birthE;
	}
	public Date getBtspsdtl_birthday() {
		return btspsdtl_birthday;
	}
	public void setBtspsdtl_birthday(Date btspsdtl_birthday) {
		this.btspsdtl_birthday = btspsdtl_birthday;
	}
	public Date getBtspsdtl_crtdtltm() {
		return btspsdtl_crtdtltm;
	}
	public void setBtspsdtl_crtdtltm(Date btspsdtl_crtdtltm) {
		this.btspsdtl_crtdtltm = btspsdtl_crtdtltm;
	}
	public String getBtspsdtl_gfgdsid() {
		return btspsdtl_gfgdsid;
	}
	public void setBtspsdtl_gfgdsid(String btspsdtl_gfgdsid) {
		this.btspsdtl_gfgdsid = btspsdtl_gfgdsid;
	}
	public String getBtspsdtl_gfgdsname() {
		return btspsdtl_gfgdsname;
	}
	public void setBtspsdtl_gfgdsname(String btspsdtl_gfgdsname) {
		this.btspsdtl_gfgdsname = btspsdtl_gfgdsname;
	}
	public Long getBtspsdtl_mbrlevel() {
		return btspsdtl_mbrlevel;
	}
	public void setBtspsdtl_mbrlevel(Long btspsdtl_mbrlevel) {
		this.btspsdtl_mbrlevel = btspsdtl_mbrlevel;
	}
	public String getBtspsdtl_tktvalue() {
		return btspsdtl_tktvalue;
	}
	public void setBtspsdtl_tktvalue(String btspsdtl_tktvalue) {
		this.btspsdtl_tktvalue = btspsdtl_tktvalue;
	}
	public String getBtspsdtl_tktvalid() {
		return btspsdtl_tktvalid;
	}
	public void setBtspsdtl_tktvalid(String btspsdtl_tktvalid) {
		this.btspsdtl_tktvalid = btspsdtl_tktvalid;
	}
	public Float getBtspsdtl_money() {
		return btspsdtl_money;
	}
	public void setBtspsdtl_money(Float btspsdtl_money) {
		this.btspsdtl_money = btspsdtl_money;
	}
	public String getBtspsdtl_addgftusr() {
		return btspsdtl_addgftusr;
	}
	public void setBtspsdtl_addgftusr(String btspsdtl_addgftusr) {
		this.btspsdtl_addgftusr = btspsdtl_addgftusr;
	}
	public Date getBtspsdtl_addgfttime() {
		return btspsdtl_addgfttime;
	}
	public void setBtspsdtl_addgfttime(Date btspsdtl_addgfttime) {
		this.btspsdtl_addgfttime = btspsdtl_addgfttime;
	}
}
