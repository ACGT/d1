package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="rcktop")
public class RackcodeTop extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="rcktop_id")
	private String id ;//done
	
	private String rcktop_rackcode;
	private String rcktop_gdsid;
	private String rcktop_gdsname;
	private String rcktop_smallimg;
	private Long rcktop_seq;
	private Float rcktop_memberprice;
	private Float rcktop_saleprice;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRcktop_rackcode() {
		return rcktop_rackcode;
	}
	public void setRcktop_rackcode(String rcktop_rackcode) {
		this.rcktop_rackcode = rcktop_rackcode;
	}
	public String getRcktop_gdsid() {
		return rcktop_gdsid;
	}
	public void setRcktop_gdsid(String rcktop_gdsid) {
		this.rcktop_gdsid = rcktop_gdsid;
	}
	public String getRcktop_gdsname() {
		return rcktop_gdsname;
	}
	public void setRcktop_gdsname(String rcktop_gdsname) {
		this.rcktop_gdsname = rcktop_gdsname;
	}
	public String getRcktop_smallimg() {
		return rcktop_smallimg;
	}
	public void setRcktop_smallimg(String rcktop_smallimg) {
		this.rcktop_smallimg = rcktop_smallimg;
	}
	public Long getRcktop_seq() {
		return rcktop_seq;
	}
	public void setRcktop_seq(Long rcktop_seq) {
		this.rcktop_seq = rcktop_seq;
	}
	public Float getRcktop_memberprice() {
		return rcktop_memberprice;
	}
	public void setRcktop_memberprice(Float rcktop_memberprice) {
		this.rcktop_memberprice = rcktop_memberprice;
	}
	public Float getRcktop_saleprice() {
		return rcktop_saleprice;
	}
	public void setRcktop_saleprice(Float rcktop_saleprice) {
		this.rcktop_saleprice = rcktop_saleprice;
	}
}
