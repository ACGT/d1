package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 活动、特价商品表
 * @author zpp
 *
 */
@Entity
@Table(name="sprckmst")
public class SpecialProduct extends BaseEntity implements java.io.Serializable {
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="sprckmst_code")
	private String id;//done
	private String sprckmst_rackcode;
	private Long sprckmst_typeid ;
	private String sprckmst_name;
	private Long sprckmst_parentcode;
	private Long sprckmst_childflag;
	private String sprckmst_explain;
	private Long sprckmst_showflag;
	private Long sprckmst_seq;
	private Date sprckmst_dtcrt;
	private Date sprckmst_deupd;
	private String sprckmst_handworkurl;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSprckmst_rackcode() {
		return sprckmst_rackcode;
	}
	public void setSprckmst_rackcode(String sprckmst_rackcode) {
		this.sprckmst_rackcode = sprckmst_rackcode;
	}
	public Long getSprckmst_typeid() {
		return sprckmst_typeid;
	}
	public void setSprckmst_typeid(Long sprckmst_typeid) {
		this.sprckmst_typeid = sprckmst_typeid;
	}
	public String getSprckmst_name() {
		return sprckmst_name;
	}
	public void setSprckmst_name(String sprckmst_name) {
		this.sprckmst_name = sprckmst_name;
	}
	public Long getSprckmst_parentcode() {
		return sprckmst_parentcode;
	}
	public void setSprckmst_parentcode(Long sprckmst_parentcode) {
		this.sprckmst_parentcode = sprckmst_parentcode;
	}
	public Long getSprckmst_childflag() {
		return sprckmst_childflag;
	}
	public void setSprckmst_childflag(Long sprckmst_childflag) {
		this.sprckmst_childflag = sprckmst_childflag;
	}
	public String getSprckmst_explain() {
		return sprckmst_explain;
	}
	public void setSprckmst_explain(String sprckmst_explain) {
		this.sprckmst_explain = sprckmst_explain;
	}
	public Long getSprckmst_showflag() {
		return sprckmst_showflag;
	}
	public void setSprckmst_showflag(Long sprckmst_showflag) {
		this.sprckmst_showflag = sprckmst_showflag;
	}
	public Long getSprckmst_seq() {
		return sprckmst_seq;
	}
	public void setSprckmst_seq(Long sprckmst_seq) {
		this.sprckmst_seq = sprckmst_seq;
	}
	public Date getSprckmst_dtcrt() {
		return sprckmst_dtcrt;
	}
	public void setSprckmst_dtcrt(Date sprckmst_dtcrt) {
		this.sprckmst_dtcrt = sprckmst_dtcrt;
	}
	public Date getSprckmst_deupd() {
		return sprckmst_deupd;
	}
	public void setSprckmst_deupd(Date sprckmst_deupd) {
		this.sprckmst_deupd = sprckmst_deupd;
	}
	public String getSprckmst_handworkurl() {
		return sprckmst_handworkurl;
	}
	public void setSprckmst_handworkurl(String sprckmst_handworkurl) {
		this.sprckmst_handworkurl = sprckmst_handworkurl;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
