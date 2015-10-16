package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="mbrlktqq")
public class UserQQ extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="mbrlktqq_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String mbrlktqq_acct;
	private Long mbrlktqq_mbrid;
	private String mbrlktqq_attach;
	private String mbrlktqq_nickname;
	private Float mbrlktqq_bonus;
	private Long mbrlktqq_point;
	private Date mbrlktqq_createtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMbrlktqq_acct() {
		return mbrlktqq_acct;
	}
	public void setMbrlktqq_acct(String mbrlktqq_acct) {
		this.mbrlktqq_acct = mbrlktqq_acct;
	}
	public Long getMbrlktqq_mbrid() {
		return mbrlktqq_mbrid;
	}
	public void setMbrlktqq_mbrid(Long mbrlktqq_mbrid) {
		this.mbrlktqq_mbrid = mbrlktqq_mbrid;
	}
	public String getMbrlktqq_attach() {
		return mbrlktqq_attach;
	}
	public void setMbrlktqq_attach(String mbrlktqq_attach) {
		this.mbrlktqq_attach = mbrlktqq_attach;
	}
	public String getMbrlktqq_nickname() {
		return mbrlktqq_nickname;
	}
	public void setMbrlktqq_nickname(String mbrlktqq_nickname) {
		this.mbrlktqq_nickname = mbrlktqq_nickname;
	}
	public Float getMbrlktqq_bonus() {
		return mbrlktqq_bonus;
	}
	public void setMbrlktqq_bonus(Float mbrlktqq_bonus) {
		this.mbrlktqq_bonus = mbrlktqq_bonus;
	}
	public Long getMbrlktqq_point() {
		return mbrlktqq_point;
	}
	public void setMbrlktqq_point(Long mbrlktqq_point) {
		this.mbrlktqq_point = mbrlktqq_point;
	}
	public Date getMbrlktqq_createtime() {
		return mbrlktqq_createtime;
	}
	public void setMbrlktqq_createtime(Date mbrlktqq_createtime) {
		this.mbrlktqq_createtime = mbrlktqq_createtime;
	}
	
}
