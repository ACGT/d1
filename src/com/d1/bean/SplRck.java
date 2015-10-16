package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="splrck")
public class SplRck extends BaseEntity implements java.io.Serializable {
	/**
	 * v id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="splrck_code")
	private String id;//done
	private String splrck_rackcode;
	private String splrck_name;
	private Long splrck_parentcode;
	private Long splrck_childflag;
	private Long splrck_seq;
	private Date splrck_dtupd;
	private Date splrck_dtcrt;
	private Long splrck_upflag;
	private Long splrck_showflag;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSplrck_rackcode() {
		return splrck_rackcode;
	}
	public void setSplrck_rackcode(String splrck_rackcode) {
		this.splrck_rackcode = splrck_rackcode;
	}
	public String getSplrck_name() {
		return splrck_name;
	}
	public void setSplrck_name(String splrck_name) {
		this.splrck_name = splrck_name;
	}
	public Long getSplrck_parentcode() {
		return splrck_parentcode;
	}
	public void setSplrck_parentcode(Long splrck_parentcode) {
		this.splrck_parentcode = splrck_parentcode;
	}
	public Long getSplrck_childflag() {
		return splrck_childflag;
	}
	public void setSplrck_childflag(Long splrck_childflag) {
		this.splrck_childflag = splrck_childflag;
	}
	public Long getSplrck_seq() {
		return splrck_seq;
	}
	public void setSplrck_seq(Long splrck_seq) {
		this.splrck_seq = splrck_seq;
	}
	public Date getSplrck_dtupd() {
		return splrck_dtupd;
	}
	public void setSplrck_dtupd(Date splrck_dtupd) {
		this.splrck_dtupd = splrck_dtupd;
	}
	public Date getSplrck_dtcrt() {
		return splrck_dtcrt;
	}
	public void setSplrck_dtcrt(Date splrck_dtcrt) {
		this.splrck_dtcrt = splrck_dtcrt;
	}
	public Long getSplrck_upflag() {
		return splrck_upflag;
	}
	public void setSplrck_upflag(Long splrck_upflag) {
		this.splrck_upflag = splrck_upflag;
	}
	public Long getSplrck_showflag() {
		return splrck_showflag;
	}
	public void setSplrck_showflag(Long splrck_showflag) {
		this.splrck_showflag = splrck_showflag;
	}


}
