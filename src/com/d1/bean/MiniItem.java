package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="minidtl")
public class MiniItem extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="minidtl_id")
	private String id;//done
	private Long minidtl_minimstid;
	private String minidtl_gdsid;
	private String minidtl_gdsname;
	private String minidtl_detail1;
	private String minidtl_detail2;
	private String minidtl_detail3;
	private String minidtl_pic1;
	private String minidtl_pic2;
	private String minidtl_pic3;
	private Long minidtl_seq;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMinidtl_minimstid() {
		return minidtl_minimstid;
	}
	public void setMinidtl_minimstid(Long minidtl_minimstid) {
		this.minidtl_minimstid = minidtl_minimstid;
	}
	public String getMinidtl_gdsid() {
		return minidtl_gdsid;
	}
	public void setMinidtl_gdsid(String minidtl_gdsid) {
		this.minidtl_gdsid = minidtl_gdsid;
	}
	public String getMinidtl_gdsname() {
		return minidtl_gdsname;
	}
	public void setMinidtl_gdsname(String minidtl_gdsname) {
		this.minidtl_gdsname = minidtl_gdsname;
	}
	public String getMinidtl_detail1() {
		return minidtl_detail1;
	}
	public void setMinidtl_detail1(String minidtl_detail1) {
		this.minidtl_detail1 = minidtl_detail1;
	}
	public String getMinidtl_detail2() {
		return minidtl_detail2;
	}
	public void setMinidtl_detail2(String minidtl_detail2) {
		this.minidtl_detail2 = minidtl_detail2;
	}
	public String getMinidtl_detail3() {
		return minidtl_detail3;
	}
	public void setMinidtl_detail3(String minidtl_detail3) {
		this.minidtl_detail3 = minidtl_detail3;
	}
	public String getMinidtl_pic1() {
		return minidtl_pic1;
	}
	public void setMinidtl_pic1(String minidtl_pic1) {
		this.minidtl_pic1 = minidtl_pic1;
	}
	public String getMinidtl_pic2() {
		return minidtl_pic2;
	}
	public void setMinidtl_pic2(String minidtl_pic2) {
		this.minidtl_pic2 = minidtl_pic2;
	}
	public String getMinidtl_pic3() {
		return minidtl_pic3;
	}
	public void setMinidtl_pic3(String minidtl_pic3) {
		this.minidtl_pic3 = minidtl_pic3;
	}
	public Long getMinidtl_seq() {
		return minidtl_seq;
	}
	public void setMinidtl_seq(Long minidtl_seq) {
		this.minidtl_seq = minidtl_seq;
	}
}
