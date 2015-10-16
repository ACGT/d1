package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * ÌØÂô»á
 * @author kk
 *
 */
@Entity
@Table(name="salesmst")
public class ProductSale extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="salesmst_id")
	private String id;//done
	
	private String salesmst_title;
	private Date salesmst_starttime;
	private Date salesmst_endtime;
	private String salesmst_indeximg;
	private String salesmst_indexlink;
	private String salesmst_zyimg;
	private String salesmst_zylink;
	private Long salesmst_recid;
	private String salesmst_memo;
	private Date salesmst_createtime;
	private Long salesmst_seq;
	private Long salesmst_validflag;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSalesmst_title() {
		return salesmst_title;
	}
	public void setSalesmst_title(String salesmst_title) {
		this.salesmst_title = salesmst_title;
	}
	public Date getSalesmst_starttime() {
		return salesmst_starttime;
	}
	public void setSalesmst_starttime(Date salesmst_starttime) {
		this.salesmst_starttime = salesmst_starttime;
	}
	public Date getSalesmst_endtime() {
		return salesmst_endtime;
	}
	public void setSalesmst_endtime(Date salesmst_endtime) {
		this.salesmst_endtime = salesmst_endtime;
	}
	public String getSalesmst_indeximg() {
		return salesmst_indeximg;
	}
	public void setSalesmst_indeximg(String salesmst_indeximg) {
		this.salesmst_indeximg = salesmst_indeximg;
	}
	public String getSalesmst_indexlink() {
		return salesmst_indexlink;
	}
	public void setSalesmst_indexlink(String salesmst_indexlink) {
		this.salesmst_indexlink = salesmst_indexlink;
	}
	public String getSalesmst_zyimg() {
		return salesmst_zyimg;
	}
	public void setSalesmst_zyimg(String salesmst_zyimg) {
		this.salesmst_zyimg = salesmst_zyimg;
	}
	public String getSalesmst_zylink() {
		return salesmst_zylink;
	}
	public void setSalesmst_zylink(String salesmst_zylink) {
		this.salesmst_zylink = salesmst_zylink;
	}
	public Long getSalesmst_recid() {
		return salesmst_recid;
	}
	public void setSalesmst_recid(Long salesmst_recid) {
		this.salesmst_recid = salesmst_recid;
	}
	public String getSalesmst_memo() {
		return salesmst_memo;
	}
	public void setSalesmst_memo(String salesmst_memo) {
		this.salesmst_memo = salesmst_memo;
	}
	public Date getSalesmst_createtime() {
		return salesmst_createtime;
	}
	public void setSalesmst_createtime(Date salesmst_createtime) {
		this.salesmst_createtime = salesmst_createtime;
	}
	public Long getSalesmst_seq() {
		return salesmst_seq;
	}
	public void setSalesmst_seq(Long salesmst_seq) {
		this.salesmst_seq = salesmst_seq;
	}
	public Long getSalesmst_validflag() {
		return salesmst_validflag;
	}
	public void setSalesmst_validflag(Long salesmst_validflag) {
		this.salesmst_validflag = salesmst_validflag;
	}
	
}
