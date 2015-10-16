package com.d1.bean;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="mbr360cps")
public class User360 extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="mbr360_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long mbr360_mbrid;
	private String mbr360_qihoo_id;
	private String mbr360_qid;
	private String mbr360_qmail;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMbr360_mbrid() {
		return mbr360_mbrid;
	}
	public void setMbr360_mbrid(Long mbr360_mbrid) {
		this.mbr360_mbrid = mbr360_mbrid;
	}
	public String getMbr360_qihoo_id() {
		return mbr360_qihoo_id;
	}
	public void setMbr360_qihoo_id(String mbr360_qihoo_id) {
		this.mbr360_qihoo_id = mbr360_qihoo_id;
	}
	public String getMbr360_qid() {
		return mbr360_qid;
	}
	public void setMbr360_qid(String mbr360_qid) {
		this.mbr360_qid = mbr360_qid;
	}
	public String getMbr360_qmail() {
		return mbr360_qmail;
	}
	public void setMbr360_qmail(String mbr360_qmail) {
		this.mbr360_qmail = mbr360_qmail;
	}
	public String getMbr360_qname() {
		return mbr360_qname;
	}
	public void setMbr360_qname(String mbr360_qname) {
		this.mbr360_qname = mbr360_qname;
	}
	private String mbr360_qname;

}
